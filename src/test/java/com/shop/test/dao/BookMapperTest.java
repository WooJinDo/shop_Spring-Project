package com.shop.test.dao;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.shop.config.FileUploadUtil;
import com.shop.dao.BookMapper;
import com.shop.model.BookVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookMapperTest {
	
	@Autowired 
	private BookMapper bookMapper;
	
	@Autowired
    private FileUploadUtil fileUploadUtil;
	
	// 상품 등록 테스트
//    @Test
//    public void add() throws Exception{
//        
//        BookVO vo = new BookVO();
//        
//        vo.setAuthor_id(145);
//        vo.setCategory_code("0231");
//        vo.setBook_name("book테스트");
//        vo.setPuble_year("2024-10-09");
//        vo.setPublisher("출판사");
//        vo.setBook_price(20000);
//        vo.setBook_stock(100);
//        vo.setBook_discount(0.23);
//        vo.setBook_intro("소개내용");
//        vo.setBook_contents("중심내용~~~~~");
//        
//        bookMapper.add(vo);
//    }    
    
    // 카테고리 리스트 테스트
//	@Test
//	public void list() throws Exception{
//		System.out.println("categoryList()......... : " + bookMapper.selectCategoryList());
//	} 
    
    // 상품 전체 게시글 수 테스트
//    @Test
//    public void select() throws Exception{
//    	 BookDto.BookSearchRequest request = new BookDto.BookSearchRequest();
//         
// 		int totalItems = bookMapper.selectTotalCount(request);	// 전체 게시글 수
// 		System.out.println("totalItems : " + totalItems);
//    }
    // 상품 리스트 테스트
//    @Test
//    public void list() throws Exception{
//    	BookDto.BookSearchRequest request = new BookDto.BookSearchRequest();
//        
//        request.setCurrentPage(1);
//        request.setItemsPerPage(10);
////        request.setSearchType("authorNameIntro");
////        request.setKeyword("길동");
//        
//    	int totalItems = bookMapper.selectTotalCount(request);	// 전체 게시글 수
//		// 페이징 정보 계산
//		PagingUtil pagingUtil = new PagingUtil(request.getCurrentPage(), request.getItemsPerPage(), totalItems);
//        
//        request.setOffset(pagingUtil.getOffset());
//        request.setLimit(pagingUtil.getLimit());
//        List<BookVO> voList = bookMapper.selectBookList(request);
//        
//        for(BookVO vo : voList) {
//        	System.out.println("vo : " + vo);
//        } 
//    }
    
	// 상품 상세 테스트
//    @Test
//    public void detail() throws Exception{
////		BookVO vo = bookMapper.selectBookDetail(343);
////		System.out.println("vo : " + vo);
//    	int bookId = 1016;
//    	List<BookImageVO> voList = bookMapper.selectBookImageList(bookId);
//    	
//    	for(BookImageVO vo : voList) {
//    		vo.setUpload_path(fileUploadUtil.getWebPath(vo.getUpload_path()));
//    		System.out.println("vo ******** : " + vo);
//    	}
//    } 
    
	// 상품 수정 테스트
    @Test
    public void update() throws Exception{
    	BookVO vo = new BookVO();
    	vo.setBook_id(1010);
    	vo.setAuthor_id(128);
    	vo.setCategory_code("102002");
    	vo.setBook_name("반가워유");
    	vo.setPuble_year("2020-12-12");
    	vo.setPublisher("출판사");
    	vo.setBook_price(100000);
    	vo.setBook_stock(10);
    	vo.setBook_discount(10);
    	vo.setBook_intro("테스트");
    	vo.setBook_contents("테스트2");
    	
    	bookMapper.update(vo);
    	
    	
    } 
	
    // 상품 삭제 테스트
//    @Test
//    public void delete() throws Exception{
//    } 

}
