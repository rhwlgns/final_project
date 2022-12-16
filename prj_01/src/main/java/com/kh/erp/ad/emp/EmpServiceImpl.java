package com.kh.erp.ad.emp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EmpServiceImpl implements EmpService{
	@Autowired
	EmpDAO empDAO;
	public int updateList(RegDTO regDTO) {
		
		int updateListCnt1 = this.empDAO.adEmpListUp1(regDTO);
		int updateListCnt2 = this.empDAO.adEmpListUp2(regDTO);
		int updateListCnt;
		if(((updateListCnt1==1) && (updateListCnt2==1))==true) {
			updateListCnt = 1;
		}else {
			updateListCnt=0;
		}
		return updateListCnt;
	}
	
	public RegDTO getEmpListCorr(String no_emp) {
	
		
		return empDAO.getEmpListCorr(no_emp);
	}
	
	public int deleteList(RegDTO regDTO) {
		
		int deleteListCnt1 = this.empDAO.adEmpListDel1(regDTO);
		int deleteListCnt2 = this.empDAO.adEmpListDel2(regDTO);
		int deleteListCnt3 = this.empDAO.adEmpListDel3(regDTO);
		int deleteListCnt;
		if(((deleteListCnt1==1) && (deleteListCnt2==1) && (deleteListCnt3==1))==true) {
			deleteListCnt = 1;
		}else {
			deleteListCnt=0;
		}
		return deleteListCnt;
	}
}
