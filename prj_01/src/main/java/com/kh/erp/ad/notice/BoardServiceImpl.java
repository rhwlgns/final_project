package com.kh.erp.ad.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
// @Service : [서비스 클래스]임을 지정하고 
// 스프링이 이 객체를 관리하도록 등록된다.
@Service
// @Transactional : [서비스 클래스]의 
// 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
@Transactional

// [서비스 클래스]인 [BoardServiceImpl 클래스 선언]
public class BoardServiceImpl implements BoardService{

	// boardDAO 속성변수에
	// BoardDAO 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardDAO boardDAO;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardDAO 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardDAO 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// [1개의 게시판 글]을 리턴하는 메소드 선언
	public BoardDTO getBoard(int b_no, boolean isBoardDetailForm) {
		
		if(isBoardDetailForm==true) {
			// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
			// [조회수 증가] 작업 후 수정한 행의 개수를 얻는다.
			int updatecount = this.boardDAO.updateReadcount(b_no);
			
			if(updatecount==0) {
				return null;
			}
		}

		// [BoardDAOImpl 객체]의 getBoard 메소드를 호출하여
		// [1개의 게시판 글]을 얻는다.
		BoardDTO getBoard = this.boardDAO.getBoard(b_no);

		return getBoard;
	}
	
	
	// [1개의 게시판 글]을 입력하고
	// 입력 적용행의 개수를 리턴하는 메소드 선언
	public int insertBoard(BoardDTO boardDTO) {

		// BoardDAOImpl 객체의  insertBoard 메소드 호출하여 게시판 글 입력 후 입력 적용 행의 개수 얻기
		int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
				
		// 입력 적용행의 개수 리턴
		return boardRegCnt;
	}
	
	public int insertComment(BoardDTO boardDTO) {
		int boardComCnt = this.boardDAO.insertComment(boardDTO);

		System.out.println(boardDTO.getB_no());
		System.out.println(boardComCnt);
		return boardComCnt;
	}

	
	// [1개의 게시판 글]을 수정하고
	// 수정 적용행의 개수를 리턴하는 메소드 선언
	public int updateBoard(BoardDTO boardDTO) {

		// 수정할 게시판의 개수 얻기
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO.getB_no());
		if(boardCnt==0) {
			return 0;
		}
		
		// 수정 실행 후 수정 적용행의 개수 얻기
		int updateBoardCnt = this.boardDAO.updateBoard(boardDTO);
		
		// 수정 적용행의 개수 리턴
		return updateBoardCnt;
	}
	
	// [1개의 게시판 글]을 삭제하고
	// 삭제 적용행의 개수를 리턴하는 메소드 선언
	public int deleteBoard(BoardDTO boardDTO) {

		// 삭제할 게시판의 개수 얻기
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO.getB_no());
		if(boardCnt==0) {
			return 0;
		}
		
		// 삭제될 게시글의 동생 글의 출력순서 번호를 1씩 감소시키기
		//this.boardDAO.updatePrintNoDown(boardDTO);
//		int updatePrintNoDownCnt = this.boardDAO.updatePrintNoDown(boardDTO);
		
		// 삭제 실행 후 삭제 적용행의 개수 얻기
		int deleteBoardCnt = this.boardDAO.deleteBoard(boardDTO);
		
		// 삭제 적용행의 개수 리턴
		return deleteBoardCnt;
	}
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 댓글 삭제
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int deleteComment(BoardDTO boardDTO) {
		System.out.println(boardDTO.getPrint_level());
		System.out.println(boardDTO.getB_no());
		System.out.println("deleteComment 보드서비스임플 시작");
		// 삭제할 게시판의 개수 얻기
		int commentCnt = this.boardDAO.getCommentCnt(boardDTO);

		System.out.println("commentCnt:"+commentCnt);
		
		if(commentCnt==0) {
			return 0;
		}
		
		// 삭제될 게시글의 동생 글의 출력순서 번호를 1씩 감소시키기
		//this.boardDAO.updateCommentPrintNoDown(boardDTO);
		
		// 삭제 실행 후 삭제 적용행의 개수 얻기
		int deleteCommentCnt = this.boardDAO.deleteComment(boardDTO);

		System.out.println("deleteCommentCnt:"+deleteCommentCnt);
		// 삭제 적용행의 개수 리턴
		System.out.println("deleteComment 보드서비스임플 종료");
		return deleteCommentCnt;
	}

	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 게시글 삭제시 b_no가 같은 댓글 모두 삭제하는 메소드
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int deleteComment1(BoardDTO boardDTO) {
		
		// 삭제 실행 후 삭제 적용행의 개수 얻기
		int deleteCommentCnt1 = this.boardDAO.deleteComment1(boardDTO);

		// 삭제 적용행의 개수 리턴
		return deleteCommentCnt1;
	}

}
