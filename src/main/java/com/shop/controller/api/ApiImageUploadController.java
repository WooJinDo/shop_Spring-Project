package com.shop.controller.api;

import java.net.URLEncoder;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.tika.metadata.HttpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.shop.config.FileUploadUtil;
import com.shop.service.ImageService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/api/images")
public class ApiImageUploadController {
	
	@Autowired
    private FileUploadUtil fileUploadUtil;
	
	@Autowired
	private ImageService imageService;
	
	@Value("${upload.max.size}")  // 10MB가 기본값
	private long maxFileSize;
    
	// @RequestParam - 파일처리 또는 요청이 json이 아닐 때
    @PostMapping("/editor")
    public Map<String, Object> uploadEditorImage(@RequestParam("upload") MultipartFile file, 
    											@RequestParam("type") String editorType,
                                               HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        log.info("에디터 이미지 업로드 시작 - 파일명: " + file.getOriginalFilename());
        log.info("에디터 타입: " + editorType);
        
        try {
            // 1. 이미지 파일 검증
            if (!fileUploadUtil.validateImageFile(file)) {
                result.put("uploaded", 0);
                // Collections.singletonMap - 키와 값 쌍으로 이루어진 하나의 항목만 포함된 불변 Map을 생성
                result.put("error", Collections.singletonMap("message", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif 파일만 가능)")); 
                return result;
            }
            
            // 2. 파일 크기 체크(10MB 제한)
    		String maxFileSizeInMB = (maxFileSize / (1024 * 1024)) + "MB";
			if(file.getSize() > maxFileSize) {
				result.put("uploaded", 0);
                // Collections.singletonMap - 키와 값 쌍으로 이루어진 하나의 항목만 포함된 불변 Map을 생성
                result.put("error", Collections.singletonMap("message", "파일 크기가 최대 크기 " + maxFileSizeInMB + "를 초과했습니다")); 
                return result;
			}
            
            // 3. 에디터 이미지 임시 업로드 처리
            String savedPath = imageService.uploadTempEditorImage(file, editorType);
            
            // 4. 업로드된 이미지의 URL 생성
            String imageUrl = request.getContextPath() + savedPath;
            
            // 5. CKEditor 응답 형식
            result.put("uploaded", 1);
            result.put("fileName", file.getOriginalFilename());
            result.put("url", imageUrl);
            log.info("에디터 이미지 업로드 성공 - URL: " + imageUrl);
            
        } catch (Exception e) {
            log.error("에디터 이미지 업로드 실패 - 파일명: " + file.getOriginalFilename(), e);
            result.put("uploaded", 0);
            result.put("error", Collections.singletonMap("message", "이미지 업로드에 실패했습니다."));
        }
        
        return result;
    }
    
    // 관리자 - 파일 다운로드
 	@GetMapping("/{imageId}/download")
 	public ResponseEntity<Resource> downloadImage(@PathVariable Long imageId) {
 		log.info("**파일 다운로드 처리**");
 	    try {
 	    	Resource resource = imageService.downloadImage(imageId);
 	    	String originalFileName = imageService.getOriginalFileName(imageId);
 	    	// 파일명 인코딩 처리
 	        String encodedFileName = URLEncoder.encode(originalFileName, "UTF-8")
 	                                         .replaceAll("\\+", "%20");
 	        
 	        return ResponseEntity
 	        		.status(HttpStatus.OK)
 	                .contentType(MediaType.APPLICATION_OCTET_STREAM)
 	                .header(HttpHeaders.CONTENT_DISPOSITION, 
 	                        "attachment; filename*=UTF-8''" + encodedFileName)
 	                .body(resource);
 	    	
 	    } catch (Exception e) {
 	    	log.error("File download error: ", e);
 	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
 	    }
 	}
 	
	// 관리자 - 이미지 삭제 처리 및 썸네일 재설정
	@DeleteMapping("/{imageId}")
	public ResponseEntity<?> deleteImage(@PathVariable("imageId") Long imageId) throws Exception {
		log.info("**이미지 삭제 및 썸네일 재설정 처리**");
		
		try {
			imageService.deleteImageAndReassignThumbnail(imageId);
		    return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
		    
	    } catch (Exception e) {
	        log.error("이미지 삭제 실패 - 시스템 에러, imageId: " + imageId, e);
	        return ResponseEntity
	            .status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .contentType(MediaType.APPLICATION_JSON_UTF8)
	            .body("이미지 삭제 중 오류가 발생했습니다.");
	    }
	}
 	
}
    
