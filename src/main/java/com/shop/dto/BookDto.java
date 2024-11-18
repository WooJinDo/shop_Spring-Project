package com.shop.dto;

import com.shop.model.BookVO;
import com.shop.model.CategoryVO;
import com.shop.model.Criteria;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class BookDto {
	
	// 관리자: 상품 등록 - 요청
	@Getter @Setter
	@ToString
	public static class BookRequest{
		// 작가 아이디
		private int author_id;
		// 카테고리 코드
		private String category_code;
		// 상품명
		private String book_name;
		// 출판일
		private String puble_year;
		// 출판사
		private String publisher;
		// 상품 가격
		private int book_price;
		// 상품 수량
		private int book_stock;
		// 상품 할인율
		private double book_discount;
		// 상품 소개
		private String book_intro;
		// 상품 내용
		private String book_contents;
	}
	
	// 관리자: 카테고리 리스트 - 결과
	@Getter @Setter
	@Builder
	public static class CategoryListResponse{
		// 계층(트리구조)
		private int tier;
		// 카테고리명
		private String category_name;
		// 카테고리 코드(부모)
		private String category_code;
		// 부모카테고리 참조
		private String category_parent_code;
		
		public static CategoryListResponse from(CategoryVO vo) {
			return CategoryListResponse.builder()
					.tier(vo.getTier())
					.category_name(Criteria.nullToEmpty(vo.getCategory_name()))
					.category_code(Criteria.nullToEmpty(vo.getCategory_code()))
					.category_parent_code(Criteria.nullToEmpty(vo.getCategory_parent_code()))
					.build();
		}
	}
	
    // 카테고리별 상품 검색 리스트 - 요청 
    @Getter @Setter
    @ToString
    public static class BookListCatetorySearchRequest {
        // 현재 페이지 번호
        private int currentPage = 1;
        // 한 페이지당 표시할 항목 수
        private int itemsPerPage = 10;
        // 시작 위치
        private int offset;
        // 끝 위치
        private int limit;
        // 카테고리 코드
        private String categoryCode;
        // 검색 타입
        private String searchType;
        // 검색 키워드
        private String keyword;
    }
    
    // 카테고리별 상품 검색 리스트 - 결과 
    @Getter @Setter
    @Builder
    public static class BookListCatetoryResponse {
        private int rnum;
        private int book_id;
        private String book_name;
    	private String publisher;
    	private String puble_year;
        private int book_price;
        private Double book_discount;
        private String book_intro;
        private String author_name;
        private String upload_path;
        private String saved_name;
        private String reg_date;
        
        public static BookListCatetoryResponse from(BookVO vo) {
            return BookListCatetoryResponse.builder()
                    .rnum(vo.getRnum())
                    .book_id(vo.getBook_id())
                    .book_name(Criteria.nullToEmpty(vo.getBook_name()))
                    .publisher(Criteria.nullToEmpty(vo.getPublisher()))
                    .puble_year(Criteria.nullToEmpty(vo.getPuble_year()))
                    .book_price(vo.getBook_price())
                    .book_discount(vo.getBook_discount())
                    .book_intro(Criteria.nullToEmpty(vo.getBook_intro()))
                    .author_name(Criteria.nullToEmpty(vo.getAuthor_name()))
                    .upload_path(Criteria.nullToEmpty(vo.getUpload_path()))
                    .saved_name(Criteria.nullToEmpty(vo.getSaved_name()))
                    .reg_date(Criteria.nullToEmpty(vo.getReg_date()))
                    .build();
        }
    }
    
	// 카테고리별 도서 상세 조회 - 결과
	@Getter @Setter
	@Builder
	public static class ShopBookDetailResponse {
		// 상품 아이디
		private int book_id;
		// 작가 아이디
		private int author_id;
		// 작가명
		private String author_name;
		// 카테고리 코드
		private String category_code;
		// 카테고리명
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
		// 상품 내용
		private String book_contents;
		
		public static ShopBookDetailResponse from(BookVO vo) {
			return ShopBookDetailResponse.builder()
					.book_id(vo.getBook_id())
					.author_id(vo.getAuthor_id())
					.author_name(Criteria.nullToEmpty(vo.getAuthor_name()))
					.category_code(Criteria.nullToEmpty(vo.getCategory_code()))
					.category_name1(Criteria.nullToEmpty(vo.getCategory_name1()))
					.category_name2(Criteria.nullToEmpty(vo.getCategory_name2()))
					.category_name3(Criteria.nullToEmpty(vo.getCategory_name3()))
					.book_name(Criteria.nullToEmpty(vo.getBook_name()))
					.puble_year(Criteria.nullToEmpty(vo.getPuble_year()))
					.publisher(Criteria.nullToEmpty(vo.getPublisher()))
					.book_price(vo.getBook_price())
					.book_stock(vo.getBook_stock())
					.book_discount(vo.getBook_discount())
					.book_intro(Criteria.nullToEmpty(vo.getBook_intro()))
					.book_contents(Criteria.nullToEmpty(vo.getBook_contents()))
					.build();
		}
	}
	
	// 관리자: 상품 검색 리스트 - 요청
	@Getter @Setter
	@ToString
	public static class BookSearchRequest{
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
	
	// 관리자: 상품 리스트 - 결과
	@Getter @Setter
	@Builder
	public static class BookListResponse{
		// 순번
		private int rnum;
		// 상품 아이디
		private int book_id;
		// 작가명
		private String author_name;
		// 카테고리명
		private String category_name;
		// 상품명
		private String book_name;
		// 상품 수량
		private int book_stock;
		// 등록날짜
		private String reg_date;
		
		public static BookListResponse from(BookVO vo) {
			return BookListResponse.builder()
					.rnum(vo.getRnum())
					.book_id(vo.getBook_id())
					.author_name(Criteria.nullToEmpty(vo.getAuthor_name()))
					.category_name(Criteria.nullToEmpty(vo.getCategory_name()))
					.book_name(Criteria.nullToEmpty(vo.getBook_name()))
					.book_stock(vo.getBook_stock())
					.reg_date(Criteria.nullToEmpty(vo.getReg_date()))
					.build();
		}
	}
	
	// 관리자: 상품 상세 - 결과
	@Getter @Setter
	@Builder
	public static class BookDetailResponse{
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
		// 상품 내용
		private String book_contents;
		// 등록날짜
		private String reg_date;
		// 수정날짜
		private String update_date;
		// 사용여부
		private String use_flag;
		
		public static BookDetailResponse from(BookVO vo) {
			return BookDetailResponse.builder()
					.book_id(vo.getBook_id())
					.author_id(vo.getAuthor_id())
					.author_name(Criteria.nullToEmpty(vo.getAuthor_name()))
					.category_code(Criteria.nullToEmpty(vo.getCategory_code()))
					.category_name(Criteria.nullToEmpty(vo.getCategory_name()))
					.book_name(Criteria.nullToEmpty(vo.getBook_name()))
					.puble_year(Criteria.nullToEmpty(vo.getPuble_year()))
					.publisher(Criteria.nullToEmpty(vo.getPublisher()))
					.book_price(vo.getBook_price())
					.book_stock(vo.getBook_stock())
					.book_discount(vo.getBook_discount())
					.book_intro(Criteria.nullToEmpty(vo.getBook_intro()))
					.book_contents(Criteria.nullToEmpty(vo.getBook_contents()))
					.reg_date(Criteria.nullToEmpty(vo.getReg_date()))
					.update_date(Criteria.nullToEmpty(vo.getUpdate_date()))
					.use_flag(Criteria.nullToEmpty(vo.getUse_flag()))
					.build();
		}
	}
	
	// 관리자: 상품 수정 - 요청
	@Getter @Setter
	@ToString
	public static class BookUpdateRequest{
		// 상품 아이디
		private int book_id;
		// 작가 아이디
		private int author_id;
		// 카테고리 코드
		private String category_code;
		// 상품명
		private String book_name;
		// 출판일
		private String puble_year;
		// 출판사
		private String publisher;
		// 상품 가격
		private int book_price;
		// 상품 수량
		private int book_stock;
		// 상품 할인율
		private double book_discount;
		// 상품 소개
		private String book_intro;
		// 상품 내용
		private String book_contents;
	}

}
