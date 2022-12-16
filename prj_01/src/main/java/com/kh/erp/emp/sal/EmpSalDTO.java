package com.kh.erp.emp.sal;

import java.sql.Date;

public class EmpSalDTO {
	// 이름, 사번, 입사일, 부서, 직급
	private String nm_emp;
	private String no_emp;
	private String enter_date;
	
	// 주민번호
	private String no_res;
	
	
	public String getNo_res() {
		return no_res;
	}
	public void setNo_res(String no_res) {
		this.no_res = no_res;
	}
	public String getNm_emp() {
		return nm_emp;
	}
	public void setNm_emp(String nm_emp) {
		this.nm_emp = nm_emp;
	}
	public String getNo_emp() {
		return no_emp;
	}
	public void setNo_emp(String no_emp) {
		this.no_emp = no_emp;
	}
	public String getEnter_date() {
		return enter_date;
	}
	public void setEnter_date(String enter_date) {
		this.enter_date = enter_date;
	}
	public String getNm_dept() {
		return nm_dept;
	}

	private String nm_dept;
	private String nm_jik;
	private String user_id;
	
	public void setNm_dept(String nm_dept) {
		this.nm_dept = nm_dept;
	}
	public String getNm_jik() {
		return nm_jik;
	}
	public void setNm_jik(String nm_jik) {
		this.nm_jik = nm_jik;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	

	// 지급내역, 공제내역
	private String nm_pay01;
	private String nm_pay02;
	private String nm_pay03;
	private String nm_pay04;
	private String nm_deduct01;
	private String nm_deduct02;
	private String nm_deduct03;
	private String nm_deduct04;
	
	
	
	
	// 지급금액, 공제금액
	private int am_pay01;
	private int am_pay02;
	private int am_deduct01;
	private int am_deduct02;
	private int am_pay03;
	private int am_pay04;
	private int am_deduct03;
	private int am_deduct04;
	private int am_pay05;
	private int am_pay06;
	private int am_pay07;
	private int am_pay08;
	private int am_deduct05;
	private int am_deduct06;
	private int am_deduct07;
	private int am_deduct08;
	
	
	
	public int getAm_pay05() {
		return am_pay05;
	}
	public void setAm_pay05(int am_pay05) {
		this.am_pay05 = am_pay05;
	}
	public int getAm_pay06() {
		return am_pay06;
	}
	public void setAm_pay06(int am_pay06) {
		this.am_pay06 = am_pay06;
	}
	public int getAm_pay07() {
		return am_pay07;
	}
	public void setAm_pay07(int am_pay07) {
		this.am_pay07 = am_pay07;
	}
	public int getAm_pay08() {
		return am_pay08;
	}
	public void setAm_pay08(int am_pay08) {
		this.am_pay08 = am_pay08;
	}
	public int getAm_deduct05() {
		return am_deduct05;
	}
	public void setAm_deduct05(int am_deduct05) {
		this.am_deduct05 = am_deduct05;
	}
	public int getAm_deduct06() {
		return am_deduct06;
	}
	public void setAm_deduct06(int am_deduct06) {
		this.am_deduct06 = am_deduct06;
	}
	public int getAm_deduct07() {
		return am_deduct07;
	}
	public void setAm_deduct07(int am_deduct07) {
		this.am_deduct07 = am_deduct07;
	}
	public int getAm_deduct08() {
		return am_deduct08;
	}
	public void setAm_deduct08(int am_deduct08) {
		this.am_deduct08 = am_deduct08;
	}
	public int getAm_pay03() {
		return am_pay03;
	}
	public void setAm_pay03(int am_pay03) {
		this.am_pay03 = am_pay03;
	}
	public int getAm_pay04() {
		return am_pay04;
	}
	public void setAm_pay04(int am_pay04) {
		this.am_pay04 = am_pay04;
	}
	public int getAm_deduct03() {
		return am_deduct03;
	}
	public void setAm_deduct03(int am_deduct03) {
		this.am_deduct03 = am_deduct03;
	}
	public int getAm_deduct04() {
		return am_deduct04;
	}
	public void setAm_deduct04(int am_deduct04) {
		this.am_deduct04 = am_deduct04;
	}
	public String getNm_pay01() {
		return nm_pay01;
	}
	public void setNm_pay01(String nm_pay01) {
		this.nm_pay01 = nm_pay01;
	}
	public String getNm_pay02() {
		return nm_pay02;
	}
	public void setNm_pay02(String nm_pay02) {
		this.nm_pay02 = nm_pay02;
	}
	public String getNm_pay03() {
		return nm_pay03;
	}
	public void setNm_pay03(String nm_pay03) {
		this.nm_pay03 = nm_pay03;
	}
	public String getNm_pay04() {
		return nm_pay04;
	}
	public void setNm_pay04(String nm_pay04) {
		this.nm_pay04 = nm_pay04;
	}
	public int getAm_pay01() {
		return am_pay01;
	}
	public void setAm_pay01(int am_pay01) {
		this.am_pay01 = am_pay01;
	}
	public int getAm_pay02() {
		return am_pay02;
	}
	public void setAm_pay02(int am_pay02) {
		this.am_pay02 = am_pay02;
	}
	public int getAm_deduct01() {
		return am_deduct01;
	}
	public void setAm_deduct01(int am_deduct01) {
		this.am_deduct01 = am_deduct01;
	}
	public int getAm_deduct02() {
		return am_deduct02;
	}
	public void setAm_deduct02(int am_deduct02) {
		this.am_deduct02 = am_deduct02;
	}
	public String getNm_deduct01() {
		return nm_deduct01;
	}
	public void setNm_deduct01(String nm_deduct01) {
		this.nm_deduct01 = nm_deduct01;
	}
	public String getNm_deduct02() {
		return nm_deduct02;
	}
	public void setNm_deduct02(String nm_deduct02) {
		this.nm_deduct02 = nm_deduct02;
	}
	public String getNm_deduct03() {
		return nm_deduct03;
	}
	public void setNm_deduct03(String nm_deduct03) {
		this.nm_deduct03 = nm_deduct03;
	}
	public String getNm_deduct04() {
		return nm_deduct04;
	}
	public void setNm_deduct04(String nm_deduct04) {
		this.nm_deduct04 = nm_deduct04;
	}
	
	
	// 급여쪽 귀속년월 받아오는 값.?
	// ym
	private String year;
	private String month;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	
	private String ym;


	public String getYm() {
		return ym;
	}
	public void setYm(String ym) {
		this.ym = ym;
	}
	
	
	
}
