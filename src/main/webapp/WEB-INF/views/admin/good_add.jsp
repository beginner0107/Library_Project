<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여기에는 제목</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<!--    회원 정의 추가용-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<script type="text/javascript">
	$(function() {

	});
</script>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
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
<c:import url = "/WEB-INF/views/include/admin_top_menu.jsp"/>	
	<!-- 이미 있는 도서 중에서 추천을 해야 함 -->
	<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">사서 추천 도서</h1>
					<ol class="breadcrumb mb-4" style="background-color: white">
						<li class="breadcrumb-item active">추천 도서 추가</li>
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath }/admin/good_delete">추천 도서 삭제</a></li>
					</ol>
				</div>
					<!--                    도서 목록-->
					<div class="card mb-4">
						<div class="card-body">현재 추천하고자 하는 도서가 존재하는지 미리 확인하세요!</div>
					</div>
		<table class="table" style="width: 90%;">
			<tr>
				<td colspan="8" class="title"><b>도서 목록</b></td>
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
				<td colspan="8" class="info2">조건에 맞는 회원이 존재하지 않습니다.</td>
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
		<!-- 검색 영역 -->
   	 <div class="search_wrap" style="text-align: center;">
    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/member_list" method="post">
    	<div class="search_input">
	   	  	<select name = "type">
				<option value = "">--</option>
	    		<option value = "T">제목</option>
	    		<option value = "I">ISBN</option>
	    		<option value = "A">작가</option>
	    		<option value = "P">출판사</option>
	    		<option value = "G">장르</option>
	    	</select>
         <input type="text" name="keyword" id = "keyword"/>
         <button style="background-color: #0d6efd; color: white; border-radius: 5px; font-size: 10pt">검 색</button>                				
   		</div>
    	</form>
    </div>

	<!--                추천 도서 추가 파트-->
	<div class="container px-4 px-lg-5">
		<div class="row justify-content-center">
			<div class="card shadow-lg border-5 rounded-lg mt-5">
				<div class="card-header">
					<h3 class="text-center font-weight-light my-4">추천 도서 추가</h3>
				</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath }/admin/goodAddOk" method="POST">

						<div class="form-floating mb-3">
							<input class="form-control" id="isbn" type="text"
								placeholder="추천 도서 게시물의 ISBN 입력해주세요." name="isbn" /> <label
								for="isbn">추천 도서 게시물의 ISBN</label>
						</div>

						<div class="form-floating mb-3">
							<input class="form-control" id="good_title" type="text"
								placeholder="추천 도서 제목을 입력해주세요." name="good_title" /> <label
								for="good_title">추천 도서를 멋지게 설명할 주제 제목</label>
						</div>

						<div class="form-group">
							<textarea class="form-control" id="good_content"
								placeholder="추천 도서 내용을 입력해주세요." rows="10"
								name="good_content"></textarea>
						</div>
						<div id="inputGoodContentCount">(0 / 1000)</div>

						<div class="mt-5 mb-0">
							<div class="d-grid">
								<input type="submit" class="btn btn-primary btn-block"
									value="추천 도서를 추가합니다." />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</main>
	</div>
	</div>
	<c:import url="/WEB-INF/views/include/admin_bottom_info.jsp"/>
</body>
</html>