<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
	<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
<!--JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언-->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 사용자 정의 태그(Custom Tag) -->
<!-- 사용자가 원하는 기능을 구현하고 -->
<!-- [HTML 형태]로 표현하여 사용할 수 있는 -->
<!-- [사용자 정의 태그]를 말한다. -->
	
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>게시판 목록</title>
        
        <!--  JQuery 라이브러리 수입 -->
		<script src="/js/jquery-1.11.0.min.js"></script>
		<script>

			$(function(){

				// 새 글 쓰기 버튼을 클릭하면 웹 서버에 
				// "/boardRegForm.do" URL 주소로 접속하기
				$(".newRegBtn").bind("click",function(){
					
					// name="boardRegForm"을 가진 form 태그의 action 값 설정
					document.boardRegForm.action="/boardRegForm.do";
					
					// name="boardRegForm"을 가진 form 태그의 method 값 설정
					document.boardRegForm.method="post";
					
					// name="boardRegForm"을 가진 form 태그의 action 값에 
					// 해당하는 URL 주소로 웹서버 접속
					document.boardRegForm.submit();
				});

                // 검색 결과물이 출력되는 table 태그의 tr 태그에
                // mouseOn, mouseOut 했을 경우 배경색 변경
                $(".searchingResults").find("tr:eq(0)").nextAll().hover(
                    function(){
                        $(this).attr({"bgcolor":"lightgreen"});
                    }
                    , function(){
                        var basic_bgcolor = $(this).attr("basic_bgcolor");
                        $(this).attr({"bgcolor":basic_bgcolor});
                    }
                );

                var formObj = $("[name=boardSearchForm]");
                formObj.find(".keyword1").val("${param.keyword1}");
                formObj.find(".keyword2").val("${param.keyword2}");
                <c:if test="${!empty param.orAnd}">
                    formObj.find(".orAnd").val("${param.orAnd}");
                </c:if>
                
                <c:if test="${!empty param.rowCntPerPage}">
			        formObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
		        </c:if>

                <c:if test="${!empty requestScope.pagingMap.selectPageNo}">
                formObj.find(".selectPageNo").val("${requestScope.selectPageNo}");
                </c:if>

                // 해당 주석을 쓰면 BoardController.java에서
                // mav.addObject("selectPageNo", (int)pagingMap.get("selectPageNo"));을 쓰지 않으면
                // formObj.find(".selectPageNo").val("${requestScope.selectPageNo}"); 대신
                // formObj.find(".selectPageNo").val("${requestScope.pagingMap.selectPageNo}"); 사용 하여야 함

			});

            // 게시판의 행을 클릭했을때 호출되는 함수 선언
            function goBoardDetailForm(b_no){
            // 클릭한 행의 b_no가 매개변수로 들어온다.

                // location.replace("/goBoardDetailForm.do?b_no=" + b_no);
                
                // name=boardDetailForm의 후손 중
                // name=b_no에 해당하는 태그의 value에 b_no 삽입
                $("[name=boardDetailForm] [name=b_no]").val(b_no);

                // name=boardDetailForm 태그의
                // action 값의 URL 주소로 웹 서버에 접속
                document.boardDetailForm.submit();
                // name : 파라미터명, value : 파라미터값으로 웹 서버에 전송된다.
            }

            // 검색 버튼 클릭 시 호출되는 함수 선언
            function boardSearch(){

                // 입력한 키워드를 가져와 keyword1 변수에 저장
                var keyword1 = $(".keyword1").val();

                // 입력한 키워드를 가져와 keyword2 변수에 저장
                var keyword2 = $(".keyword2").val();

                // keyword1이 string이 아니라면 코딩 실행
                if(typeof(keyword1)!="string"){

                    // keyword1에 길이가 없는 문자열로 갱신
                    keyword1 = "";
                }

                // keyword2 string이 아니라면 코딩 실행
                if(typeof(keyword2)!="string"){

                    // keyword2 길이가 없는 문자열로 갱신
                    keyword2 = "";
                }

                // keyword1의 앞, 뒤 공백 제거
                keyword1 = $.trim(keyword1);
                // keyword1 = keyword1.trim();
                // Internet Explorer 9 이하 version에서는 주석문 코딩 실행 불가능

                // keyword2 앞, 뒤 공백 제거
                keyword2 = $.trim(keyword2);

                // 앞, 뒤 공백이 제거된 값으로 value 갱신
                $(".keyword1").val(keyword1);
                $(".keyword2").val(keyword2);

                // name=boardSearchForm 태그의
                // action 값의 URL 주소로 웹 서버에 접속
                document.boardSearchForm.submit();
            }

            // 모두검색 버튼 클릭 시 호출되는 함수 선언
            function boardSearchAll(){

                // 길이가 없는 문자열로 value 갱신
                $(".keyword1").val("");
                $(".keyword2").val("");

                // orAnd selcet 태그의 기본값으로 or 선택
                $(".orAnd").val("or");

                // boardSearchBtn 버튼 실행
                $(".boardSearchBtn").click();
                // document.boardSearchForm.submit();
            }

            // 페이지 번호 버튼 클릭 시 호출되는 함수 선언
            function pageNoBtn(pageNo){

                // class="selectPageNo"를 가진 입력양식의
                // 페이지 번호를 value 값으로 삽입
                $(".selectPageNo").val(pageNo);

                // boardSearch 함수 호출
                boardSearch();
            }

		</script>
    </head>
    <body>

        <!-- [게시판 검색 조건 입력 양식]을 내포한 form 태그 선언 -->
        <form action="/boardList.do" name="boardSearchForm" method="post">
            <center>
                <!-- 키워드 데이터를 저장할 입력양식 선언 -->
                [키워드] : 
                <input type="text" name="keyword1" class="keyword1" id="">
                <select name="orAnd" class="orAnd" id="">
                    <option value="or">or</option>
                    <option value="and">and</option>
                </select>
                <input type="text" name="keyword2" class="keyword2" id="">
                
                <!--
                <input type="text" name="keyword1" class="keyword1" value="$ {param.keyword1}" id="">
                <select name="orAnd" id="">
                    <option value="or" $ {param.orAnd==='or'?'selected':''}>or</option>
                    <option value="and" $ {param.orAnd==='and'?'selected':''>and</option>
                </select>
                <input type="text" name="keyword2" class="keyword2" value="$ {param.keyword2}" id="">
                -->

                <!-- 클릭한 페이지 번호를 저장할 hidden 입력양식 선언 -->
                <!-- 페이징 처리 관련 데이터 -->
                <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">

                <!-- 한 화면에 보여지는 행의 개수를 저장할 hidden 입력양식 선언 -->
                <!-- <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10"> -->

                <!-- 한 화면에 보여지는 페이지 번호의 개수를 저장할 hidden 입력양식 선언 -->
                <input type="hidden" name="pageNoPerPage" class="pageNoPerPage" value="10">

                <div style="height: 5px;"></div>
                <input type="button" class="boardSearchBtn" value="검색" onclick="boardSearch()">&nbsp;
                <input type="button" class="boardSearchAllBtn" value="모두 검색" onclick="boardSearchAll()">
                <div style="height: 5px;"></div>
            </center>

            <div class="searchingResults">
                <table border="0" cellspacing="0" cellpadding="5" style="border-collapse: collapse;" align="center">
                    <caption>
                        총 개수 : ${requestScope.boardTotCnt}개 / ${requestScope.boardTotAllCnt}개
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <!-- <br> -->
                        <select name="rowCntPerPage" class="rowCntPerPage" onChange="boardSearch( );">
                            <option value="10">10
                            <option value="15">15
                            <option value="20">20
                            <option value="30">30
                        </select> 행보기&nbsp;
                        <span class="newRegBtn">[새 글 쓰기]</span>
                    </caption>
                    <tr bgcolor="lightblue">
                        <th>번호</th>
                        <th style="width: 150px;">제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>등록일</th>
                    </tr>

                    <!-- 
                    <caption>총 개수 : ${requestScope.boardTotCnt }개</caption>

                    <%
                    // HttpServletRequst 객체에 게시판 목록을 꺼내서 출력 
                    List<Map<String, String>> boardList = (List<Map<String, String>>)request.getAttribute("boardList");
                    
                    if(boardList!=null){
                        out.println("<caption>총 개수 : " + boardList.size() + "개</caption>");

                        for(int i=0; i<boardList.size(); i++){
                            Map<String, String> map = boardList.get(i);
                            String b_no = map.get("b_no");
                            String subject = map.get("subject");
                            String writer = map.get("writer");
                            String readcount = map.get("readcount");
                            String reg_date = map.get("reg_date");

                            if(i%2==1){
                            out.println("<tr bgcolor='lightgray'>");
                            }else{
                                out.println("<tr>");
                            }
                            out.println("<td>" + b_no + "</td><td>" + subject + "</td><td>" + writer + "</td><td>" + readcount + "</td><td>" + reg_date + "</td></tr>");

                            // if(i%2==1){
                            //      out.println("<tr bgcolor='lightgray'><td>" + b_no + "</td><td>" + subject + "</td><td>" + writer + "</td><td>" + readcount + "</td><td>" + reg_date + "</td></tr>");
                            // }else{
                            //      out.println("<tr><td>" + b_no + "</td><td>" + subject + "</td><td>" + writer + "</td><td>" + readcount + "</td><td>" + reg_date + "</td></tr>");
                            // }
                            

                            // out.println("<tr bgcolor='" + (i%2==1?"lightgray":"") + "'><td>" + b_no + "</td><td>" + subject + "</td><td>" + writer + "</td><td>" + readcount + "</td><td>" + reg_date + "</td></tr>");

                        }
                    }
                    %>
                    -->
                    
                    <!-- EL 문법과 C core 태그를 사용하여 -->
                    <!-- HttpServletRequest 객체에 "boardList"라는 키 값으로 저장된 -->
                    <!-- List 객체 안의 다량의 HashMap 객체의 데이터를 꺼내 -->
                    <!-- HTML 태그 사이에 삽입 -->
                    
                    <c:forEach var="board" items="${requestScope.boardList}" varStatus="loopTagStatus">
                        <tr basic_bgcolor="${loopTagStatus.index%2==0?'':'lightgray'}" bgcolor="${loopTagStatus.index%2==0?'':'lightgray'}" style="cursor: pointer;" onClick="goBoardDetailForm(${board.b_no})">
                            <td>
                                <!-- 번호 내림차순 표시 -->
                                ${requestScope.pagingMap.serialNo_desc - loopTagStatus.index}

                                <!-- 번호 오름차순 표시 -->
                                <!-- ${requestScope.pagingMap.serialNo_asc + loopTagStatus.index} -->

                                <!-- 내림차순 힌트(완성 X) -->
                                <!-- ${requestScope.boardTotCnt - ((requestScope.pagingMap.selectPageNo - 1) * requestScope.pagingMap.rowCntPerPage) - loopTagStatus.index} -->
                            </td>
                            <td>
                                <c:forEach var="i" begin="2" end="${board.print_level}">
                                    &nbsp;&nbsp;
                                </c:forEach>
                                <c:if test="${board.print_level>0}">ㄴ</c:if>${board.subject}
                            </td>
                            <td>${board.writer}</td>
                            <td>${board.readcount}</td>
                            <td>${board.reg_date}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </form>
        <center>

            <!-- 검색된 게시판의 개수가 0개 초과일 경우 실행 -->
            <c:if test="${requestScope.boardTotCnt>0}">

                <!-- [처음] 출력 및 클릭하면 처음으로 이동 -->
                <span style="cursor:pointer;" onclick="pageNoBtn(1);">[처음]</span>

                <!-- [이전] 출력 및 클릭하면 이전으로 이동 -->
                <span style="cursor:pointer;" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}-1);">[이전]</span>

                <!-- 페이지 번호를 출력하는 forEach문 실행 -->
                <c:forEach var="no" begin="${requestScope.pagingMap.begin_pageNo_perPage}" end="${requestScope.pagingMap.end_pageNo_perPage}" step="1">

                    <!-- 선택된 페이지가 아닐 경우 []를 붙인 페이지를 출력 -->
                    <c:if test="${requestScope.pagingMap.selectPageNo!=no}">
                        <span style="cursor:pointer;" onclick="pageNoBtn(${no});">[${no}]</span>&nbsp;
                    </c:if>

                    <!-- 선택된 페이지가 맞을 경우 []를 붙이지 않은 페이지를 출력 -->
                    <c:if test="${requestScope.pagingMap.selectPageNo==no}">
                        <span>${no}</span>&nbsp;
                    </c:if>
                </c:forEach>

                <!-- [다음] 출력 및 클릭하면 다음으로 이동 -->
                <span style="cursor:pointer;" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}+1);">[다음]</span>
                
                <!-- [마지막] 출력 및 클릭하면 마지막으로 이동 -->
                <span style="cursor:pointer;" onclick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
            </c:if>
        </center>

        <form name="boardRegForm"></form>
        <form action="/boardDetailForm.do" name="boardDetailForm" method="post">
            <input type="hidden" name="b_no">
        </form>
    </body>
</html>