package com.shop.dto;

import com.shop.model.MemberVO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class MemberDto {
	
	//로그인 - 요청
	@Getter @Setter
	@ToString
	public static class MemberLoginRequest{
		//회원 ID
		private String user_id;
		
		//회원 비밀번호
		private String user_pw;
	}
	
	//로그인 - 결과
	@Getter @Setter
	@Builder
	public static class MemberLoginResponse{
		private String user_id;
		private String user_name;
		private String admin_ck;
		private String msg;
		private boolean success;
		
		public static MemberLoginResponse success(MemberVO vo, boolean success) {
			return MemberLoginResponse.builder()
					.user_id(vo.getUser_id())
					.user_name(vo.getUser_name())
					.admin_ck(vo.getAdmin_ck())
					.success(success)
					.build();
		}
		
		public static MemberLoginResponse failure(String msg, boolean success) {
			return MemberLoginResponse.builder()
					.msg(msg)
					.success(success)
					.build();
		}
	}
		
	//회원 등록 - 요청
	@Getter @Setter
	@ToString
	public static class MemberRequest{
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
		
		//관리자 여부(DEFAULT: user)
		private String admin_ck;
		
		//회원 금액
		private int money;
		
		//회원 포인트
		private int point;
	}
	
	//회원 등록 - 결과
	@Getter @Setter
	@Builder
	public static class MemberResponse{
		private boolean success;
		
		//@builder 사용하지 않을 시에 기본생성자 생성해주어야 함 
//		public MemberResponse() {}
		 
		public static MemberResponse from(boolean success) {
			return MemberResponse.builder()
					.success(success)
					.build();
		}
	}

	// 회원 중복 확인
	@Getter @Setter
	@Builder
	public static class MemberIdChkResponse{
		private String idChk;
		
		public static MemberIdChkResponse from(String idChk) {
			return MemberIdChkResponse.builder()
					.idChk(idChk)
					.build();
		}
	}
	
	// 이메일 인증번호
	@Getter @Setter
	@Builder
	public static class MemberEmailChkResponse{
		private String emailNum;
		
		public static MemberEmailChkResponse from(String emailNum) {
			return MemberEmailChkResponse.builder()
					.emailNum(emailNum)
					.build();
		}
	}
	
}
