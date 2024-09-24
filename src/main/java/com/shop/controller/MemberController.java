package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	//로그인 페이지
	@GetMapping("/login")
	public String login() {
		log.info("**로그인 페이지**");
		return "member/login";
	}
	
	//회원가입 페이지
	@GetMapping("/register")
	public String register() {
		log.info("**회원가입 페이지**");
		return "member/register";
	}
	
	//회원 등록
//	@PostMapping("/register")
//	public String insertMember(MemberVO member) throws Exception {
//		log.info("**회원 등록**");
//		
//		memberService.insert(member);
//		
//		return "";
//	}
	
	
}
