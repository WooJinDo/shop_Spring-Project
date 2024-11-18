package com.shop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.log4j.Log4j;

/* 세션 타임아웃 관리 인터셉터 */
@Log4j
public class SessionTimeoutInterceptor implements HandlerInterceptor {
	private static final int MAX_INACTIVE_INTERVAL = 60 * 30; // 30분
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		/*
		 * getSession(false) - 기존 세션이 있는 경우: HttpSession 객체를 반환하여 해당 세션을 사용할 수 있습니다. 
		 * 기존 세션이 없는 경우: 새로운 세션을 만들지 않고 null을 반환합니다. 즉, 세션이 없으면 세션 객체가 생성되지 않으며, 
		 * 이 경우 session 변수는 null이 됩니다.
		 */
		HttpSession session = request.getSession(false);
		
		// StringUtils.isNotBlank() - 문자열이 null, 빈 문자열, 또는 공백이 아니여야함
		if(session != null && StringUtils.isNotBlank((String)session.getAttribute("userId"))) {
			long lastAccessedTime = session.getLastAccessedTime();	// 마지막으로 접근한 시간
            long currentTime = System.currentTimeMillis();			// 현재 시간
            long timeSinceLastAccess = currentTime - lastAccessedTime;	// 마지막 접근 시간과 현재 시간의 차이

            // 마지막 접근 이후 30분을 초과 했을 경우
            if (timeSinceLastAccess > MAX_INACTIVE_INTERVAL * 1000) { 
            	log.info("일정시간 동안 활동이 없어 세션이 만료 되었습니다");
            	session.invalidate(); // 세션 만료
            	//getSession()은 항상 세션을 반환, 만약 세션이 존재하지 않으면 새 세션을 생성
                request.getSession().setAttribute("flashMsg", "일정시간 동안 활동이 없어 세션이 만료 되었습니다");
                response.sendRedirect("/member/login?timeout=true"); // 세션 만료로 인한 페이지 이동
                return false;
            }
		}
		
		return true;
	}
	
}
