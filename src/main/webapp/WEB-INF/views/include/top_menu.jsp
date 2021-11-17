<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) response.setHeader("Cache-Control", "no-cache"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.admin{display: inline;}
</style>
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-light bg-light static-top">
		 <div class="container px-5">
		  	<a class="navbar-brand" href="${pageContext.request.contextPath }/">Library</a>
		  	<div>
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<c:if test="${user != 'anonymousUser' }">
					<li class = "nav-item">${user }님 반갑습니다&nbsp&nbsp&nbsp
					<c:if test="${user=='admin'&& msg==null }">
					<!-- 
					<form action="${pageContext.request.contextPath }/admin/admin" method="post" class = "admin">
					<input type="submit" class="btn btn-outline-info btn-sm" value="관리자 페이지" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
					 -->
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/admin/admin">관리자 페이지</a>
					</c:if>
					<c:if test="${msg!=null }">
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/">일반 페이지</a>
					</c:if>
					<c:if test="${msg==null }">
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/member/modify">회원정보수정</a>
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/member/mypage">내서재</a>
					</c:if>
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/user/logout?_csrf=${_csrf.token}">로그아웃</a></li>
					</c:if>
					<c:if test="${user == 'anonymousUser' }">
					<li class = "nav-item">
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/user/join">회원가입</a>
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/user/login">로그인</a></li>
					</c:if>
				</ul>
			</div>
		 </div>
	</nav>
	<!-- 
	<c:url value="/logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<%-- 시큐리티에 있는 로그아웃을 사용하려면 아래의 내용도 넘겨줘야 한다. --%>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="submit" value="로그아웃">
		</form> 
	  -->	
	 <!-- Navigation-->
    <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
        <div class="container">
            <a class="btn" style="background-color: #e3f2fd; color: dodgerblue;" href="${pageContext.request.contextPath }/unified_search">도서 검색</a>

            <div class="dropdown show">
                <a class="btn dropdown-toggle" style="background-color: #e3f2fd; color: dodgerblue;" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    신청 / 참여
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                	<c:if test="${user != 'anonymousUser' }">
	                  <a class="dropdown-item" href="${pageContext.request.contextPath }/member/hopeBook">희망 도서 신청</a>
                	</c:if>
                	<c:if test="${user == 'anonymousUser' }">
                      <a class="dropdown-item disabled">희망 도서 신청</a>
                	</c:if>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/board/freeBoard">자유 게시판</a>
                </div>
            </div>

            <div class="dropdown show">
                <a class="btn dropdown-toggle" style="background-color: #e3f2fd; color: dodgerblue;" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    도서관 이용
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/goodBook">사서 추천 도서</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/newBook">신간 도서</a>
                </div>
            </div>

            <div class="dropdown show">
                <a class="btn dropdown-toggle" style="background-color: #e3f2fd; color: dodgerblue;" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    도서관 정보
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/library_Introduce">도서관 소개</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/notice">공지 사항</a>
                </div>
            </div>
        </div>
    </nav>
</body>
</html>