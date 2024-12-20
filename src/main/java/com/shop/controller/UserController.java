package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user")
public class UserController {
	
	/* 일반회원 - 장바구니 페이지 */
	@GetMapping("/cart/list")
	public String cartPage() {
		log.info("**장바구니 페이지 이동**");
		return "user/cart/list";
	}
	
}
