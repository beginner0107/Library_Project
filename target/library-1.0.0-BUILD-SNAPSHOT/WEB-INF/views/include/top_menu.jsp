<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
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
					<c:if test="${user=='admin' }">
					<form action="${pageContext.request.contextPath }/admin/admin" method="post" class = "admin">
					<input type="submit" class="btn btn-outline-info btn-sm" value="관리자 페이지" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
					</c:if>
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/user">회원정보수정</a>
					<a class="btn btn-outline-info btn-sm" href="${pageContext.request.contextPath }/user">내서재</a>
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
	 <!-- Navigation-->
    <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
        <div class="container">
            <a class="btn" style="background-color: #e3f2fd; color: dodgerblue;" href="${pageContext.request.contextPath }/member/unified_search">자료 검색</a>

            <div class="dropdown show">
                <a class="btn dropdown-toggle" style="background-color: #e3f2fd; color: dodgerblue;" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    신청 / 참여
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item disabled" href="/member/member_hope">희망 도서 신청</a>
                    <a class="dropdown-item" href="/board/unified_search">자유 게시판</a>
                </div>
            </div>

            <div class="dropdown show">
                <a class="btn dropdown-toggle" style="background-color: #e3f2fd; color: dodgerblue;" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    도서관 이용
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/good/unified_search">사서 추천 도서</a>
                    <a class="dropdown-item" href="/book/new_unified_search">신간 도서</a>
                </div>
            </div>

            <div class="dropdown show">
                <a class="btn dropdown-toggle" style="background-color: #e3f2fd; color: dodgerblue;" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    도서관 정보
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/library_introduce">도서관 소개</a>
                    <a class="dropdown-item" href="/notice/unified_search">공지 사항</a>
                </div>
            </div>
        </div>
    </nav>
	
</body>
</html>