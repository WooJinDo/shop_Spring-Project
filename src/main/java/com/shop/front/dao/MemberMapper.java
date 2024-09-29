package com.shop.front.dao;

import com.shop.front.model.MemberVO;

/*DAO 역할 = data access object*/
public interface MemberMapper {
	
	//로그인
	public MemberVO login(String userId);
	//회원 등록
	public void insert(MemberVO vo);
	//회원 중복 확인
	public int memberIdChk(String userId);
}
	