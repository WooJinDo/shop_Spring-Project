package com.shop.service;

import com.shop.dto.MemberDto;
import com.shop.model.MemberVO;

import lombok.extern.log4j.Log4j;

public interface MemberService {
	
	//로그인
	MemberDto.MemberLoginResponse login(MemberDto.MemberLoginRequest request) throws Exception;
	//회원 등록
	MemberDto.MemberResponse insert(MemberDto.MemberRequest request) throws Exception;
	//회원 중복 확인
	MemberDto.MemberIdChkResponse memberIdChk(String userId) throws Exception;
	//이메일 인증
	MemberDto.MemberEmailChkResponse memberEmailChk(String email) throws Exception;

}
