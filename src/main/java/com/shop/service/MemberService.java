package com.shop.service;

import java.util.List;

import com.shop.dto.MemberDto;

public interface MemberService {
	
	// 사용자 - 로그인
	MemberDto.MemberLoginResponse login(MemberDto.MemberLoginRequest request) throws Exception;
	
	// 사용자 - 회원 등록
	MemberDto.MemberResponse insert(MemberDto.MemberRequest request) throws Exception;
	
	// 사용자 - 회원 중복 확인
	MemberDto.MemberIdChkResponse memberIdChk(String userId) throws Exception;
	
	// 사용자 - 이메일 인증
	MemberDto.MemberEmailChkResponse memberEmailChk(String email) throws Exception;
	
	// 관리자 - 회원 전체 수
	int selectTotalCount(MemberDto.MemberSearchRequest request) throws Exception;
	
	// 관리자 - 회원 리스트
	List<MemberDto.MemberListResponse> selectMemberList(MemberDto.MemberSearchRequest request) throws Exception;
	
	// 관리자 - 회원 탈퇴 처리 (논리적 삭제)
	void deleteMember(String userId) throws Exception;
	
	// 관리자 - 회원 상세 조회
	MemberDto.MemberDetailResponse selectMemberDetail(String userId) throws Exception;
	
	// 관리자 - 회원 정보 수정
    void updateMember(MemberDto.MemberUpdateRequest request) throws Exception;

}
