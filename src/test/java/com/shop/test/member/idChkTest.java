package com.shop.test.member;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import com.shop.dao.MemberMapper;

@WebAppConfiguration
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class idChkTest {
	
	@Autowired 
	private MemberMapper memberMapper;
	
	@Test
	public void memberIdChk() {
		String id = "test123";	//존재하는 아이디
		String id2 = "vvv";		//존재하지 않는 아이디
		
		memberMapper.memberIdChk(id);
		memberMapper.memberIdChk(id2);
	}

}
