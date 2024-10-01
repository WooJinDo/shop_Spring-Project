package com.shop.front.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ExceptionController {
	
	/* access-denied 처리 */
	@GetMapping("/accessDenied")
	public String accessDenied() {
		log.info("access-denied 에러 발생");
		return "exception/accessDenied";
	}
}
