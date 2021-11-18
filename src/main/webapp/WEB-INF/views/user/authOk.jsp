<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 도서관 - 인증</title>
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
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<script type="text/javascript">
	$(function(){
	
	});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<div style="text-align: center;">
	<h2>${authvo.username }(${authvo.userid })님 인증에 성공했습니다.</h2> 
	<h2>${authvo.username }님 로그인 하셔서 즐거운 시간되십시요!!</h2>
	<a href="${pageContext.request.contextPath }/">홈으로</a> 
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>