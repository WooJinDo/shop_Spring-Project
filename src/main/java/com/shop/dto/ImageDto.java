package com.shop.dto;

import com.shop.model.Criteria;
import com.shop.model.ImageVO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

public class ImageDto {
	
	// 관리자: 이미지 업로드 - 요청
	@Getter @Setter
	@Builder
	public static class ImageUploadRequest {
        // 이미지 타입
        private String imageType;
        // 참조 아이디
        private Long refId;
	}
	
	// 관리자: 이미지 업로드 - 결과
	@Getter @Setter
	@Builder
	public static class ImageUploadResponse {
		// 이미지 아이디
		private Long image_id;
		// 이미지 타입
	    private String image_type;
	    // 참조 아이디
	    private Long ref_id; // null을 가질 수도 있어서, 래퍼클래스 Integer, LONG로 사용
	    // 원본 파일명
	    private String original_name;
	    // 저장 파일명
	    private String saved_name;
	    // 저장경로
	    private String upload_path;
	    // 파일 크기
	    private Long file_size;
	    // 썸네일 여부
	    private String is_thumbnail;
	    // 삭제 여부
	    private String is_deleted;
		// 등록날짜
		private String reg_date;
		
		public static ImageUploadResponse from(ImageVO vo) {
			return ImageUploadResponse.builder()
					.image_id(vo.getImage_id())
					.image_type(vo.getImage_type())
					.ref_id(vo.getRef_id())
					.original_name(vo.getOriginal_name())
					.saved_name(vo.getSaved_name())
					.upload_path(vo.getUpload_path())
					.file_size(vo.getFile_size())
					.is_thumbnail(vo.getIs_thumbnail())
					.is_deleted(vo.getIs_deleted())
					.reg_date(Criteria.nullToEmpty(vo.getReg_date()))
					.build();
		}
	}
	
}
