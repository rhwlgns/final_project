package com.kh.erp.emp.sal;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmpSalDAO {
	
	public int checkSalPwd(EmpSalDTO empSalDTO);
	
//	EmpSalDTO getNo_emp(String no_res);
	
	List<Map<String, String>> getEmpSalInfoList(EmpSalDTO empSalDTO);
	
	List<Map<String, String>> getEmpSalAmountInfoList(EmpSalDTO empSalDTO);
	
	//List<Map<String, String>> getEmpSalList(EmpSalDTO empSalDTO);
	
	
	List<Map<String, String>> getEmpSalWithYM(EmpSalDTO empSalDTO);
	
	public int getCheckSal(EmpSalDTO empSalDTO);

}
