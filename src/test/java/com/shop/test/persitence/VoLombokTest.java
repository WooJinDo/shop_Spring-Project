package com.shop.test.persitence;


import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import com.shop.model.MemberVO;

@WebAppConfiguration
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class VoLombokTest {
	
	@Autowired
	private MemberVO vo2;
		
	@Test
	public void value() {
		
		vo2.setAddr("test");
		vo2.setAddr_detail("상세주소");
		System.out.println("==========================");
		System.out.println(vo2);
		System.out.println(vo2.getAddr());
		System.out.println(vo2.getAddr_detail());

	}
	
}
