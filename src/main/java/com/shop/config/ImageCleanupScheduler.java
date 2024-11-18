package com.shop.config;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.shop.dao.ImageMapper;
import com.shop.model.ImageVO;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class ImageCleanupScheduler {
	
    @Autowired
    private ImageMapper imageMapper;
    
    @Value("${upload.path}")
    private String uploadPath;
    
    /**
     * 일반 이미지 정리 - 매일 새벽 2시 실행
     * 삭제된지 7일 지난 이미지 물리적 삭제 처리
     */
//    @Scheduled(cron = "0 */3 * * * *") // 1분마다 실행 (초 분 시 일 월 요일)
    @Scheduled(cron = "0 0 2 * * *") // 매일 새벽 2시에 실행 (초 분 시 일 월 요일)
    public void cleanupDeletedImages() {
    	try {
    		log.info("일반 이미지 정리 - 매일 새벽 2시 실행");
            // 1. 삭제된지 7일 지난 이미지 조회
            List<ImageVO> expiredImages = imageMapper.selectExpiredImages();
            
            if (!expiredImages.isEmpty()) {
                List<Long> imageIds = new ArrayList<>();
                
                // 2. 물리적 파일 삭제
                for (ImageVO image : expiredImages) {
                    // 원본 이미지 삭제
                    String originalPath = uploadPath + image.getUpload_path() 
                                       + image.getSaved_name();
                    File originalFile = new File(originalPath);
                    if (originalFile.exists()) {
                        originalFile.delete();
                    }
                    
                    // 썸네일 이미지 삭제
                    if("Y".equals(image.getIs_thumbnail())) {
                    	String thumbPath = uploadPath + image.getUpload_path()
                						+ "thumb_" + image.getSaved_name();
				       File thumbFile = new File(thumbPath);
				       if (thumbFile.exists()) {
				           thumbFile.delete();
				       }
                    }
                    
                    imageIds.add(image.getImage_id());
                }
                log.info("만료되어 정리된 이미지 개수 : " + imageIds.size());
                // 3. 만료된 이미지 DB에서 완전히 삭제 (물리적 삭제)
                if (!imageIds.isEmpty()) {
                	imageMapper.deleteExpiredImages(imageIds);
                }
            }
        } catch (Exception e) {
            // 로그 기록 및 예외 처리
            log.error("일반 이미지 정리 작업 실패", e);
        }
    }
    
    /**
     * 임시 이미지 정리 - 매시 정각 실행
     * 1시간 이상 경과된 임시 이미지 논리적 삭제 처리
     */
//    @Scheduled(cron = "0 */1 * * * *") // 1분마다 실행 (초 분 시 일 월 요일)
    @Scheduled(cron = "0 0 * * * *") // 매시 정각에 실행
    public void cleanupExpiredTempImages() {
        try {
        	log.info("임시 이미지 정리 - 매시 정각 실행");
            // 1. 만료된 임시 이미지 조회 (1시간 이상 경과)
            List<ImageVO> expiredTempImages = imageMapper.selectExpiredTempImages();
            
            if (!expiredTempImages.isEmpty()) {
                for(ImageVO image : expiredTempImages) {
                    // 2. 물리적 파일 삭제
                    String fullPath = uploadPath + image.getUpload_path() + image.getSaved_name();
                    File imageFile = new File(fullPath);
                    if(imageFile.exists()) {
                        imageFile.delete();
                    }
                    
                    // 3. DB에서 논리적 삭제 처리
                    imageMapper.softDeleteImage(image.getImage_id());
                }
                log.info("만료되어 정리된 임시 이미지 개수: " + expiredTempImages.size());
            }
        } catch (Exception e) {
            log.error("임시 이미지 정리 작업 실패", e);
        }
    }

}
