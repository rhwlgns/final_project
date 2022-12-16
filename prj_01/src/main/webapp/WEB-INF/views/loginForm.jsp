<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 -->
<!-- 현 JSP 페이지 처리 방식 선언 -->
<!-- 모든 JSP 페이지 상단에 항상 아래와 같은 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- contectType="text/html; charset=UTF-8" -->
<!-- 현재 JSP 페이지 실행 후 생성되는 문서는 HTML이고, -->
<!-- 문서 안의 데이터는 UTF-8 방식으로 인코딩 -->
<!-- pageEncoding="UTF-8" -->
<!-- 현재 JSP 페이지는 UTF-8 방식으로 인코딩한다. -->
<!-- <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>로그인 화면</title>
        <script src="/js/jquery-1.11.0.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="/css/login/style.css" type="text/css">
        <link rel="stylesheet" href="/css/login/login_bg.css" type="text/css">
        <script src="/js/login/jquery.min.js"></script>
        <script src="/js/login/popper.js"></script>
        <script src="/js/login/bootstrap.min.js"></script>
        <script src="/js/login/main.js"></script>
        <script>
            // body 태그 안의 모든 코드를 읽은 이후 
            // 호출될 Javascript 코드 설정
            $(function(){

                // class="loginBtn" 가진 태그에
                // click 이벤트가 발생할 경우
                // checkLoginForm() 함수 호출
                $(".loginBtn").bind("click", function(){
                    checkLoginForm();
                });

                // -----------------------
                // 웹 서버에 접속한 클라이언트가 가져온 쿠키값을
                // 아이디와 암호 입력란에 삽입
                // -----------------------
                // 접속한 클라이언트가 가져온 쿠키 중
                // 쿠키명 "user_id"에 대응하는 쿠키값을
                // {cookie.user_id.value}에 삽입하여
                // name='user_id' 태그의 value 값으로 입력
                $("[name='user_id']").val("${cookie.user_id.value}");

                // 접속한 클라이언트가 가져온 쿠키 중
                // 쿠키명 "user_pwd"에 대응하는 쿠키값을
                // {cookie.user_pwd.value}에 삽입하여
                // name='user_pwd' 태그의 value 값으로 입력
                $("[name='user_pwd']").val("${cookie.user_pwd.value}");

                // -----------------------
                // 접속한 클라이언트가 가져온 쿠키 값은
                // EL 문법을 사용하여 꺼낸다.
                // 쿠키값을[EL] 문법으로 꺼내는 형식
                // $ {cookie.쿠키명.value}
                // $ 와 {} 사이의 공백은 제거하여야 작동됨
                // 주석문에서도 EL 문법이 실행됨
                // -----------------------

            });
            
            // 입력한 아이디와 함호의 유효성을 체크하는
            // checkLoginForm() 함수 선언
            function checkLoginForm(){
                // -----------------------
                // 아이디 유효성 체크
                // -----------------------

                // name='user_id'를 가진 태그를 관리하는
                // JQuery 객체의 메모리 위치 주소 값을 얻어
                // user_idObj 변수에 저장
                var user_idObj = $("[name='user_id']");

                // 화면에서 입력한 데이터를 가져와
                // user_idVal 변수에 저장
                var user_idVal = user_idObj.val();

                // user_idVal 데이터가 문자가 아닐 경우
                // 비어있는 문자열("")을 user_idVal 변수에 저장
                if(typeof(user_idVal)!="string"){
                    user_idVal="";
                }

                // user_idVal 데이터가
                // 길이가 없거나 공백으로만 이루어져 있을 경우
                if(user_idVal.split(" ").join("")==""){

                    // 경고창 띄우기
                    // alert("아이디를 입력해 주세요.");

                    // 비어있는 문자열("")로 변경
                    user_idObj.val("");

                    // 커서를 올림
                    user_idObj.focus();

                    // checkLoginForm() 함수 종료
                    return;
                }

                // user_idVal 데이터가
                // 공백이 포함되어 있을 경우
                if(user_idVal.split(" ").join("")!=user_idVal){

                    // confirm창 띄우기
                    if(confirm("아이디에 공백이 있습니다.\n공백만 지울 경우 [확인]\nID를 모두 지울 경우 [취소]")){

                        // 아이디에 공백 삭제
                        user_idObj.val(user_idVal.split(" ").join(""));

                        return;
                    }else{

                        user_idObj.val("");
                        user_idObj.focus();

                        return;
                    }
                }
                
                // -----------------------
                // 암호 유효성 체크
                // -----------------------

                // name='user_pwd'를 가진 태그를 관리하는
                // JQuery 객체의 메모리 위치 주소 값을 얻어
                // user_pwdObj 변수에 저장
                var user_pwdObj = $("[name='user_pwd']");

                // 화면에서 입력한 데이터를 가져와
                // user_pwdVal 변수에 저장
                var user_pwdVal = user_pwdObj.val();
                
                // user_pwdObj 데이터가 문자가 아닐 경우
                // 비어있는 문자열("")을 user_pwdObj 변수에 저장
                if(typeof(user_pwdVal)!="string"){
                    user_pwdVal="";
                }

                // user_pwdVal 데이터가
                // 길이가 없거나 공백으로만 이루어져 있을 경우
                if(user_pwdVal.split(" ").join("")==""){

                    // 경고창 띄우기
                    // alert("암호를 입력해 주세요.");

                    // 비어있는 문자열("")로 변경
                    user_pwdObj.val("");

                    // 커서를 올림
                    user_pwdObj.focus();

                    // checkLoginForm() 함수 종료
                    return;
                }

                // user_pwdVal 데이터가
                // 공백이 포함되어 있을 경우
                if(user_pwdVal.split(" ").join("")!=user_pwdVal){

                    // confirm창 띄우기
                    if(confirm("암호에 공백이 포함되어 있습니다.\n공백만 지울 경우 [확인]\n암호를 모두 지울 경우 [취소]")){

                        // 암호에 공백 삭제
                        user_pwdObj.val(user_pwdVal.split(" ").join(""));

                        return;
                    }else{

                        user_pwdObj.val("");
                        user_pwdObj.focus();

                        return;
                    }
                }

                // -----------------------
                // 비동기 방식으로 웹 서버에 접근하여
                // 아이디, 암호의 데이터를 판단하여
                // 로그인의 성공, 실패 여부 확인
                // 웹 서버 접속 시 사용할 URL : /loginProc.do
                // -----------------------
                $.ajax({

                    // 웹 서버 접속 시 사용할 URL 지정
                    url : "/loginProc.do"

                    // 웹 서버에 데이터 전송 방식 지정
                    // 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
                    // 두가지를 보내는 방식 지정
                    , type : "post"

                    // 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
                    // 아래 형식의 문자열로 조합해서 설정
                    // "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
                    , data : $("[name='loginForm']").serialize()
                    // , data : {"admin_id" : admin_idVal, "user_pwd" : user_pwdVal}
                    // , data : "admin_id = " + admin_idVal + "& user_pwd = " + user_pwdVal

                    // 웹 서버와 통신 후 
                    // 웹 서버의 응답을 성공적으로 받을 경우 
                    // 실행할 익명함수 설정
                    // 익명함수의 매개변수에는 웹 서버에서 받은
                    // [아이디, 암호의 존재개수]가 들어온다.
                    , success : function(idCnt){
                        
                        if(idCnt==1){
                            if(user_idVal=="system"){
                                document.adNotice.submit();
                            }else{
                                document.empNotice.submit();
                            }
                        }else{
                            alert("로그인 실패");
                            admin_idObj.val("");
                            user_pwdObj.val("");
                        }
                    }

                    // 웹 서버와 통신이 실패할 경우 
                    // 실행할 익명함수 설정
                    , error : function(){
                        alert("웹 서버 접속 실패");
                    }
                });
            }

            function enterkey() {
                if (window.event.keyCode == 13) {
                    checkLoginForm();
                }
            }
        </script>
    </head>
    <body>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="login-wrap p-4 p-md-5">
                            <div class="login-logo-align">
                                <img src="/img/login/loginLogo.png">
                            </div>
                            <div class="icon d-flex align-items-center justify-content-center">
                                <span class="fa fa-user-o"></span>
                            </div>
                            <br>
                            <form action="/adNotice.do" name="adNotice" method="post"></form>
                            <form action="/empNotice.do" name="empNotice" method="post"></form>
                            <form action="/loginProc.do" name="loginForm" method="post">
                                <div class="form-group">
                                    <input type="text" name="user_id" class="form-control rounded-left" placeholder="ID" onkeyup="enterkey()">
                                </div>
                                <div class="form-group d-flex">
                                    <input type="password" name="user_pwd" class="form-control rounded-left" placeholder="Password" onkeyup="enterkey()">
                                </div>
                                <div class="form-group">
                                    <button type="button" class="loginBtn form-control btn btn-primary rounded submit px-3">Login</button>
                                </div>
                                <div class="form-group d-md-flex">
                                    <div class="w-50">
                                        <label class="checkbox-wrap checkbox-primary">정보 기억
                                            <input type="checkbox" value="yes" name="is_login" class="is_login" ${empty cookie.user_id.value?'':'checked'}>
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>