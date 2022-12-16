package com.kh.erp;

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
		
		//  만약 엄마글의 글 번호가 있으면 댓글쓰기 이므로
		//  엄마 글 이후의 게시판 글에 대해 출력순서번호를 1 증가 시키기.
		if(boardDTO.getB_no()>0) {
			
			this.boardDAO.updatePrintNoCnt(boardDTO);
//			int updatePrintNoCnt = this.boardDAO.updatePrintNoCnt(boardDTO);
		}

		// BoardDAOImpl 객체의  insertBoard 메소드 호출하여 게시판 글 입력 후 입력 적용 행의 개수 얻기
		int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
				
		// 입력 적용행의 개수 리턴
		return boardRegCnt;
	}

	
	// [1개의 게시판 글]을 수정하고
	// 수정 적용행의 개수를 리턴하는 메소드 선언
	public int updateBoard(BoardDTO boardDTO) {

		// 수정할 게시판의 개수 얻기
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO.getB_no());
		if(boardCnt==0) {
			return 0;
		}
		
		// 암호의 존재 개수 얻기
		int boardPwdCnt = this.boardDAO.getBoardPwdCnt(boardDTO);
		if(boardPwdCnt==0) {
			return -1;
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
		
		// 암호의 존재 개수 얻기
		int boardPwdCnt = this.boardDAO.getBoardPwdCnt(boardDTO);
		if(boardPwdCnt==0) {
			return -1;
		}
		
		// [BoardDAOImpl 객체]의 getBoardChildrenCnt 메소드를 호출하여
		// [삭제할 게시판의 자식 글의 존재개수]를 얻는다.
		int getBoardChildrenCnt = this.boardDAO.getBoardChildrenCnt(boardDTO);
		if(getBoardChildrenCnt>0) {
			
			// 수정 실행 후 수정 적용행의 개수 얻기
			// 답글이 있을 경우 제목, 내용을 지우는 메소드를 호출하여
			// 글의 제목, 내용 삭제
			this.boardDAO.updateBoardEmpty(boardDTO);
//			int updateBoardEmpty = this.boardDAO.updateBoardEmpty(boardDTO);
			
			return -2;
		}
		
		// 삭제될 게시글의 동생 글의 출력순서 번호를 1씩 감소시키기
		this.boardDAO.updatePrintNoDown(boardDTO);
//		int updatePrintNoDownCnt = this.boardDAO.updatePrintNoDown(boardDTO);
		
		// 삭제 실행 후 삭제 적용행의 개수 얻기
		int deleteBoardCnt = this.boardDAO.deleteBoard(boardDTO);
		
		// 삭제 적용행의 개수 리턴
		return deleteBoardCnt;
	}

}
