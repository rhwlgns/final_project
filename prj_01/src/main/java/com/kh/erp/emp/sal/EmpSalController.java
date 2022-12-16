package com.kh.erp.emp.sal;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.erp.ad.notice.BoardService;
import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Controller
public class EmpSalController {

	@Autowired
	private LoginDAO loginDAO;

	@Autowired
	private EmpSalDAO empSalDAO;

	// 급여명세서 조회 화면
	@RequestMapping(value = "/empSalary.do")
	public ModelAndView empSalaryPwd(InfoDTO infoDTO, HttpSession session, EmpSalDTO empSalDTO) {
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

		// System.out.println(infoList);
		// System.out.println("no_emp : " + infoList.get(0).get("NO_EMP"));

		ModelAndView mav = new ModelAndView();
		mav.addObject("infoList", infoList);
		mav.setViewName("empSalaryPwd.jsp");
		return mav;
	}

	// (개인) 급여명세서 화면 넘어가기
	@RequestMapping(value = "/empSal.do")
	public ModelAndView empSal(
			// EmpSalDTO에 값 한번에 저장하려고
			EmpSalDTO empSalDTO, InfoDTO infoDTO, HttpSession session) {

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
		String no_emp = (String) session.getAttribute("no_emp");

		// System.out.println(session.getAttribute("user_id"));
		// user_id 변수의 값을 infoDTO의 user_id에 저장
		empSalDTO.setUser_id(user_id);
		infoDTO.setNo_emp(no_emp);
		empSalDTO.setNo_emp(no_emp);

		String year = (String) session.getAttribute("year");
		String month = (String) session.getAttribute("month");

		String ym = year + month;

		empSalDTO.setYm(ym);

		List<Map<String, String>> empSalInfoList = this.empSalDAO.getEmpSalInfoList(empSalDTO);

		List<Map<String, String>> empSalAmountInfoList = this.empSalDAO.getEmpSalAmountInfoList(empSalDTO);

		List<Map<String, String>> empSalWithYM = this.empSalDAO.getEmpSalWithYM(empSalDTO);

		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		// 쿼리의 결과 값인 infoList를 ModelAndView 객체에 추가
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

		mav.addObject("empSalInfoList", empSalInfoList);

		mav.addObject("empSalAmountInfoList", empSalAmountInfoList);

		// System.out.println(empSalAmountInfoList);

		// System.out.println(empSalList);

		mav.addObject("empSalWithYM", empSalWithYM);

		// System.out.println(empSalWithYM);

		mav.setViewName("empSalary.jsp");

		return mav;

	}

	// 가상주소 /empSalPwdProc.do 접근 시 호출되는 메소드 선언
	@RequestMapping(value = "/empSalPwdProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int empSalPwdProc(

			@RequestParam(value = "no_emp") String no_emp, @RequestParam(value = "no_res") String no_res,
			@RequestParam(value = "ym") String ym, HttpSession session, HttpServletResponse response,
			EmpSalDTO empSalDTO) {

		session.setAttribute("year", empSalDTO.getYear());
		session.setAttribute("month", empSalDTO.getMonth());

		int checkSalPwdCnt = empSalDAO.checkSalPwd(empSalDTO);

		int checkSal = empSalDAO.getCheckSal(empSalDTO);

		int resultCnt = 0;

		// resultCnt => 0 : no_emp, pw 안맞을 때

		// resultCnt => 1 : no_emp랑 pw가 맞고, 데이터도 있을 때
		// resultCnt => 2 : no_emp랑 pw가 맞는데, 데이터가 없을 때
		if (checkSalPwdCnt == 1) {

			if (checkSal == 1) {
				resultCnt = 1;
			} else if (checkSal == 0) {
				resultCnt = 2;
			}
		} else {
			resultCnt = 0;
		}

		return resultCnt;

	}

}
