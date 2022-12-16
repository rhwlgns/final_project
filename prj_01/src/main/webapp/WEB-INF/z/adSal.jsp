<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입
<%@ include file="common.jsp" %> -->

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Responsive Viewport & Fixed Scaling -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <title>급여명세서</title>
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
          <span class="icon"><i class="Licon ico-menu"></i></span>
          <span class="icon"><i class="Licon ico-close"></i></span>
        </button>
        <div class="menu-area">
          <div class="menu menu-vertical">
          </div>
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
              <a href="adNotice.do"><span class="label">공지사항</span></a>
            </li>
            <li class="tree-view">
              <a href="#"><span class="label">인사관리</span></a>
              <ul class="tree-view-menu">
                <li><a href="adEmpReg.html"><span class="label">사원등록</span></a></li>
                <li><a href="adUserInfoReg.html"><span class="label">사용자정보등록</span></a></li>
                <li><a href="adEmpList.html"><span class="label">사원명부 및 수정/삭제</span></a></li>
              </ul>
            </li>
            <li class="tree-view">
              <a href="#"><span class="label">급여관리</span></a>
              <ul class="tree-view-menu">
                <li><a href="adSal.do"><span class="label">급여계산</span></a></li>
                <!--<li><a href="#"><span class="label">Menu3-1</span></a></li>--> 
              </ul>
            </li>
          </ul>
        </div>
      </div>

      <div id="contents-wrapper">
        <div class="content-header">
          <div class="content-title-bar">
            <h5>급여계산<button class="btn btn-sm btn-icon"><span class="icon"></span></button></h5>
            <!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
            <div class="tools responsive-except-desktop" >
              <div class="tools-group" style="cursor:none;">
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-datareset"></i></span>
                  <span class="label">조회</span>
                </button>
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-save"></i></span>
                  <span class="label">저장</span>
                </button>
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-add"></i></span>
                  <span class="label">추가</span>
                </button>
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-minus"></i></span>
                  <span class="label">삭제</span>
                </button>
              </div>
          </div>
        </div>
      </div>

      <br><br>

      <!-- 메인 -->

      <!-- 급여계산버튼 -->
      <div class="txt-right margin-right1">
        <a href=""><button class="btn btn-md btn-primary btn-container wth-100">
          <span class="label">급여 계산</span>
        </button></a>
      </div>
      <br><br>

      <!-- 위쪽 탭(select box) -->
      <table border="1" cellspacing="0" style="border-color:rgb(229, 229, 229);" align="center" width="85%;">
        <tr>
          <td>
            <table align="center" width="90%" cellpadding="10" >
              <tr>
                <td width="5%">
                  <label>사업장</label>
                  <td width="10%">
                    <select name="" >           
                      <option value="서울">서울</option>
                      <option value="인천">인천</option>
                      <option value="부산">부산</option>
                    </select>
                  </td>
                </td>

                <td width="5%">
                  <label>귀속년</label>
                  <td width="10%">
                    <select name="">
                      <option value="재직">재직</option>
                      <option value="퇴직">퇴직</option>
                      <option value="휴직">휴직</option>
                    </select>
                  </td>
                </td>

                <td width="5%">
                  <label>귀속월</label>
                  <td width="10%">
                  <select name="">
                    <option value="재직">재직</option>
                    <option value="퇴직">퇴직</option>
                    <option value="휴직">휴직</option>
                  </select>
                  </td>
                </td>
              </tr>

              <tr>
                <td>
                  <label>부서</label>
                  <td>
                    <select name=""> 
                      <option value="UI개발부">UI개발부</option>
                      <option value="DB개발부">DB개발부</option>
                      <option value="암튼개발부">암튼개발부</option>    
                    </select>
                  </td>
                </td>
            
                <td>
                  <label>재직구분</label>
                  <td>
                    <select name="">      
                      <option value="재직">재직</option>
                      <option value="퇴직">퇴직</option>
                      <option value="휴직">휴직</option>
                    </select>
                  </td>
                </td>

                <td>
                  <label>급여제목</label>
                  <td>
                    <input type="text">
                  </td>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>


    <!-- 급여계산 테이블 -->
    <div class="content-body">
      <div class="container">
        <section>
          <div style="height: 444px;">
            <div id="top" class="split">
              <div class="data-table-wrapper">
                <div class="data-table-container">
                  
                  <!-- 총액 테이블 -->
                  <table class="data-table data-table1 data-table-sm">
                    <colgroup></colgroup>
                    <thead>
                    <tr>
                      <th></th>
                      <th class="with-tools">
                        checkbox
                        <div class="tools overflow overflow-sm overflow-right">
                          <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                            <span class="icon"><i></i></span>
                          </button>
                          <div class="overflow-menu">
                            <ul>
                              <li><a href="#" class="overflow-menu-item">없음</a></li>
                              <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                              <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                            </ul>
                          </div>
                        </div>
                      </th>
                      <th class="with-tools">
                        사번
                        <div class="tools overflow overflow-sm overflow-right">
                          <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                            <span class="icon"><i></i></span>
                          </button>
                          <div class="overflow-menu">
                            <ul>
                              <li><a href="#" class="overflow-menu-item">없음</a></li>
                              <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                              <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                            </ul>
                          </div>
                        </div>
                      </th>
                      <th class="with-tools">
                        성명
                        <div class="tools overflow overflow-sm overflow-right">
                          <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                            <span class="icon"><i></i></span>
                          </button>
                          <div class="overflow-menu">
                            <ul>
                              <li><a href="#" class="overflow-menu-item">없음</a></li>
                              <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                              <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                            </ul>
                          </div>
                        </div>
                      </th>
                      <th class="with-tools">
                        부서
                        <div class="tools overflow overflow-sm overflow-right">
                          <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                            <span class="icon"><i></i></span>
                          </button>
                          <div class="overflow-menu">
                            <ul>
                              <li><a href="#" class="overflow-menu-item">없음</a></li>
                              <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                              <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                            </ul>
                          </div>
                        </div>
                      </th>
                      <th class="with-tools">
                        차인지급액
                        <div class="tools overflow overflow-sm overflow-right">
                          <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                            <span class="icon"><i></i></span>
                          </button>
                          <div class="overflow-menu">
                            <ul>
                              <li><a href="#" class="overflow-menu-item">없음</a></li>
                              <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                              <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                            </ul>
                          </div>
                        </div>
                      </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <th>1</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>2</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>3</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>
                        <!-- 체크박스 -->
                        <div class="check_align_vertical col-xs-12 col-md-3">
                          <label class="checker-item">
                            <input type="checkbox"/>
                            <span class="label-group">
                              <span class="icon">
                                  <i class="material-icons">check_box_outline_blank</i>
                                  <i class="material-icons">check_box</i>
                              </span>
                            </span>
                          </label>
                        </div>
                      </td>
                      <td>2020. 4. 6.</td>
                      <td>일반문구텍스트</td>
                      <td>1,415,000</td>
                      <td>180</td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>

            <!-- 지급내역 테이블 -->
            <div id="bottom" class="split">
              <div id="bottom-left" class="split split-horizontal">
                <div class="data-table-wrapper">
                  <div class="data-table-container">
                    <label style="margin-left:60px;"><em class="txt-error">*</em> 지 급 내 역<br></label>
                    <table class="data-table data-table-sm">
                      <colgroup></colgroup>
                      <thead>
                      <tr>
                        <th></th>
                        <th class="with-tools">
                          지급내역
                          <div class="tools overflow overflow-sm overflow-right">
                            <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                              <span class="icon"><i></i></span>
                            </button>
                            <div class="overflow-menu">
                              <ul>
                                <li><a href="#" class="overflow-menu-item">없음</a></li>
                                <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                                <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                              </ul>
                            </div>
                          </div>
                        </th>
                        <th class="with-tools">
                          금 액
                          <div class="tools overflow overflow-sm overflow-right">
                            <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                              <span class="icon"><i></i></span>
                            </button>
                            <div class="overflow-menu">
                              <ul>
                                <li><a href="#" class="overflow-menu-item">없음</a></li>
                                <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                                <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                              </ul>
                            </div>
                          </div>
                        </th>
                      </tr>
                      </thead>
                      <tbody>
                      <tr>
                        <th>1</th>
                        <td>B57828</td>
                        <td>2020. 4. 6.</td>
                      </tr>
                      <tr>
                        <th>2</th>
                        <td>B57828</td>
                        <td>2020. 4. 6.</td>
                      </tr>
                      <tr>
                        <th>3</th>
                        <td>B57828</td>
                        <td>2020. 4. 6.</td>
                      </tr>
                      <tr>
                        <th>4</th>
                        <td>B57828</td>
                        <td>2020. 4. 6.</td>
                      </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>


              <!-- 공제내역 테이블 -->
              <div id="bottom-right" class="split split-horizontal">
                <div class="data-table-wrapper">
                  <div class="data-table-container">
                    <label style="margin-left:60px;"><em class="txt-error">*</em> 공 제 내 역<br></label>
                      <table class="data-table data-table-sm">
                        <colgroup></colgroup>
                        <thead>
                        <tr>
                          <th></th>
                          <th class="with-tools">
                            공제내역
                            <div class="tools overflow overflow-sm overflow-right">
                              <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                                <span class="icon"><i></i></span>
                              </button>
                              <div class="overflow-menu">
                                <ul>
                                  <li><a href="#" class="overflow-menu-item">없음</a></li>
                                  <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                                  <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                                </ul>
                              </div>
                            </div>
                          </th>
                          <th class="with-tools">
                            금 액
                            <div class="tools overflow overflow-sm overflow-right">
                              <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                                <span class="icon"><i></i></span>
                              </button>
                              <div class="overflow-menu">
                                <ul>
                                  <li><a href="#" class="overflow-menu-item">없음</a></li>
                                  <li><a href="#" class="overflow-menu-item">오름차순</a></li>
                                  <li><a href="#" class="overflow-menu-item">내림차순</a></li>
                                </ul>
                              </div>
                            </div>
                          </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                          <th>1</th>
                          <td>B57828</td>
                          <td>2020. 4. 6.</td>
                        </tr>
                        <tr>
                          <th>2</th>
                          <td>B57828</td>
                          <td>2020. 4. 6.</td>
                        </tr>
                        <tr>
                          <th>3</th>
                          <td>B57828</td>
                          <td>2020. 4. 6.</td>
                        </tr>
                        <tr>
                          <th>4</th>
                          <td>B57828</td>
                          <td>2020. 4. 6.</td>
                        </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <script>
              Split(['#top', '#bottom'], {
                direction: 'vertical',
                gutterSize: 12,
                sizes: [50, 50]
              })

              Split(['#bottom-left', '#bottom-right'], {
                gutterSize: 12,
                sizes: [50, 50]
              })
            </script>
          </section>
        </div>
      </div>
      <br><br><br><br><br>
    </div>

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