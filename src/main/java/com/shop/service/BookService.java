package com.shop.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.shop.dto.BookDto;
import com.shop.dto.CategoryDto;
import com.shop.model.CategoryVO;

public interface BookService {
	
	// 전체 카테고리 목록 조회
	List<CategoryDto.CategoryListResponse> selectCategoryList() throws Exception;
	
	// 특정 계층의 카테고리 조회 
	List<CategoryDto.CategoryListResponse> selectCategoryListByTier(int tier) throws Exception;
	
	// 특정 부모 카테고리의 하위 카테고리 조회
	List<CategoryDto.CategoryListResponse> selectSubCategoryList(String parentCode) throws Exception;
	
	// 카테고리별 상품리스트 조회
	List<BookDto.BookListCatetoryResponse> selectBookListByCategory(BookDto.BookListCatetorySearchRequest request)
			throws Exception;
	
	// 카테고리별 상품 전체 개수 조회
	int selectTotalCountByCategory(BookDto.BookListCatetorySearchRequest request) throws Exception;
	
	// 카테고리별 도서 상세 조회
	Map<String, Object> selectShopBookDetail(int bookId) throws Exception;
		
	// 관리자 - 상품 등록
	void add(BookDto.BookRequest request, List<MultipartFile> files) throws Exception;
	
	// 관리자 - 상품 수정
	void update(BookDto.BookUpdateRequest request, List<MultipartFile> files) throws Exception;
	
	// 관리자 - 상품 삭제
	void delete(int bookId) throws Exception;
	
	// 관리자 - 상품 전체 게시글 수
	int selectTotalCount(BookDto.BookSearchRequest request) throws Exception;
	
	// 관리자 - 상품 리스트
	List<BookDto.BookListResponse> selectBookList(BookDto.BookSearchRequest request) throws Exception;
	
	// 관리자 - 상품 상세
	Map<String, Object> selectBookDetail(int bookId) throws Exception;
	
}
