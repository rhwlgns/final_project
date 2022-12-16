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
<title>사원정보수정</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function() {
		
		$(".empUpBtn").click(function() {
			checkRegForm();
		});

		$(".delBtn").click(function(){
			delCheck();
		});

	})

	//다음 주소검색 API 
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수
						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}
						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;
						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}
						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}

	//첨부파일 미리보기 버튼
	function ResizeImage() {
		var filesToUpload = document.getElementById('imageFile').files;
		var file = filesToUpload[0];
		// 문서내에 img 객체를 생성합니다
		var img = document.createElement("img");
		// 파일을 읽을 수 있는 File Reader 를 생성합니다
		var reader = new FileReader();
		// 파일이 읽혀지면 아래 함수가 실행됩니다
		reader.onload = function(e) {
			img.src = e.target.result;
			// HTML5 canvas 객체를 생성합니다
			var canvas = document.createElement("canvas");
			var ctx = canvas.getContext("2d");
			// 캔버스에 업로드된 이미지를 그려줍니다
			ctx.drawImage(img, 0, 0);
			// 최대폭을 400 으로 정했다고 가정했을때
			// 최대폭을 넘어가는 경우 canvas 크기를 변경해 줍니다.
			var MAX_WIDTH = 200;
			var MAX_HEIGHT = 280;
			var width = img.width;
			var height = img.height;
			if (width > height) {
				if (width > MAX_WIDTH) {
					height *= MAX_WIDTH / width;
					width = MAX_WIDTH;
				}
			} else {
				if (height > MAX_HEIGHT) {
					width *= MAX_HEIGHT / height;
					height = MAX_HEIGHT;
				}
			}
			canvas.width = width;
			canvas.height = height;
			// canvas에 변경된 크기의 이미지를 다시 그려줍니다.
			var ctx = canvas.getContext("2d");
			ctx.drawImage(img, 0, 0, width, height);
			// canvas 에 있는 이미지를 img 태그로 넣어줍니다
			var dataurl = canvas.toDataURL("image/png");
			document.getElementById('output').src = dataurl;
		}
		reader.readAsDataURL(file);
	}

	//유효성체크
	function checkRegForm() {
		var formObj = $(".adEmpUpDel");
		var emp_nameObj = $(".emp_name");
		var emp_partObj = $(".emp_part");
		var emp_jikupObj = $(".emp_jikup");
		var emp_phoneObj = $(".emp_phone");
		var emp_emailObj = $(".emp_email");
		var emp_locObj = $(".emp_loc");
		var emp_detaillocObj = $(".emp_detailloc");


		var emp_name = emp_nameObj.val();
		var emp_part = emp_partObj.val();
		var emp_jikup = emp_jikupObj.val();
		var emp_phone = emp_phoneObj.val();
		var emp_email = emp_emailObj.val();
		var emp_loc = emp_locObj.val();
		var emp_detailloc = emp_detaillocObj.val();




		//사원명 유효성체크
		if (new RegExp(/^[가-힣]{2,10}$/).test(emp_name) == false) {
			alert("사원명 한글 2-10자를 입력해주세요.")
			emp_nameObj.val("");
			emp_nameObj.focus();
			return false;
		}


		//부서명 유효성체크
		if (emp_partObj.val() == "") {
			alert("부서명을 입력해주세요.")
			return false;
		}

		//직급명 유효성체크
		if (emp_jikupObj.val() == "") {
			alert("직급명을 입력해주세요.")
			return false;
		}

		//휴대전화번호 유효성체크
		if (new RegExp(/^[0-9]{11}$/).test(emp_phone) == false) {
			alert("휴대전화번호 11자리를 입력해주세요.")
			emp_phoneObj.val("");
			emp_phoneObj.focus();
			return false;
		}

		//이메일 유효성체크
		if (new RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/)
				.test(emp_email) == false) {
			alert("올바른 이메일 형식을 입력해주세요.")
			emp_emailObj.val("");
			emp_emailObj.focus();
			return false;
		}

		//주소 유효성체크
		if (emp_locObj.val() == "") {
			alert("주소를 입력해주세요.")
			return false;
		}

		//상세주소 유효성체크
		if (emp_detaillocObj.val() == "") {
			alert("상세주소를 입력해주세요.")
			return false;
		}

		if(confirm("수정하시겠습니까?")==false){
			return;
		}

		
		$.ajax({
			url : "/adEmpListUp.do",
			type : "post",
			data : $("[name='adEmpUpDel']").serialize(),
			success : function(cnt) {
				if(cnt==1){
					alert("수정 완료");
					// 
					document.adEmpListForm.submit();
				}else{
					alert("수정할 사원 정보가 없습니다.")
				}
				
			},
			error : function() {
				alert("웹서버 접속 실패");
			}
		});
	}

	function delCheck(){
		var formObj = $("[name='adEmpUpDel']");
		if(confirm("정말로 삭제하시겠습니까?")==false){
			return;
		}

		$.ajax({
			url : "/adEmpListDel.do",
			type : "post",
			data : $("[name='adEmpUpDel']").serialize(),
			success : function(cnt) {
				if(cnt==1){
					alert("삭제 완료");
					// 
					document.adEmpListForm.submit();
				}else{
					alert("수정할 사원 정보가 없습니다.")
				}
				
			},
			error : function() {
				alert("웹서버 접속 실패");
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
			<div class="content-header" style="z-index: 1; cursor: default;">
				<div class="content-title-bar" style="z-index: 2; cursor: default;">
					<h5>사원정보수정</h5>
					<!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
					<div class="tools responsive-except-desktop" style="z-index: 3; cursor: default;">
						<div class="tools-group" style="z-index: 4; cursor: default;">
							<a class="tool-item delBtn">
								<button class="tool-item" style="cursor: pointer; position: inherit; z-index: 5 !important;">
									<span class="icon"><i class="Licon ico-minus"></i></span> <span class="label">삭제</span>
								</button>
							</a>
						</div>
					</div>
				</div>
			</div>



			<!-- 메인 -->
			<br> <br> <br> <br> <br> <br> <br> <br>


			<div class="content-body reg-top">
				<form name="adEmpUpDel" method="post">
					<div class="container">
						<section class="mg-t-20u">
							<p class="h7 mg-b-4u">
							<div class="box signup">
								<!-- <div class="input-container input-container-md mg-t-4u mar">
									<label>프로필사진<em class="txt-error">*</em></label> <input type="file" accept="image/*"
										id="imageFile">
								</div>
								<div>
									<img src="" id="output">
								</div>
								<div style="margin-top: 10px">
									<input type="button" value="미리보기" onclick="ResizeImage()" />
								</div> -->
								<div class="input-container input-container-md mg-t-4u">
									<label>사원번호<em class="txt-error">*</em></label>
									<div class="input-group">
										<input type="hidden" class="emp_no" name="emp_no" value="${requestScope.regDTO.emp_no}">
										<div class="input-box">${requestScope.regDTO.emp_no}</div>					
										<div class="input-group-tools">
											<button type="button" class="option error">
												<i class="Licon size-24 ico-warning"></i>
											</button>
											<button type="button" class="option success">
												<i class="Licon size-24 ico-check"></i>
											</button>
											<button type="button" class="clear">
												<i class="material-icons">cancel</i>
											</button>
										</div>
									</div>
									<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
								</div>

								<div class="input-container input-container-md mg-t-4u">
									<div class="input-container input-container-md">
										<label>사원명<em class="txt-error">*</em></label>
										<div class="input-group">
											<input type="text" placeholder="사원명을 입력해주세요." class="input-box emp_name" name="emp_name"
												value="${requestScope.regDTO.emp_name}">
											<div class="input-group-tools">
												<button type="button" class="option error">
													<i class="Licon size-24 ico-warning"></i>
												</button>
												<button type="button" class="option success">
													<i class="Licon size-24 ico-check"></i>
												</button>
												<button type="button" class="clear">
													<i class="material-icons">cancel</i>
												</button>
											</div>
										</div>
										<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
									</div>
								</div>

								<div class="input-container input-container-md mg-t-4u">
									<div class="input-container input-container-md">
										<label>생년월일</label>
										<div class="input-group">
											<input type="hidden" class="emp_birth" name="emp_birth" value="${requestScope.regDTO.emp_birth}">
											<div class="input-box">${requestScope.regDTO.emp_birth}</div>
											<div class="input-group-tools">
												<button type="button" class="option error">
													<i class="Licon size-24 ico-warning"></i>
												</button>
												<button type="button" class="option success">
													<i class="Licon size-24 ico-check"></i>
												</button>
												<button type="button" class="clear">
													<i class="material-icons">cancel</i>
												</button>
											</div>
										</div>
										<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
									</div>
								</div>

								<div class="input-container input-container-md mg-t-4u">
									<div class="input-container input-container-md">
										<label>주민등록번호</label>
										<div class="input-group">
											<input type="hidden" class="emp_jumin" name="emp_jumin" value="${requestScope.regDTO.emp_jumin}">
											<div class="input-box emp_jumin">${requestScope.regDTO.emp_jumin}</div>
											<div class="input-group-tools">
												<button type="button" class="option error">
													<i class="Licon size-24 ico-warning"></i>
												</button>
												<button type="button" class="option success">
													<i class="Licon size-24 ico-check"></i>
												</button>
												<button type="button" class="clear">
													<i class="material-icons">cancel</i>
												</button>
											</div>
										</div>
										<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
									</div>
								</div>

								<table style="width: 100%;">
									<tr>
										<td style="width: 50%;">


											<div class="input-container input-container-sm" id="c_size_single">
												<label>부서명<em class="txt-error">*</em></label>
												<div class="input-group dropdown dropdown-bottom">
													<input class="dummy emp_part" type="text" name="emp_part"
														value="${requestScope.regDTO.emp_part}">
													<button type="button" class="input-box">${requestScope.regDTO.emp_part}</button>
													<div class="dropdown-menu" style="transform: translate3d(0px, 34px, 0px);">
														<div class="dropdown-menu-body">
															<ul class="dropdown-menu-options">
																<c:forEach var="partList" items="${requestScope.partList}" varStatus="status">
																	<li><button type="button" class="dropdown-menu-item"
																			data-value="${partList.NM_DEPT}">${partList.NM_DEPT}</button></li>
																</c:forEach>
															</ul>
														</div>
													</div>
												</div>
												<p class="status-message">에러메세지는 이곳에 쓰여집니다.</p>
											</div>

										</td>
										<td style="width: 50%;">

											<div class="input-container input-container-sm" id="c_size_single">
												<label>직급명<em class="txt-error">*</em></label>
												<div class="input-group dropdown dropdown-bottom">
													<input class="dummy emp_jikup" type="text" name="emp_jikup"
														value="${requestScope.regDTO.emp_jikup}">
													<button type="button" class="input-box">${requestScope.regDTO.emp_jikup}</button>
													<div class="dropdown-menu" style="transform: translate3d(0px, 34px, 0px);">
														<div class="dropdown-menu-body">
															<ul class="dropdown-menu-options">
																<c:forEach var="jikupList" items="${requestScope.jikupList}" varStatus="status">
																	<li><button type="button" class="dropdown-menu-item"
																			data-value="${jikupList.NM_JIK}">${jikupList.NM_JIK}</button></li>
																</c:forEach>
															</ul>
														</div>
													</div>
												</div>
												<p class="status-message">에러메세지는 이곳에 쓰여집니다.</p>
											</div>

										</td>
									</tr>
								</table>

								<div class="input-container input-container-md mg-t-4u">
									<label>휴대전화번호<em class="txt-error">*</em></label>
									<div class="input-group">
										<input type="text" placeholder="'-'없이 입력해 주세요." class="input-box emp_phone"
											name="emp_phone" value="${requestScope.regDTO.emp_phone}">
										<div class="input-group-tools">
											<button class="option error">
												<i class="Licon size-24 ico-warning"></i>
											</button>
											<button class="option success">
												<i class="Licon size-24 ico-check"></i>
											</button>
											<button class="clear">
												<i class="material-icons">cancel</i>
											</button>
										</div>
									</div>
									<p class="status-message">에러메세지는 이곳에 쓰여집니다.</p>
								</div>

								<div class="input-container input-container-md mg-t-4u">
									<label>이메일<em class="txt-error">*</em></label>
									<div class="input-group">
										<input type="text" placeholder="이메일을 입력해주세요." class="input-box emp_email" name="emp_email"
											value="${requestScope.regDTO.emp_email}">
										<div class="input-group-tools">
											<button class="option error">
												<i class="Licon size-24 ico-warning"></i>
											</button>
											<button class="option success">
												<i class="Licon size-24 ico-check"></i>
											</button>
											<button class="clear">
												<i class="material-icons">cancel</i>
											</button>
										</div>
									</div>
									<p class="status-message">에러메세지는 이곳에 쓰여집니다.</p>
								</div>

								<div class="col-container mg-t-4u">
									<div class="col-xs-12 col-md-7">
										<div class="fix-width-column right bottom w-140 mg-t-4u">
											<div class="input-container input-container-md">
												<label>주소<em class="txt-error">*</em></label>
												<div class="input-group">
													<input type="text" placeholder="주소검색을 눌러주세요." class="input-box emp_loc"
														id="sample6_address" placeholder="주소" name="emp_loc"
														value="${requestScope.regDTO.emp_loc}">
													<div class="input-group-tools">
														<button type="button" class="option error">
															<i class="Licon size-24 ico-warning"></i>
														</button>
														<button type="button" class="option success">
															<i class="Licon size-24 ico-check"></i>
														</button>
														<button type="button" class="clear">
															<i class="material-icons">cancel</i>
														</button>
													</div>
												</div>
												<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
											</div>

											<div class="pd-l-2u">
												<input type="text" id="sample6_postcode" placeholder="우편번호"> <input
													type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br> <input
													type="text" id="sample6_extraAddress" placeholder="참고항목">
												<button type="button" class="btn btn-md btn-secondary btn-container btn-full"
													onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
													<span class="label">주소검색</span>
												</button>
											</div>
										</div>
									</div>
								</div>


								<div class="input-container input-container-md mg-t-2u">
									<div class="input-group">

										<input type="text" class="input-box emp_detailloc" id="sample6_detailAddress"
											placeholder="상세주소" name="emp_detailloc" value="${requestScope.regDTO.emp_detailloc}">
										<div class="input-group-tools">
											<button type="button" class="option error">
												<i class="Licon size-24 ico-warning"></i>
											</button>
											<button type="button" class="option success">
												<i class="Licon size-24 ico-check"></i>
											</button>
											<button type="button" class="clear">
												<i class="material-icons">cancel</i>
											</button>
										</div>
									</div>
									<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
								</div>


								<div class="input-container input-container-md mg-t-4u">
									<label>입사일자</label>
									<div class="input-group">
										<input type="hidden" class="emp_hire" name="emp_hire" value="${requestScope.regDTO.emp_hire}">
										<div class="input-box">${requestScope.regDTO.emp_hire}</div>
										<div class="input-group-tools">
											<button type="button" class="option error">
												<i class="Licon size-24 ico-warning"></i>
											</button>
											<button type="button" class="option success">
												<i class="Licon size-24 ico-check"></i>
											</button>
											<button type="button" class="clear">
												<i class="material-icons">cancel</i>
											</button>
										</div>
									</div>
									<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
								</div>

								<div class="input-container input-container-md mg-t-4u">
									<label>퇴사일자<em class="txt-error">*</em></label>
									<div class="input-group">
										<input type="text" placeholder="퇴사일자를 입력해주세요." class="input-box emp_retire"
											name="emp_retire" value="${requestScope.regDTO.emp_retire}">
										<div class="input-group-tools">
											<button type="button" class="option error">
												<i class="Licon size-24 ico-warning"></i>
											</button>
											<button type="button" class="option success">
												<i class="Licon size-24 ico-check"></i>
											</button>
											<button type="button" class="clear">
												<i class="material-icons">cancel</i>
											</button>
										</div>
									</div>
									<p class="status-message">상태메세지는 이곳에 쓰여집니다.</p>
								</div>





								<div class="divider mg-t-10u mg-b-6u"></div>

								<div class="txt-right">
									<a href="javascript:location.reload();"><button type="button"
											class="btn btn-md btn-gray btn-container wth-100">
											<span class="label">취소</span>
										</button></a> <a class="empUpBtn"><button type="button"
											class="btn btn-md btn-primary btn-container wth-100">
											<span class="label">수정</span>
										</button></a>
								</div>

							</div>
						</section>
					</div>				
				</form>
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
	
	<form name="adEmpListForm" method="post" action="/adEmpList.do"></form>
</body>
</html>
