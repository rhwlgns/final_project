package com.kh.erp.ad.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.buf.StringUtils;
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
public class EmpController {

	@Autowired
	private EmpDAO empDAO;
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private LoginDAO loginDAO;

	@RequestMapping(value = "/adEmpReg.do")
	public ModelAndView AdEmpReg(HttpSession session, InfoDTO infoDTO) {
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
		ModelAndView mav = new ModelAndView();
		// ---------------------------------------------
		mav.addObject("infoList", infoList);
		// ---------------------------------------------
		List<Map<String, String>> partList = this.empDAO.getPartList();
		mav.addObject("partList", partList);
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();
		mav.addObject("jikupList", jikupList);

		mav.setViewName("adEmpReg.jsp");
		return mav;
	}

	@RequestMapping(value = "/adEmpList.do")
	public ModelAndView AdEmpList(EmpListDTO empListDTO
			,HttpSession session, InfoDTO infoDTO) {
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
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> empList = this.empDAO.getEmpList(empListDTO);
		List<Map<String, String>> partList = this.empDAO.getPartList();
		List<Map<String, String>> proofList = this.empDAO.getProofList();
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();
		mav.addObject("infoList", infoList);
		mav.addObject("empList", empList);
		mav.addObject("partList", partList);
		mav.addObject("proofList", proofList);
		mav.addObject("jikupList", jikupList);
		mav.setViewName("adEmpList.jsp");
		return mav;
	}

	@RequestMapping(value = "/adEmpListCorr.do")
	public ModelAndView AdEmpListCorr(@RequestParam(value = "no_emp", required = false) String no_emp
			,HttpSession session, InfoDTO infoDTO) {
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
		ModelAndView mav = new ModelAndView();
		mav.addObject("infoList", infoList);
		RegDTO regDTO = this.empDAO.getEmpListCorr(no_emp);		
		List<Map<String, String>> partList = this.empDAO.getPartList();
		mav.addObject("partList", partList);
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();
		mav.addObject("jikupList", jikupList);
		mav.addObject("regDTO", regDTO);
		mav.setViewName("adEmpListCorr.jsp");
		return mav;
	}

	@RequestMapping(value = "/adUserInfoReg.do")
	public ModelAndView AdUserInfoReg(HttpSession session, InfoDTO infoDTO) {
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
		ModelAndView mav = new ModelAndView();
		mav.addObject("infoList", infoList);
		mav.setViewName("adUserInfoReg.jsp");
		return mav;
	}

	@RequestMapping(value = "/adUserInfoRegConfirm.do")
	public ModelAndView AdUserInfoRegConfirm(HttpSession session, InfoDTO infoDTO) {
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
		ModelAndView mav = new ModelAndView();
		mav.addObject("infoList", infoList);
		mav.setViewName("adUserInfoRegConfirm.jsp");
		return mav;
	}

	@RequestMapping(value = "/adUserInfoRegProc.do")
	@ResponseBody
	public int adUserInfoRegProc(UserInfoDTO userInfoDTO) {

		int data = this.empDAO.adUserInfoReg(userInfoDTO);
		return data;
	}

	@RequestMapping(value = "/checkId.do")
	@ResponseBody
	public int checkId(String emp_id) {
		int data = this.empDAO.checkId(emp_id);
		return data;
	}
	
	@RequestMapping(value = "/checkNo.do")
	@ResponseBody
	public int checkNo(String emp_no) {
		int data = this.empDAO.checkNo(emp_no);
		return data;
	}


	@RequestMapping(value = "/adEmpRegConfirm.do")
	public ModelAndView AdEmpRegConfirm(HttpSession session, InfoDTO infoDTO) {
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
		ModelAndView mav = new ModelAndView();
		mav.addObject("infoList", infoList);
		mav.setViewName("adEmpRegConfirm.jsp");
		return mav;
	}

	@RequestMapping(value = "/adEmpRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> adEmpRegProc(RegDTO regDTO) {

		Map<String, String> regDateMap = new HashMap<String, String>();
		

		regDateMap.put("emp_no", regDTO.getEmp_no());
		regDateMap.put("emp_name", regDTO.getEmp_name());
		regDateMap.put("emp_birth", regDTO.getEmp_birth());
		regDateMap.put("emp_jumin", regDTO.getEmp_jumin());
		regDateMap.put("emp_part", regDTO.getEmp_part());
		regDateMap.put("emp_jikup", regDTO.getEmp_jikup());
		regDateMap.put("emp_phone", regDTO.getEmp_phone());
		regDateMap.put("emp_email", regDTO.getEmp_email());
		regDateMap.put("emp_loc", regDTO.getEmp_loc());
		regDateMap.put("emp_detailloc", regDTO.getEmp_detailloc());
		regDateMap.put("emp_hire", regDTO.getEmp_hire());


		this.empDAO.adEmpRegForm(regDTO);

		this.empDAO.adEmpRegPrivate(regDTO);
		
		return regDateMap;

	}

	@RequestMapping(value = "/adEmpListUp.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int adEmpListUp(
			RegDTO regDTO
			
			) {
		
		int updateListCnt = this.empService.updateList(regDTO);
		return updateListCnt;
	}
	
	@RequestMapping(value = "/adEmpListDel.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int adEmpListDel(
			RegDTO regDTO
			
			) {

		int deleteListCnt = this.empService.deleteList(regDTO);
		return deleteListCnt;
	}
	
}
