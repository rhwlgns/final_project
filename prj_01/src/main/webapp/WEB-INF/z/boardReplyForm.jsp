<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>답글 쓰기</title>

		<!--  JQuery 라이브러리 수입 -->
		<script src="/js/jquery-1.11.0.min.js"></script>
		<script>
			$(function(){
				$("[name='writer']").val("사오정");
				$("[name='subject']").val("제목111");
				$("[name='content']").val("내용 111");
				$("[name='email']").val("abc111@kh.com");
				$("[name='pwd']").val("1111");
				
				// class="regBtn" 태그에 click 이벤트가 발생하면
				// regFormCheck 함수 호출
				$(".regBtn").bind("click",function(){
					replyFormCheck();

				});

				// class="boardListBtn" 태그에 click 이벤트가 발생하면
				// class="boardListBtn" form 태그의 action 값의
				// URL 주소로 웹 서버에 접속하기
				$(".boardListBtn").bind("click",function(){

					// 웹 서버에 "/boardList.do" URL 주소로 접속 시도
					// 사용 메소드 : location.replace("URL 주소");
					// 해당 메소드 접속 방식은 get 방식이다.
					// location.replace("/boardList.do");
					
					// POST 방식을 사용하고 싶을 경우
					// HTML form 태그 생성 method와 action 값을 준 후
					// document.~.submit();으로 접속한다.
					document.boardListForm.submit();
				});
			})

			// 유효성 체크,비동기 방식으로 웹서버에 접속하는  함수 선언
			function replyFormCheck(){

				// -----------------------
				// 유효성 체크
				// -----------------------


				// -----------------------
				// 비동기 방식으로 웹 서버에 접근하여
				// 게시판 [답글 쓰기] 관련 입력양식의 데이터 전송
				// -----------------------
				$.ajax({

					// 웹 서버 접속 시 사용할 URL 지정
					url : "/boardReplyRegProc.do"

					// 웹 서버에 데이터 전송 방식 지정
					// 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 두가지를 보내는 방식 지정
					, type : "post"

					// 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 아래 형식의 문자열로 조합해서 설정
					// "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
					, data : $("[name='boardReplyForm']").serialize()

					// 웹 서버와 통신 후 
					// 웹 서버의 응답을 성공적으로 받을 경우 
					// 실행할 익명함수 설정
					// 익명함수의 매개변수에는 웹 서버에서 받은
					// [새 글의 입력된 행 개수]가 들어온다.
					, success : function(regCnt){

						// 게시판 답글 입력 성공 시
						if(regCnt==1){

							alert("답글 쓰기 성공");
							location.replace("/boardList.do");

						}else{
							alert("새 글 쓰기 실패");
						}
					}

					// 웹 서버와 통신이 실패할 경우 
					// 실행할 익명함수 설정
					, error : function(){
						alert("웹 서버 접속 실패");
					}
				});

				

				

			}
		</script>
	</head>
	<body>
		<center>
			<form name="boardReplyForm">
				<table border="1" cellpadding="5" style="border-collapse:collapse" align="center"> 
					<caption>[답글 쓰기]</caption>
					<tr>
						<th bgcolor="lightgray">작성자</th>
						<td>
							<input type="text" name="writer" class="writer" size="10" maxlength="10">
						</td>
					<tr>
						<th bgcolor="lightgray">제목</th>
						<td>
							<input type="text" name="subject" class="subject" size="40" maxlength="30">
						</td>
					</tr>
					<tr>
						<th bgcolor="lightgray">이메일</th>
						<td>
							<input type="text" name="email" class="email" size="40" maxlength="30" >
						</td>
					</tr>
					<tr>
						<th bgcolor="lightgray">내용</th>
						<td>
							<textarea name="content"  class="content" rows="13" cols="40"  maxlength="300"></textarea>
						</td>
					</tr>
					<tr>
						<th bgcolor="lightgray">비밀번호</th>
						<td>
							<input type="password" name="pwd" class="pwd"  size="8"  maxlength="4">
						</td>
					</tr>
				</table>
				<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">

				<div style="height:5px;"></div>

				<input type="button" value="답글달기" class="regBtn">
				<input type="reset" value="다시작성">
				<input type="button" value="목록보기" class="boardListBtn">
			</form>
			<form name="boardListForm" action="/boardList.do" method="post"></form>
			
		</center>
	</body>
</html>