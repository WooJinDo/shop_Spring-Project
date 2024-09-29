package com.shop.persitence;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.shop.front.dao.MemberMapper;
import com.shop.front.model.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MapperTest {
	
	
	  @Autowired 
	  private MemberMapper memberMapper;
	  
	  @Test 
	  public void memberInsert() throws Exception { 
		  MemberVO vo = new MemberVO(); 
	  vo.setUser_id("zxczcx"); vo.setUser_pw("1234");
	  vo.setUser_name("홍길동"); vo.setUser_email("abc@asd.com");
	  vo.setPost_no("abc"); vo.setAddr("testabc"); vo.setAddr_detail("상세주소");
	  vo.setAdmin_ck("USER");
	  
	  memberMapper.insert(vo); 
	  }
	 
	
}
