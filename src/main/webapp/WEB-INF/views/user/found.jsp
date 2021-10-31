<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${userid!=null }">
	아이디 : ${userid }<br>
	${userid } 으로 로그인해주세요<br>
	<a href = "${pageContext.request.contextPath }/user/login">로그인 화면으로</a>
</c:if>
<c:if test="${email!=null}">
	임시비밀번호가 ${email }로 발송되었습니다.<br>
	<a href = "${pageContext.request.contextPath }/user/login">로그인 화면으로</a>
</c:if>
</body>
</html>