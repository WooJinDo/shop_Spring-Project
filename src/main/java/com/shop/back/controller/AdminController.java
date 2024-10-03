package com.shop.back.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.front.controller.MemberController;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	/* 관리자 - 메인페이지 */
	@GetMapping("/main")
	public String register() {
		log.info("**관리자페이지 이동**");
		return "admin/main";
	}

}
