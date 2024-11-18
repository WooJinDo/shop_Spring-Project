package com.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartVO {
    private Long cart_id;        // 장바구니 ID
    private String user_id;      // 회원 ID
    private int book_id;         // 상품 ID
    private int cart_count;      // 상품 수량
    private String reg_date;     // 등록일
    
    // 조인용 필드
    private String book_name;    // 상품명
    private int book_price;      // 상품 가격
    private double book_discount; // 상품 할인율
    private String saved_name;   // 저장된 이미지명
    private String upload_path;  // 이미지 경로
    private int book_stock;      // 재고수량     
	
}
