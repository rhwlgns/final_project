package com.kh.erp.emp.sal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
//[서비스 클래스]에는 @Service와 @Transactional을 붙인다.
//@Service : [서비스 클래스]임을 지정하고 
//스프링이 이 객체를 관리하도록 등록된다.
@Service
//@Transactional : [서비스 클래스]의 
//메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
@Transactional


public class EmpSalServiceImpl implements EmpSalService{

	@Autowired
	private EmpSalDAO empSalDAO;
	
	
	
}
