package com.kh.erp.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.erp.ad.notice.BoardSearchDTO;

// ---------------------------------------------------------------
// [LoginDAO 인터페이스] 선언
// ---------------------------------------------------------------
// Spring에서 관용적으로 인터페이스 이름에 DAO가 들어가면
// 인터페이스를 구현한 클래스가 만들어질 것이고
// 이 클래스는 직접 DB연동에 사용될 메소드를 소유하게 될 것이다.
// xml에 SQL 구문을 저장하고 사용할 경우
// 이 인터페이스 구조와 xml 파일 안의 구조가 동일할 것이다.
// xml 파일 안에 아래 태그들이 나온다
// ---------------------------------------------------------------
// <mapper namespace="인터페이스 경로.인터페이스명">
// 	<~ id = "인터페이스 메소드명1" ~> SQL 구문 </~>
//	<~ id = "인터페이스 메소드명2" ~> SQL 구문 </~>
// </mapper>
// SQL 구문 위치에는 1개의 SQL 구문만 삽입된다.
// ---------------------------------------------------------------
// SQL 구문이 insert 구문일 경우
// <insert id = "인터페이스 메소드명1" parameterType="SQL 구문에 참여하는 외부 데이터의 타입"> insert SQL 구문 </insert>
// SQL 구문이 update 구문일 경우
// <update id = "인터페이스 메소드명1" parameterType="SQL 구문에 참여하는 외부 데이터의 타입"> update SQL 구문 </update>
// SQL 구문이 delete 구문일 경우
// <delete id = "인터페이스 메소드명1" parameterType="SQL 구문에 참여하는 외부 데이터의 타입"> delete SQL 구문 </delete>
// SQL 구문이 select 구문일 경우
// <select id = "인터페이스 메소드명1" parameterType="SQL 구문에 참여하는 외부 데이터의 타입" result="SQL 구문의 결과 값을 저장할 수 있는 자바 자료형 "> select SQL 구문 </select>
// insert, update, delete 구문은 결과가 개수로만 나오기 때문에 결과 값이 result 설정 없이 int로 리턴된다.
// insert는 1 이상 update, delete는 0 이상의 값이 리턴된다.
@Mapper
public interface LoginDAO {
	
	// ---------------------------------------------------------------
	// 로그인 아이디와 로그인 암호 존재 개수를 리턴하는 메소드 선언
	// ---------------------------------------------------------------
	public int getCntLogin(
		
		// 로그인 아이디와 암호가 HashMap 객체가 들어오는 매개변수 선언
		Map<String, String> idPwd
	);
	
	
	// ---------------------------------------------
	List<Map<String, String>> getInfoList(InfoDTO infoDTO);
	// ---------------------------------------------

}
