package com.shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.dto.BookDto;
import com.shop.model.BookVO;
import com.shop.model.CategoryVO;

/*DAO 역할 = data access object*/
public interface BookMapper {
	
	// 전체 카테고리 목록 조회 
	public List<CategoryVO> selectCategoryList();
	
    // 특정 부모 카테고리의 하위 카테고리 조회
	public List<CategoryVO> selectSubCategoryList(@Param("parentCode") String parentCode);
    
    // 특정 계층의 카테고리 조회 
	public List<CategoryVO> selectCategoryListByTier(@Param("tier") int tier);
	
	// 카테고리별 상품리스트 조회
	public List<BookVO> selectBookListByCategory(BookDto.BookListCatetorySearchRequest request);
	
	// 카테고리별 상품 전체 개수 조회
	public int selectTotalCountByCategory(BookDto.BookListCatetorySearchRequest request);
	
	// 관리자 - 상품 등록
	public void add(BookVO vo);
	
	// 관리자 - 상품 수정
	public void update(BookVO vo);
	
	// 관리자 - 상품 삭제
	public void delete(@Param("bookId") int bookId);
	
	// 관리자 - 상품 전체 게시글 수
	public int selectTotalCount(BookDto.BookSearchRequest request);
	
	// 관리자 - 상품 리스트
	public List<BookVO> selectBookList(BookDto.BookSearchRequest request);
	
	// 관리자 - 상품 상세
	public BookVO selectBookDetail(@Param("bookId") int bookId);
	
	// 카테고리별 도서 상세 조회
	public BookVO selectShopBookDetail(@Param("bookId") int bookId);
	
}
	