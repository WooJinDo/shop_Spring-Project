package com.shop.config;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PagingUtil {
	// 현재 페이지 번호
    private int currentPage;
    
    // 한 페이지당 표시할 항목 수
    private int itemsPerPage;
    
    // 전체 항목 수
    private int totalItems;
    
    // 전체 페이지 수
    private int totalPages;
    
    // 현재 페이지 그룹의 시작 페이지 번호
    private int startPage;
    
    // 현재 페이지 그룹의 끝 페이지 번호
    private int endPage;
    
    // 현재 페이지, 페이지당 항목 수, 전체 항목 수를 받아 페이징 정보 초기화 생성자
    public PagingUtil(int currentPage, int itemsPerPage, int totalItems) {
    	this.currentPage = currentPage;
    	this.itemsPerPage = itemsPerPage;
    	this.totalItems = totalItems;
    	calculate();
    }
    
    // 페이징 정보 계산 메서드
    public void calculate() {
    	// 전체 페이지 수 계산
    	totalPages = (totalItems + itemsPerPage - 1) / itemsPerPage;
    	// 현재 페이지가 유효한 범위 내에 있도록 보정
    	// 현재 페이지가 1보다 작거나 전체 페이지 수보다 큰 경우 이를 적절한 범위로 보정
    	currentPage = Math.max(1, Math.min(currentPage, totalPages));
    	// 현재 페이지 그룹의 시작 페이지 계산 (페이지 번호를 10개씩 그룹화)
    	// 현재 페이지가 15이면 startPage는 11
    	startPage = ((currentPage - 1) / 10) * 10 + 1;
    	// 현재 페이지 그룹의 끝 페이지
    	endPage = Math.min(startPage + 9, totalPages);
    }
    
    // Oracle의 ROWNUM 페이징을 위한 시작 게시물 번호 반환
    // ex) 현재 페이지가 2이고 한 페이지에 10개를 표시하는 경우 11이 됩니다
    public int getOffset() {
    	return (currentPage - 1) * itemsPerPage + 1;
    }
    
    // Oracle의 ROWNUM 페이징을 위한 끝 게시물 번호 반환
    public int getLimit() {
    	return currentPage * itemsPerPage;
    }
    
    // 현재 페이지 번호가 1보다 큰 경우, 이전 페이지가 존재
    public boolean getHasPreviousPage() {
        return currentPage > 1;
    }

    // 현재 페이지 번호가 전체 페이지 수보다 작은 경우, 다음 페이지가 존재
    public boolean getHasNextPage() {
        return currentPage < totalPages;
    }
    
}
