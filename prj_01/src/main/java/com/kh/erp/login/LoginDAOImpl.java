package com.kh.erp.login;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.erp.ad.notice.BoardSearchDTO;

// ---------------------------------------------------------------
// [LoginDAOImpl 클래스] 선언
// ---------------------------------------------------------------
// 관용적으로 DAO가 들어간 클래스는 직접 DB연동을 하는 클래스이다.
// 직접 DB연동을 하는 클래스들을 보동 [DAO 클래스 또는 객체]라고 부른다.
// 직접 DB연동을 하는 클래스 앞에는 @Repository 어노테이션을 붙인다.
// ---------------------------------------------------------------
// @Repository를 붙임으로서 [DAO 클래스]임을 지정하게 되고
// Spring에서 인식해서 필요 시 객체화하여 사용한다.
// 직접 DB연동을 하는 클래스는 보통 인터페이스를 구현하여 만든다.
@Repository
public class LoginDAOImpl implements LoginDAO{
	
	// ---------------------------------------------------------------
	// 속성변수 sqlSession에 SqlSessionTemplate 객체를 생성하여 저장
	// ---------------------------------------------------------------
	// @Autowired 어노테이션을 붙이면
	// 속성변수의 자료형에 맞는 SqlSessionTemplate 객체를 생성한 후
	// 객체의 메모리 위치 주소 값을 속성변수에 저장한다.
	// ---------------------------------------------------------------
	// SqlSessionTemplate 객체는 DB 연동 시 사용하는 객체이다.
	// xml 파일에 있는 SQL 구문을 읽어 DB에 SQL 명령을 내린 후
	// 그 결과값을 받아오는 객체이다.
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// ---------------------------------------------------------------
	// [로그인 아이디]와 [로그인 암호]의 존재 개수를 리턴하는 메소드 선언
	// ---------------------------------------------------------------
	// LoginController 객체 안의 메소드에서 호출된다.
	public int getCntLogin(Map<String, String> idPwd) {
	// [로그인 아이디]와 [로그인 암호]가 저장된
	// HashMap 객체가 들어오는 매개변수 선언
		
		// SqlSessionTemplate 객체의 [selectOne 메소드] 호출로
		// xml 파일에 있는 select 구문을 호출하여
		// [로그인 아이디, 로그인 암호의 존재 개수]를 얻기
		int login_idCnt = this.sqlSession.selectOne(
		// selectOne 메소드는 select 구문을 DB에 날리고
		// [1행 m열]의 결과를 리턴하는 메소드이다.
		// - selectOne 메소드의 실행결과가 2행 이상이면 에러가 난다.
		// - selectOne 메소드의 실행결과가 1행 1열일 경우
		// int, String, double 중 하나로 리턴된다.
		// - selectOne 메소드의 실행결과가 1행 2열 이상일 경우
		// 자바의 [HashMap 객체] 또는 [DTO 객체]에 저장되어 리턴된다.
				
		// <참고> n행m열의 검색은 selectList 메소드를 사용하여야 한다.
		// selectList 메소드의 리턴형은
		// List<Map<String, String>> 또는 List<DTO 객체>이다.
		// ArrayList<HashMap 객체> 또는 ArrayList<DTO 객체>로도 표현된다.
		
				
				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.login.LoginDAO.getCntLogin"
				// com.kh.login.erp.LoginDAO : xml 파일의 mapper 태그 안의 namespace 값
				// getCntLogin : mapper 태그 안의 <select id="getCntLogin" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				// 현재는 아이디와 암호가 저장된 HashMap 객체이다.
				, idPwd
		);
		
		// [로그인 아이디, 로그인 암호의 존재 개수] 리턴
		return login_idCnt;
	}
	
	// ---------------------------------------------
	public List<Map<String, String>> getInfoList(InfoDTO infoDTO){

		// SqlSessionTemplate 객체의 selectList 메소드 호출로
		// n행 m열 게시판 글을 List<Map<String, String>>으로 받아오기
		List<Map<String, String>> infoList = this.sqlSession.selectList(
				
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.login.LoginDAO.getInfoList"
			// SQL 구문의 위치 : *.xml 파일 내부
			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
			// <select id="getBoardList"> SELECT 구문 </select>
			// </mapper>
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, infoDTO
		);
		
//		List<Map<String, String>> boardList = new ArrayList<String, String>();
//		Map<String, String> map1 = new HashMap<String, String>();
//		map1.put("b_no", 1);
//		map1.put("subject", "제목1");
//		map1.put("content", "내용1");
//		boardList.add(map1);
		
		return infoList;
	}
	// ---------------------------------------------
}
