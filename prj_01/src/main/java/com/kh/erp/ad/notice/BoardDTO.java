package com.kh.erp.ad.notice;

// ---------------------------------------------------------------
// [BoardDTO 클래스] 선언
// ---------------------------------------------------------------
public class BoardDTO {	
	
	private int b_no;
	private String subject;
	private String content;
	private String writer;
	private String email;
	private String pwd;
	private String readcount;
	private String reg_date;
	private String no_emp;
	private String nm_emp;
	private int group_no;
	private int print_no;
	private int print_level; 
	
	private String content_com;
	
	
	public String getContent_com() {
		return content_com;
	}
	public void setContent_com(String content_com) {
		this.content_com = content_com;
	}
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getReadcount() {
		return readcount;
	}
	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getNo_emp() {
		return no_emp;
	}
	public void setNo_emp(String no_emp) {
		this.no_emp = no_emp;
	}
	public String getNm_emp() {
		return nm_emp;
	}
	public void setNm_emp(String nm_emp) {
		this.nm_emp = nm_emp;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getPrint_no() {
		return print_no;
	}
	public void setPrint_no(int print_no) {
		this.print_no = print_no;
	}
	public int getPrint_level() {
		return print_level;
	}
	public void setPrint_level(int print_level) {
		this.print_level = print_level;
	}

}
