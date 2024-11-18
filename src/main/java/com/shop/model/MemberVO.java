package com.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberVO extends Criteria {
	
	//회원 ID
	private String user_id;
	
	//회원 비밀번호
	private String user_pw;
	
	//회원 이름
	private String user_name;
	
	//회원 이메일
	private String user_email;
	
	//우편번호
	private String post_no;
	
	//주소
	private String addr;
	
	//상세주소
	private String addr_detail;
	
	//권한(DEFAULT: user)
	private String admin_ck;
	
	//등록일자(DEFAULT: SYSDATE)
	private String reg_date;
	
	//회원 금액
	private int money;
	
	//회원 포인트
	private int point;
	
	// 사용여부
	private String use_flag;
	
}
