package com.shop.controller.api;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.dto.CartDto;
import com.shop.service.CartService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/api/carts")
public class ApiCartController {
	
	@Autowired
	private CartService cartService;
    
	/* 
	 * 장바구니 추가 
	 */
    @PostMapping
    public ResponseEntity<?> addCart(@RequestBody CartDto.CartRequest request,
                                    HttpSession session) throws Exception {
        log.info("**장바구니 추가 처리**");
        try {
        	String userId = (String) session.getAttribute("userId");
        	if (userId == null || userId.trim().isEmpty()) {
                return ResponseEntity
                		.status(HttpStatus.UNAUTHORIZED)
    		            .contentType(MediaType.APPLICATION_JSON_UTF8)
    		            .body("로그인이 필요한 서비스입니다.");
            }
			if (request.getBook_id() <= 0) {
			     return ResponseEntity
			            .status(HttpStatus.BAD_REQUEST)
			            .contentType(MediaType.APPLICATION_JSON_UTF8)
			            .body("유효하지 않은 상품입니다.");
			}
		    if (request.getCart_count() <= 0) {
	            return ResponseEntity
			            .status(HttpStatus.BAD_REQUEST)
			            .contentType(MediaType.APPLICATION_JSON_UTF8)
			            .body("수량은 1개 이상이어야 합니다.");
	        }
        	
            cartService.addCart(userId, request);
            
            return ResponseEntity.status(HttpStatus.CREATED).build();
            
        } catch (RuntimeException e) {
        	return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body(e.getMessage());
        } catch (Exception e) {
        	log.error("장바구니 추가 중 오류 발생", e);
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("장바구니 추가 중 오류가 발생했습니다.");
        }
        
    }
    
    /* 
	 * 장바구니 목록
	 */
    @GetMapping
    public ResponseEntity<?> cartList(HttpSession session) throws Exception {
        log.info("**장바구니 목록 조회**");
        try {
        	String userId = (String) session.getAttribute("userId");
        	if (userId == null || userId.trim().isEmpty()) {
                return ResponseEntity
                		.status(HttpStatus.UNAUTHORIZED)
    		            .contentType(MediaType.APPLICATION_JSON_UTF8)
    		            .body("로그인이 필요한 서비스입니다.");
            }
        	
            List<CartDto.CartListResponse> cartList = cartService.selectCartList(userId);
            
            return ResponseEntity.status(HttpStatus.OK).body(cartList);
            
        } catch (Exception e) {
            log.error("장바구니 목록 조회 중 오류 발생", e);
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("장바구니 목록 조회 중 오류가 발생했습니다.");
        }
        
    }
    
    /* 
	 * 장바구니 수량 수정
	 */
    @PutMapping("/{cartId}")
    public ResponseEntity<?> updateCount(@PathVariable("cartId") Long cartId,
                                       @RequestParam("count") int count) throws Exception {
        log.info("**장바구니 수량 수정 처리**");
        try {
		    if (count <= 0) {
	            return ResponseEntity
			            .status(HttpStatus.BAD_REQUEST)
			            .contentType(MediaType.APPLICATION_JSON_UTF8)
			            .body("수량은 1개 이상이어야 합니다.");
	        }
	        if (cartId == null || cartId <= 0) {
                return ResponseEntity
    		            .status(HttpStatus.BAD_REQUEST)
    		            .contentType(MediaType.APPLICATION_JSON_UTF8)
    		            .body("유효하지 않은 장바구니 정보입니다.");
            }
	        
			cartService.updateCount(cartId, count);
			return ResponseEntity.status(HttpStatus.OK).build();
			
        } catch (Exception e) {
            log.error("장바구니 수량 수정 중 오류 발생", e);
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("장바구니 수량 수정 중 오류가 발생했습니다.");
        }
     
    }
    
    /* 
	 * 장바구니 삭제
	 */
    @DeleteMapping
    public ResponseEntity<?> deleteSelectedItems(@RequestBody List<Long> cartIds, 
    		HttpSession session) {
        try {
            // 입력값 검증
            if(cartIds == null || cartIds.isEmpty()) {
                return ResponseEntity
                		.status(HttpStatus.BAD_REQUEST)
                		.contentType(MediaType.APPLICATION_JSON_UTF8)
                		.body("삭제할 상품을 선택해주세요.");
            }
            
            // 로그인 체크
            String userId = (String) session.getAttribute("userId");
        	if (userId == null || userId.trim().isEmpty()) {
                return ResponseEntity
                		.status(HttpStatus.UNAUTHORIZED)
    		            .contentType(MediaType.APPLICATION_JSON_UTF8)
    		            .body("로그인이 필요한 서비스입니다.");
            }
            
            cartService.deleteCart(cartIds, session);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
            
        } catch (RuntimeException e) {
            // 비즈니스 로직 예외
            log.error("장바구니 삭제 실패: ", e);
            return ResponseEntity
            		.status(HttpStatus.BAD_REQUEST)
            		.contentType(MediaType.APPLICATION_JSON_UTF8)
            		.body(e.getMessage());
                
        } catch (Exception e) {
        	log.error("장바구니 삭제 중 오류 발생: ", e);
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("장바구니 삭제 중 오류가 발생했습니다.");
        }
    }
    
    
}
