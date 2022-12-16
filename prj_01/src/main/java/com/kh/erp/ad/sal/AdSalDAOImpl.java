package com.kh.erp.ad.sal;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.erp.ad.notice.BoardSearchDTO;

@Repository
public class AdSalDAOImpl implements AdSalDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Map<String, String>> getEmpSalList(AmpaymentDTO ampaymentDTO) {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.getEmpSalList", ampaymentDTO);

		return data;
	}
	
	public List<Map<String, String>> getPayList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.payList");

		return data;
	}
	
	public List<Map<String, String>> getNoEmp() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.noEmp");

		return data;
	}
	
	public int searchPay(AmpaymentDTO ampaymentDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [검색한 게시판 목록]의 총 개수를 얻는 SQL 구문을 실행하고 
		// 입력 성공한 행의 존재개수 얻기
		int searchPay = this.sqlSession.selectOne(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.sal.AdSalDAO.searchPay"
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, ampaymentDTO
		);
		
		return searchPay;
	}
	
	public int insertPay(AmpaymentDTO ampaymentDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [검색한 게시판 목록]의 총 개수를 얻는 SQL 구문을 실행하고 
		// 입력 성공한 행의 존재개수 얻기
		int insertPay = this.sqlSession.insert(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.sal.AdSalDAO.insertPay"
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, ampaymentDTO
		);
		
		return insertPay;
	}
	
	public int updatePay(AmpaymentDTO ampaymentDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [검색한 게시판 목록]의 총 개수를 얻는 SQL 구문을 실행하고 
		// 입력 성공한 행의 존재개수 얻기
		int updatePay = this.sqlSession.update(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.sal.AdSalDAO.updatePay"
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, ampaymentDTO
		);
		
		return updatePay;
	}

	public int deletePay(AmpaymentDTO ampaymentDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [검색한 게시판 목록]의 총 개수를 얻는 SQL 구문을 실행하고 
		// 입력 성공한 행의 존재개수 얻기
		int deletePay = this.sqlSession.insert(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.sal.AdSalDAO.deletePay"
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, ampaymentDTO
		);
		
		return deletePay;
	}
	
	public List<Map<String, String>> selPay(AmpaymentDTO ampaymentDTO) {
		
		List<Map<String, String>> selPay = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.selPay"
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, ampaymentDTO
		);

		return selPay;
	}
	
	
	
//	public List<Map<String, String>> getEmpSearchList(AmpaymentDTO ampaymentDTO) {
//		List<Map<String, String>> data = this.sqlSession.selectList(
//
//				"com.kh.erp.ad.sal.AdSalDAO.getEmpSearchList");
//
//		return data;
//	}

}
