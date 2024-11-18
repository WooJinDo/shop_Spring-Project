package com.shop.service;

import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import com.shop.dto.ImageDto;

public interface ImageService {
	// 관리자 - 이미지 업로드 처리
	void uploadImage(ImageDto.ImageUploadRequest request, List<MultipartFile> files) throws Exception;
	
	// 관리자 - 에디터 이미지 임시 업로드 처리
	String uploadTempEditorImage(MultipartFile file, String editorType) throws Exception;
	
	// 관리자 - 이미지 리스트 조회 (타입 및 참조ID 기준)
	List<ImageDto.ImageUploadResponse> selectImagesByRefId(String imageType, Long refId) throws Exception;
	
	// 관리자 - 파일 다운로드
	Resource downloadImage(Long imageId)  throws Exception;
	
	// 관리자 - 원본파일명
	String getOriginalFileName(Long imageId)  throws Exception;
	
	// 관리자 - 이미지 삭제 처리 및 썸네일 재설정
	void deleteImageAndReassignThumbnail(Long imageId) throws Exception;
	
	// 관리자 - 임시 이미지 실제 경로로 이동처리
	String moveEditorImagesToRealPath(String content, String editorType) throws Exception;
	
	// 관리자 - 미사용 에디터 이미지 처리 
	void cleanupUnusedEditorImages(String oldContent, String newContent) throws Exception;
	
}
