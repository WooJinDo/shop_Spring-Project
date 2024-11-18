package com.shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.model.ImageVO;

/*DAO 역할 = data access object*/
public interface ImageMapper {
	
	// 관리자 - 이미지 등록
	public void insertImage(ImageVO image);
	
	// 관리자 - 썸네일 개수 조회
	int countThumbnails(@Param("imageType") String imageType, @Param("refId") Long refId);
	
	// 관리자 - 이미지 리스트 조회 (타입 및 참조ID 기준)
	public List<ImageVO> selectImagesByRefId(@Param("imageType") String imageType, @Param("refId") Long refId);
	
	// 관리자 - 이미지 조회
	public ImageVO selectImage(@Param("imageId") Long imageId);
	
	// 관리자 - 논리적 삭제 처리 (DB 업데이트)
	public void softDeleteImage(@Param("imageId") Long imageId);
	
	// 관리자 - 상품 이미지 썸네일 상태 업데이트
	public void updateThumbnail(ImageVO vo);
	
	// 관리자 - 삭제된지 7일 지난 만료된 이미지 리스트
	public List<ImageVO> selectExpiredImages();
	
	// 관리자 - 만료된 이미지 DB에서 완전히 삭제 (물리적 삭제)
	public void deleteExpiredImages(List<Long> imageIds);
	
	// 관리자 - 이미지 경로로 이미지 정보 조회
	public ImageVO selectImageByPath(String realPath);
	
	// 관리자 - 이미지 경로 정보 업데이트 (임시->실제 저장소 이동 시)
	public void updateImagePath(ImageVO image);
	
	// 관리자 - 만료된 임시 이미지 조회
	public List<ImageVO> selectExpiredTempImages();
	
}
	