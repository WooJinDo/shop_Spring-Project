package com.shop.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.dto.MemberDto;
import com.shop.service.MemberService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class ApiMemberController {
	
	@Autowired
	private MemberService memberService;
	
	//회원 등록
	@PostMapping("/api/register")
	public ResponseEntity<?> memberRegister(@RequestBody MemberDto.MemberRequest request) 
			throws Exception {
		log.info("**회원 등록**");
		
		MemberDto.MemberResponse result = memberService.insert(request);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(result);
	}
	
	//회원 중복 확인
	@PostMapping("/api/memberIdChk")
	public ResponseEntity<?> memberIdChk(@RequestBody MemberDto.MemberRequest request) 
			throws Exception {
		log.info("**회원 중복 확인**");
		log.info("회원 아이디 : " + request.getUser_id().trim());
		
		MemberDto.MemberIdChkResponse idChk = memberService.memberIdChk(request.getUser_id().trim());
		
		return ResponseEntity.status(HttpStatus.OK).body(idChk);
	}
	
	//이메일 인증
	@GetMapping("/api/memberEmailChk")
	public ResponseEntity<?> memberEmailChk(@RequestParam String email) 
			throws Exception {
		log.info("**이메일 인증**");
		log.info("회원 이메일 : " + email.trim());
		
		MemberDto.MemberEmailChkResponse emailNum = memberService.memberEmailChk(email.trim());
		
		return ResponseEntity.status(HttpStatus.OK).body(emailNum);
	}
	
	
}
