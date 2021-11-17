<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>온라인도서관 - 신간도서</title>
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
<script type="text/javascript">
	$(function() {

	});
</script>
<style type="text/css">
	.table {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 90%; 
      margin: auto;
    }  
	.table th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
    .table th, .table td {
      padding: 10px;
      border: 1px solid #ddd;
    }
    .table th:first-child, .table td:first-child {
      border-left: 0;
    }
    .table th:last-child, .table td:last-child {
      border-right: 0;
    }
    .table tr td:first-child{
      text-align: center;
    }
	body{font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">신간 도서</h1>
				</div>
				<br><br>
		<div style="overflow-x:auto;">
		<table class="table">
			<tr>
				<td colspan="8" class="title"><b>신간 도서 목록</b></td>
			</tr>
			<tr>
				<td colspan="8" class="info" style="text-align: right;"><c:out value="${pv.getPageInfo() }"></c:out></td>
			</tr>
			<tr>
				<th>ISBN</th>
				<th>제목</th>
				<th>작가</th>
				<th>출판사</th>
				<th>장르</th>
				<th>권수</th>
				<th>등록일자</th>
				<th>해당 도서 페이지</th>
			</tr>
			<c:if test="${empty pv.list}">
			<tr>
				<td colspan="8" class="info2">신간도서가 없습니다.</td>
			</tr>
			</c:if>
			<c:if test="${not empty pv.list }">
				<c:forEach var="vo" items="${pv.list }" varStatus="vs">
					<tr align="center">
						<td>
							<c:out value="${vo.isbn }"></c:out>
						</td>	
						<td>
							<c:out value="${vo.title }"></c:out>
						</td>
						<td>
							<c:out value="${vo.author }"></c:out>
						</td>
						<td>
							<c:out value="${vo.publisher }"></c:out>
						</td>
						<td>
							<c:out value="${vo.genre }"></c:out>
						</td>
						<td>
							<c:out value="${vo.count }"></c:out>
						</td>
						<td>
							<fmt:formatDate value="${vo.regdate }" type="date" dateStyle="short"/>
						</td>
						<td>
							<a href = "${pageContext.request.contextPath }/book_detail?isbn=${vo.isbn }">자세히</a>
						</td>
					</tr>		
				</c:forEach>
					<tr>
					<td style="border: none;text-align: center; padding-top: 20px;" colspan="8">
					${pv.pageList }
					</td>
				</tr>
			</c:if>
		</table>
		</div>
	</main>
	</div>
	</div>
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>