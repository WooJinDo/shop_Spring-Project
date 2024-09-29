package com.shop.member;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.shop.front.dao.MemberMapper;

@RunWith(SpringJUnit4ClassRunner.class)
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
