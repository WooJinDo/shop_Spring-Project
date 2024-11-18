package com.shop.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.config.PagingUtil;
import com.shop.dto.BookDto;
import com.shop.dto.MemberDto;
import com.shop.service.MemberService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class ApiMemberController {
	
	@Autowired
	private MemberService memberService;
	
	/* 
	 * 사용자 - 회원 등록
	 */
	@PostMapping("/api/register")
	public ResponseEntity<?> memberRegister(@RequestBody MemberDto.MemberRequest request) 
			throws Exception {
		log.info("**회원 등록 처리**");
		
		try {
            MemberDto.MemberResponse result = memberService.insert(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(result);
            
        } catch (RuntimeException e) {
            return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(e.getMessage());
        }
	}
	
	/* 
	 * 사용자 - 회원 중복 확인
	 */
	@PostMapping("/api/memberIdChk")
	public ResponseEntity<?> memberIdChk(@RequestBody MemberDto.MemberRequest request) 
			throws Exception {
		log.info("**회원 중복 확인 처리**");
		log.info("회원 아이디 : " + request.getUser_id().trim());
		
		MemberDto.MemberIdChkResponse idChk = memberService.memberIdChk(request.getUser_id().trim());
		
		return ResponseEntity.status(HttpStatus.OK).body(idChk);
	}
	
	/* 
	 * 사용자 - 이메일 인증
	 */
	@GetMapping("/api/memberEmailChk")
	public ResponseEntity<?> memberEmailChk(@RequestParam String email) 
			throws Exception {
		log.info("**이메일 인증 처리**");
		log.info("회원 이메일 : " + email.trim());
		
		try {
            MemberDto.MemberEmailChkResponse emailNum = memberService.memberEmailChk(email.trim());
            return ResponseEntity.status(HttpStatus.OK).body(emailNum);
            
        } catch (RuntimeException e) {
            return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(e.getMessage());
        }
	}
	
	/* 
	 * 관리자 - 회원 리스트 조회 
	 */
	@GetMapping("/api/member")
	public ResponseEntity<?> memberkList(MemberDto.MemberSearchRequest request) throws Exception {
		log.info("**회원 리스트 조회 처리**");
		
		int totalItems = memberService.selectTotalCount(request);	// 전체 수
		// 페이징 정보 계산
		PagingUtil pagingUtil = new PagingUtil(request.getCurrentPage(), request.getItemsPerPage(), totalItems);
		
		// 페이징된 회원 리스트
		request.setOffset(pagingUtil.getOffset());
		request.setLimit(pagingUtil.getLimit());
		List<MemberDto.MemberListResponse> memberList = memberService.selectMemberList(request);
		
		Map<String, Object> response = new HashMap<>();
		response.put("totalCount", totalItems);
		response.put("paging", pagingUtil);
		response.put("memberList", memberList);
		
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
	
	/* 
	 * 관리자 - 회원 상세 조회 
	 */
	@GetMapping("/api/member/{id}")
	public ResponseEntity<?> memberDetail(@PathVariable("id") String userId, Model model) 
			throws Exception {
		log.info("**회원 상세 조회 처리**");
		
        try {
            MemberDto.MemberDetailResponse result = memberService.selectMemberDetail(userId);
            return ResponseEntity.status(HttpStatus.OK).body(result);
            
        } catch (RuntimeException e) {
            return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(e.getMessage());
        }
	}
	
	/* 
	 * 관리자 - 회원 정보 수정 
	 */
	@PutMapping("/api/member/{id}")
	public ResponseEntity<?> memberUpdate(@PathVariable("id") String userId,
	        @RequestBody MemberDto.MemberUpdateRequest request) throws Exception {
		
		log.info("**회원 정보 수정 처리**");
	    try {
	        // 경로 변수의 userId와 요청 본문의 userId가 일치하는지 확인
	        if (!userId.equals(request.getUser_id())) {
	            return ResponseEntity
	                .status(HttpStatus.BAD_REQUEST)
	                .contentType(MediaType.APPLICATION_JSON_UTF8)
	                .body("잘못된 요청입니다.");
	        }
	        
	        memberService.updateMember(request);
	        return ResponseEntity.status(HttpStatus.OK).build();
	        
	    } catch (RuntimeException e) {
	        return ResponseEntity
	            .status(HttpStatus.BAD_REQUEST)
	            .contentType(MediaType.APPLICATION_JSON_UTF8)
	            .body(e.getMessage());
	    }
	}
	
	/* 
	 * 관리자 - 회원 탈퇴 처리 (논리적 삭제)
	 */
	@DeleteMapping("/api/member/{id}")
	public ResponseEntity<?> memberDelete(@PathVariable("id") String userId) 
			throws Exception {
		log.info("**상품 삭제 처리**");
	    try {
	        memberService.deleteMember(userId);
	        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
	        
	    } catch (RuntimeException e) {
	        return ResponseEntity
	            .status(HttpStatus.BAD_REQUEST)
	            .contentType(MediaType.APPLICATION_JSON_UTF8)
	            .body(e.getMessage());  // 예외 메시지를 응답 본문에 포함
	    }
	}
	
	
}
