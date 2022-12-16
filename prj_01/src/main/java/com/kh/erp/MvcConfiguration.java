package com.kh.erp;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 개발자가 만든 SessionInterceptor 클래스를 
// [인터셉터]로 등록하기 위한 MvcConfiguration 클래스 선언
// 설정을 위한 클래스
@Configuration
public class MvcConfiguration implements WebMvcConfigurer{

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// InterceptorRegistry 객체의 addInterceptor 메소드를 호출하여
		// SessionInterceptor 객체를 interceptor로 등록하고
		// excludePathPatterns 메소드를 호출하여 예외되는 URL 주소 패턴을 등록
		registry.addInterceptor(new SessionInterceptor()).excludePathPatterns("/loginForm.do", "/loginProc.do", "/**");
	}

}