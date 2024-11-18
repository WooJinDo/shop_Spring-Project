package com.shop.test.service;

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

import com.shop.config.FileUploadUtil;
import com.shop.dao.CartMapper;
import com.shop.dto.AuthorDto;
import com.shop.model.CartVO;
import com.shop.service.AuthorService;
import com.shop.service.CartService;

@WebAppConfiguration
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartServiceImplTest {

	private static final Logger logger = LoggerFactory.getLogger(CartServiceImplTest.class);
	
    @Autowired
    private CartService cartService;
    
    @Autowired
    private CartMapper cartMapper;
	
    @Test
    @Transactional
    public void deleteCartTest() throws Exception {
        // 테스트용 세션 생성
        HttpSession session = new MockHttpSession();
        session.setAttribute("userId", "admin1");  // 실제 DB에 있는 userId
        
        // 삭제할 카트 ID 리스트 (실제 DB에 있는 cartId)
        List<Long> cartIds = Arrays.asList(22L, 23L);
        
        // 삭제 실행
        cartService.deleteCart(cartIds, session);
        
        // 삭제된 카트 아이템이 실제로 없는지 확인
        List<CartVO> remainingItems = cartMapper.selectCartById(cartIds);
        assertTrue(remainingItems.isEmpty(), "카트 아이템이 모두 삭제되어야 함");
        
        logger.info("장바구니 삭제 테스트 완료");
    }
    
}
