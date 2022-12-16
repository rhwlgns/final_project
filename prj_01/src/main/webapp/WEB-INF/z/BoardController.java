package com.kh.erp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	
	// boardDAO 속성변수에
	// BoardDAO 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardDAO boardDAO;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardDAO 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardDAO 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// boardService 속성변수에
	// BoardService 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardService boardService;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardService 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardService 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// ---------------------------------------------------------------
	// 가상주소 /boardList.do로 접근하면 호출되는 메소드 선언
	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
	// 가상주소 /boardList.do로 접근 시 get 또는 post 접근 모두 허용
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardList.do")
	public ModelAndView boardListForm( 
			
			// 파라미터값을 저장할 [BoardSearchDTO 객체]를 매개변수로 선언
			BoardSearchDTO boardSearchDTO
			// [파라미터명]과 [BoardSearchDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			
//			미 로그인 시 보여줄 창 띄우기(직접설정)
//			, HttpSession session
	) {
		
//		if(boardSearchDTO.getDate()!=null) {
//			for(int i=0; i<boardSearchDTO.getDate().size(); i++){
//				System.out.println(boardSearchDTO.getDate().get(i));
//			}
//		}
//		System.out.println("getKeyword1 : " + boardSearchDTO.getKeyword1());
//		System.out.println("getSelectPageNo : " + boardSearchDTO.getSelectPageNo());
//		System.out.println("getRowCntPerPage : " + boardSearchDTO.getRowCntPerPage());
//		System.out.println("getPageNoPerPage : " + boardSearchDTO.getPageNoPerPage());
		
//		미 로그인 시 보여줄 창 띄우기(직접설정)
//		String mid = (String)session.getAttribute("mid");
//		if(mid==null) {
//			ModelAndView mav = new ModelAndView();
//			
//			mav.addObject("msg", "로그인을 먼저 해주세요.");
//			mav.setViewName("error.jsp");
//			
//			return mav;
//		}
		
		// BoardDAOImpl 객체의 
		// getBoardListTotAllCnt 메소드 호출로 [게시판 행의 총 개수] 얻기
		int boardTotAllCnt = this.boardDAO.getBoardListTotAllCnt(boardSearchDTO);
		
		// BoardDAOImpl 객체의 
		// getBoardListTotCnt 메소드 호출로 [검색된 게시판 행의 개수] 얻기
		int boardTotCnt = this.boardDAO.getBoardListTotCnt(boardSearchDTO);
		
		// Util 객체의 
		// getPagingMap 메소드 호출로 
		// paging 처리와 관련된 데이터와
		// 기타 데이터가 저장되어 있는 HashMap 객체 얻기
			// 기타 데이터 : DB 연동 시 필요한 데이터, 보정된 선택 페이지 번호 등
		Map<String, Integer> pagingMap = Util.getPagingMap(
				
			// 선택된 페이지 번호
			boardSearchDTO.getSelectPageNo()
			
			// 한 화면에 보여지는 행의 개수
			, boardSearchDTO.getRowCntPerPage()
			
			// 검색된 게시판 행의 총 개수 
			, boardTotCnt
		);
		
		// boardSearchDTO 객체의 
		// setSelectPageNo 메소드 호출로 [선택된 페이지 번호] 보정
		boardSearchDTO.setSelectPageNo((int)pagingMap.get("selectPageNo"));
		
		// boardSearchDTO 객체의 
		// setBegin_rowNo 메소드 호출로 [보여지는 시작 페이지 번호] 보정
		boardSearchDTO.setBegin_rowNo((int)pagingMap.get("begin_rowNo"));
		
		// boardSearchDTO 객체의 
		// setEnd_rowNo 메소드 호출로 [보여지는 끝 페이지 번호] 보정
		boardSearchDTO.setEnd_rowNo((int)pagingMap.get("end_rowNo"));
		
		// BoardDAOImpl 객체의 
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 결과]를 저장
		mav.addObject("boardList", boardList);
		// [ModelAndView 객체]에 저장된 객체는
		// HttpServletRequest 객체에도 저장된다.
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 결과 개수]를 저장
		mav.addObject("boardTotCnt", boardTotCnt);
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 총 결과]를 저장
		mav.addObject("boardTotAllCnt", boardTotAllCnt);
		
		// [ModelAndView 객체]에 
		// [페이징 처리 관련 HashMap 객체]를 저장
		mav.addObject("pagingMap", pagingMap);
		
		// [ModelAndView 객체]에 
		// [보정된 선택 페이지 번호]를 저장
		 mav.addObject("selectPageNo", (int)pagingMap.get("selectPageNo"));
//		해당 코딩을 쓰지 않으면 boardList.jsp에서
//		formObj.find(".selectPageNo").val("${requestScope.selectPageNo}"); 대신
//		formObj.find(".selectPageNo").val("${requestScope.pagingMap.selectPageNo}"); 사용하여야 함


		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("boardList.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	@RequestMapping(value="/boardList2.do")
	public ModelAndView boardListForm2( 
			
			// 파라미터값을 저장할 [BoardSearchDTO 객체]를 매개변수로 선언
			BoardSearchDTO boardSearchDTO
			// [파라미터명]과 [BoardSearchDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			
//			미 로그인 시 보여줄 창 띄우기(직접설정)
//			, HttpSession session
	) {
		
//		if(boardSearchDTO.getDate()!=null) {
//			for(int i=0; i<boardSearchDTO.getDate().size(); i++){
//				System.out.println(boardSearchDTO.getDate().get(i));
//			}
//		}
//		System.out.println("getKeyword1 : " + boardSearchDTO.getKeyword1());
//		System.out.println("getSelectPageNo : " + boardSearchDTO.getSelectPageNo());
//		System.out.println("getRowCntPerPage : " + boardSearchDTO.getRowCntPerPage());
//		System.out.println("getPageNoPerPage : " + boardSearchDTO.getPageNoPerPage());
		
//		미 로그인 시 보여줄 창 띄우기(직접설정)
//		String mid = (String)session.getAttribute("mid");
//		if(mid==null) {
//			ModelAndView mav = new ModelAndView();
//			
//			mav.addObject("msg", "로그인을 먼저 해주세요.");
//			mav.setViewName("error.jsp");
//			
//			return mav;
//		}
		
		// BoardDAOImpl 객체의 
		// getBoardListTotAllCnt 메소드 호출로 [게시판 행의 총 개수] 얻기
		int boardTotAllCnt = this.boardDAO.getBoardListTotAllCnt(boardSearchDTO);
		
		// BoardDAOImpl 객체의 
		// getBoardListTotCnt 메소드 호출로 [검색된 게시판 행의 개수] 얻기
		int boardTotCnt = this.boardDAO.getBoardListTotCnt(boardSearchDTO);
		
		// Util 객체의 
		// getPagingMap 메소드 호출로 
		// paging 처리와 관련된 데이터와
		// 기타 데이터가 저장되어 있는 HashMap 객체 얻기
			// 기타 데이터 : DB 연동 시 필요한 데이터, 보정된 선택 페이지 번호 등
		Map<String, Integer> pagingMap = Util.getPagingMap(
				
			// 선택된 페이지 번호
			boardSearchDTO.getSelectPageNo()
			
			// 한 화면에 보여지는 행의 개수
			, boardSearchDTO.getRowCntPerPage()
			
			// 검색된 게시판 행의 총 개수 
			, boardTotCnt
		);
		
		// boardSearchDTO 객체의 
		// setSelectPageNo 메소드 호출로 [선택된 페이지 번호] 보정
		boardSearchDTO.setSelectPageNo((int)pagingMap.get("selectPageNo"));
		
		// boardSearchDTO 객체의 
		// setBegin_rowNo 메소드 호출로 [보여지는 시작 페이지 번호] 보정
		boardSearchDTO.setBegin_rowNo((int)pagingMap.get("begin_rowNo"));
		
		// boardSearchDTO 객체의 
		// setEnd_rowNo 메소드 호출로 [보여지는 끝 페이지 번호] 보정
		boardSearchDTO.setEnd_rowNo((int)pagingMap.get("end_rowNo"));
		
		// BoardDAOImpl 객체의 
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 결과]를 저장
		mav.addObject("boardList", boardList);
		// [ModelAndView 객체]에 저장된 객체는
		// HttpServletRequest 객체에도 저장된다.
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 결과 개수]를 저장
		mav.addObject("boardTotCnt", boardTotCnt);
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 총 결과]를 저장
		mav.addObject("boardTotAllCnt", boardTotAllCnt);
		
		// [ModelAndView 객체]에 
		// [페이징 처리 관련 HashMap 객체]를 저장
		mav.addObject("pagingMap", pagingMap);
		
		// [ModelAndView 객체]에 
		// [보정된 선택 페이지 번호]를 저장
		 mav.addObject("selectPageNo", (int)pagingMap.get("selectPageNo"));
//		해당 코딩을 쓰지 않으면 boardList.jsp에서
//		formObj.find(".selectPageNo").val("${requestScope.selectPageNo}"); 대신
//		formObj.find(".selectPageNo").val("${requestScope.pagingMap.selectPageNo}"); 사용하여야 함


		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("boardList2.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// 가상주소 /boardRegForm.do로 접근하면 호출되는 메소드 선언
	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
	// 가상주소 /boardRegForm.do로 접근 시 get 또는 post 접근 모두 허용
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardRegForm.do")
	public ModelAndView boardRegForm(){

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("boardRegForm.jsp");

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// /boardRegProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardRegProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int boardRegProc( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	){
		
		// [boardServiceDAOImpl 객체]의 insertBoard 메소드를 호출하여 
		// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
		int boardRegCnt = this.boardService.insertBoard(boardDTO);
			
		// [입력 적용행의 개수] 얻기
		return boardRegCnt;
	}
	
	// ---------------------------------------------------------------
	// /boardDetailForm.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardDetailForm.do")
	public ModelAndView boardDetailForm(
			
		// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
		@RequestParam(value = "b_no") int b_no
		// 상세보기 할 게시판 고유번호가 들어오는 매개변수 선언
	){
		
		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여 
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, true);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("boardDetailForm.jsp");
		
		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
		// BoardDTO 객체 저장하기
		mav.addObject("boardDTO", boardDTO);

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// /boardUpDelForm.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardUpDelForm.do")
	public ModelAndView boardUpDelForm(
			
		// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
		@RequestParam(value = "b_no") int b_no
		// 수정/삭제 할 게시판 고유번호가 들어오는 매개변수 선언
	){
		
		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여 
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, false);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("boardUpDelForm.jsp");
		
		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
		// BoardDTO 객체 저장하기
		mav.addObject("boardDTO", boardDTO);

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// /boardUpProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardUpProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int boardUpProc( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	){
		// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여 
		// 게시판 글을 수정하고 [수정이 적용될 행의 개수] 얻기
		int updateBoardCnt = this.boardService.updateBoard(boardDTO);
		
		// [수정 적용행의 개수] 얻기
		return updateBoardCnt;
	}
	
	// ---------------------------------------------------------------
	// /boardDelProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardDelProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int boardDelProc( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	){
		// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여 
		// 게시판 글을 삭제하고 [삭제가 적용될 행의 개수] 얻기
		int deleteBoardCnt = this.boardService.deleteBoard(boardDTO);
		
		// [삭제 적용행의 개수] 얻기
		return deleteBoardCnt;
	}
	
//	// ---------------------------------------------------------------
//	// 가상주소 /boardReplyForm.do로 접근하면 호출되는 메소드 선언
//	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
//	// 가상주소 /boardReplyForm.do로 접근 시 get 또는 post 접근 모두 허용
//	// ---------------------------------------------------------------
//	@RequestMapping(value="/boardReplyForm.do")
//	public ModelAndView boardReplyForm(
//			
//		// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
//		@RequestParam(value = "b_no") int b_no
//		// 답글을 달 게시판 고유번호가 들어오는 매개변수 선언
//			
//	){
//		
//		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여 
//		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
//		BoardDTO boardDTO = this.boardService.getBoard(b_no, false);
//		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
//		// VO : Value Object
//		// DTO : Data Transfer Object
//
//		// [ModelAndView 객체] 생성
//		ModelAndView mav = new ModelAndView();
//		
//		// [ModelAndView 객체]의
//		// setViewName 메소드를 호출하여
//		// [호출할 JSP 페이지명]을 문자로 저장
//		mav.setViewName("boardReplyForm.jsp");
//		
//		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
//		// BoardDTO 객체 저장하기
//		mav.addObject("boardDTO", boardDTO);
//		
//		// [ModelAndView 객체] 리턴
//		return mav;
//		// Spring은 ModelAndView 객체 리턴 시
//		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
//	}
//		
//	// ---------------------------------------------------------------
//	// /boardReplyRegProc.do로 접근하면 호출되는 메소드 선언
//	// ---------------------------------------------------------------
//	@RequestMapping( 
//			value="/boardReplyRegProc.do" 
//			,method=RequestMethod.POST
//			,produces="application/json;charset=UTF-8"
//	)
//	@ResponseBody
//	public int boardReplyRegProc( 
//			
//			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
//			BoardDTO boardDTO
//			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
//			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
//	){
//		
//		this.boardDAO.updatePrintNo(boardDTO.getB_no());
//		
//		// [BoardDAOImpl 객체]의 insertReplyBoard 메소드를 호출하여 
//		// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
//		int boardReplyRegCnt = this.boardDAO.insertReplyBoard(boardDTO);
//		
//		// [입력 적용행의 개수] 얻기
//		return boardReplyRegCnt;
//	}
	
}
