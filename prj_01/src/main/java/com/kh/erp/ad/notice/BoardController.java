package com.kh.erp.ad.notice;

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

import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Controller
public class BoardController {

	// ---------------------------------------------
	@Autowired
	private LoginDAO loginDAO;
	// ---------------------------------------------

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
	@RequestMapping(value = "/adNotice.do")
	public ModelAndView adNotice(

			// 파라미터값을 저장할 [BoardSearchDTO 객체]를 매개변수로 선언
			BoardSearchDTO boardSearchDTO
			// [파라미터명]과 [BoardSearchDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.

			// ---------------------------------------------
			, InfoDTO infoDTO, HttpSession session
			// ---------------------------------------------
	) {
		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (!(user_id.equals("system"))) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);

		session.setAttribute("no_emp", infoList.get(0).get("NO_EMP"));
		// ---------------------------------------------

		// BoardDAOImpl 객체의
		// getBoardListTotAllCnt 메소드 호출로 [게시판 행의 총 개수] 얻기
		int boardTotAllCnt = this.boardDAO.getBoardListTotAllCnt(boardSearchDTO);

		// BoardDAOImpl 객체의
		// getBoardListTotCnt 메소드 호출로 [검색된 게시판 행의 개수] 얻기
		int boardTotCnt = this.boardDAO.getBoardListTotCnt(boardSearchDTO);

		// *******************************************
		// 페이징 처리 관련 데이터와 기타 데이터(DB 연동시 필요한 데이터,보정된 선택 페이지 번호 등)가 저장된 HashMap 객체 얻기
		// Util 객체의 getPagingMap 라는 메소드 호출로 얻는다.
		// *******************************************
		Map<String, Integer> pagingMap = Util.getPagingMap(boardSearchDTO.getSelectPageNo() // 선택한 페이지 번호
				, boardSearchDTO.getRowCntPerPage() // 한 화면에 보여지는 행의 개수
				, boardTotCnt // 검색된 게시판의 총개수
		);

		// *******************************************
		// BoardSearchDTO 객체의 selectPageNo 속성변수 보정된 선택페이지 번호 재 저장하기
		// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지번호 맞게 부분을 가져올 때 시작행 번호를 저장하기
		// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지번호 맞게 부분을 가져올 때 끝행 번호를 저장하기
		// *******************************************
		boardSearchDTO.setSelectPageNo((int) pagingMap.get("selectPageNo"));
		boardSearchDTO.setBegin_rowNo((int) pagingMap.get("begin_rowNo"));
		boardSearchDTO.setEnd_rowNo((int) pagingMap.get("end_rowNo"));

		// BoardDAOImpl 객체의
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------
//		System.out.println(infoList);
		// [ModelAndView 객체]에
		// [게시판 목록 검색 결과]를 저장
		mav.addObject("boardList", boardList);
		mav.addObject("boardTotCnt", boardTotCnt);
		mav.addObject("boardTotAllCnt", boardTotAllCnt);
		mav.addObject("pagingMap", pagingMap);
		mav.addObject("selectPageNo", (int) pagingMap.get("selectPageNo"));
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
		mav.setViewName("adNotice.jsp");

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}

	@RequestMapping(value = "/empNotice.do")
	public ModelAndView boardListForm(

			// 파라미터값을 저장할 [BoardSearchDTO 객체]를 매개변수로 선언
			BoardSearchDTO boardSearchDTO
			// [파라미터명]과 [BoardSearchDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.

			// ---------------------------------------------
			, InfoDTO infoDTO, HttpSession session
			// ---------------------------------------------
	) {
		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (user_id.equals("")) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);

		session.setAttribute("no_emp", infoList.get(0).get("NO_EMP"));
		// ---------------------------------------------

		// BoardDAOImpl 객체의
		// getBoardListTotAllCnt 메소드 호출로 [게시판 행의 총 개수] 얻기
		int boardTotAllCnt = this.boardDAO.getBoardListTotAllCnt(boardSearchDTO);

		// BoardDAOImpl 객체의
		// getBoardListTotCnt 메소드 호출로 [검색된 게시판 행의 개수] 얻기
		int boardTotCnt = this.boardDAO.getBoardListTotCnt(boardSearchDTO);

		// *******************************************
		// 페이징 처리 관련 데이터와 기타 데이터(DB 연동시 필요한 데이터,보정된 선택 페이지 번호 등)가 저장된 HashMap 객체 얻기
		// Util 객체의 getPagingMap 라는 메소드 호출로 얻는다.
		// *******************************************
		Map<String, Integer> pagingMap = Util.getPagingMap(boardSearchDTO.getSelectPageNo() // 선택한 페이지 번호
				, 10 // 한 화면에 보여지는 행의 개수
				, boardTotCnt // 검색된 게시판의 총개수
		);

		// *******************************************
		// BoardSearchDTO 객체의 selectPageNo 속성변수 보정된 선택페이지 번호 재 저장하기
		// BoardSearchDTO 객체의 begin_rowNo 속성변수에 검색 결과물에서 페이지번호 맞게 부분을 가져올 때 시작행 번호를 저장하기
		// BoardSearchDTO 객체의 end_rowNo 속성변수에 검색 결과물에서 페이지번호 맞게 부분을 가져올 때 끝행 번호를 저장하기
		// *******************************************
		boardSearchDTO.setSelectPageNo((int) pagingMap.get("selectPageNo"));
		boardSearchDTO.setBegin_rowNo((int) pagingMap.get("begin_rowNo"));
		boardSearchDTO.setEnd_rowNo((int) pagingMap.get("end_rowNo"));

		// BoardDAOImpl 객체의
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

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
		mav.addObject("selectPageNo", (int) pagingMap.get("selectPageNo"));
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
		mav.setViewName("empNotice.jsp");
//		System.out.println("boardListForm 컨트롤러 종료");
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
	@RequestMapping(value = "/adNoticeReg.do")
	public ModelAndView boardRegForm(
			// ---------------------------------------------
			InfoDTO infoDTO, HttpSession session
	// ---------------------------------------------
	) {

		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (!(user_id.equals("system"))) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);
		// ---------------------------------------------

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("adNoticeReg.jsp");

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}

	// ---------------------------------------------------------------
	// /boardRegProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value = "/boardRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int boardRegProc(

			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO, @RequestParam(value = "subject") String subject,
			@RequestParam(value = "content", required = false) String content
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			, HttpSession session

	) {
		boardDTO.setNo_emp((String) session.getAttribute("no_emp"));

//		System.out.println(boardDTO.getNo_emp());

		// [boardServiceDAOImpl 객체]의 insertBoard 메소드를 호출하여
		// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
		int boardRegCnt = this.boardService.insertBoard(boardDTO);

		// [입력 적용행의 개수] 얻기
		return boardRegCnt;
	}

	// ---------------------------------------------------------------
	// /boardComProc.do로 접근하면 호출되는 메소드 선언 (댓글입력관련)
	// ---------------------------------------------------------------
	@RequestMapping(value = "/boardComProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int boardComProc(BoardDTO boardDTO, HttpSession session) {

		// [boardServiceDAOImpl 객체]의 insertBoard 메소드를 호출하여
		// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
		int boardComCnt = this.boardService.insertComment(boardDTO);

//		System.out.println(boardComCnt);
		// [입력 적용행의 개수] 얻기
//		System.out.println("boardComProc 컨트롤러 종료");
		return boardComCnt;
	}

	// ---------------------------------------------------------------
	// /adNoticeDetail.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value = "/adNoticeDetail.do")
	public ModelAndView adNoticeDetail(

			// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
			@RequestParam(value = "b_no", required = false) int b_no
			// 상세보기 할 게시판 고유번호가 들어오는 매개변수 선언

			// ---------------------------------------------
			, InfoDTO infoDTO, HttpSession session
	// ---------------------------------------------
	) {
		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (!(user_id.equals("system"))) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);

		// ---------------------------------------------
		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, true);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		List<Map<String, String>> comment = this.boardDAO.getComment(b_no);

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("adNoticeDetail.jsp");

		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
		// BoardDTO 객체 저장하기
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("comment", comment);
		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}

	// ---------------------------------------------------------------
	// /empNoticeDetail.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value = "/empNoticeDetail.do")
	public ModelAndView empNoticeDetail(@RequestParam(value = "b_no", required = false) int b_no, InfoDTO infoDTO, HttpSession session) {
		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (user_id.equals("")) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);

		session.setAttribute("no_emp", infoList.get(0).get("NO_EMP"));
		// ---------------------------------------------

		// ---------------------------------------------
		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, true);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		List<Map<String, String>> comment = this.boardDAO.getComment(b_no);

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("empNoticeDetail.jsp");

		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
		// BoardDTO 객체 저장하기
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("comment", comment);
		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}

	// ---------------------------------------------------------------
	// /adNoticeUpdate.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value = "/adNoticeUpdate.do")
	public ModelAndView adNoticeUpdate(

			// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
			@RequestParam(value = "b_no", required = false) int b_no
			// 수정/삭제 할 게시판 고유번호가 들어오는 매개변수 선언
			// ---------------------------------------------
			, InfoDTO infoDTO, HttpSession session
	// ---------------------------------------------
	) {

		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (!(user_id.equals("system"))) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);
		// ---------------------------------------------

		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, false);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("adNoticeUpdate.jsp");

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
	@RequestMapping(value = "/boardUpProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int boardUpProc(

			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO, @RequestParam(value = "subject", required = false) String subject,
			@RequestParam(value = "content", required = false) String content
	// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
	// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	) {
		// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여
		// 게시판 글을 수정하고 [수정이 적용될 행의 개수] 얻기
		int updateBoardCnt = this.boardService.updateBoard(boardDTO);

		// [수정 적용행의 개수] 얻기
		return updateBoardCnt;
	}

	// ---------------------------------------------------------------
	// /boardDelProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value = "/boardDelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int boardDelProc(

			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
	// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
	// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	) {
		// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여
		// 게시판 글을 삭제하고 [삭제가 적용될 행의 개수] 얻기
		int deleteBoardCnt = this.boardService.deleteBoard(boardDTO);

		// [삭제 적용행의 개수] 얻기
		return deleteBoardCnt;
	}

	// ---------------------------------------------------------------
	// /commentDelProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value = "/commentDelProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int commentDelProc(

			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
	// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
	// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	) {
//		System.out.println("commentDelProc.do 컨트롤러 시작");
//		System.out.println(boardDTO.getPrint_level());
//		System.out.println(boardDTO.getB_no());

		int deleteCommentCnt = this.boardService.deleteComment(boardDTO);

		// [삭제 적용행의 개수] 얻기
//		System.out.println("commentDelProc.do 컨트롤러에서 종료");
		return deleteCommentCnt;
	}

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// /commentDelProc2.do로 접근하면 호출되는 메소드 선언(게시글 댓글 모두 삭제하는 메소드)
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/commentDelProc2.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int commentDelProc2(

			BoardDTO boardDTO) {
//		System.out.println("commentDelProc.do 컨트롤러 시작");
//		System.out.println(boardDTO.getPrint_level());
//		System.out.println(boardDTO.getB_no());

		// b_no 가 같은 댓글들 모두 삭제
		int deleteCommentCnt1 = this.boardService.deleteComment1(boardDTO);

		// [삭제 적용행의 개수] 얻기
//		System.out.println("commentDelProc.do 컨트롤러에서 종료");
		return 1;
	}

}
