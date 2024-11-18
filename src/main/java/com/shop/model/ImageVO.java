package com.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ImageVO {
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
    // 삭제날짜
    private String delete_date;
	// 임시저장 여부
	private String is_temp;
	// 임시저장 날짜
	private String temp_date;
	// 등록날짜
	private String reg_date;

}
