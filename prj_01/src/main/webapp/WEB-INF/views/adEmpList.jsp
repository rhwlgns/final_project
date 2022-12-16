<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Responsive Viewport & Fixed Scaling -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
<title>사원명부 및 수정/삭제</title>
<script type="text/javascript">
	$(function() {
		$("#searchBtn").bind("click", function() {
			search();
		});

	})

	function search() {
		var keyword = $("[name='keyword']").val();
		if (typeof (keyword) != "string") {
			keyword = "";
		}

		keyword = $.trim(keyword);
		$("[name='keyword']").val(keyword);

		document.searchForm.submit();

	}

	function adEmpListCorr(data) {
		$("[name='adEmpListProc']").find("[name='no_emp']").val(data);
		document.adEmpListProc.submit();
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
						<a class="utility"> <span class="icon"><i class="Licon ico-my "
								onclick="$.Lithium.popupHandler.open({ full: false, warning: false })"></i></span>
						</a> <a class="utility logout"> <span class="icon"><i class="Licon ico-logout"></i></span>
						</a>
					</div>
				</div>
				<div class="user-area responsive-except-desktop">
					<span class="user-info">${requestScope.infoList[0].NM_EMP} (${requestScope.infoList[0].NO_EMP})</span>
				</div>
			</div>
		</header>

		<aside id="side-bar" class="slim tab">
			<button class="side-bar-toggle tab-item" data-tab-contents="DEFAULT"
				data-tab-contents-group="SIDE_MENU" onclick="$.Lithium.sideSubMenuToggle().toggleSideBar();">
				<span class="icon"><i class="Licon ico-menu"></i></span> <span class="icon"><i
					class="Licon ico-close"></i></span>
			</button>
			<div class="menu-area">
				<div class="menu menu-vertical"></div>
			</div>
		</aside>

		<div id="side-bar-sub" class="">
			<div class="tab-contents" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU">
				<!-- search bar -->
				<div class="searchbar_con">
					<img src="assets/images/Biglogo.png">
				</div>
				<!-- menu -->
				<ul class="menu-accordion">
					<li>
						<!-- <a href="adNotice.do"><span class="label">공지사항</span></a> a 태그 해당 방식으로 추후 모두 변경해야함--> <a
						href="/adNotice.do"><span class="label">공지사항</span></a>
					</li>
					<li class="tree-view"><a><span class="label">인사관리</span></a>
						<ul class="tree-view-menu">
							<li><a href="/adEmpReg.do"> <span class="label">사원등록</span></a></li>
							<li><a href="/adUserInfoReg.do"><span class="label">사용자정보등록</span></a></li>
							<li><a href="/adEmpList.do"><span class="label">사원명부 및 수정/삭제</span></a></li>
						</ul></li>
					<li class="tree-view"><a><span class="label">급여관리</span></a>
						<ul class="tree-view-menu">
							<li><a href="adSal.do"><span class="label">급여입력</span></a></li>
							<!--<li><a><span class="label">Menu3-1</span></a></li>-->
						</ul></li>
				</ul>
			</div>
		</div>

		<div id="contents-wrapper">
			<div class="content-header">
				<div class="content-title-bar">
					<h5>사원명부 및 수정/삭제</h5>
					<!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
					<div class="tools responsive-except-desktop">
						<div class="tools-group" style="cursor: none;">
							<a href="/adEmpList.do"><button class="tool-item"  style="cursor: pointer;">
								<span class="icon"><i class="Licon ico-datareset"></i></span> <span class="label">조회</span>
							</button></a>							
						</div>
					</div>
				</div>




				<br> <br> <br> <br>

				<!-- 사원명부 위쪽 탭 (검색 및 select box) -->

				<div class="split detailserch content" style="max-height: 15%;">
					<div class="selectbox">
						<form name="searchForm" method="post" action="/adEmpList.do">
							<!-- 사업장 셀렉트박스 -->

							<label>사업장 &nbsp;</label>
							<label>하이이알피 &nbsp;</label>

							<!-- 부서 셀렉트박스 -->
							<label class="select1">부서 &nbsp;</label> <select name="part">
								<option value="">전체</option>
								<c:forEach var="jikupList" items="${requestScope.partList}" varStatus="status">
										<option value="${jikupList.NM_DEPT}">${jikupList.NM_DEPT}</option>
								</c:forEach>
							</select>

							<!-- 재직구분 셀렉트박스 -->
							<label class="select1">재직구분 &nbsp;</label> <select name="proof">
								<option value="">전체</option>
								<c:forEach var="proofList" items="${requestScope.proofList}" varStatus="status">
										<option value="${proofList.NM_CD_EMP}">${proofList.NM_CD_EMP}</option>
								</c:forEach>
							</select>

							<!-- 직급 셀렉트박스 -->
							<label class="select1">직급 &nbsp;</label> <select name="position">
								<option value="">전체</option>
								<c:forEach var="jikupList" items="${requestScope.jikupList}" varStatus="status">
										<option value="${jikupList.NM_JIK}">${jikupList.NM_JIK}</option>
								</c:forEach>
							</select>

							<!-- 검색창 -->
							<div class="mg-b-2u serch-loc">
								<div class="input-container input-container-sm search-bar" id="c_size_default">
									<div class="input-group">
										<input type="search" placeholder="Menu Search..." class="input-box" name="keyword">
										<div class="search-history-panel">
											<div class="search-history-panel-dim"
												onclick="$.Lithium.search().closeSearchHistoryPanel()"></div>
										</div>
										<div class="input-group-tools">
											<button type="button" class="clear">
												<i class="material-icons">cancel</i>
											</button>
											<button class="search" id="searchBtn">
												<i class="Licon size-24 ico-search"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="select-dim"></div>
					<br>
				</div>
				<br>

				<!-- 사원명부 테이블 -->
				<div class="split content"
					style="max-width: 80%; margin-left: auto; margin-right: auto; max-height: 60%;">
					<div class="data-table-wrapper">
						<div class="data-table-container"
							style="min-width: 100%; max-width: 100%; margin-left: auto; margin-right: auto;">
							<br>

							<table class="data-table data-table-sm" id="empListTable">
								<colgroup></colgroup>
								<thead>
									<tr>

										<th></th>
										<th>사원명</th>
										<th>사원번호</th>
										<th>입사일</th>
										<th>퇴사일</th>
										<th>재직구분</th>
										<th>부서</th>
										<th>직급</th>
										<th>이메일</th>
										<th>연락처</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="empList" items="${requestScope.empList}" varStatus="status">
										<tr style="cursor: pointer;" onclick="adEmpListCorr('${empList.no_emp}')">
											<th>${status.count}</th>
											<td>${empList.nm_emp}</td>
											<td>${empList.no_emp}</td>
											<td>${empList.enter_date}</td>
											<td>${empList.retire_date}</td>
											<td>${empList.nm_cd_emp}</td>
											<td>${empList.nm_dept}</td>
											<td>${empList.nm_jik}</td>
											<td>${empList.email}</td>
											<td>${empList.phone}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<br>
						</div>
					</div>
				</div>
				<br> <br> <br> <br> <br> <br>

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
							<div class="popup-contents">
								<table border="0" cellpadding="5" align="center" width="300px"
									style="font-size: 15px; font-weight: bold;">
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

							<div class="popup-tools txt-right" style="margin-top: -20px;">

								<button class="btn btn-md btn-primary btn-container mg-l-2u"
									onclick="$.Lithium.popupHandler.close()">
									<span class="label">닫기</span>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
	<form name="adEmpListProc" method="post" action="/adEmpListCorr.do">
		<input type="hidden" name="no_emp">
	</form>
</body>
</html>
