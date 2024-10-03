package com.shop.back.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.front.controller.MemberController;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/product")
public class AdminProductController {
	
	/* 관리자 - 상품 등록 페이지 */
	@GetMapping("/add")
	public String productAdd() {
		log.info("**상품 등록 페이지 이동**");
		return "admin/product/add";
	}
	
	/* 관리자 - 상품 조회 페이지 */
	@GetMapping("/list")
	public String productList() {
		log.info("**상품 조회 페이지 이동**");
		return "admin/product/list";
	}

}
