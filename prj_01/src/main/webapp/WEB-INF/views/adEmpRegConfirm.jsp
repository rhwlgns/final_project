<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*"%>

<%@ include file="common.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Responsive Viewport & Fixed Scaling -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
<title>사원등록완료</title>
<script>
	
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
						<a class="utility"> <span class="icon"><i class="Licon ico-my"
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
						href="adNotice.do"><span class="label">공지사항</span></a>
					</li>
					<li class="tree-view"><a><span class="label">인사관리</span></a>
						<ul class="tree-view-menu">
							<li><a href="adEmpReg.do"><span class="label">사원등록</span></a></li>
							<li><a href="adUserInfoReg.do"><span class="label">사용자정보등록</span></a></li>
							<li><a href="adEmpList.do"><span class="label">사원명부 및 수정/삭제</span></a></li>
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
					<h5>사원등록완료</h5>
					<!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->					
				</div>


			</div>



			<!-- 메인 -->
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>


			<div class="content-body reg-top">
				<div class="container">

					<section class="mg-t-20u">

						<div class="box signup">

							<div class="empty-states-wrapper mg-v-20u">
								<div class="empty-states">
									<div class="icon-area">
										<!--                  <i class="Licon ico-new"></i>-->
										<img src="assets/images/seah-membership-card.svg">
									</div>
									<div class="message-area">
										<h6>사원등록 완료</h6>
									</div>
									<div class="btn-area">
										<a href="adNotice.do"><button class="btn btn-md btn-primary btn-container wth-140">
												<span class="label">메인으로</span>
											</button></a>
									</div>
								</div>
							</div>
						</div>
					</section>

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
</body>
</html>
