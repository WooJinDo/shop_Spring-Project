package com.shop.front.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.front.dto.MemberDto;
import com.shop.front.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	/* 로그인 페이지 */
	@GetMapping("/login")
	public String loginPage() {
		log.info("**로그인 페이지**");
		return "member/login";
	}
	
	/* 로그인 */
	@PostMapping("/login")
	public String login(HttpSession session, Model model, RedirectAttributes redirectAttributes, 
			MemberDto.MemberLoginRequest request) throws Exception {
		 log.info("**로그인 처리**");  
		 MemberDto.MemberLoginResponse member = memberService.login(request);
		 
		if (member.isSuccess()) { 
			// 로그인 성공
			log.info("로그인 성공");
			log.info("ROLE: " + member.getAdmin_ck());
			session.setAttribute("userId", member.getUser_id());
			session.setAttribute("role", member.getAdmin_ck());
			return "redirect:/";
		} else {
		    // 로그인 실패
			log.info("로그인 실패");
			// 일회성 메세지 전달
			redirectAttributes.addFlashAttribute("error", member.getMsg());
			return "redirect:/member/login/error";
		}
	}
	
	/* 로그인 에러페이지 */
	@GetMapping("/login/error")
    public String errorPage() {
        return "member/login";
    }
	
	/* 로그아웃 */
	@GetMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		 log.info("**로그아웃 처리**");
		 session.invalidate();	// 세션을 완전히 종료
		return "redirect:/";
	}
	
	/* 회원가입 페이지 */
	@GetMapping("/register")
	public String register() {
		log.info("**회원가입 페이지**");
		return "member/register";
	}
	
	
}
