package com.shop.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.dao.AuthorMapper;
import com.shop.dto.AuthorDto;
import com.shop.model.AuthorVO;
import com.shop.service.AuthorService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AuthorServiceImpl implements AuthorService {
	
	@Autowired
	private AuthorMapper authorMapper;
	
	/*
	 * 관리자 - 소속국가 리스트
	 */	
//	@Override
//	public List<AuthorDto.NationListResponse> selectNationList() throws Exception {
//		List<AuthorVO> voList = authorMapper.selectNationList();
//		List<AuthorDto.NationListResponse> dtoList = new ArrayList<>();
//		
//		for(AuthorVO vo : voList) {
//			dtoList.add(AuthorDto.NationListResponse.from(vo));
//		}
//		
//		return dtoList;
//	}
	
	/*
	 * 관리자 - 작가 등록
	 */	
	@Override
	public void add(AuthorDto.AuthorRequest request) throws Exception {
		AuthorVO vo = AuthorVO.builder()
				.author_name(request.getAuthor_name().trim())
				.author_intro(request.getAuthor_intro().trim())
				.nation_id(request.getNation_id().trim())
				.build();
		authorMapper.add(vo);
		
		log.info("등록 결과 *************************** : " + vo);
	}
	
	/*
	 * 관리자 - 작가 수정
	 */	
	@Override
	public void update(AuthorDto.AuthorUpdateRequest request) throws Exception {
		AuthorVO vo = AuthorVO.builder()
				.author_id(request.getAuthor_id())
				.author_name(request.getAuthor_name().trim())
				.author_intro(request.getAuthor_intro().trim())
				.nation_id(request.getNation_id().trim())
				.build();
		authorMapper.update(vo);
		log.info("수정 결과 *************************** : " + vo);
	}
	
	/*
	 * 관리자 - 작가 삭제
	 */
	@Override
	public void delete(int authorId) throws Exception {
		authorMapper.delete(authorId);
		
		log.info("삭제 *************************** : " + authorId);
	}

	/*
	 * 관리자 - 작가 전체 게시글 수
	 */	
	@Override
	public int selectTotalCount(AuthorDto.AuthorSearchRequest request) throws Exception {
		return authorMapper.selectTotalCount(request);
	}

	/*
	 * 관리자 - 작가 리스트
	 * offset - 시작 게시물 번호, limit - 끝 게시물 번호
	 */	
	@Override
	public List<AuthorDto.AuthorListResponse> selectAuthorList(AuthorDto.AuthorSearchRequest request) 
			throws Exception {
		List<AuthorVO> voList = authorMapper.selectAuthorList(request);
		List<AuthorDto.AuthorListResponse> dtoList = new ArrayList<>();
		
		for(AuthorVO vo : voList) {
			dtoList.add(AuthorDto.AuthorListResponse.from(vo));
		}
		
		return dtoList;
	}
	
	/*
	 * 관리자 - 작가 상세
	 */	
	@Override
	public AuthorDto.AuthorDetailResponse selectAuthorDetail(int authorId) 
			throws Exception {
		AuthorVO vo = authorMapper.selectAuthorDetail(authorId);
		
		return AuthorDto.AuthorDetailResponse.from(vo);
	}
	
	

}
