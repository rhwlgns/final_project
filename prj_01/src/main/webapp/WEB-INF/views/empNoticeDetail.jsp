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
    <title>공지사항 상세보기</title>
     <script>
    
		$(function(){
			
			

			// 삭제버튼
			$(".boardDelBtn").bind("click",function(){
				
				commentDelBtn2();
				
				boardDelFormCheck();
				
			});

			// 댓글등록버튼
			$(".boardComBtn").bind("click",function(){
				
				boardComFormCheck();
				
			});
			
			
		});
		
		function boardComFormCheck(){
			
			var formObj = $("[name='boardComForm']");
			
			var content_com = formObj.find(".content_com").val();
	
			if(content_com.length==0){
				alert("내용을 입력해주세요.");
				return;
			}

			if(content_com.toUpperCase().indexOf(("<script>").toUpperCase())>=0){

				alert("댓글에 <script>는 사용할 수 없습니다.");
				formObj.find(".content_com").val("");
				return;
			}
			
			if(confirm("댓글을 등록하시겠습니까?")==false){
				return;
			}
			
			$.ajax({

				url : "/boardComProc.do"
				
				, type : "post"
				
				, data : $("[name='boardComForm']").serialize()

				, success : function(comCnt){

					// 댓글 입력 성공 시
					if(comCnt==1){
						alert("댓글이 등록되었습니다.");
						
					}
					else{
						alert("댓글 등록에 실패했습니다.");
					}
				}
				
				, error : function(){
					alert("웹 서버 접속 실패");
				}
			});
			
		}
		
		
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 게시판 수정/삭제 화면으로 이동하는 함수 선언
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		function goBoardUpDelForm(){

			document.boardUpDelForm.submit();
		}

		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 게시판 글 삭제 관련 함수 설정
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		function boardDelFormCheck(){
			
			var formObj = $("[name='boardUpDelForm']") 
			
			if(confirm("삭제하시겠습니까?")==false){
				return;
			}

			// -----------------------
			// 비동기 방식으로 웹 서버에 접근하여
			// 게시판 [삭제] 관련 입력양식의 데이터 전송
			// -----------------------
			$.ajax({

				url : "/boardDelProc.do"

				, type : "post"

				, data : $("[name='boardUpDelForm']").serialize()

				// 웹 서버와 통신 후 
				// 웹 서버의 응답을 성공적으로 받을 경우 
				// 실행할 익명함수 설정
				// 익명함수의 매개변수에는 웹 서버에서 받은
				// [삭제 적용행의 개수]가 들어온다.
				, success : function(boardDelCnt){

					if(boardDelCnt==1){
						alert("게시글이 삭제되었습니다.");
						document.boardListForm.submit();
					}
					
					else if(boardDelCnt==0){
						alert("이미 삭제된 게시글입니다.");
						document.boardListForm.submit();
						
					}
				}
				
				, error : function(){
					alert("웹 서버 접속에 실패했습니다.");
				}
			});
		}
		
		function goBoardDetailForm(b_no){
			document.boardDetailForm.submit();
		}
		
		
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 게시판 글 삭제시 b_no 가 같은 모든 댓글이 삭제되는 함수
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		
		function commentDelBtn2(){
			
			var formObj = $("[name='boardUpDelForm']") 
	
			// -----------------------
			// 비동기 방식으로 웹 서버에 접근하여
			// 게시판 [삭제] 관련 입력양식의 데이터 전송
			// -----------------------
			$.ajax({

				url : "/commentDelProc2.do"

				, type : "post"

				, data : $("[name='boardUpDelForm']").serialize()

				// 웹 서버와 통신 후 
				// 웹 서버의 응답을 성공적으로 받을 경우 
				// 실행할 익명함수 설정
				// 익명함수의 매개변수에는 웹 서버에서 받은
				// [삭제 적용행의 개수]가 들어온다.
				, success : function(commentDelCnt2){
					
					if(commentDelCnt2==1){

					}
				}
				
				, error : function(){
					alert("웹 서버 접속에 실패했습니다.");
				}
			});
		}


		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 댓글 삭제 버튼 관련 함수
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		function commentDelBtn(b_no, print_level){
			
			var formObj = $("[name='boardPrintComForm']") 
			
			var inputData = {
				b_no : b_no
				,print_level : print_level
			};
			
			if(confirm("삭제하시겠습니까?")==false){
				return;
			}

			// -----------------------
			// 비동기 방식으로 웹 서버에 접근하여
			// 게시판 [삭제] 관련 입력양식의 데이터 전송
			// -----------------------
			$.ajax({

				url : "/commentDelProc.do"

				, type : "post"

				, data : inputData
				
				, dataType : "json"
				
				// 웹 서버와 통신 후 
				// 웹 서버의 응답을 성공적으로 받을 경우 
				// 실행할 익명함수 설정
				// 익명함수의 매개변수에는 웹 서버에서 받은
				// [삭제 적용행의 개수]가 들어온다.
				, success : function(commentDelCnt){
					
					if(commentDelCnt==1){
						alert("댓글이 삭제되었습니다.");
						location.reload();
					}
					
					else if(commentDelCnt==0){
						alert("이미 삭제된 댓글입니다.");
					}
				}
				, error : function(){
					alert("웹 서버 접속에 실패했습니다.");
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

	<!-- 사이드 바 메뉴 -->

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
              <li><a href="empSalary.do"><span class="label">급여명세서조회</span></a></li>
              <!--<li><a><span class="label">Menu3-1</span></a></li>--> 
            </ul>
          </li>
        </ul>
      </div>
    </div>

<!-- 위쪽 버튼 -->

    <div id="contents-wrapper">
      <div class="content-header">
        <div class="content-title-bar">
          <h5>공지사항 상세보기</h5>
          <!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
          <div class="tools responsive-except-desktop" >
            <div class="tools-group" style="cursor:none;">
              <button class="tool-item">
                <a href="empNotice.do">
                <span class="icon"><i class="Licon ico-datareset"></i></span>
                <span class="label">목록</span></a>
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
      </div>

      <br><br>


     <!-- 공지사항 테이블 -->
		
		<form name="boardDetailForm" class="boardDetailForm" action="">
		 <table align="center" width="80%" border="1" cellspacing="0" cellpadding="10" style="border-color:lightgray;" >
		   <tr align="left">
		     <td width="3%" align="center">제목</td>
		     <td width="30%" bgcolor="white">${requestScope.boardDTO.subject}</td>
		     <td width="3%" align="center">작성일</td>
		     <td width="10%" bgcolor="white">${requestScope.boardDTO.reg_date}</td>
		     <td width="3%" align="center">조회수</td>
		     <td width="10%" bgcolor="white">${requestScope.boardDTO.readcount}</td>
		   </tr>
		   <tr>
		     <td colspan="8" height="400px" bgcolor="white">${requestScope.boardDTO.content}</td>
		   </tr>
		 </table>
		 <!-- (${requestScope.infoList[0].NO_EMP}) -->
		</form>
		
		<!-- 웹 서버에 action="/boardUpDelForm.do" URL 주소로 접속하기 위한 from 태그 선언 -->
		<form action="/adNoticeUpdate.do" name="boardUpDelForm" method="post">
			<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
		</form>
		    
	 	<br>



    <!-- 공지사항 댓글 테이블 -->
      	
		<form name="boardPrintComForm" class="boardPrintComForm">
		<table width="80%" align="center" border="1" cellspacing="0" cellpadding="10" style="border-color:lightgray">
		    
			<c:forEach var="comment" items="${requestScope.comment}" varStatus="loopTagStatus">
			<tr>
				<td width="7%" align="center">${comment.nm_emp}</td>
			    <td width="50%" bgcolor="white">${comment.content}</td>
			    <td width="10%" bgcolor="white" align="center">${comment.reg_date}</td>
		        
         	</c:forEach>
         	</tr>
		</table>
		
		</form>
		<br>


       <!-- 공지사항 댓글입력폼 -->
        
        <form name="boardComForm" class="boardComForm">
	        <table align="center" style="width:80%;">
	          	<tr>	          		
	            	<td align="center">
		            	<div class="textarea" style="width:100%;">
		                	<textarea name="content_com" class="content_com" placeholder="댓글을 입력하세요." rows="5" maxlength="200"></textarea>
		              	</div>
		            </td>
		            <td align="right" style="width:10%;">
		              	<button class="boardComBtn btn btn-primary btn-xl btn-container btn-floating">
		                	<span class="label">등록</span>
		              	</button>
	            	</td>
	          	</tr>
	        </table>
			<input type="hidden" name="no_emp" value="${requestScope.infoList[0].NO_EMP}">
			<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
        </form>
        <form name="boardListForm" class="boardListForm" action="/empNotice.do"></form>
        
        <br><br>
        <br><br>
        <br><br>
    </div>
  </div>



  <!-- 내정보 팝업 -->
  
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