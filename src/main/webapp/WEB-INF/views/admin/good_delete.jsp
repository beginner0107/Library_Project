<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 사서추천도서 삭제</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
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
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/admin/good_add">추천 도서 추가</a></li>
						<li class="breadcrumb-item active">추천 도서 삭제</li>
					</ol>
				</div>
					<!--                    도서 목록-->
					<div class="card mb-4">
						<div class="card-body">현재 삭제하고자 하는 사서 추천 도서가 존재하는지 미리 확인하세요!</div>
					</div>
		<table class="table" style="width: 90%;">
			<tr>
				<td colspan="5" class="title"><b>도서 목록</b></td>
			</tr>
			<tr>
				<td colspan="5" class="info" style="text-align: right;"><c:out value="${pv.getPageInfo() }"></c:out></td>
			</tr>
			<tr>
				<th>No</th>
				<th>ISBN</th>
				<th>제목</th>
				<th>등록일자</th>
				<th>해당 도서 페이지</th>
			</tr>
			<c:if test="${empty pv.list}">
			<tr>
				<td colspan="5" class="info2">조건에 맞는 추천도서가 존재하지 않습니다.</td>
			</tr>
			</c:if>
			<c:if test="${not empty pv.list }">
				<c:forEach var="vo" items="${pv.list }" varStatus="vs">
					<tr align="center">
						<td>
							<c:out value="${vo.good_id }"></c:out>
						</td>	
						<td>
							<c:out value="${vo.isbn }"></c:out>
						</td>	
						<td>
							<c:out value="${vo.good_title }"></c:out>
						</td>
						<td>
							<fmt:formatDate value="${vo.good_regdate }" type="date" dateStyle="short"/>
						</td>
						<td>
							<a href = "${pageContext.request.contextPath }/book_detail?isbn=${vo.isbn }">자세히</a>
						</td>
					</tr>		
				</c:forEach>
					<tr>
					<td style="border: none;text-align: center; padding-top: 20px;" colspan="5">
					${pv.pageList }
					</td>
				</tr>
			</c:if>
		</table>
		<!-- 검색 영역 -->
	    <div class="search_wrap" style="text-align: center;">
	    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/good_delete" method="post">
	    	<div class="search_input">
		   	  	<select name = "type">
		    		<option value = "">--</option>
		    		<option value = "I">ISBN</option>
		    		<option value = "T">제목</option>
		    		<option value = "A">작가</option>
		    		<option value = "G">장르</option>
		    	</select>
	         <input type="text" name="keyword" id = "keyword"/>
	         <button class='btn btn-primary btn-block'>검 색</button>           				
	   		</div>
	    	</form>
	    </div>
	   </main>
	  </div>
	 </div>
	 
	 <!--                추천 도서 삭제 파트-->
		<div class="container px-4 px-lg-5">
			<div class="row justify-content-center">
				<div class="card shadow-lg border-5 rounded-lg mt-5">
					<div class="card-header">
						<h3 class="text-center font-weight-light my-4">추천 도서 게시물 삭제</h3>
					</div>
					<div class="card-body">
						<form action="${pageContext.request.contextPath }/admin/goodDeleteOk" method="POST" onsubmit="return goodDeleteCheck()">

							<div class="form-floating mb-3">
								<input class="form-control" id="good_id" type="text"
									placeholder="추천 도서 게시물의 NO 입력해주세요." name="good_id" /> <label
									for="good_id">추천 도서 게시물의 NO</label>
							</div>

							<!--                                    제목-->
							<div class="row mb-3">
								<div class="col-md-6">
									<div class="form-floating mb-3 mb-md-0">
										<input class="form-control" id="good_title" type="text"
											placeholder="제목 명을 입력하십시오." name="good_title" /> <label
											for="good_title">제목</label>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-floating mb-3 mb-md-0">
										<input class="form-control" id="good_title2"
											type="text" placeholder="제목이 맞는지 확인하십시오."
											name="good_title2" /> <label
											for="good_title2">제목 확인</label>
									</div>
								</div>
							</div>

							<div class="mt-5 mb-0">
								<div class="d-grid">
									<input type="submit" class="btn btn-primary btn-block"
										value="추천 도서 게시물을 삭제합니다." />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
<c:import url="/WEB-INF/views/include/admin_bottom_info.jsp"/>
<script type="text/javascript">
function goodDeleteCheck(){
	var good_id = $("#good_id").val().trim();
	if(!good_id && good_id.length==0){
		alert("No에는 공백이 올 수 없습니다.");
		$("#good_id").val("");
		$("#good_id").focus();
		return false;
	}
	var title = $("#good_title").val().trim();
	var title2 = $("#good_title2").val().trim();
	if(title != title2){
		alert("제목이 일치하지 않습니다.");
		$("#good_title").val("");
		$("#good_title2").val("");
		$("#good_title").focus();
		return false;
	}
	if(!title && title.length==0){
		alert("제목을 입력해주세요");
		$("#good_title").val("");
		$("#good_title").focus();
		return false;
	}
	if(!title2 && title2.length==0){
		alert("제목 확인을 입력하지 않았습니다.");
		$("#good_title2").val("");
		$("#good_title2").focus();
		return false;
	}
	
	$("#input[name=good_id]").val(good_id);
	$("#input[name=good_title]").val(title);
	
	return true;
}
</script>
</body>
</html>