package com.shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.model.CartVO;

/*DAO 역할 = data access object*/
public interface CartMapper {
	
    // 장바구니 추가
    void addCart(CartVO cart);
    
    // 장바구니 목록
    List<CartVO> selectCartList(String userId);
    
    // 장바구니 수량 수정
    void updateCount(@Param("cart_id") Long cartId, @Param("cart_count") int count);
    
    // 장바구니 삭제
    void deleteCart(List<Long> cartIds);
    
    // 장바구니 소유자 확인
    List<CartVO> selectCartById(List<Long> cartIds);
    
    // 장바구니 중복 체크
    int checkCart(@Param("book_id") int bookId, @Param("user_id") String userId);
	
}
	