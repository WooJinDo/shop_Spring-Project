package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/book")
public class BookController {
	
	/* 상품리스트 페이지 */
	@GetMapping("/list")
	public String shopBookList() {
		log.info("**상품리스트 페이지 이동**");
		return "book/list";
	}
	
	/* 상품 상세 페이지 */
	@GetMapping("/detail/{id}")
	public String shopBookDetail(@PathVariable int id, Model model) throws Exception {
		log.info("**상품 상세 페이지 이동**");
		
		model.addAttribute("book_id", id);
		
		return "book/detail";
	}
	
	
}
