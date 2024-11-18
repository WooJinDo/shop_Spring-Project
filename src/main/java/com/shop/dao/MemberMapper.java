package com.shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.dto.MemberDto;
import com.shop.model.MemberVO;

/*DAO 역할 = data access object*/
public interface MemberMapper {
	
	// 사용자 - 로그인
	public MemberVO login(String userId);
	
	// 사용자 - 회원 등록
	public void insert(MemberVO vo);
	
	// 사용자 - 회원 중복 확인
	public int memberIdChk(@Param("userId") String userId);
	
	// 관리자 - 회원 전체 수
	public int selectTotalCount(MemberDto.MemberSearchRequest request);
	
	// 관리자 - 회원 리스트
	public List<MemberVO> selectMemberList(MemberDto.MemberSearchRequest request);
	
    // 관리자 - 회원 상세 조회
	public MemberVO selectMemberDetail(@Param("userId") String userId);
	
    // 관리자 - 회원 정보 수정
    void updateMember(MemberVO member);
    
    // 관리자 - 회원 정보 수정 이메일 중복 체크 (본인 제외)
    int checkDuplicateEmailForUpdate(@Param("email") String email, @Param("userId") String userId);
    
    // 관리자 - 회원 가입 이메일 중복 체크
    int checkDuplicateEmailForRegister(@Param("email") String email);
	
	// 관리자 - 회원 탈퇴 처리 (논리적 삭제)
	public void deleteMember(@Param("userId") String userId);
}

	