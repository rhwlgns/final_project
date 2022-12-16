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
<title>사용자 정보 등록</title>
<script type="text/javascript">
	$(function() {
		$("#emp_id_div").removeClass("checked");

		$("#check_no").bind("click", function() {
			checkOverlappedNo();
		});
		
		$("#check_id").bind("click", function() {
			checkOverlappedId();
		});

		$("#bigRedButton").bind("click", function() {
			if ($("#emp_no_div").hasClass("error")) {
				$("[name='emp_no']").focus()
				return;
			} else if ($("#emp_id_div").hasClass("error")) {
				$("[name='emp_id']").focus()
				return;
			} else if ($("#emp_pwd_div").hasClass("error")) {
				$("[name='emp_pwd']").focus()
				return;
			} else if ($("#emp_pwdChk_div").hasClass("error")) {
				$("[name='emp_pwdChk']").focus()
				return;
			} else if ($("#emp_name_div").hasClass("error")) {
				$("[name='emp_name']").focus()
				return;
			} else if (	!$("#emp_id_div").hasClass("checked")){
				alert("중복체크를 해주세요")
				return;
			} else {
				adUserInfoReg();
			}

		});

		$(".testBtn").bind("click", function() {
			data = $("[name='registryFormat']").serialize();
			alert(data);
		});

		//	사원 번호 유효성
		$("[name='emp_no']").on("blur keyup", function() {
			var emp_no = $(this).val();
			let msg = $("#emp_no_msg")
			let flag = $("#emp_no_div")
			if (emp_no == '' || emp_no == 'undefined') {
				msg.text('필수 입력 항목입니다.');
				flag.addClass("error");
				flag.removeClass("success");
				return;
			}
			if (!emp_no_check(emp_no)) {
				msg.text('유효성확인');
				flag.addClass("error");
				flag.removeClass("success");
				$(this).focus();
				return false;
			} else {
				msg.text('');
				flag.addClass("success");
				flag.removeClass("error");
			}
		});

		//	아이디 유효성
		$("[name='emp_id']").on("blur keyup", function() {
			var emp_id = $(this).val();
			let msg = $("#emp_id_msg")
			let flag = $("#emp_id_div")
			if (emp_id == '' || emp_id == 'undefined') {
				msg.text('필수 입력 항목입니다.');
				flag.addClass("error");
				flag.removeClass("success");
				return;
			}
			if (!emp_id_check(emp_id)) {
				msg.text('유효성확인');
				flag.addClass("error");
				flag.removeClass("success");
				$(this).focus();
				return false;
			} else {
				msg.text('');
				flag.addClass("success");
				flag.removeClass("error");
			}
		});

		//	비밀번호 유효성
		$("[name='emp_pwd']").on("blur keyup", function() {
			var emp_pwd = $(this).val();
			let msg = $("#emp_pwd_msg")
			let flag = $("#emp_pwd_div")
			if (emp_pwd == '' || emp_pwd == 'undefined') {
				msg.text('필수 입력 항목입니다.');
				flag.addClass("error");
				flag.removeClass("success");
				return;
			}
			switch (emp_pwd_check(emp_pwd)) {
			case -1:
				msg.text('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
				flag.addClass("error");
				flag.removeClass("success");
				break;
			case -2:
				msg.text('숫자와 영문자를 혼용하여야 합니다.');
				flag.addClass("error");
				flag.removeClass("success");
				break;
			case -3:
				msg.text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				flag.addClass("error");
				flag.removeClass("success");
				break;
			case 1:
				msg.text('');
				flag.addClass("success");
				flag.removeClass("error");
				break;

			}

		});

		//		비밀번호 확인 유효성
		$("[name='emp_pwdChk']").on("blur keyup", function() {
			var emp_pwd = $("[name='emp_pwd']").val();
			var emp_pwdChk = $(this).val();
			let msg = $("#emp_pwdChk_msg")
			let flag = $("#emp_pwdChk_div")
			if (emp_pwdChk == '' || emp_pwdChk == 'undefined')
				return;
			if (emp_pwd != emp_pwdChk) {
				msg.text('비밀번호가 일치하지 않습니다.');
				flag.addClass("error");
				flag.removeClass("success");
				$(this).focus();
				return false;
			} else {
				msg.text('');
				flag.addClass("success");
				flag.removeClass("error");
			}
		});

		//		이름 유효성
		$("[name='emp_name']").on("blur keyup", function() {
			var emp_name = $(this).val();
			let msg = $("#emp_name_msg")
			let flag = $("#emp_name_div")
			if (emp_name == '' || emp_name == 'undefined')
				return;
			if (!emp_name_check(emp_name)) {
				msg.text('유효성확인');
				flag.addClass("error");
				flag.removeClass("success");
				$(this).focus();
				return false;
			} else {
				msg.text('');
				flag.addClass("success");
				flag.removeClass("error");
			}
		});
	})

	function emp_no_check(data) {
		var regex = /^[A-Za-z0-9]{1,10}$/;
		let checkedNo = $("[name='checked_emp_no']").val();
		let ID = $("[name='emp_no']").val();
		
		if(checkedID.equals(ID)){
			$("#emp_no_div").addClass("checked");
		}else{
			$("#emp_no_div").removeClass("checked");
		}
		return (data != '' && data != 'undefined' && regex.test(data));
	}

	function emp_id_check(data) {
		var regex = /^[a-z][a-z0-9_]{3,14}$/;
		let checkedID = $("[name='checked_emp_id']").val();
		let ID = $("[name='emp_id']").val();
		
		if(checkedID.equals(ID)){
			$("#emp_id_div").addClass("checked");
		}else{
			$("#emp_id_div").removeClass("checked");
		}
		return (data != '' && data != 'undefined' && regex.test(data));
	}

	function emp_pwd_check(data) {
		var checkNumber = data.search(/[0-9]/g);
		var checkEnglish = data.search(/[a-z]/ig);

		if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(data)) {
			return -1;
		} else if (checkNumber < 0 || checkEnglish < 0) {
			return -2;
		} else if (/(\w)\1\1\1/.test(data)) {
			return -3;
		} else {
			return 1;
		}
	}

	function emp_name_check(data) {
		var regex = /^[가-힣a-zA-Z]{2,15}$/;
		return (data != '' && data != 'undefined' && regex.test(data));
	}

	function adUserInfoReg() {
		$.ajax({
			url : "/adUserInfoRegProc.do",
			type : "post",
			dataType : "json",
			data : $("[name='registryFormat']").serialize(),
			success : function(data) {
				if (data == 1) {
					location.replace("/adUserInfoRegConfirm.do");
				} else {
				}
			},
			error : function() {
				alert("웹 서버 접속 실패");
			}
		});
	}
	function checkOverlappedNo() {
		var noObj = $("[name='emp_no']");
		var emp_no = noObj.val();
		if (emp_no == null || emp_no == "")
			return;
		$.ajax({
			url : "/checkNo.do",
			type : "post",
			data : {
				emp_no : emp_no
			},
			datatype : 'json',
			success : function(data) {
				if (data >= 1) {
					$("#emp_no_msg").text("이미 등록이 되어있는 사원번호입니다.");
					$("#emp_no_div").addClass("error");
					$("#emp_no_div").removeClass("success");
				} else {
					$("#emp_no_msg").text("등록 가능한 사원번호입니다.");
					$("#emp_no_div").addClass("success");
					$("#emp_no_div").removeClass("error");
					$("#emp_no_div").addClass("checked");
					$("[name='checked_emp_no']").val($("[name='emp_no']").val())
				}
			},
			error : function() {
				alert("서버 요청 실패");
			}
		})
	}

	function checkOverlappedId() {
		var idObj = $("[name='emp_id']");
		var emp_id = idObj.val();
		if (emp_id == null || emp_id == "")
			return;
		$.ajax({
			url : "/checkId.do",
			type : "post",
			data : {
				emp_id : emp_id
			},
			datatype : 'json',
			success : function(data) {
				if (data >= 1) {
					$("#emp_id_msg").text("이미 사용중인 ID 입니다.");
					$("#emp_id_div").addClass("error");
					$("#emp_id_div").removeClass("success");
				} else {
					$("#emp_id_msg").text("사용 가능한 ID 입니다.");
					$("#emp_id_div").addClass("success");
					$("#emp_id_div").removeClass("error");
					$("#emp_id_div").addClass("checked");
					$("[name='checked_emp_id']").val($("[name='emp_id']").val())
				}
			},
			error : function() {
				alert("서버 요청 실패");
			}
		})
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
					<h5>사용자 정보 등록</h5>
					<!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
				</div>
			</div>
		</div>

		<!-- 메인 -->
		<div class="content-body reg-top">
			<div class="container">
				<section class="mg-t-20u">
					<div class="box signup">
						<form name="registryFormat">

							<div class="fix-width-column right bottom w-100 mg-t-4u">
								<div class="input-container input-container-md" id="emp_no_div">
									<label>사원번호<em class="txt-error">*</em></label>
									<div class="input-group">
										<input type="text" placeholder="사원번호를 입력해주세요." class="input-box" name="emp_no">
										<input type="hidden" name="checked_emp_no">
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
									<p class="status-message" id="emp_no_msg">사원번호 중복확인을 해주세요.</p>
								</div>

								<div class="pd-l-2u">
									<button type="button" class="btn btn-md btn-secondary btn-container btn-full" id="check_no">
										<span class="label">중복확인</span>
									</button>
								</div>
							</div>

							<div class="fix-width-column right bottom w-100 mg-t-4u">
								<div class="input-container input-container-md" id="emp_id_div">
									<label>아이디<em class="txt-error">*</em></label>
									<div class="input-group">
										<input type="text" placeholder="아이디를 입력해주세요." class="input-box" name="emp_id">
										<input type="hidden" name="checked_emp_id">
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
									<p class="status-message" id="emp_id_msg">아이디 중복확인을 해주세요.</p>
								</div>

								<div class="pd-l-2u">
									<button type="button" class="btn btn-md btn-secondary btn-container btn-full" id="check_id">
										<span class="label">중복확인</span>
									</button>
								</div>
							</div>


							<div class="input-container input-container-md mg-t-4u" id="emp_pwd_div">
								<label>비밀번호<em class="txt-error">*</em></label>
								<div class="input-group">
									<input type="password" placeholder="8~32자의 영문 대소문자,숫자,특수문자를 조합해서 입력해주세요." class="input-box"
										name="emp_pwd">
									<div class="input-group-tools">
										<button type="button" class="option view-password">
											<i class="material-icons">visibility</i>
										</button>
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
								<p class="status-message" id="emp_pwd_msg">필수 입력 항목입니다.</p>
							</div>


							<div class="input-container input-container-md mg-t-4u" id="emp_pwdChk_div">
								<label>비밀번호 확인<em class="txt-error">*</em></label>
								<div class="input-group">
									<input type="password" placeholder="확인을 위하여 위와 동일하게 입력해주세요." class="input-box"
										name="emp_pwdChk">
									<div class="input-group-tools">
										<button type="button" class="option view-password">
											<i class="material-icons">visibility</i>
										</button>
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
								<p class="status-message" id="emp_pwdChk_msg">필수 입력 항목입니다.</p>
							</div>

							<div class="divider mg-t-10u mg-b-6u"></div>

							<div class="txt-right">
								<a href="javascript:location.reload();">
									<button type="button" class="btn btn-md btn-gray btn-container wth-100">
										<span class="label">취소</span>
									</button>
								</a> <a>
									<button type="button" class="btn btn-md btn-primary btn-container wth-100"
										id="bigRedButton">
										<span class="label">등록</span>
									</button>
								</a>
							</div>
						</form>
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

</body>
</html>