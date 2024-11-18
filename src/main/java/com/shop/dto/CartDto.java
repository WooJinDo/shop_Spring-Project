package com.shop.dto;

import com.shop.model.CartVO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class CartDto {
	
    // 장바구니 추가 - 요청
    @Getter @Setter
    @ToString
    public static class CartRequest {
        private int book_id;
        private int cart_count;
    }
    
    // 장바구니 목록 - 응답
    @Getter @Setter
    @Builder
    public static class CartListResponse {
        private Long cart_id;
        private String book_name;
        private int book_price;
        private double book_discount;
        private int cart_count;
        private String saved_name;
        private String upload_path;
        private int book_stock;
        
        public static CartListResponse from(CartVO vo) {
            return CartListResponse.builder()
                    .cart_id(vo.getCart_id())
                    .book_name(vo.getBook_name())
                    .book_price(vo.getBook_price())
                    .book_discount(vo.getBook_discount())
                    .cart_count(vo.getCart_count())
                    .saved_name(vo.getSaved_name())
                    .upload_path(vo.getUpload_path())
                    .book_stock(vo.getBook_stock())
                    .build();
        }
    }
}