package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	/* 관리자 - 회원 리스트 페이지 */
	@GetMapping("/member/list")
	public String membertAdd() {
		log.info("**회원 리스트 페이지 이동**");
		return "admin/member/list";
	}
	
	/* 관리자 - 회원 상세 페이지 */
	@GetMapping("/member/detail/{id}")
	public String membertDetail(@PathVariable String id, Model model) {
		log.info("**회원 상세 페이지 이동**");
		
		model.addAttribute("user_id", id);
		
		return "admin/member/detail";
	}
	
	/* 관리자 - 회원 수정 페이지 */
	@GetMapping("/member/update/{id}")
	public String membertUpdate(@PathVariable String id, Model model) {
		log.info("**회원 수정 페이지 이동**");
		
		model.addAttribute("user_id", id);
		
		return "admin/member/update";
	}
	
	/* 관리자 - 작가 등록 페이지 */
	@GetMapping("/author/add")
	public String authortAdd(Model model) throws Exception {
		log.info("**작가 등록 페이지 이동**");
		
		return "admin/author/add";
	}
	
	/* 관리자 - 작가 리스트 페이지 */
	@GetMapping("/author/list")
	public String authorList() throws Exception {
		log.info("**작가 리스트 페이지 이동**");
		
		return "admin/author/list";
	}
	
	/* 관리자 - 작가 상세 페이지 */
	@GetMapping("/author/detail/{id}")
	public String authorDetail(@PathVariable int id, Model model) throws Exception {
		log.info("**작가 상세 페이지 이동**");
		
		model.addAttribute("author_id", id);
		
		return "admin/author/detail";
	}
	
	/* 관리자 - 작가 수정 페이지 */
	@GetMapping("/author/update/{id}")
	public String authorUpdate(@PathVariable int id, Model model) throws Exception {
		log.info("**작가 수정 페이지 이동**");
		
		model.addAttribute("author_id", id);
		
		return "admin/author/update";
	}
	
	/* 관리자 - 상품 등록 페이지 */
	@GetMapping("/book/add")
	public String productAdd() {
		log.info("**상품 등록 페이지 이동**");
		return "admin/book/add";
	}
	
	/* 관리자 - 상품 리스트 페이지 */
	@GetMapping("/book/list")
	public String productList() {
		log.info("**상품 리스트 페이지 이동**");
		return "admin/book/list";
	}
	
	/* 관리자 - 상품 상세 페이지 */
	@GetMapping("/book/detail/{id}")
	public String bookDetail(@PathVariable int id, Model model) throws Exception {
		log.info("**상품 상세 페이지 이동**");
		
		model.addAttribute("book_id", id);
		
		return "admin/book/detail";
	}
	
	/* 관리자 - 상품 수정 페이지 */
	@GetMapping("/book/update/{id}")
	public String bookUpdate(@PathVariable int id, Model model) throws Exception {
		log.info("**상품 수정 페이지 이동**");
		
		model.addAttribute("book_id", id);
		
		return "admin/book/update";
	}
	
}
