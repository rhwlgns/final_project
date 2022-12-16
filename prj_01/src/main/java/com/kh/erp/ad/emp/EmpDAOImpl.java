package com.kh.erp.ad.emp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Repository
public class EmpDAOImpl implements EmpDAO {

	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int adUserInfoReg(UserInfoDTO userInfoDTO) {
		int data = this.sqlSession.insert(

				"com.kh.erp.ad.emp.EmpDAO.adUserInfoReg", userInfoDTO);

		return data;
	}

	public int checkId(String emp_id) {
		int data = this.sqlSession.selectOne(

				"com.kh.erp.ad.emp.EmpDAO.checkId", emp_id);

		return data;
	}
	
	public int checkNo(String emp_no) {
		int data = this.sqlSession.selectOne(

				"com.kh.erp.ad.emp.EmpDAO.checkNo", emp_no);

		return data;
	}


	public List<Map<String, String>> getEmpList(EmpListDTO empListDTO) {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getEmpList", empListDTO);

		return data;
	}

	public int adEmpRegForm(RegDTO regDTO) {
		int data = this.sqlSession.insert(

				"com.kh.erp.ad.emp.EmpDAO.adEmpRegForm", regDTO);

		return data;
	}

	public int adEmpRegPrivate(RegDTO regDTO) {
		int data = this.sqlSession.insert(

				"com.kh.erp.ad.emp.EmpDAO.adEmpRegPrivate", regDTO);

		return data;
	}

	public List<Map<String, String>> getPartList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getPartList");

		return data;
	}
	
	public List<Map<String, String>> getProofList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getProofList");

		return data;
	}

	public List<Map<String, String>> getJikupList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getJikupList");

		return data;
	}

	public RegDTO getEmpListCorr(String no_emp) {
		RegDTO data = this.sqlSession.selectOne(

				"com.kh.erp.ad.emp.EmpDAO.getEmpListCorr", no_emp);
		return data;
	}	
	
	public int adEmpListUp1(RegDTO regDTO) {
		int data = this.sqlSession.update(
				"com.kh.erp.ad.emp.EmpDAO.adEmpListUp1", regDTO);
		return data;
	}
	
	public int adEmpListUp2(RegDTO regDTO) {
		int data = this.sqlSession.update(
				"com.kh.erp.ad.emp.EmpDAO.adEmpListUp2", regDTO);
		return data;
	}
	
	public int adEmpListDel1(RegDTO regDTO) {
		int data = this.sqlSession.delete(
				"com.kh.erp.ad.emp.EmpDAO.adEmpListDel1", regDTO);
		return data;
	}
	
	public int adEmpListDel2(RegDTO regDTO) {
		int data = this.sqlSession.delete(
				"com.kh.erp.ad.emp.EmpDAO.adEmpListDel2", regDTO);
		return data;
	}

	public int adEmpListDel3(RegDTO regDTO) {
		int data = this.sqlSession.delete(
				"com.kh.erp.ad.emp.EmpDAO.adEmpListDel3", regDTO);
		return data;
	}
	
	public RegDTO getUserInfo(String no_emp) {
		RegDTO data = this.sqlSession.selectOne(
				"com.kh.erp.ad.emp.EmpDAO.getUserInfo", no_emp);
		return data;
	}

}
