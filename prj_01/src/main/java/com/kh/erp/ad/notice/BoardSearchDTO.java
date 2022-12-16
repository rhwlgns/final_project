package com.kh.erp.ad.notice;

import java.util.List;

// ---------------------------------------------------------------
// [BoardSearchDTO 클래스] 선언
// ---------------------------------------------------------------
public class BoardSearchDTO {
	
	private String keyword1;
	private String keyword2;
	private String orAnd;
	private List<String> date;
	private int selectPageNo;
	private int rowCntPerPage;
	private int pageNoPerPage;
	private int begin_rowNo;
	private int end_rowNo;
	private String min_year;
	private String min_month;
	private String max_year;
	private String max_month;
	private String min_year_month;
	private String max_year_month;
	private String sort;
	
	public String getKeyword1() {
		return keyword1;
	}
	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}
	public String getKeyword2() {
		return keyword2;
	}
	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}
	public String getOrAnd() {
		return orAnd;
	}
	public void setOrAnd(String orAnd) {
		this.orAnd = orAnd;
	}
	public List<String> getDate() {
		return date;
	}
	public void setDate(List<String> date) {
		this.date = date;
	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	public int getPageNoPerPage() {
		return pageNoPerPage;
	}
	public void setPageNoPerPage(int pageNoPerPage) {
		this.pageNoPerPage = pageNoPerPage;
	}
	public int getBegin_rowNo() {
		return begin_rowNo;
	}
	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}
	public int getEnd_rowNo() {
		return end_rowNo;
	}
	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}
	public String getMin_year() {
		return min_year;
	}
	public void setMin_year(String min_year) {
		this.min_year = min_year;
	}
	public String getMin_month() {
		return min_month;
	}
	public void setMin_month(String min_month) {
		this.min_month = min_month;
	}
	public String getMax_year() {
		return max_year;
	}
	public void setMax_year(String max_year) {
		this.max_year = max_year;
	}
	public String getMax_month() {
		return max_month;
	}
	public void setMax_month(String max_month) {
		this.max_month = max_month;
	}
	public String getMin_year_month() {
		return min_year_month;
	}
	public void setMin_year_month(String min_year_month) {
		this.min_year_month = min_year_month;
	}
	public String getMax_year_month() {
		return max_year_month;
	}
	public void setMax_year_month(String max_year_month) {
		this.max_year_month = max_year_month;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}

}
