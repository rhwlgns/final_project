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
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Responsive Viewport & Fixed Scaling -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <title>공지사항 등록</title>
    
    <script>
		$(function(){
			
			$(".boardRegBtn").bind("click",function(){
				
				boardRegFormCheck();
				
			});
			
		})

		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 유효성 체크,비동기 방식으로 웹서버에 접속하는 boardRegFormCheck 함수 선언
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		function boardRegFormCheck(){
			
			//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
			// subject 유효성 체크
			//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
			
			var formObj = $("[name='boardRegForm']");

			var subject = formObj.find(".subject").val();

			// subject 변수 안의 데이터 타입이 string이 아닐 경우 "" 저장
			if(typeof(subject)!="string"){
				subject = "";
			}

			subject = $.trim(subject);

			formObj.find(".subject").val(subject);

			// subject가 1~15자가 아닐경우 경고 후 함수 중단
			if(subject.length>15){
				// alert("제목은 1~15자로 작성해주세요.");
				if(confirm("제목은 1~15자로 작성해주세요. \n15자 까지만 제목으로 입력하시겠습니까?")){
					formObj.find(".subject").val(subject.substring(0,15));
				}else{
					formObj.find(".subject").val("");
				}
				return;
			}else if(subject.length==0){
				alert("제목은 1~15자로 작성해주세요.");
				return;
			}

			// subject에 <script>가 포함될 경우 경고 후 함수 중단
			if(subject.toUpperCase().indexOf(("<script>").toUpperCase())>=0){
				alert("<script>는 사용할 수 없습니다.");
				formObj.find(".subject").val("");
				
				return;
			}
			

			//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
			// content 유효성 체크
			//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
			var content = formObj.find(".content").val();

			// content가 500자 이내가 아닐경우 경고 후 함수 중단
			if(content.length>500){
				// alert("내용은 500자 이내로 작성해주세요.");
				if(confirm("내용은 500자 이내로 작성해주세요. \n500자 까지만 내용으로 입력하시겠습니까?")){
					formObj.find(".content").val(content.substring(0,500));
				}else{
					formObj.find(".content").val("");
				}
				return;
			}
			
			else if(content.length==0){
				alert("내용은 500자 이내로 작성해주세요.");
				return;
			}

			// content에 <script>가 포함될 경우 경고 후 함수 중단
			if(content.toUpperCase().indexOf(("<script>").toUpperCase())>=0){
			// if(content.toLowerCase().indexOf("<script>")>=0 || content.toLowerCase().indexOf("<\/script>")>=0){

				alert("<script>는 사용할 수 없습니다.");
				formObj.find(".content").val("");

				// 내용 전체를 지우지 않고 <script>, <\/script> 부분만 지우고 싶을 경우
				// 주석 처리된 if문으로 변경 후 아래 주석 부분 주석 해제
				// var recontent = formObj.find(".content").val();
				// recontent = recontent.toLowerCase().replace("<script>", "").replace("<\/script>", "");
				// formObj.find(".content").val(recontent);

				return;
			}


			// -----------------------
			// 작성 여부 확인
			// -----------------------
			if(confirm("게시글을 등록하시겠습니까?")==false){
				return;
			}
			
			// -----------------------
			// 비동기 방식으로 웹 서버에 접근하여
			// 게시판 [새 글 쓰기] 관련 입력양식의 데이터 전송
			// -----------------------
			$.ajax({

				url : "/boardRegProc.do"
				
				, type : "post"
				
				, data : $("[name='boardRegForm']").serialize()

				, success : function(regCnt){

					// 게시판 글 입력 성공 시
					if(regCnt==1){
						alert("게시글이 등록되었습니다.");
						location.replace("/adNotice.do");
					}
					else{
						alert("게시글 등록에 실패했습니다.");
					}
				}
				
				, error : function(){
					alert("웹 서버 접속 실패");
				}
			});
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
        <span class="icon"><i class="Licon ico-menu" ></i></span>
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
            <a href="adNotice.do"><span class="label">공지사항</span></a>
          </li>
          <li class="tree-view">
            <a><span class="label">인사관리</span></a>
            <ul class="tree-view-menu">
              <li><a href="adEmpReg.do"><span class="label">사원등록</span></a></li>
              <li><a href="adUserInfoReg.do"><span class="label">사용자정보등록</span></a></li>
              <li><a href="adEmpList.do"><span class="label">사원명부 및 수정/삭제</span></a></li>
            </ul>
          </li>
          <li class="tree-view">
            <a><span class="label">급여관리</span></a>
            <ul class="tree-view-menu">
              <li><a href="adSal.do"><span class="label">급여입력</span></a></li>
              <!--<li><a><span class="label">Menu3-1</span></a></li>--> 
            </ul>
          </li>
        </ul>
      </div>

      
    </div>

    <div id="contents-wrapper">
      <div class="content-header">
        <div class="content-title-bar">
          <h5>공지사항 등록</h5>
          <!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
          <div class="tools responsive-except-desktop" >
            <div class="tools-group" style="cursor:none;">
            
              <button class="boardListBtn tool-item" >
                <a href="adNotice.do">
                <span class="icon"><i class="Licon ico-datareset"></i></span>
                <span class="label">목록</span></a>
              </button>
              
              <button class="boardRegBtn tool-item" >
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
      </div>


      <br><br>


<!-- 메인 공지사항 등록 form -->
<form name="boardRegForm" class="boardRegForm">
  
  <section class="mg-b-6u">
    <div class="textarea">
      <label>제목</label>
      <textarea name="subject" class="subject" placeholder="제목을 입력해주세요." rows="1" maxlength="50"></textarea>
    </div>
  </section>
  
  <section class="mg-b-6u">
    <div class="textarea">
      <label>내용</label>
      <textarea name="content" class="content" placeholder="내용을 입력해주세요." rows="40" maxlength="3000"></textarea>
      <div class="message-box">
        <div class="tools">
          <span class="count"></span>
        </div>
      </div>
    </div>
  </section>
  
</form>

<br><br>
<br><br>


  
  <!-- 내정보 팝업-->
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
