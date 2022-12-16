package com.kh.erp.ad.notice;

import java.awt.print.Printable;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

// ---------------------------------------------------------------
// [BoardDAOBoardDAOImpl 클래스] 선언
// ---------------------------------------------------------------
 @Repository
public class BoardDAOImpl implements BoardDAO {
	
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
	
	// [검색한 게시판 목록]을 리턴하는 메소드 선언
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO){
		
		// SqlSessionTemplate 객체의 selectList 메소드 호출로
		// n행 m열 게시판 글을 List<Map<String, String>>으로 받아오기
		List<Map<String, String>> boardList = this.sqlSession.selectList(
				
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.getBoardList"
			// SQL 구문의 위치 : *.xml 파일 내부
			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
			// <select id="getBoardList"> SELECT 구문 </select>
			// </mapper>
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, boardSearchDTO
		);
		
//		List<Map<String, String>> boardList = new ArrayList<String, String>();
//		Map<String, String> map1 = new HashMap<String, String>();
//		map1.put("b_no", 1);
//		map1.put("subject", "제목1");
//		map1.put("content", "내용1");
//		boardList.add(map1);
		
		return boardList;
	}
	
	// [검색한 게시판 목록]의 총 개수를 리턴하는 메소드 선언
	public int getBoardListTotCnt(BoardSearchDTO boardSearchDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [검색한 게시판 목록]의 총 개수를 얻는 SQL 구문을 실행하고 
		// 입력 성공한 행의 존재개수 얻기
		int getBoardListTotCnt = this.sqlSession.selectOne(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.getBoardListTotCnt"
			// SQL 구문의 위치 : *.xml 파일 내부
			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
			// <select id="getBoard"> SELECT 구문 </select>
			// </mapper>
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, boardSearchDTO
		);
		
		return getBoardListTotCnt;
	}
	
	// [게시판 목록]의 총 개수를 리턴하는 메소드 선언
	public int getBoardListTotAllCnt(BoardSearchDTO boardSearchDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [검색한 게시판 목록]의 총 개수를 얻는 SQL 구문을 실행하고 
		// 입력 성공한 행의 존재개수 얻기
		int getBoardListTotAllCnt = this.sqlSession.selectOne(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.getBoardListTotAllCnt"
			// SQL 구문의 위치 : *.xml 파일 내부
			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
			// <select id="getBoard"> SELECT 구문 </select>
			// </mapper>
			
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, boardSearchDTO
		);
		
		return getBoardListTotAllCnt;
	}
	
	// [게시판 글 입력 후 적용될 행의 개수]를 리턴하는 메소드 선언
	public int insertBoard(BoardDTO boardDTO){
		
		// SqlSessionTemplate 객체의 insert 메소드 호출로
		// 게시판 글을 입력하는 SQL 구문을 실행하고 입력 성공한 행의 개수 얻기
		int boardRegCnt = sqlSession.insert(
				
			// 실행할 SQL INSERT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.insertBoard"
			// SQL 구문의 위치 : *.xml 파일 내부
			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
			// <insert id="insertBoard"> INSERT 구문 </insert>
			// </mapper>
				
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, boardDTO
		);
		
		return boardRegCnt;
	}
	

	// [댓글 입력 후 적용될 행의 개수]를 리턴하는 메소드 선언
	public int insertComment(BoardDTO boardDTO){
		// SqlSessionTemplate 객체의 insert 메소드 호출로
		// 게시판 글을 입력하는 SQL 구문을 실행하고 입력 성공한 행의 개수 얻기
		int boardComCnt = sqlSession.insert(
				
			// 실행할 SQL INSERT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.insertComment"
			// SQL 구문의 위치 : *.xml 파일 내부
			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
			// <insert id="insertBoard"> INSERT 구문 </insert>
			// </mapper>
				
			// 실행할 SQL 구문에서 사용할 데이터 지정
			, boardDTO
		);
		return boardComCnt;
	}
	
	
	
	
	// 답글을 달 게시판의 모든 후손 글들의 
	// print_no를 1 업데이트 하는 메소드 선언
	public int updatePrintNoCnt(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 update 메소드 호출로
		// [수정 적용행]을 얻는 SQL 구문을 실행하고 수정 적용행 얻기
		int updatePrintNoCnt = this.sqlSession.update(
				
				// 실행할 SQL UPDATE 구문의 위치 지정
				"com.kh.erp.ad.notice.BoardDAO.updatePrintNoCnt"
				// SQL 구문의 위치 : *.xml 파일 내부
				// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
				// <update id="updateReadcount"> UPDATE 구문 </update>
				// </mapper>
					
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
				
		);
		
		// [수정 적용행] 리턴
		return updatePrintNoCnt;
		
	}
	
	// [게시판 글의 조회수 증가 및 수정행의 개수]를 리턴하는 메소드 선언
	public int updateReadcount(int b_no) {
		
		// SqlSessionTemplate 객체의 update 메소드 호출로
		// 게시판 글을 수정하는 SQL 구문을 실행하고 입력 성공한 행의 개수 얻기
		int updateCount = this.sqlSession.update(
				
				// 실행할 SQL UPDATE 구문의 위치 지정
				"com.kh.erp.ad.notice.BoardDAO.updateReadcount"
				// SQL 구문의 위치 : *.xml 파일 내부
				// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
				// <update id="updateReadcount"> UPDATE 구문 </update>
				// </mapper>
					
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, b_no
		);
		return updateCount;
		
	}
	
	// [1개의 게시판 글 정보]를 리턴하는 메소드 선언
	public BoardDTO getBoard(int b_no) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [1개 게시판 글 정보]를 얻는 SQL 구문을 실행하고 입력 성공한 행의 개수 얻기
		BoardDTO board = this.sqlSession.selectOne(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.getBoard"
				
			, b_no
		);
		
		// [1개 게시판 글 정보] 리턴
		return board;
	}
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 댓글관련정보를 리턴하는 메소드 선언
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public List<Map<String, String>> getComment(int b_no) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [1개 게시판 글 정보]를 얻는 SQL 구문을 실행하고 입력 성공한 행의 개수 얻기
		List<Map<String, String>> getComment = this.sqlSession.selectOne(
		// selectOne은 1행m열의 select 결과를 얻을 떄 사용하는 메소드이다.
			
			// 실행할 SQL SELECT 구문의 위치 지정
			"com.kh.erp.ad.notice.BoardDAO.getComment"
				
			, b_no
		);

		// [1개 게시판 글 정보] 리턴
		
		return getComment;
	}
	
	
	
	
	// 수정할 게시판의 존재 개수를 리턴하는 메소드 선언
	public int getBoardCnt(int b_no) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [게시판의 존재 개수]를 얻는 SQL 구문을 실행하고 게시판의 존재 개수 얻기
		int boardCnt = this.sqlSession.selectOne(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.getBoardCnt"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// getBoardCnt : mapper 태그 안의 <select id="boardCnt" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, b_no
		);

		// [게시판의 존재 개수] 리턴
		return boardCnt;
	}
	
	// 수정, 삭제할 게시판의 비밀번호 존재 개수를 리턴하는 메소드 선언
	public int getBoardPwdCnt(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [비밀번호 존재 개수]를 얻는 SQL 구문을 실행하고 비밀번호 존재 개수 얻기
		int boardPwdCnt = this.sqlSession.selectOne(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.getBoardPwdCnt"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// getBoardPwdCnt : mapper 태그 안의 <select id="getBoardPwdCnt" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [비밀번호 존재 개수] 리턴
		return boardPwdCnt;
	}
	
	// 게시판 수정 명령 후 수정 적용행의 개수를 리턴하는 메소드 선언
	public int updateBoard(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 update 메소드 호출로
		// [수정 적용행]을 얻는 SQL 구문을 실행하고 수정 적용행 얻기
		int updateBoard = this.sqlSession.update(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.updateBoard"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// updateBoard : mapper 태그 안의 <update id="updateBoard" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [수정 적용행] 리턴
		return updateBoard;
	}
	
	// 삭제할 게시판의 후손 글의 존재개수를 리턴하는 메소드 선언
	public int getBoardChildrenCnt(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [후손 글의 존재개수]를 얻는 SQL 구문을 실행하고 자식 글의 존재개수 얻기
		int getBoardChildrenCnt = this.sqlSession.selectOne(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.getBoardChildrenCnt"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// getBoardChildrenCnt : mapper 태그 안의 <select id="getBoardChildrenCnt" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [후손 글의 존재개수] 리턴
		return getBoardChildrenCnt;
	}
	
	// 후손 글이 있을 경우 제목, 내용을 비우는 메소드 선언
	public int updateBoardEmpty(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 update 메소드 호출로
		// [수정 적용행]을 얻는 SQL 구문을 실행하고 수정 적용행 얻기
		int updateBoardEmpty = this.sqlSession.update(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.updateBoardEmpty"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// updateBoardEmpty : mapper 태그 안의 <update id="updateBoardEmpty" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [수정 적용행] 리턴
		return updateBoardEmpty;
	}
	
	// 삭제될 게시글의 동생 글의 출력순서 번호를 1씩 감소시키는 메소드 선언
	public int updatePrintNoDown(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 update 메소드 호출로
		// [수정 적용행]을 얻는 SQL 구문을 실행하고 수정 적용행 얻기
		int updatePrintNoDown = this.sqlSession.update(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.updatePrintNoDown"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// updateBoardEmpty : mapper 태그 안의 <update id="updateBoardEmpty" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [수정 적용행] 리턴
		return updatePrintNoDown;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 게시판 삭제 명령 후 삭제 적용행을 리턴하는 메소드 선언
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int deleteBoard(BoardDTO boardDTO) {
		
		// SqlSessionTemplate 객체의 delete 메소드 호출로
		// [삭제 적용행의 개수]를 얻는 SQL 구문을 실행하고 삭제 적용행 얻기
		int deleteBoard = this.sqlSession.delete(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.deleteBoard"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// deleteBoard : mapper 태그 안의 <delete id="deleteBoard" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [삭제 적용행] 리턴
		return deleteBoard;
	}

	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 댓글 삭제 명령 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int getCommentCnt(BoardDTO boardDTO) {
		System.out.println("getCommentCnt 보드DAOImpl 시작");
		System.out.println(boardDTO.getPrint_level());
		System.out.println(boardDTO.getB_no());
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// [게시판의 존재 개수]를 얻는 SQL 구문을 실행하고 게시판의 존재 개수 얻기
		int commentCnt = this.sqlSession.selectOne(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.getCommentCnt"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// getBoardCnt : mapper 태그 안의 <select id="boardCnt" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);

		// [게시판의 존재 개수] 리턴
		System.out.println("getCommentCnt 보드DAOImpl 종료");
		return commentCnt;
	}
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 댓글 삭제 명령 후 삭제 적용행을 리턴하는 메소드 선언
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int deleteComment(BoardDTO boardDTO) {
		System.out.println("deleteComment 보드DAOImpl 시작");
		// SqlSessionTemplate 객체의 delete 메소드 호출로
		// [삭제 적용행의 개수]를 얻는 SQL 구문을 실행하고 삭제 적용행 얻기
		int deleteComment = this.sqlSession.delete(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.deleteComment"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// deleteBoard : mapper 태그 안의 <delete id="deleteBoard" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [삭제 적용행] 리턴
		System.out.println("deleteComment 보드DAOImpl 종료");
		return deleteComment;
	}

	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 게시글 삭제 시 b_no 가 같은 모든 댓글이 삭제되게끔 하는 메소드
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public int deleteComment1(BoardDTO boardDTO) {
		// SqlSessionTemplate 객체의 delete 메소드 호출로
		// [삭제 적용행의 개수]를 얻는 SQL 구문을 실행하고 삭제 적용행 얻기
		int deleteComment1 = this.sqlSession.delete(

				// 실행할 [SQL 구문의 위치 문자]를 지정
				"com.kh.erp.ad.notice.BoardDAO.deleteComment1"
				// com.kh.erp.ad.notice.BoardDAO : xml 파일의 mapper 태그 안의 namespace 값
				// deleteBoard : mapper 태그 안의 <delete id="deleteBoard" ~> 태그 안의 SQL 구문
				
				// 실행할 SQL 구문에서 사용할 데이터 지정
				, boardDTO
		);
		
		// [삭제 적용행] 리턴
		return deleteComment1;
	}
	
//	// 답글을 달 게시판의 모든 후손 글들의 
//	// print_no를 1 업데이트 하는 메소드 선언
//	public int updatePrintNo(int b_no) {
//		
//		// SqlSessionTemplate 객체의 update 메소드 호출로
//		// [수정 적용행]을 얻는 SQL 구문을 실행하고 수정 적용행 얻기
//		int updatePrintNo = this.sqlSession.update(
//				
//				// 실행할 SQL UPDATE 구문의 위치 지정
//				"com.kh.erp.ad.notice.BoardDAO.updatePrintNo"
//				// SQL 구문의 위치 : *.xml 파일 내부
//				// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
//				// <update id="updateReadcount"> UPDATE 구문 </update>
//				// </mapper>
//					
//				// 실행할 SQL 구문에서 사용할 데이터 지정
//				, b_no
//		);
//		
//		// [수정 적용행] 리턴
//		return updatePrintNo;
//		
//	}
//	
//	// [게시판 글 입력 후 적용될 행의 개수]를 리턴하는 메소드 선언
//	public int insertReplyBoard(BoardDTO boardDTO){
//		
//		// SqlSessionTemplate 객체의 selectList 메소드 호출로
//		// 게시판 글을 입력하는 SQL 구문을 실행하고 입력 성공한 행의 개수 얻기
//		int boardReplyRegCnt = sqlSession.insert(
//				
//			// 실행할 SQL INSERT 구문의 위치 지정
//			"com.kh.erp.ad.notice.BoardDAO.insertReplyBoard"
//			// SQL 구문의 위치 : *.xml 파일 내부
//			// <mapper namespace="com.kh.erp.ad.notice.BoardBAO">
//			// <insert id="insertBoard"> INSERT 구문 </insert>
//			// </mapper>
//				
//			// 실행할 SQL 구문에서 사용할 데이터 지정
//			, boardDTO
//		);
//		
//		return boardReplyRegCnt;
//	}
	
	

}
