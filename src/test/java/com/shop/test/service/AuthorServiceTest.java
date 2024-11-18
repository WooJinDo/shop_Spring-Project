package com.shop.test.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import com.shop.dto.AuthorDto;
import com.shop.service.AuthorService;

@WebAppConfiguration
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AuthorServiceTest {

	@Autowired 
	private AuthorService authorService;
	
	// 작가 등록 테스트
    @Test
    public void add() throws Exception{
        
        AuthorDto.AuthorRequest dto = new AuthorDto.AuthorRequest();
        
        dto.setAuthor_name("테스트2");
        dto.setAuthor_intro("테스트 소개2");
        dto.setNation_id("02");
        
        authorService.add(dto);
    }   
}
