package com.shop.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.dao.AuthorMapper;
import com.shop.dto.AuthorDto;
import com.shop.dto.MemberDto;
import com.shop.model.AuthorVO;
import com.shop.model.MemberVO;
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
	@Transactional
	@Override
	public void add(AuthorDto.AuthorRequest request) throws Exception {
        try {
            // 입력값 검증
            if (request.getAuthor_name() == null || request.getAuthor_name().trim().isEmpty()) {
                throw new RuntimeException("작가 이름은 필수 입력값입니다.");
            }
            
            AuthorVO vo = AuthorVO.builder()
                    .author_name(request.getAuthor_name().trim())
                    .author_intro(request.getAuthor_intro().trim())
                    .nation_id(request.getNation_id().trim())
                    .build();
                    
            authorMapper.add(vo);
            log.info("작가 등록 완료: " + vo);
            
        } catch (Exception e) {
            log.error("작가 등록 실패", e);
            throw new RuntimeException("작가 등록 중 오류가 발생했습니다.", e);
        }
	}
	
	/*
	 * 관리자 - 작가 수정
	 */	
	@Transactional
	@Override
	public void update(AuthorDto.AuthorUpdateRequest request) throws Exception {
        try {
            // 기존 작가 존재 여부 확인
            AuthorVO existingAuthor = authorMapper.selectAuthorDetail(request.getAuthor_id());
            if (existingAuthor == null) {
                throw new RuntimeException("수정할 작가 정보를 찾을 수 없습니다.");
            }

            AuthorVO vo = AuthorVO.builder()
                    .author_id(request.getAuthor_id())
                    .author_name(request.getAuthor_name().trim())
                    .author_intro(request.getAuthor_intro().trim())
                    .nation_id(request.getNation_id().trim())
                    .build();
                    
            authorMapper.update(vo);
            log.info("작가 수정 완료: " + vo);
            
        } catch (Exception e) {
            log.error("작가 수정 실패", e);
            throw new RuntimeException("작가 수정 중 오류가 발생했습니다.", e);
        }
	}
	
	/*
	 * 관리자 - 작가 삭제
	 */
	@Transactional
	@Override
	public void delete(int authorId) throws Exception {
        try {
            // 기존 작가 존재 여부 확인  
            AuthorVO existingAuthor = authorMapper.selectAuthorDetail(authorId);
            if (existingAuthor == null) {
                throw new RuntimeException("삭제할 작가 정보를 찾을 수 없습니다.");
            }
            
            authorMapper.delete(authorId);
            log.info("작가 삭제 완료: " + authorId);
            
        } catch (Exception e) {
            log.error("작가 삭제 실패", e);
            throw new RuntimeException("작가 삭제 중 오류가 발생했습니다.", e);
        }
	}

	/*
	 * 관리자 - 작가 전체 게시글 수
	 */	
	@Override
	public int selectTotalCount(AuthorDto.AuthorSearchRequest request) throws Exception {
	    try {
	    	return authorMapper.selectTotalCount(request);
	    } catch (Exception e) {
	        log.error("전체 건수 조회 실패", e);
	        throw new Exception("전체 건수 조회 중 오류가 발생했습니다.");
	    }
	}

	/*
	 * 관리자 - 작가 리스트
	 * offset - 시작 게시물 번호, limit - 끝 게시물 번호
	 */	
	@Override
	public List<AuthorDto.AuthorListResponse> selectAuthorList(AuthorDto.AuthorSearchRequest request) 
			throws Exception {
	    try {
			List<AuthorVO> voList = authorMapper.selectAuthorList(request);
			List<AuthorDto.AuthorListResponse> dtoList = new ArrayList<>();
			
			for(AuthorVO vo : voList) {
				dtoList.add(AuthorDto.AuthorListResponse.from(vo));
			}
			
			return dtoList;
	    
	    } catch (Exception e) {
	        log.error("작가 리스트 조회 실패", e);
	        throw new Exception("작가 리스트 조회 중 오류가 발생했습니다.");
	    }
	}
	
	/*
	 * 관리자 - 작가 상세
	 */	
	@Override
	public AuthorDto.AuthorDetailResponse selectAuthorDetail(int authorId) 
			throws Exception {
        try {
        	AuthorVO vo = authorMapper.selectAuthorDetail(authorId);
        	if(vo == null) {
				throw new RuntimeException("존재하지 않는 작가입니다.");
			}
        	
    		return AuthorDto.AuthorDetailResponse.from(vo);
			
	    } catch (Exception e) {
	    	log.error("작가 상세 조회 실패 - authorId: " + authorId, e);
	    	throw new RuntimeException("작가 상세 조회 중 오류가 발생했습니다.", e);
	    }
	}
	
	

}
