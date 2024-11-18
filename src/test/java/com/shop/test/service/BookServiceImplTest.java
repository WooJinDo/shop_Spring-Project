package com.shop.test.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.config.FileUploadUtil;
import com.shop.dao.BookMapper;
import com.shop.dao.CartMapper;
import com.shop.dto.AuthorDto;
import com.shop.dto.BookDto;
import com.shop.dto.ImageDto;
import com.shop.model.BookVO;
import com.shop.model.CartVO;
import com.shop.service.AuthorService;
import com.shop.service.BookService;
import com.shop.service.CartService;
import com.shop.service.ImageService;
import com.shop.service.impl.ImageServiceImpl;

@WebAppConfiguration
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookServiceImplTest {

	private static final Logger logger = LoggerFactory.getLogger(BookServiceImplTest.class);
	
    @Autowired
    private BookService bookService;
    
    @Autowired
    private BookMapper bookMapper;
	
    @Test
    public void updateTransactionTest() throws Exception {
        // 1. 수정할 상품 정보 준비
        BookDto.BookUpdateRequest request = new BookDto.BookUpdateRequest();
        request.setBook_id(103);  // 실제 DB에 있는 ID
        request.setBook_name("트랜잭션 테스트");
        request.setBook_price(20000);
        // ... 필요한 다른 필드 설정
        
        // 2. 수정 전 상품 정보 저장
        BookVO beforeUpdate = bookMapper.selectBookDetail(request.getBook_id());
        logger.info("수정 전 상품정보: " + beforeUpdate);
        
        try {
            // 3. 수정 시도 - 예외 발생 예상
            bookService.update(request, null);
        } catch (Exception e) {
        	logger.error("예상된 예외 발생: " + e.getMessage());
        }
        
        // 4. 수정 후 상품 정보 조회
        BookVO afterUpdate = bookMapper.selectBookDetail(request.getBook_id());
        logger.info("수정 후 상품정보: " + afterUpdate);
        
        // 5. 트랜잭션 롤백 확인 - 수정 전과 후의 데이터가 동일해야 함
        assertEquals(beforeUpdate.getBook_name(), afterUpdate.getBook_name());
        assertEquals(beforeUpdate.getBook_price(), afterUpdate.getBook_price());
    }
    
}
