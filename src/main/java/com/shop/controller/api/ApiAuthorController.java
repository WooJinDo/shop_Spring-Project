package com.shop.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.config.PagingUtil;
import com.shop.dto.AuthorDto;
import com.shop.service.AuthorService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/api/author")
public class ApiAuthorController {
	
	@Autowired
	private AuthorService authorService;
	
	// 관리자 - 작가 리스트 조회
	@GetMapping
	public ResponseEntity<?> authorList(AuthorDto.AuthorSearchRequest request) throws Exception {
		log.info("**작가 리스트 조회 처리**");
		
		int totalItems = authorService.selectTotalCount(request);	// 전체 게시글 수
		// 페이징 정보 계산
		PagingUtil pagingUtil = new PagingUtil(request.getCurrentPage(), request.getItemsPerPage(), totalItems);
		
		// 페이징된 작가 리스트
		request.setOffset(pagingUtil.getOffset());
		request.setLimit(pagingUtil.getLimit());
		List<AuthorDto.AuthorListResponse> authorList = authorService.selectAuthorList(request);
		
		Map<String, Object> response = new HashMap<>();
		response.put("totalCount", totalItems);
		response.put("paging", pagingUtil);
		response.put("authorList", authorList);
		
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
	
	// 관리자 - 작가 상세 조회
	@GetMapping("/{id}")
	public ResponseEntity<?> authorDetail(@PathVariable("id") int authorId, Model model) 
			throws Exception {
		log.info("**작가 상세 조회 처리**");
		
		AuthorDto.AuthorDetailResponse authorDetailResponse = authorService.selectAuthorDetail(authorId);
		
		return ResponseEntity.status(HttpStatus.OK).body(authorDetailResponse);
	}
	
	// 관리자 - 작가 등록
	@PostMapping
	public ResponseEntity<?> authorAdd(@RequestBody AuthorDto.AuthorRequest request) 
			throws Exception {
		log.info("**작가 등록 처리**");
		
		authorService.add(request);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(request);
	}
	
	// 관리자 - 작가 수정
	@PutMapping("/{id}")
	public ResponseEntity<?> authorUpdate(@PathVariable("id") int authorId, 
			@RequestBody AuthorDto.AuthorUpdateRequest request) throws Exception {
		log.info("**작가 수정 처리**");
		
		request.setAuthor_id(authorId);
		authorService.update(request);
		
		return ResponseEntity.status(HttpStatus.OK).body(request);
	}
	
	// 관리자 - 작가 삭제
	@DeleteMapping("/{id}")
	public ResponseEntity<?> authorDelete(@PathVariable("id") int authorId) 
			throws Exception {
		log.info("**작가 삭제 처리**");
		
		authorService.delete(authorId);
		
		return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
	}
	
}
