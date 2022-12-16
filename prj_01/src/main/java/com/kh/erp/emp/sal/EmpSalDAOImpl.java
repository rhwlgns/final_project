package com.kh.erp.emp.sal;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmpSalDAOImpl implements EmpSalDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int checkSalPwd(EmpSalDTO empSalDTO) {
		
		int check_SalPwdCnt = this.sqlSession.selectOne(
			"com.kh.erp.emp.sal.EmpSalDAO.checkSalPwd"	
			, empSalDTO
		);
		//return 1;
		return check_SalPwdCnt;
		
	}
	
	// 금액 출력 (ym 포함)
	public List<Map<String, String>> getEmpSalWithYM(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalWithYM = this.sqlSession.selectList(
				"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalWithYM"
				, empSalDTO
				);
		return empSalWithYM;
	}
	
	// 급여명세서에 개인정보 출력
	public List<Map<String, String>> getEmpSalInfoList(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalInfoList = this.sqlSession.selectList(
				"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalInfoList"	
				, empSalDTO
		);
		return 	empSalInfoList;
	}
	
	// 급여명세서에 지급, 공제 항목 출력
	public List<Map<String, String>> getEmpSalAmountInfoList(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalAmountInfoList = this.sqlSession.selectList(
			"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalAmountList"	
				, empSalDTO
				
		);
		return empSalAmountInfoList ;
	} 
	
	// 급여 유효성 체크
	public int getCheckSal(EmpSalDTO empSalDTO){
		int checkSal = this.sqlSession.selectOne(
				"com.kh.erp.emp.sal.EmpSalDAO.getCheckSal"
				, empSalDTO
				);
		return checkSal ;
	}
	
	/*
	// 급여명세서에 지급, 공제 금액 출력
	public List<Map<String, String>> getEmpSalList(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalList = this.sqlSession.selectList(
				"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalList"
				, empSalDTO
		);
		return empSalList;
	}
	*/
	
	
	
	
	


}