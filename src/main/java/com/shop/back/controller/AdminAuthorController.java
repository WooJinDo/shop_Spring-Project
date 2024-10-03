package com.shop.back.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.front.controller.MemberController;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/author")
public class AdminAuthorController {
	
	/* 관리자 - 작가 등록 페이지 */
	@GetMapping("/add")
	public String productAdd() {
		log.info("**작가 등록 페이지 이동**");
		return "admin/author/add";
	}
	
	/* 관리자 - 작가 조회 페이지 */
	@GetMapping("/list")
	public String authorList() {
		log.info("**작가 조회 페이지 이동**");
		return "admin/author/list";
	}

}