package com.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookVO extends Criteria {
	// 상품 아이디
	private int book_id;
	// 작가 아이디
	private int author_id;
	// 작가명
	private String author_name;
	// 카테고리 코드
	private String category_code;
	// 카테고리명
	private String category_name;
	private String category_name1;
	private String category_name2;
	private String category_name3;
	// 상품명
	private String book_name;
	// 출판일
	private String puble_year;
	// 출판사
	private String publisher;
	// 상품 가격
	private int book_price;
	// 상품 재고
	private int book_stock;
	// 상품 할인율
	private double book_discount;
	// 상품 소개
	private String book_intro;
	// 상품 목차
	private String book_contents;
	// 등록날짜
	private String reg_date;
	// 수정날짜
	private String update_date;
	// 사용여부
	private String use_flag;
	// 이미지 저장 경로
    private String upload_path;
	// 저장된 이미지명
    private String saved_name;      
	
}
