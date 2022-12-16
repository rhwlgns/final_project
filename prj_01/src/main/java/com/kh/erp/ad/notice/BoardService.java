package com.kh.erp.ad.notice;

public interface BoardService {

	// [1개의 게시판 글]을 리턴하는 메소드 선언
	BoardDTO getBoard(int b_no, boolean isBoardDetailForm);

	// [1개의 게시판 글]을 입력하고
	// 입력 적용행의 개수를 리턴하는 메소드 선언
	int insertBoard(BoardDTO boardDTO);
	
	// [1개의 게시판 글]을 수정하고
	// 수정 적용행의 개수를 리턴하는 메소드 선언
	int updateBoard(BoardDTO boardDTO);
	
	// [1개의 게시판 글]을 삭제하고
	// 수정 적용행의 개수를 리턴하는 메소드 선언
	int deleteBoard(BoardDTO boardDTO);
	
	int insertComment(BoardDTO boardDTO);
	
	int deleteComment(BoardDTO boardDTO);
	
	int deleteComment1(BoardDTO boardDTO);
}
