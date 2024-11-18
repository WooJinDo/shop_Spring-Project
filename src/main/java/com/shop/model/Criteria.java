package com.shop.model;

import lombok.Data;

@Data
public class Criteria {
	// 순번
	private int rnum;
	
	// 값이 null 경우 공백으로 처리 
	public static String nullToEmpty(String value) {
		return value == null ? "" : value;
	}

}
