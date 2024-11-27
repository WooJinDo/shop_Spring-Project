package com.shop.config;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.tika.Tika;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {
	
	@Value("${upload.path}")	// 실제 업로드 경로
    private String uploadPath;
	
    @Value("${upload.temp.dir}")  // 임시 저장 경로
    private String uploadTempDir;
	
    private static final Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
    
    /**
     * 일반 파일 업로드 처리
     */
    public String uploadFile(MultipartFile file, String imageType, boolean isThumbnail) throws IOException {
    	logger.info("uploadPath************* : " + uploadPath);
        String originalFileName = file.getOriginalFilename();
        String fileExtension = FilenameUtils.getExtension(originalFileName);
        // 안전한 파일명 생성 (UUID로 생성하여 충돌 방지)
        String newFileName = UUID.randomUUID().toString() + "." + fileExtension;
        
        // 경로 생성 (일반 파일 업로드 시)
        String uploadDir = createUploadPath(imageType, null, false);
        File uploadDirectory = new File(uploadPath + uploadDir);
        
        if (!uploadDirectory.exists()) {	// 경로가 존재하지 않으면 폴더 생성
            uploadDirectory.mkdirs();
        }
        
        // 파일 저장 (외부 스토리지에만)
        File destination = new File(uploadDirectory, newFileName);
        file.transferTo(destination); // 파일을 지정된 경로에 저장
        
        // 이미지 파일인 경우 썸네일 생성, isThumbnail가 true 일 때
        if (isImageFile(fileExtension) && isThumbnail && !"EDITOR".equals(imageType)) {
            createThumbnail(destination, uploadDir, newFileName);
        }
        
        return uploadDir + newFileName; // 파일 경로 반환(상대 경로만 반환)
    }
    
    /**
     * 에디터 이미지 임시 업로드 처리
     */
    public String uploadTempEditorFile(MultipartFile file, String editorType) throws IOException {
        String originalFileName = file.getOriginalFilename();
        String fileExtension = FilenameUtils.getExtension(originalFileName);
        String newFileName = UUID.randomUUID().toString() + "." + fileExtension;
        
        // 임시 경로 생성
        String tempDir = createUploadPath("EDITOR", editorType, true);
        File tempDirectory = new File(uploadPath + tempDir);
        
        if (!tempDirectory.exists()) {
            tempDirectory.mkdirs();
        }
        
        // 임시 파일 저장
        File destination = new File(tempDirectory, newFileName);
        file.transferTo(destination);
        
        return tempDir + newFileName;
    }
    
    /**
     * 임시 파일을 실제 경로로 이동
     */
    public String moveToRealPath(String tempPath, String editorType) throws IOException {
        // 임시 파일 경로에서 파일명 추출
        File tempFile = new File(uploadPath + tempPath);
        String fileName = tempFile.getName();
        
        // 실제 저장 경로 생성
        String realDir = createUploadPath("EDITOR", editorType, false);
        File realDirectory = new File(uploadPath + realDir);
        
        if (!realDirectory.exists()) {
            realDirectory.mkdirs();
        }
        
        // 실제 저장 파일
        File realFile = new File(realDirectory, fileName);
        
        // 파일 이동
        FileUtils.moveFile(tempFile, realFile);
        
        return realDir + fileName;
    }
    
    /**
     * 임시 파일 삭제
     */
//    public void deleteTempFile(String tempPath) {
//        File tempFile = new File(uploadPath + tempPath);
//        if (tempFile.exists()) {
//            tempFile.delete();
//        }
//    }
    
    /**
     * 업로드 경로 생성
     * 일반 파일: /uploads/[IMAGE_TYPE]/yyyy/MM/dd/
     * 에디터 파일: /uploads/editor/[EDITOR_TYPE]/yyyy/MM/dd/
     * 임시 파일: /uploads/temp/editor/[EDITOR_TYPE]/yyyy/MM/dd/
     */
    private String createUploadPath(String imageType, String editorType, boolean isTemp) {
    	// 날짜별 폴더 업로드 경로 생성
        String datePath = getDatePath();
        
    	if("EDITOR".equals(imageType)) {
    		return (isTemp ? "temp/" : "") + "editor/" + editorType.toLowerCase() + "/" + datePath;
    	} else {
    		return imageType.toLowerCase() + "/" + datePath;
    	}
    	
    }
    
    /**
     * 날짜별 디렉토리 경로 생성
     */
    private String getDatePath() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
        Date date = new Date();
        return sdf.format(date); // 날짜 형식의 폴더 경로 생성
    }
    
    /**
     * 이미지 파일 체크
     */
    private boolean isImageFile(String extension) {
        return Arrays.asList("jpg", "jpeg", "png", "gif")
                    .contains(extension.toLowerCase()); // 이미지 파일 확장자 확인
    }
    
    /**
     * 썸네일 생성
     */
    public void createThumbnail(File originalFile, String datePath, String fileName) {
        try {
        	BufferedImage originalImage = ImageIO.read(originalFile);
            int thumbnailWidth = 300;
            
            BufferedImage thumbnailImage = Scalr.resize(originalImage, 
                Scalr.Method.AUTOMATIC, 
                Scalr.Mode.FIT_TO_WIDTH,
                thumbnailWidth);
            
            String thumbnailPath = uploadPath + datePath + "thumb_" + fileName;
            File thumbnailFile = new File(thumbnailPath);
            ImageIO.write(thumbnailImage, 
                         FilenameUtils.getExtension(fileName), 
                         thumbnailFile);
                         
        } catch (IOException e) {
            logger.error("썸네일 생성 실패: " + e.getMessage());
        }
    }
    
    /**
     * 파일 타입 검증
     */
    public boolean validateFileType(MultipartFile file) {
        try {
            Tika tika = new Tika();
            String detectedType = tika.detect(file.getInputStream());
            return detectedType.startsWith("image/") || 
                   detectedType.equals("application/pdf") ||
                   detectedType.equals("application/msword");
        } catch (IOException e) {
            logger.error("파일 타입 검증 실패: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * CKEditor 이미지 파일 전용 유효성 검사
     */
    public boolean validateImageFile(MultipartFile file) {
        try {
            Tika tika = new Tika();
            String detectedType = tika.detect(file.getInputStream());
            return detectedType.startsWith("image/"); 
        } catch (IOException e) {
            logger.error("이미지 파일 타입 검증 실패: " + e.getMessage());
            return false;
        }

    }
    
    /**
     * webapp/uploads 이후의 경로만 추출(절대 경로로 사용시)
     */
//    public String getWebPath(String fullPath) {
//        String[] pathParts = fullPath.split("uploads/");
//        return pathParts.length > 1 ? "/uploads/" + pathParts[1] : fullPath;
//    }
    
}
