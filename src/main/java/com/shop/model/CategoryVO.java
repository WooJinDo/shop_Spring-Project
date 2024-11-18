package com.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryVO extends Criteria {
	// 계층(트리구조)
	private int tier;
	// 카테고리명
	private String category_name;
	// 카테고리 코드(부모)
	private String category_code;
	// 부모카테고리 참조
	private String category_parent_code;
	
}
