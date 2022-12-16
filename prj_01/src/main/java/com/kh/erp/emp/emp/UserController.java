package com.kh.erp.emp.emp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.erp.ad.emp.EmpDAO;
import com.kh.erp.ad.emp.EmpService;
import com.kh.erp.ad.emp.RegDTO;
import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Controller
public class UserController {
	
	@Autowired
	private LoginDAO loginDAO;
	
	@Autowired
	private EmpDAO empDAO;
		
	@RequestMapping(value="/empUserInfo.do")
	public ModelAndView empUserInfo(
			InfoDTO infoDTO
			,HttpSession session
			){
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
		String no_emp = (String)session.getAttribute("no_emp");
		RegDTO regDTO = this.empDAO.getUserInfo(no_emp);
		ModelAndView mav = new ModelAndView();
		mav.addObject("infoList", infoList);
		mav.addObject("regDTO", regDTO);
		mav.setViewName("empUserInfo.jsp");
		return mav;
	}
}
