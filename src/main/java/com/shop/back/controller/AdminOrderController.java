package com.shop.back.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.front.controller.MemberController;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order")
public class AdminOrderController {
	
	/* 관리자 - 주문 조회 페이지 */
	@GetMapping("/list")
	public String productAdd() {
		log.info("**주문 조회 페이지 이동**");
		return "admin/order/list";
	}

}
