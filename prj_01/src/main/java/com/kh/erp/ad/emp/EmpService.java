package com.kh.erp.ad.emp;

public interface EmpService {
	RegDTO getEmpListCorr(String no_emp);
	int updateList (RegDTO regDTO);
	
	int deleteList (RegDTO regDTO);
}
