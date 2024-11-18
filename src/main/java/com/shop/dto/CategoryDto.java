package com.shop.dto;

import com.shop.model.CategoryVO;
import com.shop.model.Criteria;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

public class CategoryDto {
	
	// 관리자: 카테고리 리스트 - 결과
	@Getter @Setter
	@Builder
	public static class CategoryListResponse{
		// 계층(트리구조)
		private int tier;
		// 카테고리명
		private String category_name;
		// 카테고리 코드(부모)
		private String category_code;
		// 부모카테고리 참조
		private String category_parent_code;
		
		public static CategoryListResponse from(CategoryVO vo) {
			return CategoryListResponse.builder()
					.tier(vo.getTier())
					.category_name(Criteria.nullToEmpty(vo.getCategory_name()))
					.category_code(Criteria.nullToEmpty(vo.getCategory_code()))
					.category_parent_code(Criteria.nullToEmpty(vo.getCategory_parent_code()))
					.build();
		}
	}
}
