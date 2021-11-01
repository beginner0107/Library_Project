<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>데모도서관</title>
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
	<!-- Navigation-->
	<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
	<section>
		<div>${mvo.username }님의 서재</div><br>
		<div>${bvo }</div>
		<div>회원님의 등급은 ${mvo.rank } 입니다.</div>
		<br>
		<div>회원의 등급 : -1 (대여 불가), 0 (3권 대여), 1 (10권 대여) </div><br>
		<div>빌릴 수 있는 도서의 개수 : ${mvo.rent_available }</div><br><br>
		
		<div>빌린 도서의 목록</div> 
		<br>
		<!-- Page Content-->
		<div class="container px-4 px-lg-5">
			<table class="table" style="width: 90%;">
				<tr>
					<td colspan="6" class="title"><b>자료 검색</b></td>
				</tr>
				<tr>
					<th>ISBN코드</th>
					<th>책제목</th>
					<th>빌린 날짜</th>
					<th>반납 예정 날짜</th>
					<th>반납일 </th>
					<th>연장일 </th>
				</tr>
				<c:if test="${empty rlist}">
				<tr>
					<td colspan="6" class="info2">대여한 이력이 없습니다.</td>
				</tr>
				</c:if>
				<c:if test="${not empty rlist }">
					<c:forEach var="vo" items="${rlist }" varStatus="vs">
						<tr align="center">
							<td>
								<c:out value="${vo.isbn }"></c:out>
							</td>	
							<td>
								<c:out value="${vo.title }"></c:out>
							</td>
							<td>
								<fmt:formatDate value="${vo.rent_date }" type="date" dateStyle="short"/>
							</td>
							<td>
								<fmt:formatDate value="${vo.return_due_date }" type="date" dateStyle="short"/>
							</td>
							<td>
								<fmt:formatDate value="${vo.return_date }" type="date" dateStyle="short"/>
							</td>
							<td>
								<c:out value="${vo.extension_count }"></c:out>
							</td>
						</tr>		
					</c:forEach>
				</c:if>
			</table>
		<br><br>
		<div>반납하기</div>
		<br>
		<form action="${pageContext.request.contextPath }/member/return_bookOk" method="post">
			isbn코드 입력 : <input type = "text" name = "isbn" id = "isbn" placeholder="isbn">
			<input type = "submit" value = "반납" >
		</form>
		<br>
		<div>연장하기</div>
		<br>
		<form action="${pageContext.request.contextPath }/member/extension_book" method="post">
			isbn코드 입력 : <input type = "text" name = "isbn" id = "isbn" placeholder="isbn"><br>
				연장일 :  <input type = "text" name = "extension_count" id = "extension_count" placeholder="최대 3일">
			<input type = "submit" value = "연장" >
		</form>
	</section>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>