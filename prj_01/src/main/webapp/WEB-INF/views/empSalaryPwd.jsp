<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp" %>



<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Responsive Viewport & Fixed Scaling -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <title>급여명세서 조회</title>
			
    
    
<script>
	$(function(){
		$(".checkPwdBtn").bind("click", function(){
			checkPwd();
		})
	});
	
	function checkPwd(){
		var checkPwdFormObj = $("[name=checkPwdForm]");
		
		var no_emp = checkPwdFormObj.find(".no_emp").val();
		var no_res = checkPwdFormObj.find(".no_res").val();
		
		var year = checkPwdFormObj.find(".year").val();
		var month = checkPwdFormObj.find(".month").val();
		
		var ym = year + month ;
		
		//alert(ym);
		
		//alert(year + "," + month);
		//return;
		
		// alert(no_res);
		// 주민등록번호 유효성 체크
		var regExp = new RegExp(/^[0-9]{7}$/);
		
		if(year==""||month==""){
			alert("귀속년월을 선택하세요.")
			return;
		}
		
		if(regExp.test(no_res)==false){
			alert("주민등록번호 뒷자리가 일치하지 않습니다.")
			checkPwdFormObj.find(".no_emp").val("");
			checkPwdFormObj.find(".no_res").val("");
			checkPwdFormObj.find(".no_emp").focus();
			return;
		}
	
		  $.ajax({
		      
		      url : "/empSalPwdProc.do"
		      , type : "post"
		      , data : $("[name='checkPwdForm']").serialize()

		      , success : function(Cnt){
		       // alert(salPwdCnt);
		        if(Cnt==1){ document.empSalary.submit();} 
		        else if(Cnt==2){alert("해당 귀속년월에 데이터가 없습니다.")}
		        else if(Cnt==0){
		          //alert(no_emp);
		          alert("사원번호 또는 주민등록번호 뒷자리를 다시 확인해주세요.");
		          checkPwdFormObj.find(".no_emp").val("");
		          checkPwdFormObj.find(".no_res").val(""); }
		      }

		      // 웹 서버와 통신이 실패할 경우 
		      // 실행할 익명함수 설정
		      , error : function(){
		          alert("웹 서버 접속 실패");}
		    });

		
	}
	
		
	
		
		
		
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
			



function enterkey(){
	if(window.event.keyCode == 13){
		checkPwd();
	}
}
	
		
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




        <br><br><br><br><br><br><br><br>

      </div>
      
  <!-- 메인 -->

  <div style="background-color:white; height:250px; width: 300px; text-align: left; margin-left: auto; margin-right: auto;">

  <br>
  
  
  
  <!-- form  -->
  <form action="/empSal.do" name="empSalary" method="post"></form>

  
  
  <form action="/empSalPwdProc.do" method="post" name="checkPwdForm" class="checkPwdForm">
  <div style="text-align:center;">
  
   <label >귀속년월을 선택하세요.<em class="txt-error lable-margin" ></em></label>
   	<div class="input-container input-container-md mg-t-4u" style="margin-left:10px; margin-right:10px;">
    	<div class="input-group">
    	<label>귀 속 <em class="txt-error"></em></label>
    		<select name="year" id="year" class="year">
    			<option value=""></option>
    		</select>년
    	<label><em class="txt-error"></em></label>
    		<select name="month" id="month" class="month">
    			<option value=""></option>
 				<option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
                <option value="04">04</option>
                <option value="05">05</option>
                <option value="06">06</option>
                <option value="07">07</option>
                <option value="08">08</option>
                <option value="09">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
    		</select>월  			
    	</div>
    </div>
    <input type = "hidden" class="ym" name="ym">
    
  <div class="input-container input-container-md mg-t-4u" style="margin-left:10px; margin-right:10px;">
    <div class="input-group">
  <input type="hidden" name="no_emp" class="no_emp input-box" value="${requestScope.infoList[0].NO_EMP}" onkeyup="enterkey()">
   <div class="input-group-tools">
        <button class="option error"><i class="Licon size-24 ico-warning"></i></button>
        <button class="option success"><i class="Licon size-24 ico-check"></i></button>
        <!-- <button class="clear"><i class="material-icons">cancel</i></button>  -->
      </div>
  </div>
  </div>
   
  <br>
  <label >주민등록번호 뒷자리 7자리를 입력해주세요.<em class="txt-error lable-margin" ></em></label>
  </div>
  <div class="input-container input-container-md mg-t-4u" style="margin-left:10px; margin-right:10px;">
    <div class="input-group">
      <input type="password" name="no_res" class="no_res input-box" onkeyup="enterkey()">
      <div class="input-group-tools">
        <button type="button" class="option view-password"><i class="material-icons">visibility</i></button>
        <button class="option error"><i class="Licon size-24 ico-warning"></i></button>
        <button class="option success"><i class="Licon size-24 ico-check"></i></button>
        <button type="button" class="clear"><i class="material-icons">cancel</i></button>
      </div>
    </div>
    <p class="status-message">에러메세지는 이곳에 쓰여집니다.</p>
  </div>
  
  
  
  
  
  <div class="txt-right" style="margin-top:10px; margin-right: 15px; text-align:center; margin-left:auto; margin-right:auto;">
  	<!--<input type="button" class="checkPwdBtn btn btn-md btn-primary btn-container label" placeholder="확인">-->
  	 
  	
    <button type="button" class="checkPwdBtn btn btn-md btn-primary btn-container">
      <span class="label">확인</span>
    </button>
     
    
    </form>
    
    
    
  </div>
  </div>
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
