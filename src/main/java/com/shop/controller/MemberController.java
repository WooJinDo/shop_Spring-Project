package com.shop.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.dto.MemberDto;
import com.shop.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	/* 로그인 페이지 */
	@GetMapping("/login")
	public String loginPage(HttpSession session, Model model) {
		log.info("**로그인 페이지**");
		
		// 일정시간 동안 활동이 없을 시 세션 만료
		String msg = (String)session.getAttribute("flashMsg");
		// isNotBlank() - 문자열이 null, 빈 문자열, 또는 공백이 아니여야함
		if(StringUtils.isNotBlank(msg)) {
			model.addAttribute("flashMsg", msg);
			session.removeAttribute("flashMsg"); // 메시지를 한 번 사용한 후 제거(model에 추가 후 세선에서 제거)
		}
		return "member/login";
	}
	
	/* 로그인 */
	@PostMapping("/login")
	public String login(HttpSession session, Model model, RedirectAttributes redirectAttributes, 
			MemberDto.MemberLoginRequest request) throws Exception {
		 log.info("**로그인 처리중**");  
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
