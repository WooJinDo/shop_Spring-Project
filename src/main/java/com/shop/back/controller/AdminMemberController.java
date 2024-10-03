package com.shop.back.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.front.controller.MemberController;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	/* 관리자 - 회원 조회 페이지 */
	@GetMapping("/list")
	public String productAdd() {
		log.info("**회원 조회 페이지 이동**");
		return "admin/member/list";
	}

}
