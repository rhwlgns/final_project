<script>
    // var formObj = $("[name='boardSearch")
    $(function(){
        init();
    });

    function init(){

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
        // $(".searchingResults").find("tr:eq(0)").siblings().hover(

            // mouseOn일 경우 실행
            function(){

                // class="mouseOnTrBgC" 삽입
                $(this).addClass("mouseOnTrBgC");

            }

            // mouseOut일 경우 실행
            , function(){

                // class="mouseOnTrBgC" 삭제
                $(this).removeClass("mouseOnTrBgC");

            }
        );
        
        /*
            //--------------------------------------------------
            //  방법1
            //--------------------------------------------------
            var old_bgcolor;
            $(".seachingResults").find("tr:eq(0)").nextAll().hover(
                    function(){
                        old_bgcolor = $(this).attr( "bgcolor" );
                        $(this).attr( {"bgcolor":"lightblue"} )
                    }
                    ,function(i){
                        $(this).attr( {"bgcolor":old_bgcolor} )
                    }
            );
            //--------------------------------------------------
            //  방법2
            //--------------------------------------------------
            $(".seachingResults").find("tr:eq(0)").nextAll().hover(
                    function(){
                        $(this).attr( {"bgcolor":"lightblue"} )
                    }
                    ,function(i){
                        var basic_bgcolor = $(this).attr( "basic_bgcolor" )
                        $(this).attr( {"bgcolor":basic_bgcolor} )
                    }
            );

            // tr 태그 수정
            <tr basic_bgcolor="${loopTagStatus.index%2==0?'':'lightgray'}" bgcolor="${loopTagStatus.index%2==0?'':'lightgray'}" style="cursor: pointer;" onClick="goBoardDetailForm(${board.b_no})">
        */

        $(".sortHeader").click(function(){
            var thisObj = $(this);
            var text = thisObj.text().trim();

            if(text=="조회수"){
                $(".sort").val("readcount asc");
            }else if(text=="조회수▲"){
                $(".sort").val("readcount desc");
            }else if(text=="조회수▼"){
                $(".sort").val("");
            }else if(text=="등록일"){
                $(".sort").val("reg_date asc");
            }else if(text=="등록일▲"){
                $(".sort").val("reg_date desc");
            }else if(text=="등록일▼"){
                $(".sort").val("");
            }

            // boardSearchBtn 버튼 실행
            $(".boardSearchBtn").click();
        });

        var formObj = $("[name=boardSearchForm]");

        // class="keyword1" 태그를 가진 입력양식에
        // "keyword1" 파라미터명의 파라미터값 삽입
        formObj.find(".keyword1").val("${param.keyword1}");

        // class="keyword2" 태그를 가진 입력양식에
        // "keyword2" 파라미터명의 파라미터값 삽입
        formObj.find(".keyword2").val("${param.keyword2}");

        // "orAnd" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.orAnd}">

            // class="orAnd" 태그를 가진 입력양식에
            // "orAnd" 파라미터명의 파라미터값 삽입
            formObj.find(".orAnd").val("${param.orAnd}");
        </c:if>

        // "rowCntPerPage" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.rowCntPerPage}">

            // class="rowCntPerPage" 태그를 가진 입력양식에
            // "rowCntPerPage" 파라미터명의 파라미터값 삽입
            formObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
        </c:if>

        // "selectPageNo" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty requestScope.pagingMap.selectPageNo}">

            // class="selectPageNo" 태그를 가진 입력양식에
            // "selectPageNo" 파라미터명의 파라미터값 삽입
            formObj.find(".selectPageNo").val("${requestScope.selectPageNo}");
        </c:if>

        // "min_year" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.min_year}">

            // class="min_year" 태그를 가진 입력양식에
            // "min_year" 파라미터명의 파라미터값 삽입
            formObj.find(".min_year").val("${param.min_year}");
        </c:if>

        // "min_month" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.min_month}">

            // class="min_month" 태그를 가진 입력양식에
            // "min_month" 파라미터명의 파라미터값 삽입
            formObj.find(".min_month").val("${param.min_month}");
        </c:if>

        // "max_year" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.max_year}">

            // class="max_year" 태그를 가진 입력양식에
            // "max_year" 파라미터명의 파라미터값 삽입
            formObj.find(".max_year").val("${param.max_year}");
        </c:if>

        // "max_month" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.max_month}">

            // class="max_month" 태그를 가진 입력양식에
            // "max_month" 파라미터명의 파라미터값 삽입
            formObj.find(".max_month").val("${param.max_month}");
        </c:if>

        // "sort" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.sort}">

            // class="sort" 태그를 가진 입력양식에
            // "sort" 파라미터명의 파라미터값 삽입
            formObj.find(".sort").val("${param.sort}");

            // class="sortHeader" 태그를 가진 입력양식들에
            // 각각 지정된 Javascript 코드 실행
            $(".sortHeader").each(function(){

                // i번째 class="sortHeader" 태그를 관리하는 JQuery 객체를 얻어
                // thisObj 변수에 저장
                var thisObj = $(this);

                // i번째 태그의 문자 얻기
                var text = thisObj.text().trim();

                // i번째 태그의 문자열 중 ▲와 ▼ 제거
                text = text.replace("▲", "").replace("▼", "");

                // ▲와 ▼가 제거된 문자열로 태그안의 문자열 갱신
                thisObj.text(text);

                // sort와 text의 기준에 맞춰 태그의 문자열에 ▲, ▼ 삽입
                if("${param.sort}"=="readcount asc" && text=="조회수"){
                    thisObj.append("▲");
                }else if("${param.sort}"=="readcount desc" && text=="조회수"){
                    thisObj.append("▼");
                }else if("${param.sort}"=="reg_date asc" && text=="등록일"){
                    thisObj.append("▲");
                }else if("${param.sort}"=="reg_date desc" && text=="등록일"){
                    thisObj.append("▼");
                }
            });
        </c:if>

        // <% 
        //     String orAnd = request.getParameter("orAnd");
        //     if(orAnd!=null){
        //         out.print("formObj.find('.orAnd').val('" + orAnd + "');");
        //     }
        //     String rowCntPerPage = request.getParameter("rowCntPerPage");
        //     if(rowCntPerPage!=null){
        //         out.print("formObj.find('.rowCntPerPage').val('" + rowCntPerPage + "');");
        //     }
        //     String selectPageNo = request.getParameter("selectPageNo");
        //     if(selectPageNo!=null){
        //         out.print("formObj.find('.selectPageNo').val('" + selectPageNo + "');");
        //     }
        // %>

        // 해당 주석을 쓰면 BoardController.java에서
        // mav.addObject("selectPageNo", (int)pagingMap.get("selectPageNo"));을 쓰지 않으면
        // formObj.find(".selectPageNo").val("${requestScope.selectPageNo}"); 대신
        // formObj.find(".selectPageNo").val("${requestScope.pagingMap.selectPageNo}"); 사용 하여야 함

        <c:forEach var="date" items="${paramValues.date}">
            formObj.find(".date").filter("[value=${date}]").prop("checked", true);
        </c:forEach>

    }

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

        var min_year = $(".min_year").val();
        var min_month = $(".min_month").val();
        var max_year = $(".max_year").val();
        var max_month = $(".max_month").val();

        if(min_year!="" && min_month!=""){
            $(".min_year_month").val(min_year + "-" + min_month + "-01");
        }

        if(max_year!="" && max_month!=""){
            $(".max_year_month").val(max_year + "-" + max_month + "-" + new Date(parseInt(max_year, 10), parseInt(max_month, 10), 0).getDate());
        }
        

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

        // date selcetbox 태그의 기본값으로 false 선택
        $(".date").prop("checked", false);

        emptyYMRange();

        // "sort" 파라미터명의 파라미터값이 비어있지 않을 경우 실행
        <c:if test="${!empty param.sort}">

            var formObj = $("[name=boardSearchForm]");
            
            // class="sort" 태그를 가진 입력양식에
            // "sort" 파라미터명의 파라미터값 삽입
            formObj.find(".sort").val("${param.sort}");

            // class="sortHeader" 태그를 가진 입력양식들에
            // 각각 지정된 Javascript 코드 실행
            $(".sortHeader").each(function(){

                // i번째 class="sortHeader" 태그를 관리하는 JQuery 객체를 얻어
                // thisObj 변수에 저장
                var thisObj = $(this);

                // i번째 태그의 문자 얻기
                var text = thisObj.text().trim();

                // i번째 태그의 문자열 중 ▲와 ▼ 제거
                text = text.replace("▲", "").replace("▼", "");

                // ▲와 ▼가 제거된 문자열로 태그안의 문자열 갱신
                thisObj.text(text);

                $(".sort").val("");
            });
        </c:if>

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

    // 날짜 범위 관련 select 태그들의 유효성 체크
    function checkYMRange(){
        var formObj = $("[name='boardSearchForm']");
        var min_yearObj = formObj.find(".min_year");
        var min_monthObj = formObj.find(".min_month");
        var max_yearObj = formObj.find(".max_year");
        var max_monthObj = formObj.find(".max_month");

        var min_yearVal = min_yearObj.val();
        var min_monthVal = min_monthObj.val();
        var max_yearVal = max_yearObj.val();
        var max_monthVal = max_monthObj.val();

        if(min_yearVal=="" && min_monthVal!=""){
            alert("년도를 먼저 선택해주세요.");
            min_monthObj.val("");
            return;
        }
        if(max_yearVal=="" && max_monthVal!=""){
            alert("년도를 먼저 선택해주세요.");
            max_monthObj.val("");
            return;
        }
        if(min_yearVal!="" && min_monthVal==""){
            min_monthObj.val("01");
            min_monthVal = "01";
            // min_monthVal = min_monthObj.val();
        }
        if(max_yearVal!="" && max_monthVal==""){
            max_monthObj.val("12");
            max_monthVal = "12";
            // max_monthVal = max_monthObj.val();
        }
        if(min_yearVal!="" && min_monthVal!="" && max_yearVal!="" && max_monthVal!=""){
            if(min_monthVal.length==1){min_monthVal = "0" + min_monthVal;}
            if(max_monthVal.length==1){max_monthVal = "0" + max_monthVal;}
            if((min_yearVal + min_monthVal) > (max_yearVal + max_monthVal)){
                alert("minimum 년, 월이 maximum 년, 월 보다 큽니다.")
                max_yearObj.val("");
                max_monthObj.val("");

                return;
            }
        }
    }

    function emptyYMRange(){
        var formObj = $("[name='boardSearchForm']");
        formObj.find(".min_year").val("");
        formObj.find(".min_month").val("");
        formObj.find(".max_year").val("");
        formObj.find(".max_month").val("");
    }

    function setYMRange_to_thisMonth(){
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1;
        if(month<10){
            month = "0" + month;
        }
        var formObj = $("[name='boardSearchForm']");
        formObj.find(".min_year").val(year);
        formObj.find(".min_month").val(month);
        formObj.find(".max_year").val(year);
        formObj.find(".max_month").val(month);
    }

    function setYMRange_to_thisYear(){
        var today = new Date();
        var year = today.getFullYear();
        // var month = today.getMonth() + 1;
        // if(month<10){
        //     month = "0" + month;
        // }
        var formObj = $("[name='boardSearchForm']");
        formObj.find(".min_year").val(year);
        formObj.find(".min_month").val("01");
        formObj.find(".max_year").val(year);
        formObj.find(".max_month").val("12");
    }

</script>






















<!-- [게시판 검색 조건 입력 양식]을 내포한 form 태그 선언 -->
            <form action="/boardList.do" name="boardSearchForm" method="post">
                <center>adNotice
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

                    <br>
                    <input type="checkbox" name="date" class="date" value="-0" id="">오늘
                    <input type="checkbox" name="date" class="date" value="-1" id="">어제
                    <input type="checkbox" name="date" class="date" value="-2" id="">그제

                    <br>
                    <select name="min_year" class="min_year" onChange="checkYMRange()" id="">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option value="2022">2022</option>
                        <option value="2021">2021</option>
                        <option value="2020">2020</option>
                    </select>년
                    <select name="min_month" class="min_month" onChange="checkYMRange()" id="">
                        <option value="">&nbsp;&nbsp;</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>월 ~
                    <select name="max_year" class="max_year" onChange="checkYMRange()" id="">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option value="2022">2022</option>
                        <option value="2021">2021</option>
                        <option value="2020">2020</option>
                    </select>년
                    <select name="max_month" class="max_month" onChange="checkYMRange()" id="">
                        <option value="">&nbsp;&nbsp;</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>월

                    <input type="hidden" name="min_year_month" class="min_year_month">
                    <input type="hidden" name="max_year_month" class="max_year_month">
                    <input type="hidden" name="sort" class="sort">

                    <span style="cursor: pointer;" onclick="setYMRange_to_thisMonth();">[이번달]</span>
                    <span style="cursor: pointer;" onclick="setYMRange_to_thisYear();">[올해]</span>
                    <span style="cursor: pointer;" onclick="emptyYMRange();">[날짜 비움]</span>

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
                            <!-- ${requestScope.boardTotCnt} -->
                            <!-- HttpServletRequest 객체에 "boardTotCnt" 키 값으로 저장된 데이터를 표현 -->
                            <!-- ModelAndView 객체에 저장되면 HttpServletRequest 객체에도 동일하게 저장된다. -->
                            <!-- ${requestScope.boardTotAllCnt} -->
                            <!-- HttpServletRequest 객체에 "boardTotAllCnt" 키 값으로 저장된 데이터를 표현 -->
                            <!-- ModelAndView 객체에 저장되면 HttpServletRequest 객체에도 동일하게 저장된다. -->

                            &nbsp;&nbsp;&nbsp;&nbsp;

                            <select name="rowCntPerPage" class="rowCntPerPage" onChange="boardSearch( );">
                                <option value="10">10
                                <option value="15">15
                                <option value="20">20
                                <option value="30">30
                            </select> 행보기&nbsp;
                            <span class="newRegBtn" style="cursor:pointer;">[새 글 쓰기]</span>
                        </caption>
                        <tr bgcolor="lightblue">
                            <th>번호</th>
                            <th style="width: 150px;">제목</th>
                            <th>작성자</th>

                            <!-- HttpSession 객체에 mid 키 값의 문자가 abc일 경우 -->
                            <!-- 정렬 가능하게 하기 -->
                            <c:if test="${sessionScope.mid=='abc'}">
                                <th>
                                    <span style="cursor: pointer;" class="sortHeader">
                                        조회수
                                    </span>
                                </th>
                                <th>
                                    <span style="cursor: pointer;" class="sortHeader">
                                        등록일
                                    </span>
                                </th>
                            </c:if>

                            <!-- HttpSession 객체에 mid 키 값의 문자가 abc가 아닐 경우 -->
                            <!-- 정렬 불가능하게 하기 -->
                            <c:if test="${sessionScope.mid!='abc'}">
                                <th>조회수</th>
                                <th>등록일</th>
                            </c:if>

                            <!--
                            <%
                                String mid = (String)session.getAttribute("mid");
                                if(mid!=null){
                                    if(mid.equals("abc")){
                            %>
                                        <th>
                                            <span style="cursor: pointer;" class="sortHeader">
                                                조회수
                                            </span>
                                        </th>
                                        <th>
                                            <span style="cursor: pointer;" class="sortHeader">
                                                등록일
                                            </span>
                                        </th>
                            <%
                                    }else{
                            %>
                                        <th>조회수</th>
                                        <th>등록일</th>
                            <%
                                    }
                                }
                            %>
                            -->
                        </tr>

                        <!-- 
                        <caption>총 개수 : ${requestScope.boardTotCnt }개</caption>

                        <%--
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
                        --%>
                        -->

                        <!-- EL 문법과 C core 태그를 사용하여 -->
                        <!-- HttpServletRequest 객체에 "boardList"라는 키 값으로 저장된 -->
                        <!-- List 객체 안의 다량의 HashMap 객체의 데이터를 꺼내 -->
                        <!-- HTML 태그 사이에 삽입 -->

                        <c:forEach var="board" items="${requestScope.boardList}" varStatus="loopTagStatus">
                            <tr bgcolor="${loopTagStatus.index%2==0?'':'lightgray'}" style="cursor: pointer;" onClick="goBoardDetailForm(${board.b_no})">
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