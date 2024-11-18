package com.shop.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.shop.dto.BookDto;
import com.shop.dto.CartDto;
import com.shop.dto.CategoryDto;
import com.shop.model.CategoryVO;

public interface CartService {
	
    // 장바구니 추가
    void addCart(String userId, CartDto.CartRequest request) throws Exception;
    
    // 장바구니 목록
    List<CartDto.CartListResponse> selectCartList(String userId) throws Exception;
    
    // 장바구니 수량 수정
    void updateCount(Long cartId, int count) throws Exception;
    
    // 장바구니 삭제
    void deleteCart(List<Long> cartIds, HttpSession session) throws Exception;
	
}
