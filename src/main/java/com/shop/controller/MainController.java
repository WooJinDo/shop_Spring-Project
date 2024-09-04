package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String home() {
		log.info("메인페이지 접속");
		
		return "main";
	}
	
}
