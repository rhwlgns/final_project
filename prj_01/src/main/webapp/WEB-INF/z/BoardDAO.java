package com.kh.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

// ---------------------------------------------------------------
// [BoardDAO 인터페이스] 선언
// ---------------------------------------------------------------

@Mapper
public interface BoardDAO {
	
	// [검색한 게시판 목록]을 리턴하는 메소드 선언
	List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO);
	
	// [검색한 게시판 목록]의 총 개수를 리턴하는 메소드 선언
	int getBoardListTotCnt(BoardSearchDTO boardSearchDTO);
	
	// [게시판 목록]의 총 개수를 리턴하는 메소드 선언
	int getBoardListTotAllCnt(BoardSearchDTO boardSearchDTO);
	
	// [게시판 글 입력 후 적용될 행의 개수]를 리턴하는 메소드 선언
	int insertBoard(BoardDTO boardDTO);
	// public int insertBoard(BoardDTO boardDTO);
	
	// 답글을 달 게시판의 모든 후손 글들의 
	// print_no를 1 업데이트 하는 메소드 선언
	int updatePrintNoCnt(BoardDTO boardDTO);
	
	// 조회수를 1 증가하고
	// 업데이트한 행의 개수를 얻는 메소드 선언
	int updateReadcount(int b_no);
	
	// [1개의 게시판 정보]를 리턴하는 메소드 선언
	BoardDTO getBoard(int b_no);
	
	// 수정, 삭제할 게시판의 존재 개수를 리턴하는 메소드 선언
	int getBoardCnt(int b_no);
	
	// 수정, 삭제할 게시판의 비밀번호 존재 개수를 리턴하는 메소드 선언
	int getBoardPwdCnt(BoardDTO boardDTO);
	
	// 게시판 수정 명령 후 수정 적용행의 개수를 리턴하는 메소드 선언
	int updateBoard(BoardDTO boardDTO);
	
	// 삭제할 게시판의 후손 글의 존재개수를 리턴하는 메소드 선언
	int getBoardChildrenCnt(BoardDTO boardDTO);
	
	// 후손 글이 있을 경우 제목, 내용을 비우는 메소드 선언
	int updateBoardEmpty(BoardDTO boardDTO);
	
	// 삭제될 게시글의 동생 글의 출력순서 번호를 1씩 감소시키는 메소드 선언
	int updatePrintNoDown(BoardDTO boardDTO);
	
	// 게시판 삭제 명령 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	int deleteBoard(BoardDTO boardDTO);
	
//	// 답글을 달 게시판의 모든 후손 글들의 
//	// print_no를 1 업데이트 하는 메소드 선언
//	int updatePrintNo(int b_no);
//	
//	// [답글 입력 후 적용될 행의 개수]를 리턴하는 메소드 선언
//	int insertReplyBoard(BoardDTO boardDTO);
	
}
