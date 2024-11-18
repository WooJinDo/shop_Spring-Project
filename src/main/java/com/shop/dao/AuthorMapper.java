package com.shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.dto.AuthorDto;
import com.shop.model.AuthorVO;

/*DAO 역할 = data access object*/
public interface AuthorMapper {
	
	// 관리자 - 소속국가 리스트
//	public List<AuthorVO> selectNationList();
		
	// 관리자 - 작가 등록
	public void add(AuthorVO vo);
	
	// 관리자 - 작가 수정
	public void update(AuthorVO vo);
	
	// 관리자 - 작가 삭제
	public void delete(@Param("authorId") int authorId);
	
	// 관리자 - 작가 전체 게시글 수
	public int selectTotalCount(AuthorDto.AuthorSearchRequest request);
	
	// 관리자 - 작가 리스트
	public List<AuthorVO> selectAuthorList(AuthorDto.AuthorSearchRequest request);
	
	// 관리자 - 작가 상세
	// @Param 어노테이션을 사용하면 매퍼 XML에서 파라미터를 더 쉽게 참조
	public AuthorVO selectAuthorDetail(@Param("authorId") int authorId);
	
}
	