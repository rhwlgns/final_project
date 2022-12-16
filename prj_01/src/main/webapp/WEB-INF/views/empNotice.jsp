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
    <title>공지사항</title>
     <script>
	//******************************************************** 
	// body 태그 안의 모든 내용을 읽어들인 이후 호출할 자스 코딩 설정하기
	//******************************************************** 
		
		function goEmpNoticeDetail(
				b_no	//클릭한 행의 게시판 번호가 들어오는 매개변수
		){
		
			document.empNoticeDetail.action = "/empNoticeDetail.do";
			document.empNoticeDetail.method = "post";
			
			$("[name=empNoticeDetail]").find(".selectPageNo").val(
					$("[name=boardSearchForm]").find(".selectPageNo").val()
			);
			$("[name=empNoticeDetail]").find(".rowCntPerPage").val(
					$("[name=boardSearchForm]").find(".rowCntPerPage").val()
			);
			//-------------------------------------------------
			// name=boardDetailForm 를 가진 form 태그 내부에 
			// name=b_no 가진 태그에 매개변수로 들어온 게시판 번호를 삽입해라
			//-------------------------------------------------
			$("[name=empNoticeDetail]").find("[name=b_no]").val(b_no);
			document.empNoticeDetail.submit();
		}
		
		function boardSearch( ){
			
			
			document.boardSearchForm.submit();
		}
		//**********************************************
		// [페이지 번호]를 클릭하면 호출되는 함수 선언
		//**********************************************
		function pageNoBtn( pageNo ){
			
			//------------------------------------
			// class=selectPageNo 를 가진 입력양식에 
			// 클릭한(=선택한) 페이지 번호를 value 값으로 삽입하기
			// 왜? 서버에로 보낼려고!
			//------------------------------------
			$(".selectPageNo").val(pageNo);
			//------------------------------------
			// boardSearch 함수 호출하기
			//------------------------------------
			boardSearch();
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
          <div class="menu menu-vertical"></div>
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
              </ul>
            </li>
          </ul>
        </div>
      </div>
  
      <div id="contents-wrapper">
        <div class="content-header">
          <div class="content-title-bar">
            <h5>공지사항</h5>
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
                  <span class="label">추가</span></a>
                </button>
                <button class="tool-item" disabled style="cursor:default;">
                  <span class="icon"><i class="Licon ico-minus"></i></span>
                  <span class="label">삭제</span>
                </button>
              </div>
            </div>
          </div>
        </div>
  
  
  
  
        <br><br><br><br><br><br><br><br>
  
  
  
  
  
       <!-- 공지사항 테이블 -->
  
      <table class="table table-md table-top">
        <thead align="center">
        <tr align="center">
          <th width=6%>번호</th>
          <th width=25%>제목</th>
          <th width=10%>작성일</th>
          <th width=8%>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="board" items="${requestScope.boardList}" varStatus="loopTagStatus">
        <tr style="cursor:pointer;" onClick="goEmpNoticeDetail(${board.b_no})">
          <th>
            <span class="label">${requestScope.pagingMap.serialNo_desc - loopTagStatus.index}</span>
          </th>
          <td>${board.subject}</td>
          <td>${board.reg_date}</td>
          <td>${board.readcount}</td>
         </c:forEach>
        </tr>
        
        </tbody>
      </table>
      
      <form name="empNoticeDetail" method="post" action="/empNoticeDetail.do">  
        <input type="hidden" name="b_no">	
      </form>
      
      <form name="boardSearchForm" method="post" action="">
      	<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> 
      	<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">
      	<input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10">
      </form>
      
      <!-- 페이징처리 -->
      <center>
      <c:if test="${requestScope.boardTotCnt>0}">
									
		<!----------------------------------------------------------->
		<!-- [처음] 문자 출력--->
		<!----------------------------------------------------------->
		<span style="cursor:pointer" onclick="pageNoBtn(1);">[처음]</span>
		<!----------------------------------------------------------->
		<!-- [이전] 문자 출력--->
		<!----------------------------------------------------------->
		<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}-1);">[이전]</span>
		
	<!----------------------------------------------------------->
	<!-- 선택한 페이지 번호에 대응하는 페이지 번호들을 출력--->
	<!----------------------------------------------------------->
	<c:forEach  var="no"  begin="${requestScope.pagingMap.begin_pageNo_perPage}"  
						  end="${requestScope.pagingMap.end_pageNo_perPage}" step="1"> 
		<!----------------------------------------------------------->
		<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호 다르면--->
		<!----------------------------------------------------------->
		<c:if test="${requestScope.pagingMap.selectPageNo!=no}">
			<span style="cursor:pointer" onclick="pageNoBtn(${no});">[${no}]</span>&nbsp;
		</c:if>
		<!----------------------------------------------------------->
		<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호 같으면--->
		<!----------------------------------------------------------->
		<c:if test="${requestScope.pagingMap.selectPageNo==no}">				     
			${no}&nbsp;
		</c:if>
	</c:forEach>
		
		<!----------------------------------------------------------->
		<!-- [다음] 문자 출력--->
		<!----------------------------------------------------------->
		<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}+1);">[다음]</span>
		<!----------------------------------------------------------->
		<!-- [마지막] 문자 출력--->
		<!----------------------------------------------------------->
		<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
		
</c:if>  
</center><br><br><br><br>
    </div>
  </div>
  
  
  <!--  내정보 팝업 -->
  
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