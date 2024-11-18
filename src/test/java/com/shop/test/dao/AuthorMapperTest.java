package com.shop.test.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import com.shop.config.PagingUtil;
import com.shop.dao.AuthorMapper;
import com.shop.dto.AuthorDto;
import com.shop.dto.AuthorDto.AuthorSearchRequest;
import com.shop.model.AuthorVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AuthorMapperTest {
	
	
	@Autowired 
	private AuthorMapper authorMapper;
	
	// 작가 등록 테스트
//    @Test
//    public void add() throws Exception{
//        
//        AuthorVO vo = new AuthorVO();
//        
//        vo.setAuthor_name("테스트");
//        vo.setAuthor_intro("테스트 소개");
//        vo.setNation_id("01");
//        
//        authorMapper.add(vo);
//    }    
    
    // 작가 전체 게시글 수 테스트
//    @Test
//    public void select() throws Exception{
//    	AuthorDto.AuthorSearchRequest request = new AuthorSearchRequest();
//		int totalItems = authorMapper.selectTotalCount(request);	// 전체 게시글 수
//		System.out.println("totalItems : " + totalItems);
//        
//    } 
    
    // 작가 리스트 테스트
    @Test
    public void list() throws Exception{
        AuthorDto.AuthorSearchRequest request = new AuthorDto.AuthorSearchRequest();
        
        request.setCurrentPage(1);
        request.setItemsPerPage(10);
//        request.setSearchType("authorNameIntro");
//        request.setKeyword("길동");
        
    	int totalItems = authorMapper.selectTotalCount(request);	// 전체 게시글 수
		// 페이징 정보 계산
		PagingUtil pagingUtil = new PagingUtil(request.getCurrentPage(), request.getItemsPerPage(), totalItems);
        
        request.setOffset(pagingUtil.getOffset());
        request.setLimit(pagingUtil.getLimit());
        List<AuthorVO> voList = authorMapper.selectAuthorList(request);
        
        for(AuthorVO vo : voList) {
        	System.out.println("vo : " + vo);
        }
        
        
    } 
    
	// 작가 상세 테스트
//    @Test
//    public void detail() throws Exception{
//    	AuthorVO vo = authorMapper.selectAuthorDetail(100);
//        System.out.println("vo : " + vo);
//    } 
    
	// 작가 수정 테스트
//    @Test
//    public void update() throws Exception{
//    	AuthorVO vo = new AuthorVO();
//    	vo.setAuthor_id(100);
//    	System.out.println("수정 전 조회 :" + authorMapper.selectAuthorDetail(vo.getAuthor_id()));
//    	
//    	vo.setAuthor_name("러쉬");
//    	vo.setAuthor_intro("만나서 반갑습니다");
//    	vo.setNation_id("01");
//    	authorMapper.update(vo);
//    	
//        System.out.println("수정 후 조회 :" + authorMapper.selectAuthorDetail(vo.getAuthor_id()));
//    } 
	
    // 작가 삭제 테스트
//    @Test
//    public void delete() throws Exception{
//    	AuthorVO vo = new AuthorVO();
//    	vo.setAuthor_id(1);
//    	System.out.println("삭제 전 조회 :" + authorMapper.selectAuthorDetail(vo.getAuthor_id()));
//    	
//    	authorMapper.delete(vo.getAuthor_id());
//    	
//    	System.out.println("삭제 후 조회 :" + authorMapper.selectAuthorDetail(vo.getAuthor_id()));
//    } 

}
