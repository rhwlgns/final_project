package com.kh.erp.ad.emp;

import java.util.List;
import java.util.Map;

//@Mapper
public interface EmpDAO {
	int adUserInfoReg(UserInfoDTO userInfoDTO);

	int checkId(String emp_id);
	
	int checkNo(String emp_no);

	List<Map<String, String>> getEmpList(EmpListDTO empListDTO);

	int adEmpRegForm(RegDTO regDTO);

	int adEmpRegPrivate(RegDTO regDTO);

	List<Map<String, String>> getPartList();
	
	List<Map<String, String>> getProofList();

	List<Map<String, String>> getJikupList();

	RegDTO getEmpListCorr(String no_emp);
	
	RegDTO getUserInfo(String no_emp);
	
	int adEmpListUp1(RegDTO regDTO);
	
	int adEmpListUp2(RegDTO regDTO);
	
	int adEmpListDel1(RegDTO regDTO);
	
	int adEmpListDel2(RegDTO regDTO);
	
	int adEmpListDel3(RegDTO regDTO);
	
}
