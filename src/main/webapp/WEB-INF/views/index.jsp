<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>온라인도서관</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<style type="text/css">
a:link {text-decoration: none; color: blue;}
</style>
</head>
<body>
	<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
	
		<!-- Masthead-->
		<header class="masthead">
	        <div class="container position-relative">
	            <div class="row justify-content-center">
	                <div class="col-xl-6">
	                    <div class="text-center text-white">
	                        <!-- Page heading-->
	                        <h1 class="mb-5">Welcome to Library</h1>
	                    </div>
	                </div>
	            </div>
	        </div>
    	</header>
		<!-- Icons Grid-->
		<section class="features-icons bg-light text-center">
			<div class="container">
					<div class="row">
					<div class="col-lg-4">
						<div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
							<table>
							<c:if test="${not empty notice }">
								<tr>
									<td colspan="2" align="center"><b>공지사항</b></td>
								</tr>
								<tr>
									<td colspan="2" align="right"><a href = "${pageContext.request.contextPath }/notice">(+)</a></td>
								</tr>
								<c:forEach var = "vo" items="${notice }" varStatus="vs">
								<tr>
									<td align="left" >
										<a href="#" onclick='SendPost("${pageContext.request.contextPath }/notice_detail",{"idx":${vo.notice_id }},"post")'><c:out value="${vo.notice_title }"></c:out></a>
									</td>
									<td>
										<fmt:formatDate value="${vo.notice_regdate}" type="date" dateStyle="short"/>
									</td>
								</tr>
								</c:forEach>
							</c:if>
							</table>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
							<table>
							<c:if test="${not empty good }">
								<tr>
									<td colspan="2" align="center"><b>사서 추천 도서</b></td>
								</tr>
								<tr>
									<td colspan="2" align="right"><a href = "${pageContext.request.contextPath }/goodBook">(+)</a></td>
								</tr>
								<c:forEach var = "vo" items="${good }" varStatus="vs">
								<tr>
									<td align="left" >
										<a href="#" onclick='SendPost("${pageContext.request.contextPath }/goodBook_detail",{"idx":${vo.good_id }},"post")'><c:out value="${vo.good_title }"></c:out></a>
									</td>
									<td>
										<fmt:formatDate value="${vo.good_regdate}" type="date" dateStyle="short"/>
									</td>
								</tr>
								</c:forEach>
							</c:if>
							</table>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="features-icons-item mx-auto mb-0 mb-lg-3">
							<table>
							<c:if test="${not empty book }">
								<tr>
									<td colspan="2" align="center"><b>신간도서</b></td>
								</tr>
								<tr>
									<td colspan="2" align="right"><a href = "${pageContext.request.contextPath }/newBook">(+)</a></td>
								</tr>
								<c:forEach var = "vo" items="${book }" varStatus="vs">
								<tr>
									<td align="left" >
										<a href="#" onclick='SendPost("${pageContext.request.contextPath }/book_detail",{"isbn":${vo.isbn }},"get")'><c:out value="${vo.title }"></c:out></a>
									</td>
									<td>
										<fmt:formatDate value="${vo.regdate}" type="date" dateStyle="short"/>
									</td>
								</tr>
								</c:forEach>
							</c:if>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Image Showcases-->
		<!-- Footer-->
		<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

</body>
</html>
