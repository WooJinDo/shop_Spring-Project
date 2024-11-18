package com.shop.dto;

import com.shop.model.Criteria;
import com.shop.model.MemberVO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class MemberDto {
	
	// 사용자: 로그인 - 요청
	@Getter @Setter
	@ToString
	public static class MemberLoginRequest{
		//회원 ID
		private String user_id;
		
		//회원 비밀번호
		private String user_pw;
	}
	
	// 사용자: 로그인 - 결과
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
		
	// 사용자: 회원 등록 - 요청
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
		//권한(DEFAULT: user)
		private String admin_ck;
		//회원 금액
		private int money;
		//회원 포인트
		private int point;
	}
	
	// 사용자: 회원 등록 - 결과
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

	// 사용자: 회원 중복 확인
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
	
	// 사용자: 이메일 인증번호
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
	
	// 관리자: 회원 검색 리스트 - 요청
	@Getter @Setter
	@ToString
	public static class MemberSearchRequest{
		private String memberStatus = "active"; // 기본값은 정상회원
		// 현재 페이지 번호
		private int currentPage = 1; // 기본값 1
		// 한 페이지당 표시할 항목 수
		private int itemsPerPage = 10; // 기본값 10
		// 한 페이지에 보여줄 시작 게시물 번호 반환
	    private int offset;       
	    // 한 페이지에 보여줄 끝 게시물 번호 반환
	    private int limit;        
		// 검색 타입
		private String searchType;
		// 검색 키워드
		private String keyword;
	}
	
	// 관리자: 회원 검색 리스트 - 결과
	@Getter @Setter
	@Builder
	public static class MemberListResponse{
		// 순번
		private int rnum;
		//회원 ID
		private String user_id;
		//회원 이름
		private String user_name;
		//회원 이메일
		private String user_email;
		//권한(DEFAULT: user)
		private String admin_ck;
		//등록일자
		private String reg_date;
		// 사용여부
		private String use_flag;
		
		public static MemberListResponse from(MemberVO vo) {
			return MemberListResponse.builder()
					.rnum(vo.getRnum())
					.user_id(vo.getUser_id())
					.user_name(Criteria.nullToEmpty(vo.getUser_name()))
					.user_email(Criteria.nullToEmpty(vo.getUser_email()))
					.admin_ck(Criteria.nullToEmpty(vo.getAdmin_ck()))
					.reg_date(Criteria.nullToEmpty(vo.getReg_date()))
					.use_flag(Criteria.nullToEmpty(vo.getUse_flag()))
					.build();
		}
	}
	
	// 관리자: 회원 상세조회 - 결과
	@Getter @Setter
	@Builder
	public static class MemberDetailResponse {
        private String user_id;
        private String user_name;
        private String user_email;
        private String post_no;
        private String addr;
        private String addr_detail;
        private String admin_ck;
        private String reg_date;
        private int money;
        private int point;
        private String use_flag;
		
		public static MemberDetailResponse from(MemberVO vo) {
			return MemberDetailResponse.builder()
                    .user_id(vo.getUser_id())
                    .user_name(vo.getUser_name())
                    .user_email(vo.getUser_email())
                    .post_no(vo.getPost_no())
                    .addr(vo.getAddr())
                    .addr_detail(vo.getAddr_detail())
                    .admin_ck(vo.getAdmin_ck())
                    .reg_date(vo.getReg_date().toString())
                    .money(vo.getMoney())
                    .point(vo.getPoint())
                    .use_flag(vo.getUse_flag())
                    .build();
		}
	}
	
	// 관리자: 회원 정보 수정 - 요청
	@Getter @Setter
	@ToString
	public static class MemberUpdateRequest {
	    private String user_id;         // 아이디
	    private String user_name;       // 이름
	    private String user_email;      // 이메일
	    private String post_no;         // 우편번호
	    private String addr;            // 주소
	    private String addr_detail;     // 상세주소
	    private int money;             // 보유 머니
	    private int point;             // 보유 포인트
	    private String use_flag;       // 회원 상태
	    private String admin_ck;       // 권한
	}
	
}
