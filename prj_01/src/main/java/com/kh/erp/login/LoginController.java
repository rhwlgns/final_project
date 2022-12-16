package com.kh.erp.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

// ---------------------------------------------------------------
// URL 주소로 접속하면 호출되는 자격을 가진
// 메소드를 소유한 [컨트롤러 클래스] 선언
// ---------------------------------------------------------------
// 관용적으로 Controller가 들어간 클래스는
// URL 주소 접속 시에 대응하여 호출되는 메소드를 소유하고 있다.
// 클래스의 이름 앞에는 @Controller 어노테이션이 붙는다.
// 클래스 내부의 URL 주소 접속 시 호출되는 메소드명 앞에는
// @RequestMapping 어노테이션이 붙는다.
// URL 주소 접속 시 호츨되는 메소드를 소유하고 있는 클래스를
// [Controller 클래스] 또는 [Controller 객체]라고 지칭한다.
// ---------------------------------------------------------------
// @Controller라는 어노테이션을 붙임으로서
// 스프링 프레임 워크가 객체를 생성하고 관리하고
// [컨트롤러 클래스]임이 지정된다.
// ---------------------------------------------------------------
@Controller
public class LoginController {
	
	// LoginDAO 인터페이스 구현
	@Autowired
	private LoginDAO loginDAO;
	
	// /loginForm.do로 접근하면 호출되는 메소드 선언
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginForm() {
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("loginForm.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;
	}

	// 가상주소 /loginProc.do 접근 시 호출되는 메소드 선언
	@RequestMapping(value="/loginProc.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int loginProc(

			@RequestParam(value = "user_id") String user_id
			, @RequestParam(value = "user_pwd") String user_pwd
			, @RequestParam(value = "is_login", required = false) String is_login
			, HttpSession session
			, HttpServletResponse response
	){
		
		// HashMap 객체 생성
		Map<String, String> map = new HashMap<String, String>();
		
		// [로그인 아이디] 저장
		map.put("user_id", user_id);
		
		// [로그인 암호] 저장
		map.put("user_pwd", user_pwd);
		
		// ---------------------------------------------------------------
		// [로그인 아이디]와 [로그인 암호]의 DB 존재 개수를
		// 저장할 변수 loginIdCnt 선언하고
		// LoginDAOImpl 객체의 getCntLogin 메소드를 호출하여 얻은 데이터 저장
		// ---------------------------------------------------------------
		// 이 메소드는 [로그인 아이디]와 [로그인 암호]의 DB 존재 개수를 구해주는 메소드이다.
		// 이 메소드 호출 시 매개변수로 던져지는 HashMap 객체에는 
		// [로그인 아이디]와 [로그인 암호]가 저장되어 있다.
		int loginIdCnt = loginDAO.getCntLogin(map);
		
		// loginIdCnt==1, 아이디와 암호가 매칭되는 값이 DB에 있을 경우
		if(loginIdCnt==1) {
			
			// HttpSession 객체에 로그인 아이디 저장
			// HttpSession 객체에 저장 시 재 접속할 때 다시 꺼낼 수 있다.
			// <참고> HttpSession 객체는 접속 시 생성되고 
			// 접속 이후에도 바로 제거되지 않고 일정기간 살아있다.
			// <참고> HttpServletRequest, HttpServletResponse 객체는 
			// 접속 시 생성되고 응답 이후 삭제된다.
			session.setAttribute("user_id", user_id);
			
			// is_login에 null이 저장되어 있을 경우(ID, PW 기억 X)
			if(is_login==null) {
				
				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["user_id"-null]로 설정
				Cookie cookie1 = new Cookie("user_id", user_id);
				
				// Cookie 객체의 수명 0으로 설정
				cookie1.setMaxAge(0);
				
				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["user_pwd"-null]로 설정
				Cookie cookie2 = new Cookie("user_pwd", user_pwd);
				
				// Cookie 객체의 수명 0으로 설정
				cookie2.setMaxAge(0);
				
				// Cookie 객체가 소유한 쿠키를 응답 메시지에 저장
				// 응답 메시지에 저장되는 쿠키는
				// 웹 브라우저(클라이언트 쪽)에 저장된다.
				response.addCookie(cookie1);
				response.addCookie(cookie2);
				
			// is_login에 "yes"가 저장되어 있을 경우(ID, PW 기억 O)
			}else {
				
				// ---------------------------------------------------------------
				// 클라이언트가 보낸 아이디, 암호를 
				// [응답 메시지]에 쿠키명-쿠키값으로 저장
				// ---------------------------------------------------------------
				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["user_id"-"입력 아이디"]로 설정
				Cookie cookie1 = new Cookie("user_id", user_id);
				
				// Cookie 객체의 수명 설정
				cookie1.setMaxAge(86400);

				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["user_pwd"-"입력 암호"]로 설정
				Cookie cookie2 = new Cookie("user_pwd", user_pwd);
				
				// Cookie 객체의 수명 설정
				cookie2.setMaxAge(86400);
				
				// Cookie 객체가 소유한 쿠키를 응답 메시지에 저장
				// 응답 메시지에 저장되는 쿠키는
				// 웹 브라우저(클라이언트 쪽)에 저장된다.
				response.addCookie(cookie1);
				response.addCookie(cookie2);

			}

		}

		return loginDAO.getCntLogin(map);
	}
	
	// /logout.do로 접근하면 호출되는 메소드 선언
	@RequestMapping(value="/logout.do")
	public ModelAndView logout(
		HttpSession session
	) {
		
		// session의 모든 값 삭제
		session.invalidate();
		
		// [ModelAndView 객체] 생성
		// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
		ModelAndView mav = new ModelAndView("redirect:/loginForm.do");
		
		return mav;
	}

}
