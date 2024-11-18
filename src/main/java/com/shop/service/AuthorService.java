package com.shop.service;

import java.util.List;

import com.shop.dto.AuthorDto;

public interface AuthorService {
	
	// 관리자 - 소속국가 리스트
//	List<AuthorDto.NationListResponse> selectNationList() throws Exception;
		
	// 관리자 - 작가 등록
	void add(AuthorDto.AuthorRequest request) throws Exception;
	
	// 관리자 - 작가 수정
	void update(AuthorDto.AuthorUpdateRequest request) throws Exception;
	
	// 관리자 - 작가 삭제
	void delete(int authorId) throws Exception;
	
	// 관리자 - 작가 전체 게시글 수
	int selectTotalCount(AuthorDto.AuthorSearchRequest request) throws Exception;
	
	// 관리자 - 작가 리스트
	List<AuthorDto.AuthorListResponse> selectAuthorList(AuthorDto.AuthorSearchRequest request) throws Exception;
	
	// 관리자 - 작가 상세
	AuthorDto.AuthorDetailResponse selectAuthorDetail(int authorId) throws Exception;
}
