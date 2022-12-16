<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
<%@page import="java.sql.*" %>   

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여명세서 조회</title>

<script>
/*
// 오늘 날짜 관련 각종 데이터를 저장한 
// JSON 객체를 리턴하는 함수 선언
function json_today(){
    var today = new Date();
    var weeks = ["일", "월", "화", "수", "목", "금", "토"];
    var week = weeks[today.getDay()];
    var json = {
        "year":today.getFullYear()
        , "month":today.getMonth()+1
        , "date":today.getDate()
        , "week":week
        , "ymd":today.getFullYear() + "-" + today.getMonth()+1 + "-" + today.getDate()
    }
    return json;
}
	// 귀속 3년치
	 $(function (){
		 var thisYear = json_today()["year"];
	        var year_obj = $("[name='year']");

	        maxYear = thisYear;
	        minYear = maxYear-2;

	        for(var i=maxYear; i>=minYear; i--){
	          year_obj.append("<option value='" + i + "'>" + i + "</option>");
	        }


	  });
	
	*/
	 </script>
</head>


<body class="side-first by-menu popup-menu-open">
  <div id="wrapper">
    <header id="header-bar" class="on-light">
      <div id="header-bar-main">
        <button class="menu-toggle float-l" onclick="$('body').addClass('mobile-menu-open')">
          <span class="icon"><i class="Licon ico-menu"></i></span>
        </button>
        <div class="logo-area">
            <img src="assets/images/Hierp_Logo1.png" class="on-light logo_margin">
        </div>
        <div class="utility-area">
          <div class="utility-group">
            <a class="utility">
              <span class="icon"><i class="Licon ico-my" onclick="$.Lithium.popupHandler.open({ full: false, warning: false })"></i></span>
            </a>
            <a class="utility logout">
              <span class="icon"><i class="Licon ico-logout"></i></span>
            </a>
          </div>
        </div>
        <div class="user-area responsive-except-desktop">
          <span class="user-info">${requestScope.infoList[0].NM_EMP} (${requestScope.infoList[0].NO_EMP})</span>
        </div>
      </div>
    </header>

    <aside id="side-bar" class="slim tab">
      <button class="side-bar-toggle tab-item" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU"  onclick="$.Lithium.sideSubMenuToggle().toggleSideBar();">
        <span class="icon"><i class="Licon ico-menu"></i></span>
        <span class="icon"><i class="Licon ico-close"></i></span>
      </button>
      <div class="menu-area">
        <div class="menu menu-vertical">
        </div>
      </div>
    </aside>

    <div id="side-bar-sub" class="">
      <div class="tab-contents" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU">
        <!-- search bar -->
        <div class="searchbar_con"><img src="assets/images/Biglogo.png"></div>
        <!-- menu -->
        <ul class="menu-accordion">
          <li>
            <!-- <a href="adNotice.do"><span class="label">공지사항</span></a> a 태그 해당 방식으로 추후 모두 변경해야함-->
            <a href="empNotice.do"><span class="label">공지사항</span></a>
          </li>
          <li class="tree-view">
            <a><span class="label">인사관리</span></a>
            <ul class="tree-view-menu">
              <li><a href="empUserInfo.do"><span class="label">개인정보조회</span></a></li>
            </ul>
          </li>
          <li class="tree-view">
            <a><span class="label">급여관리</span></a>
            <ul class="tree-view-menu">
              <li><a href="empSalary.do"><span class="label">급여명세서 조회</span></a></li>
              <!--<li><a><span class="label">Menu3-1</span></a></li>--> 
            </ul>
          </li>
        </ul>
      </div>    
    </div>

    <div id="contents-wrapper">
      <div class="content-header">
        <div class="content-title-bar">
          <h5>급여명세서 조회</h5>
          <!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
          <div class="tools responsive-except-desktop" >
            <div class="tools-group" style="cursor:none;">
              <button class="tool-item" disabled style="cursor:default;">
                <span class="icon"><i class="Licon ico-datareset"></i></span>
                <span class="label">조회</span>
              </button>
              <button class="tool-item" disabled style="cursor:default;">
                <span class="icon"><i class="Licon ico-save"></i></span>
                <span class="label">저장</span>
              </button>
              <button class="tool-item" disabled style="cursor:default;">
                <span class="icon"><i class="Licon ico-add"></i></span>
                <span class="label">추가</span>
              </button>
              <button class="tool-item" disabled style="cursor:default;">
                <span class="icon"><i class="Licon ico-minus"></i></span>
                <span class="label">삭제</span>
              </button>
            </div>
        </div>
      </div>




      <br><br><br><br>

    </div>
    
<!-- 메인


<table class="dtable1" border="0" style="margin-bottom:-15px;">
  <tr align="left">
    <td><label><b>귀 속 년 월 : year</b><em class="txt-error"></em></label></td>
  </tr>
</table> 
		
<br><br>	
-->   
<table class="dtable1" border="1">
    <tr class="dtr1">
			<td class="dtd1-1">회 사 명</td>
			<td class="dtd1-2">
			주식회사 하이이알피
			</td>
			<td class="dtd1-1">이 름</td>
			<td class="dtd1-2">
			${requestScope.empSalInfoList[0].NM_EMP }
			</td>
		</tr>
    <tr class="dtr1">
			<td class="dtd1-1">사 번</td>
			<td class="dtd1-2">
			${requestScope.empSalInfoList[0].NO_EMP }
			</td>
			<td class="dtd1-1">입 사 일 자</td>
			<td class="dtd1-2">
			${requestScope.empSalInfoList[0].ENTER_DATE}
			</td>
		</tr>
    <tr class="dtr1">
			<td class="dtd1-1">부 서</td>
			<td class="dtd1-2">
			${requestScope.empSalInfoList[0].NM_DEPT }
			</td>
			<td class="dtd1-1">직 급</td>
			<td class="dtd1-2">
			${requestScope.empSalInfoList[0].NM_JIK }
			</td>
		</tr>

</table>
<br>
<table class="dtable1" border="0" style="margin-bottom:-15px;">
  <tr align="left">
    <td><label><b>지 급 내 역</b><em class="txt-error">*</em></label></td>
  </tr>
</table>
<br><br>
<table class="dtable1" border="1">
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY01 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY01 }</td>
    
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY02 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY02 }</td>
  </tr>
   <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY03 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY03 }</td>
  </tr>
   <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY04 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY04 }</td>
  </tr>
   <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY05 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY05 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY06 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY06 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY07 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY07 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_PAY08 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_PAY08 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dth"><b>지 급 총 액</b></td>
    <td class="dtd2-2">
    	<b>${requestScope.empSalWithYM[0].AM_TOT_PAY }</b>
    </td>
  </tr>
</table>
<br>
<table class="dtable1" border="0" style="margin-bottom:-15px;">
  <tr align="left">
    <td><label><b>공 제 내 역</b><em class="txt-error">*</em></label></td>
  </tr>
</table>
<br><br>
<table class="dtable1" border="1">
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT01 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT01 }</td>
    
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT02 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT02 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT03 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT03 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT04 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT04 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT05 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT05 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT06 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT06 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT07 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT07 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dtd2-1">${requestScope.empSalAmountInfoList[0].NM_DEDUCT08 }</td>
    <td class="dtd2-2">${requestScope.empSalWithYM[0].AM_DEDUCT08 }</td>
  </tr>
  <tr class="dtr1">
    <td class="dth"><b>공 제 총 액</b></td>
    <td class="dtd2-2">
    	<b>${requestScope.empSalWithYM[0].AM_TOT_DEDUCT }</b>
    </td>
  </tr>
</table>
<br>
<table class="dtable1" border="1">
  <tr class="dtr1">
    <td class="dth"><b>차 인 지 급 액</b></td>
    <td class="dtd2-2">
    	<b>${requestScope.empSalWithYM[0].AM_TOT }</b>
    </td>
  </tr>
</table>

<br><br>
<br><br>
<br><br>





  </div>
  <div class="popup-wrapper">
    <div class="popup-dim" onclick="$.Lithium.popupHandler.close()"></div>
    <!-- option class / popup-warning, popup-full -->
    <div class="popup">
      <div class="popup-inner">
        <div class="popup-title">
          <div class="title-wrap">
            <h6 class="title">내정보</h6>              
          </div>
        </div>
        <div class="popup-contents" >
          <table border="0" cellpadding="5" align="center" width="300px" style="font-size:15px; font-weight: bold;">
            <tr align="center">
              <td><img src="./assets/images/test_img.png"></td>
            </tr>
            <tr align="center">
              <td>${requestScope.infoList[0].NM_EMP} ${requestScope.infoList[0].NM_JIK}</td>                                     
            </tr>
            <tr align="center">
              <td>(${requestScope.infoList[0].NM_DEPT})</td>                                     
            </tr>
            <tr align="center">
              <td>${requestScope.infoList[0].PHONE}</td>
            </tr>
            <tr align="center">
              <td>${requestScope.infoList[0].EMAIL}</td>
            </tr>
          </table>

          
        </div>

        <div class="popup-tools txt-right" style="margin-top:-20px;">
          
          <button class="btn btn-md btn-primary btn-container mg-l-2u" onclick="$.Lithium.popupHandler.close()">
            <span class="label" >닫기</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>