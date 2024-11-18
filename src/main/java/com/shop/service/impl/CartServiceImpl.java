package com.shop.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.dao.BookMapper;
import com.shop.dao.CartMapper;
import com.shop.dto.BookDto;
import com.shop.dto.CartDto;
import com.shop.dto.CategoryDto;
import com.shop.dto.ImageDto;
import com.shop.dto.ImageDto.ImageUploadRequest;
import com.shop.model.BookVO;
import com.shop.model.CartVO;
import com.shop.model.CategoryVO;
import com.shop.service.BookService;
import com.shop.service.CartService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;
	
    
    /**
	 * 장바구니 추가
	 */
	@Transactional
	@Override
    public void addCart(String userId, CartDto.CartRequest request) throws Exception {
        try {
            // 장바구니 중복 체크
            int count = cartMapper.checkCart(request.getBook_id(), userId);
            if(count > 0) {
                throw new RuntimeException("이미 장바구니에 담긴 상품입니다.");
            }
            
            // 장바구니 추가
            CartVO cart = CartVO.builder()
                    .user_id(userId)
                    .book_id(request.getBook_id())
                    .cart_count(request.getCart_count())
                    .build();
            
            cartMapper.addCart(cart);
            log.info("장바구니 추가 완료 - userId: " + userId + ", bookId: " + request.getBook_id());
            
        } catch (RuntimeException e) {
            log.error("장바구니 추가 실패 - " + e.getMessage());
            throw e;
        } catch (Exception e) {
            log.error("장바구니 추가 실패", e);
            throw new RuntimeException("장바구니 추가 중 오류가 발생했습니다.", e);
        }
    }
    
    /**
	 * 장바구니 목록
	 */
    @Override
    public List<CartDto.CartListResponse> selectCartList(String userId) throws Exception {
        try {
            List<CartVO> cartList = cartMapper.selectCartList(userId);
            List<CartDto.CartListResponse> dtoList = new ArrayList<>();
            
            for(CartVO cart : cartList) {
                dtoList.add(CartDto.CartListResponse.from(cart));
            }
            
            log.info("장바구니 조회 완료 - userId: " + userId + ", count: " + dtoList.size());
            return dtoList;
            
        } catch (Exception e) {
            log.error("장바구니 조회 실패", e);
            throw new RuntimeException("장바구니 조회 중 오류가 발생했습니다.", e);
        }
    }
    
    /**
	 * 장바구니 수량 수정
	 */
    @Transactional
    @Override
    public void updateCount(Long cartId, int count) throws Exception {
        try {
            cartMapper.updateCount(cartId, count);
            log.info("장바구니 수량 수정 완료 - cartId: " + cartId + ", count: " + count);
            
        } catch (Exception e) {
            log.error("장바구니 수량 수정 실패", e);
            throw new RuntimeException("장바구니 수량 수정 중 오류가 발생했습니다.", e);
        }
    }
    
    /**
	 * 장바구니 삭제
	 */
    @Transactional
    @Override
    public void deleteCart(List<Long> cartIds, HttpSession session) throws Exception {
        try {
        	String userId = (String) session.getAttribute("userId");
        	
            // 장바구니 소유자 확인
            List<CartVO> cartItems = cartMapper.selectCartById(cartIds);
            for(CartVO cart : cartItems) {
                if(!userId.equals(cart.getUser_id())) {
                    throw new RuntimeException("본인의 장바구니 항목만 삭제할 수 있습니다.");
                }
            }
            
            cartMapper.deleteCart(cartIds);
            log.info("장바구니 삭제 완료 - cartId: " + cartIds);
            
        } catch (Exception e) {
            log.error("장바구니 삭제 실패", e);
            throw new RuntimeException("장바구니 삭제 중 오류가 발생했습니다.", e);
        }
    }
    
}
