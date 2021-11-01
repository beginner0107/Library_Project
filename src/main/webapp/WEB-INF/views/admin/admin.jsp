<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% response.setHeader("Cache-Control","no-store"); 
   response.setHeader("Pragma","no-cache"); 
   response.setDateHeader("Expires",0); 
   if (request.getProtocol().equals("HTTP/1.1")) 
	   response.setHeader("Cache-Control", "no-cache"); %>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>도서관</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" type="text/css" />
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
	<c:import url = "/WEB-INF/views/include/admin_top_menu.jsp"/>	
	    <!-- Page Content-->
    <div class="container px-4 px-lg-5">
        <!-- Heading Row-->
        <div class="row gx-4 gx-lg-5 align-items-center my-5">
            <div class="col-lg-7"><img class="img-fluid rounded mb-4 mb-lg-0" /></div>
            <div class="col-lg-5">
                <h1 class="font-weight-light">Library<br /> 관리자 페이지</h1>
                <p>관리자님 안녕하세요! <br /> 관리자님의 행복한 하루를 기원합니다.</p>
            </div>
        </div>

        <!--    도서 / 알림 / 회원 모음집 섹션 -->

        <div class="container my-5 py-4 text-center">
            <div class="card text-center">
                <div class="card-header">
                    <ul class="nav nav-tabs card-header-tabs" id="tabs">
                        <li class="nav-item">
                            <a class="nav-link active" href="#nav_Book" data-toggle="tab">도서</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#nav_Alarm" data-toggle="tab">알림</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#nav_Member" data-toggle="tab">회원</a>
                        </li>
                    </ul>
                </div>
                <div class="card-body">
                    <div class="tab-content">
                        <div class="tab-pane active" id="nav_Book">
                            <!--                        도서-->
                            <div class="card-group">
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">도서 추가/삭제</h5>
                                        <p class="card-text">도서 시스템에<br /> <b>도서를 추가/삭제</b>하는 기능을 이용합니다.</p>
                                        <a href="${pageContext.request.contextPath }/admin/book_add" class="btn btn-primary">도서 추가</a>
                                         <a href="${pageContext.request.contextPath }/admin/book_delete" class="btn btn-primary">도서 삭제</a>
                                    </div>
                                </div>
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">도서 수정</h5>
                                        <p class="card-text">도서 시스템에<br /> <b>도서의 정보를 수정</b>하는 기능을 이용합니다.</p>
                                        <a href="${pageContext.request.contextPath }/admin/book_update" class="btn btn-primary">도서 수정</a>
                                    </div>
                                </div>
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">연체 도서</h5>
                                        <p class="card-text">도서 시스템에<br /> <b>연체된 도서 정보를</b> 보는 기능을 이용합니다.</p>
                                        <a href="/admin/book/overdue" class="btn btn-primary">연체 도서</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="nav_Alarm">
                            <!--                        알림-->
                            <div class="card-group">
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">공지사항</h5>
                                        <p class="card-text">도서 시스템의<br /> <b>공지사항 게시판</b>을 관리합니다.</p>
                                        <a href="/admin/alarm/notice/notice_add" class="btn btn-primary">공지 사항 추가</a>
                                        <a href="/admin/alarm/notice/notice_delete" class="btn btn-primary">공지 사항 삭제</a>
                                    </div>

                                </div>
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">사서 추천 도서</h5>
                                        <p class="card-text">도서 시스템의<br /> <b>사서 추천 도서 게시판</b>을 관리합니다.</p>
                                        <a href="/admin/alarm/good/good_add" class="btn btn-primary">추천 도서 추가</a>
                                        <a href="/admin/alarm/good/good_delete" class="btn btn-primary">추천 도서 삭제</a>
                                    </div>

                                </div>
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">자유 게시판 관리</h5>
                                        <p class="card-text">도서 시스템의<br /> <b>자유 게시판 게시물</b>을 관리합니다.</p>
                                        <a href="/admin/alarm/board/board_update" class="btn btn-primary">게시물 비공개 설정</a>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="nav_Member">
                            <!--                        회원회원회원회원-->
                            <div class="card-group">
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">회원 목록</h5>
                                        <p class="card-text">도서 시스템의<br /> <b>전체 회원 목록</b>을 확인합니다.</p>
                                        <form action="${pageContext.request.contextPath }/admin/member_list" method = "post">
                                        <input type= "submit" class = "btn btn-primary" value = "회원 목록"/>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </form>
                                    </div>
                                </div>
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">회원 희망 도서</h5>
                                        <p class="card-text">회원들이 신청한<br /> <b>희망 도서</b>를 확인합니다.</p>
                                        <form action="${pageContext.request.contextPath }/admin/member_good_list" method = "post">
                                        <input type= "submit" class = "btn btn-primary" value = "회원 희망 도서"/>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </form>
                                    </div>
                                </div>
                                <div class="card" style="width: 18rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">회원 블랙리스트 관리</h5>
                                        <p class="card-text">도서 시스템의<br /> <b>블랙리스트 회원 정보</b>를 관리합니다.</p>
                                        <form action="${pageContext.request.contextPath }/admin/member_black_list" method = "post">
                                        <input type= "submit" class = "btn btn-primary" value = "회원 블랙리스트 관리"/>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<!-- Footer-->
		<c:import url="/WEB-INF/views/include/admin_bottom_info.jsp"/>

		<!-- Bootstrap core JS-->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Core theme JS-->
		<script
			src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
		<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
		<!-- * *                               SB Forms JS                               * *-->
		<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
		<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
</body>
</html>
