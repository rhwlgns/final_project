package com.kh.erp.ad.sal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.authenticator.DigestAuthenticator.DigestInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.erp.ad.notice.BoardDAO;
import com.kh.erp.ad.notice.BoardDTO;
import com.kh.erp.ad.notice.BoardSearchDTO;
import com.kh.erp.ad.notice.BoardService;
import com.kh.erp.ad.notice.Util;
import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Controller
public class AdSalController {

	@Autowired
	private LoginDAO loginDAO;

	@Autowired
	private AdSalDAO adSalDAO;

	@RequestMapping(value = "/adSal.do")
	public ModelAndView adNotice(InfoDTO infoDTO, HttpSession session, AmpaymentDTO qwe) {

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

		List<Map<String, String>> empSalList = this.adSalDAO.getEmpSalList(qwe);

		List<Map<String, String>> payList = this.adSalDAO.getPayList();

		List<Map<String, String>> noEmp = this.adSalDAO.getNoEmp();

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		mav.addObject("infoList", infoList);
		// ---------------------------------------------

		mav.addObject("empList", empSalList);
		mav.addObject("payList", payList);
		mav.addObject("noEmp", noEmp);
		mav.setViewName("adSal.jsp");

		// [ModelAndView 객체] 리턴
		return mav;

	}

	// 가상주소 /insertPayProc.do 접근 시 호출되는 메소드 선언
	@RequestMapping(value = "/insertPayProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int insertPayProc(

			AmpaymentDTO ampaymentDTO, HttpSession session, HttpServletResponse response) {
		int searchPay = this.adSalDAO.searchPay(ampaymentDTO);

		if (searchPay >= 1) {
			return -1;
		} else {
			int inesertPay = this.adSalDAO.insertPay(ampaymentDTO);

			return inesertPay;
		}
	}
	
	// 가상주소 /updatePayProc.do 접근 시 호출되는 메소드 선언
	@RequestMapping(value = "/updatePayProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int updatePayProc(

			AmpaymentDTO ampaymentDTO, HttpSession session, HttpServletResponse response) {
		
		int updatePay = this.adSalDAO.updatePay(ampaymentDTO);
		
		return updatePay;
	}

	// 가상주소 /deletePayProc.do 접근 시 호출되는 메소드 선언
	@RequestMapping(value = "/deletePayProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int deletePayProc(

			AmpaymentDTO ampaymentDTO, HttpSession session, HttpServletResponse response) {
		int searchPay = this.adSalDAO.searchPay(ampaymentDTO);

		if (searchPay != 1) {
			return -1;
		} else {
			int deletePay = this.adSalDAO.deletePay(ampaymentDTO);
			
			System.out.println(deletePay);

			return deletePay;
		}
	}

	@RequestMapping(value = "/selPayProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> selPayProc(

			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			AmpaymentDTO ampaymentDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			, HttpSession session

	) {

		List<Map<String, String>> selPayList1 = this.adSalDAO.selPay(ampaymentDTO);
		Map<String, String> selPayList = selPayList1.get(0);

//		System.out.println(selPayList);

		// [ModelAndView 객체] 리턴
		return selPayList;
	}



}