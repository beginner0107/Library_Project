<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script   src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<!-- 다운로드 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;}
</style>
</head>
<body>
	<!-- Navigation-->
	<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
        <div class="container mt-5">
            <!--        중앙정렬-->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Post content-->
                    <article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <h1 class="fw-bolder mb-1">${nvo.notice_title}</h1>
                            <!-- Post meta content-->
                            <div class="text-muted fst-italic mb-2"><fmt:formatDate value="${nvo.notice_regdate}" type="date" dateStyle="short"/></div>
                            <!-- Post categories -->
                        </header>
                        <!-- Post content-->
                        <section class="mb-5" style="font-size: 15pt">
                        	<pre><c:out value="${nvo.notice_content }" /></pre>
                        </section>
                    </article>
                </div>
            </div>
        </div>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>