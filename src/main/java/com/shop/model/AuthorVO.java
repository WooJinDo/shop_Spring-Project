package com.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuthorVO extends Criteria {
	// 작가 아이디
	private int author_id;
	// 작가 이름
	private String author_name;
	// 작가 소개
	private String author_intro;
	// 국가 아이디
	private String nation_id;
	// 소속국가
	private String nation_name;
	// 등록날짜
	private String reg_date;
	// 수정날짜
	private String update_date;
	// 사용여부
	private String use_flag;

}
