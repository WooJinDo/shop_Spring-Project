package com.shop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.log4j.Log4j;

/* 로그인 및 권한 여부에 따른 인터셉터 */
@Log4j
public class AuthenticationInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
        String requestURI = request.getRequestURI();
        log.info("AuthenticationInterceptor: preHandle called for path: " + request.getRequestURI());
        
    	// 로그인 여부 확인 - 로그인 하지 않았을 떄 
        if (!StringUtils.isNotBlank((String)session.getAttribute("userId"))) {
        	log.info("사용자가 존재하지 않습니다");
            // 로그인되지 않은 경우 - 관리자, 사용자 페이지 접근
            if (requestURI.startsWith("/admin") || requestURI.startsWith("/user")) {
                response.sendRedirect("/accessDenied");
                return false;
            }
            return true; // 공개 페이지는 접근 허용
        }

        // 로그인된 경우
        String role = (String) session.getAttribute("role");
        log.info("ROLE : " + role);

        if (requestURI.startsWith("/admin")) {
            // 관리자 페이지 접근 시
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("/accessDenied");
                return false;
            }
        } else if (requestURI.startsWith("/user")) {
            // 일반 사용자 페이지 접근 시
            if (!"USER".equals(role) && !"ADMIN".equals(role)) {
                response.sendRedirect("/accessDenied");
                return false;
            }
        }

        return true; // 조건을 모두 통과하면 접근 허용
    }
	
}
