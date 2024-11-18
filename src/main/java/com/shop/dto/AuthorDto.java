package com.shop.dto;

import com.shop.model.AuthorVO;
import com.shop.model.Criteria;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class AuthorDto {
	
	// 관리자: 소속국가 리스트 - 결과
	@Getter @Setter
	@Builder
	public static class NationListResponse{
		// 국가 아이디
		private String nation_id;
		// 소속 국가
		private String nation_name;
		
		public static NationListResponse from(AuthorVO vo) {
			return NationListResponse.builder()
					.nation_id(vo.getNation_id())
					.nation_name(vo.getNation_name())
					.build();
		}
	}
	
	// 관리자: 작가 등록 - 요청
	@Getter @Setter
	@ToString
	public static class AuthorRequest{
		// 작가 이름
		private String author_name;
		// 작가 소개
		private String author_intro;
		// 국가 아이디
		private String nation_id;
	}
	
	// 관리자: 작가 등록 - 결과
//	@Getter @Setter
//	@Builder
//	public static class AuthorResponse{
//		private String author_name;
//		private String author_intro;
//		private String nation_id;
//		
//		public static AuthorResponse from(AuthorVO vo) {
//			return AuthorResponse.builder()
//					.author_name(vo.getAuthor_name())
//					.author_intro(vo.getAuthor_intro())
//					.nation_id(vo.getNation_id())
//					.build();
//		}
//	}
	
	// 관리자: 작가 수정 - 요청
	@Getter @Setter
	@ToString
	public static class AuthorUpdateRequest{
		// 작가 아이디
		private int author_id;
		// 작가 이름
		private String author_name;
		// 작가 소개
		private String author_intro;
		// 국가 아이디
		private String nation_id;
	}
	
	// 관리자: 작가 수정 - 결과
//	@Getter @Setter
//	@Builder
//	public static class AuthorUpdateResponse{
//		private boolean success;
//		
//		public static AuthorUpdateResponse from(boolean success) {
//			return AuthorUpdateResponse.builder()
//					.success(success)
//					.build();
//		}
//	}
	
	// 관리자: 작가 검색 리스트 - 요청
	@Getter @Setter
	@ToString
	public static class AuthorSearchRequest{
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
		
	// 관리자: 작가 리스트 - 결과
	@Getter @Setter
	@Builder
	public static class AuthorListResponse{
		// 순번
		private int rnum;
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
		
		public static AuthorListResponse from(AuthorVO vo) {
			return AuthorListResponse.builder()
					.rnum(vo.getRnum())
					.author_id(vo.getAuthor_id())
					.author_name(Criteria.nullToEmpty(vo.getAuthor_name()))
					.author_intro(Criteria.nullToEmpty(vo.getAuthor_intro()))
					.nation_id(Criteria.nullToEmpty(vo.getNation_id()))
					.nation_name(Criteria.nullToEmpty(vo.getNation_name()))
					.reg_date(Criteria.nullToEmpty(vo.getReg_date()))
					.update_date(Criteria.nullToEmpty(vo.getUpdate_date()))
					.build();
		}
	}
	
	// 관리자: 작가 상세 - 결과
	@Getter @Setter
	@Builder
	public static class AuthorDetailResponse{
		// 작가 아이디
		private int author_id;
		// 작가 이름
		private String author_name;
		// 작가 소개
		private String author_intro;
		// 국가 아이디
		private String nation_id;
		// 등록날짜
		private String reg_date;
		// 수정날짜
		private String update_date;
		
		public static AuthorDetailResponse from(AuthorVO vo) {
			return AuthorDetailResponse.builder()
					.author_id(vo.getAuthor_id())
					.author_name(Criteria.nullToEmpty(vo.getAuthor_name()))
					.author_intro(Criteria.nullToEmpty(vo.getAuthor_intro()))
					.nation_id(Criteria.nullToEmpty(vo.getNation_id()))
					.reg_date(Criteria.nullToEmpty(vo.getReg_date()))
					.update_date(Criteria.nullToEmpty(vo.getUpdate_date()))
					.build();
		}
	}
}
