package com.shop.service.impl;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.config.FileUploadUtil;
import com.shop.dao.ImageMapper;
import com.shop.dto.ImageDto;
import com.shop.model.ImageVO;
import com.shop.service.ImageService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ImageServiceImpl implements ImageService {
	
	// 썸네일이 필요한 타입들
	private static final List<String> THUMBNAIL_TYPES = Arrays.asList("BOOK", "BOARD"); 
	
	// 이미지 URL 추출을 위한 상수 정의
    private static final String TEMP_PATH_PATTERN = "/uploads/temp/[^\"'\\s]+";
    private static final String REAL_PATH_PATTERN = "/uploads/editor/[^\"'\\s]+";
	
	@Autowired
	private ImageMapper imageMapper;
	
    @Autowired
    private FileUploadUtil fileUploadUtil;
    
	@Value("${upload.path}")	// 외부 스토리지 경로
    private String uploadPath;
	
    @Value("${upload.temp.dir}")  // 임시 저장 경로
    private String uploadTempDir;
    
    /**
	 * 관리자 - 이미지 업로드 처리
	 */
    @Transactional
	@Override
    public void uploadImage(ImageDto.ImageUploadRequest request, List<MultipartFile> files) throws Exception {
        try {
        	log.info("이미지 업로드*********  ");
            if (files != null && !files.isEmpty()) {
            	// 1. 썸네일 처리가 필요한 타입인지 확인
            	boolean needThumbnail = THUMBNAIL_TYPES.contains(request.getImageType());
            	boolean hasExistingThumbnail = false;
            	
            	// 2. 썸네일이 필요한 타입일 경우 기존 썸네일 존재 여부 확인
            	if(needThumbnail) {
            		hasExistingThumbnail = checkExistingThumbnail(request.getImageType(), request.getRefId());
                    log.info("기존 썸네일 유무********* : " + hasExistingThumbnail);
            	}
                
                for (int i = 0; i < files.size(); i++) {
                    MultipartFile file = files.get(i);
                    
                    if (!file.isEmpty()) {
                    	// 3. 썸네일 여부 결정: 썸네일이 필요한 타입이고, 기존 썸네일이 없고, 첫 번째 이미지인 경우
                        boolean shouldBeThumbnail = needThumbnail && !hasExistingThumbnail && i == 0;
                        log.info("썸네일 생성 유무********* : " + shouldBeThumbnail);
                        
                        // 4. 파일 업로드 처리 (shouldBeThumbnail이 false면 썸네일 생성 안함)
                        String savedPath = fileUploadUtil.uploadFile(file, request.getImageType(), shouldBeThumbnail);
                        
                        // 5. 이미지 정보 생성
                        ImageVO imageVo = ImageVO.builder()
                            .image_type(request.getImageType())
                            .ref_id(request.getRefId())
                            .original_name(file.getOriginalFilename())
                            .saved_name(FilenameUtils.getName(savedPath))
                            .upload_path(FilenameUtils.getPath(savedPath))
                            .file_size(file.getSize())
                            .is_thumbnail(shouldBeThumbnail ? "Y" : "N") // 첫 번째 이미지를 썸네일로 설정
                            .is_deleted("N")
                            .is_temp("N")
                            .build();
                        
                        // 6. DB에 이미지 정보 저장
                        imageMapper.insertImage(imageVo);
                        
                    	// 7. 썸네일 타입이고, 썸네일로 설정되었다면 플래그 업데이트
                        if(needThumbnail && shouldBeThumbnail) {
                            hasExistingThumbnail = true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.error("이미지 업로드 실패", e);
            throw new RuntimeException("이미지 업로드 중 오류가 발생했습니다.", e);
        }
    }
	
	/**
	 * 관리자 - 기존 썸네일 존재 여부 확인 
	 */
	private boolean checkExistingThumbnail(String imageType, Long refId) throws Exception {
        return imageMapper.countThumbnails(imageType, refId) > 0;
    }
	
	/**
	 * 관리자 - 이미지 리스트 조회 (타입 및 참조ID 기준)
	 */	
	@Override
	public List<ImageDto.ImageUploadResponse> selectImagesByRefId(String imageType, Long refId) throws Exception {
		try {
			
	        // 1. 입력값 검증
	        if (imageType == null || imageType.trim().isEmpty()) {
	            throw new RuntimeException("이미지 타입이 유효하지 않습니다.");
	        }
	        if (refId == null || refId <= 0) {
	            throw new RuntimeException("참조 ID가 필요합니다.");
	        }
	        
			// 2. 이미지 조회 (BOOK 등 다른 타입과 refId로 조회) 
			List<ImageVO> voList = imageMapper.selectImagesByRefId(imageType, refId);
			
			// 3. VO를 DTO로 변환
			List<ImageDto.ImageUploadResponse> dtoList = new ArrayList<>();
			for(ImageVO vo : voList) {
				dtoList.add(ImageDto.ImageUploadResponse.from(vo));
			}
			
            // 4. 조회 결과 로깅
            log.info("이미지 조회 완료 - type: " + imageType + ", refId: " + refId + ", totalCount: " + dtoList.size());
            
			return dtoList;
			
        } catch (RuntimeException e) {
            log.error("이미지 리스트 조회 실패 - type: " + imageType + ", refId: " + refId, e);
            throw e;
        } catch (Exception e) {
            log.error("이미지 리스트 조회 중 오류 발생 - type: " + imageType + ", refId: " + refId, e);
            throw new RuntimeException("이미지 리스트 조회 중 오류가 발생했습니다.", e);
        }
	}
	
	/**
	 * 관리자 - 상품 파일 다운로드
	 */	
	@Override
    public Resource downloadImage(Long imageId) throws Exception {
		ImageVO image = imageMapper.selectImage(imageId);
		
        if (image == null) {
            throw new RuntimeException("Image not found with id: " + imageId);
        }

        // 전체 파일 경로 생성(외부 스토리지의 전체 경로로 생성)
        Path filePath = Paths.get(uploadPath,
				        		image.getUpload_path(), 
				        		image.getSaved_name());
        
        // 디버깅을 위한 로그 출력
        log.info("Full file path: " + filePath);
        log.info("File exists: " + Files.exists(filePath));
        
        Resource resource = new UrlResource(filePath.toUri());
        if (!resource.exists()) {
            throw new RuntimeException("File not found: " + filePath);
        }

        return resource;
    }
	
	/**
	 * 관리자 - 원본 파일명
	 */	
	@Override
	public String getOriginalFileName(Long imageId) throws Exception {
		ImageVO image = imageMapper.selectImage(imageId);
		if (image == null) {
            throw new RuntimeException("Image not found with id: " + imageId);
        }
        return image.getOriginal_name();
	}
	
	/**
	 * 관리자 - 이미지 삭제 처리 및 썸네일 재설정
	 */	
	@Transactional
	@Override
	public void deleteImageAndReassignThumbnail(Long imageId) throws Exception {
		try {
		    // 1. 삭제할 이미지 정보 조회
		    ImageVO deleteImageVo = imageMapper.selectImage(imageId);
		    if (deleteImageVo == null) {
		        throw new RuntimeException("삭제할 이미지를 찾을 수 없습니다.");
		    }
		    
		    String imageType = deleteImageVo.getImage_type();
		    Long refId = deleteImageVo.getRef_id();
	
		    // 2. 논리적 삭제 처리 (DB 업데이트)
		    imageMapper.softDeleteImage(imageId);
	        
		    // 3. 썸네일이 필요한 타입이고 썸네일이었던 경우에만 재설정
            if (THUMBNAIL_TYPES.contains(imageType) && "Y".equals(deleteImageVo.getIs_thumbnail())) {
            	
                // 남은 이미지 중 가장 먼저 등록된 이미지 조회
                List<ImageVO> remainingImages = imageMapper.selectImagesByRefId(imageType, refId);
                
                if (!remainingImages.isEmpty()) {
                    ImageVO newThumbnail = remainingImages.get(0);
                    newThumbnail.setIs_thumbnail("Y");
                    // 썸네일 상태 업데이트
                    imageMapper.updateThumbnail(newThumbnail);
                    
                    // 썸네일 이미지 파일 생성
                    String newThumbPath = uploadPath + newThumbnail.getUpload_path() + newThumbnail.getSaved_name();
                    File newImageFile = new File(newThumbPath);
                    if (newImageFile.exists()) {
                        fileUploadUtil.createThumbnail(
                            newImageFile, 
                            newThumbnail.getUpload_path(), 
                            newThumbnail.getSaved_name()
                        );
                    }
                }
            }
            
        } catch (Exception e) {
            log.error("이미지 삭제 실패", e);
            throw new RuntimeException("이미지 삭제 중 오류가 발생했습니다.", e);
        }
	}
	
	/**
	 * 관리자 - 에디터 이미지 임시 업로드
	 */    
	@Transactional
	@Override
    public String uploadTempEditorImage(MultipartFile file, String editorType) throws Exception {
        try {
        	log.info("Editor 이미지 임시 업로드*********  ");
        	// 1. 파일 유효성 검사
            if (file == null || file.isEmpty()) {
                throw new RuntimeException("업로드할 파일이 비어있습니다.");
            }
                    
            // 2. 에디터 파일 임시 업로드 처리 (썸네일 불필요)
            String tempPath = fileUploadUtil.uploadTempEditorFile(file, editorType);
            
            // 3. 이미지 정보 생성
            ImageVO imageVo = ImageVO.builder()
					.image_type(editorType)
					.ref_id(null) // 에디터 이미지는 refId 없음
					.original_name(file.getOriginalFilename())
					.saved_name(FilenameUtils.getName(tempPath))
					.upload_path(FilenameUtils.getPath(tempPath))
					.file_size(file.getSize())
					.is_thumbnail("N")
					.is_deleted("N")
					.is_temp("Y")  // 임시 저장 표시
					.build();
            
            // 4. DB에 이미지 정보 저장
            imageMapper.insertImage(imageVo);
	         
	        // 5. 에디터에서 사용할 이미지 URL 반환
            return "/uploads/" + tempPath;
        } catch (Exception e) {
            log.error("에디터 이미지 임시 업로드 실패", e);
            throw new RuntimeException("에디터 이미지 임시 업로드 중 오류가 발생했습니다.", e);
        }
    }
	
	/**
     * 관리자 - 임시 이미지 실제 경로로 이동처리
     */
	@Override
    public String moveEditorImagesToRealPath(String content, String editorType) throws Exception {
        if(content == null || content.isEmpty()) {
            return content;
        }
        if (editorType == null || editorType.trim().isEmpty()) {
            throw new RuntimeException("에디터 타입이 유효하지 않습니다.");
        }
        
        List<String> imageUrls = extractImageUrls(content, true);
        log.info("이미지 임시경로 URLs: " + imageUrls);
        
        // 컨텐츠 내용 수정을 위한 변수
        String updatedContent = content;
        
        for(String imageUrl : imageUrls) {
            // temp 경로에 있는 이미지인 경우에만 처리
            if(imageUrl.contains("/temp/")) {
                String tempPath = imageUrl.replace("/uploads/", "");
                ImageVO imageVO = imageMapper.selectImageByPath(tempPath);
                
                if(imageVO != null && "Y".equals(imageVO.getIs_temp())) {
                    // 실제 경로로 파일 이동
                    String realPath = fileUploadUtil.moveToRealPath(tempPath, editorType);
                    
                    // DB 정보 업데이트
                    imageVO.setUpload_path(FilenameUtils.getPath(realPath));
                    imageVO.setSaved_name(FilenameUtils.getName(realPath));
                    imageVO.setIs_temp("N");
                    imageMapper.updateImagePath(imageVO); // (임시->실제 저장소 이동 시)
                    
                    // 컨텐츠 내의 이미지 URL 경로 변경
                    String realUrl = "/uploads/" + realPath;
                    updatedContent = updatedContent.replace(imageUrl, realUrl);
                }
            }
        }
        
        return updatedContent;
    }
    
    /**
     * 관리자 - 미사용 에디터 이미지 처리 
     */
	@Override
    public void cleanupUnusedEditorImages(String oldContent, String newContent) throws Exception {
        try {
            // 이전 컨텐츠와 새 컨텐츠의 이미지 URL 추출
            List<String> oldUrls = extractImageUrls(oldContent, false);
            List<String> newUrls = extractImageUrls(newContent, false);
            
            log.info("기존 이미지 URLs: " + oldUrls);
            log.info("새로운 이미지 URLs: " + newUrls);
            
            // 더 이상 사용되지 않는 이미지 찾기
            List<String> unusedUrls = new ArrayList<>(oldUrls);
            unusedUrls.removeAll(newUrls);	// 새로 추가하는 이미지 중에 기존 이미지와 겹치는 url이 있다면 삭제
            
            // 미사용 이미지 삭제 처리
            for(String url : unusedUrls) {
                String imagePath = url.replace("/uploads/", "");
                ImageVO imageVO = imageMapper.selectImageByPath(imagePath);
                if(imageVO != null) {
                    imageMapper.softDeleteImage(imageVO.getImage_id());
                }
            }
        } catch (Exception e) {
            log.error("미사용 에디터 이미지 정리 실패", e);
            throw new RuntimeException("미사용 에디터 이미지 정리 중 오류가 발생했습니다.", e);
        }
    }
    
    /**
     * 관리자 - 에디터 내용에서 이미지 URL 추출
     * isTemp true: 임시경로 패턴, false: 실제경로 패턴
     */
	@Override
	public List<String> extractImageUrls(String content, boolean isTemp) throws Exception {
		
		try {
	        List<String> urls = new ArrayList<>();
	        
	        // 1. 입력값 검증
	        if(content == null || content.isEmpty()) {
	            return urls;
	        }
	        
	        // 2. URL 패턴 설정 및 매칭
	        // 2-1. /uploads/temp/ or /uploads/editor/ 경로로 시작하는 URL을 찾습니다
	        String patternString = isTemp ? TEMP_PATH_PATTERN : REAL_PATH_PATTERN;
	        Pattern pattern = Pattern.compile(patternString);
	        Matcher matcher = pattern.matcher(content); // content 안에서 정규표현식에 맞는 부분을 검색
	        
	        // 3. URL 추출
	        while(matcher.find()) {	// 정규표현식에 맞는 부분을 찾으면 matcher.group()으로 해당 문자열을 추출하여 urls 리스트에 추가
	            urls.add(matcher.group());
	        }
	        
	        log.info("이미지 URL 추출 완료 - count: " + urls.size());
	        return urls;
        
	    } catch (PatternSyntaxException e) {
	        log.error("URL 패턴 매칭 실패", e);
	        throw new RuntimeException("URL 패턴 매칭 중 오류가 발생했습니다.", e);
	    } catch (Exception e) {
	        log.error("이미지 URL 추출 중 오류 발생", e);
	        throw new RuntimeException("이미지 URL 추출 중 오류가 발생했습니다.", e);
	    }
    }

    /**
     * 관리자 - 논리적 삭제 처리 (DB 업데이트)
     */
	@Override
	public void softDeleteImage(Long imageId) throws Exception {
		try {
	        // 1. 이미지 존재 여부 확인
	        ImageVO image = imageMapper.selectImage(imageId);
	        if (image == null) {
	            throw new RuntimeException("삭제할 이미지를 찾을 수 없습니다.");
	        }
	        
	        // 2. 이미지가 이미 삭제되었는지 확인
	        if ("Y".equals(image.getIs_deleted())) {
	            throw new RuntimeException("이미 삭제된 이미지입니다.");
	        }
	        
	        // 3. 논리적 삭제 처리
	        imageMapper.softDeleteImage(imageId);
	        log.info("이미지 논리적 삭제 완료 - imageId: " + imageId + ", imageType: " + image.getImage_type());
	        
	    } catch (RuntimeException e) {
	        log.error("이미지 논리적 삭제 실패 - imageId: " + imageId, e);
	        throw e;
	    } catch (Exception e) {
	        log.error("이미지 논리적 삭제 중 오류 발생 - imageId: " + imageId, e);
	        throw new RuntimeException("이미지 삭제 처리 중 오류가 발생했습니다.", e);
	    }
	}
	
	 /**
     * 관리자 - 이미지 경로로 이미지 정보 조회
     */
	@Override
	public ImageVO selectImageByPath(String imagePath) throws Exception {
		
	    try {
	        // 1. 입력값 검증
	        if (imagePath == null || imagePath.trim().isEmpty()) {
	            throw new RuntimeException("이미지 경로가 유효하지 않습니다.");
	        }
	        
	        // 2. 이미지 정보 조회
	        ImageVO imageVO = imageMapper.selectImageByPath(imagePath.trim());
	        
	        // 3. 조회 결과 로깅
	        if (imageVO != null) {
	            log.info("이미지 경로로 이미지 조회 성공 - imagePath: " + imagePath + 
	                    ", imageId: " + imageVO.getImage_id());
	        } else {
	        	log.error("이미지 경로에 해당하는 이미지를 찾을 수 없습니다 - imagePath: " + imagePath);
	        	throw new RuntimeException("이미지 경로에 해당하는 이미지를 찾을 수 없습니다.");
	        }
	        
	        return imageVO;
	        
	    } catch (RuntimeException e) {
	        log.error("이미지 경로로 이미지 조회 실패 - imagePath: " + imagePath, e);
	        throw e;
	    } catch (Exception e) {
	        log.error("이미지 경로로 이미지 조회 중 오류 발생 - imagePath: " + imagePath, e);
	        throw new RuntimeException("이미지 정보 조회 중 오류가 발생했습니다.", e);
	    }
	}
	
	
	
}
