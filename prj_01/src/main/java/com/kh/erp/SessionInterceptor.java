package com.kh.erp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

// URL 접속 시 [@Controller가 붙은 클래스의 @RequestMapping이 붙은 메소드]
// 호출 전 또는 후에 실행될 메소드를 소유한 [SessionInterceptor 클래스] 선언

// ---------------------------------------------------------------------------------------
// [@Controller가 붙은 클래스의 @RequestMapping이 붙은 메소드]
// 호출 전 또는 후에 실행될 메소드를 소유한 클래스가 될 자격 조건
//
// 1. Spring이 제공하는 [HandlerInterceptor 인터페이스]를 구현한다.
// 2. @RequestMapping이 붙은 메소드 호출 전에 실행할 코딩은
// HandlerInterceptor 인터페이스의 [preHandle 메소드]를 재정의(overriding)하며 삽입한다.
// 3. @RequestMapping이 붙은 메소드 호출 후에 실행할 코딩은
// HandlerInterceptor 인터페이스의 [postHandle 메소드]를 재정의(overriding)하며 삽입한다.
// ---------------------------------------------------------------------------------------
public class SessionInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(
			HttpServletRequest request
			, HttpServletResponse response
			, Object handler
	) throws Exception  {
		
		// HttpSession 객체 얻기
		// HttpServletRequest 객체의 getSession() 메소드를 호출하면 
		// HttpSession 객체를 얻을 수 있다.
		HttpSession session = request.getSession();
		
		// HttpSession 객체에서 키 값이 "user_id"로 저장된 데이터 꺼내기
		String user_id = (String)session.getAttribute("user_id");
		
		System.out.println(user_id);
		
		// 만약 mid 변수에 null이 저장되어 있을 경우
		if(user_id==null) {
			
			// 클라이언트에게 /loginForm.do 재 접속 요청
			// 응답 메시지를 받은 클라이언트는 해당 URL 주소로 강제 재 접속한다.
			response.sendRedirect("/loginForm.do");
			
			// false를 리턴하면 @RequestMapping이 붙은 메소드는 호출되지 않는다.
			return false;
		}
		// 만약 mid 변수에 null이 저장되어 있지 않을 경우
		else {
			
			// true를 리턴하면 @RequestMapping이 붙은 메소드가 호출된다.
			return true;
		}
	}
}
