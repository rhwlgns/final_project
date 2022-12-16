<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <script src="/js/jquery-1.11.0.min.js"></script>
        <script>
            $(function(){
                $(".loginBtn").bind("click", function(){
                    checkLoginForm();
                });
            });

            function checkLoginForm(){
                var admin_idObj = $("[name='admin_id']");
                var admin_idVal = admin_idObj.val();
                if(typeof(admin_idVal)!="string"){
                    admin_idVal="";
                }

                if(admin_idVal.split(" ").join("")==""){
                    alert("아이디를 입력해 주세요.");
                    admin_idObj.val("");
                    admin_idObj.focus();
                    return;
                }

                // // 앞, 뒤 공백이 있을 경우
                // // 경고문을 띄우고 중지
                // var adminTrim = $.trim(admin_idVal);
                // if(admin_idVal!=adminTrim){
                //     alert("아이디 앞이나 뒤에 공백이 있습니다.");
                //     admin_idObj.val("");
                //     admin_idObj.focus();
                //     return;
                // }

                // 앞 중간 뒤 공백 다 따로
                // 공백 제거 후 전송
                var flag;
                if(admin_idVal.indexOf(" ")==0){
                    flag = confirm("문자의 앞에 공백이 있습니다.\n공백을 제거하고 전송하시겠습니까?\n(취소 시 입력 값이 모두 지워집니다.)");
                    if(flag==true){
                        while(admin_idVal.indexOf(" ")==0){
                            admin_idVal = admin_idVal.slice(1, admin_idVal.length);
                        }
                    }else{
                        admin_idObj.val("");
                        admin_idObj.focus();
                        return;
                    }
                }

                if(admin_idVal.lastIndexOf(" ")==admin_idVal.length-1){
                    flag = confirm("문자의 뒤에 공백이 있습니다.\n공백을 제거하고 전송하시겠습니까?\n(취소 시 입력 값이 모두 지워집니다.)");
                    if(flag==true){
                        while(admin_idVal.lastIndexOf(" ")==admin_idVal.length-1){
                            admin_idVal = admin_idVal.slice(0, admin_idVal.length-1);
                        }
                    }else{
                        admin_idObj.val("");
                        admin_idObj.focus();
                        return;
                    }
                }

                var adminTrim = $.trim(admin_idVal);
                if(adminTrim!=admin_idVal.split(" ").join("")){
                    flag = confirm("문자의 중간에 공백이 있습니다.\n공백을 제거하고 전송하시겠습니까?\n(취소 시 입력 값이 모두 지워집니다.)");
                    if(flag==true){
                        admin_idVal = admin_idVal.split(" ").join("");
                    }else{
                        admin_idObj.val("");
                        admin_idObj.focus();
                        return;
                    }
                }
                
                var pwdObj = $("[name='pwd']");
                var pwdVal = pwdObj.val();
                if(typeof(pwdObj)!="string"){
                    pwdVal="";
                }

                if(pwdVal.split(" ").join("")==""){
                    alert("암호를 입력해 주세요.");
                    pwdObj.val("");
                    pwdObj.focus();
                    return;
                }
            }
        </script>
    </head>
    <body>
        <center>
            <form action="/loginPorc.do" name="loginForm">
                <table border="1" cellpadding="5">
                    <caption>로그인</caption>
                    <tr>
                        <th>아이디</th>
                        <td><input type="text" name="admin_id"></td>
                    </tr>
                    <tr>
                        <th>암 호</th>
                        <td><input type="password" name="pwd"></td>
                    </tr>
                </table>
                <div style="height: 5px;"></div>
                <input type="button" value="로그인" class="loginBtn">
            </form>
        </center>
    </body>
</html>