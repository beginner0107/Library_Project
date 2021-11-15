<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여기에는 제목</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<!--    회원 정의 추가용-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- 글자제한 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
				<td colspan="8" class="info2">조건에 맞는 도서가 존재하지 않습니다.</td>
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
    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/good_add" method="post">
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
         <button class='btn btn-primary btn-block'>검 색</button>               				
   		</div>
    	</form>
    </div>
			<!--추천 도서 추가 파트-->
			<div class="container px-4 px-lg-5">
				<div class="row justify-content-center">
					<div class="card shadow-lg border-5 rounded-lg mt-5">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-4">추천 도서 추가</h3>
						</div>
						<div class="card-body">
							<form action="${pageContext.request.contextPath }/admin/goodAddOk" method="POST" onsubmit="return goodAddCheck();">
		
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
								<span style="color: #aaa;" id="counter">(0 / 최대 2000자)</span>
		
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
<script type="text/javascript">
$(function(){
	$('#good_content').keyup(function() {
		var content = $(this).val();
		$('#counter').html("(" + content.length + " / 최대2000자)");
		//글자수 실시간 카운팅 
		if (content.length > 2000) {
			alert("최대 2000자까지 입력가능합니다.");
			$(this).val(content.substring(0, 2000));
			$('#counter').html("(2000 / 최대 2000자)");
		}
	}); 
	var inputs = document.getElementsByTagName('input');
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].type == 'text') {
            inputs[i].onchange = function() {
            this.value = this.value.trim();
            }
        }
    }
});
function goodAddCheck(){
	var isbn = $("#isbn").val().trim();
	if(!isbn && isbn.length==0){
		alert("isbn에는 공백이 올 수 없습니다.");
		$("#isbn").val("");
		$("#isbn").focus();
		return false;
	}
	var good_title = $("#good_title").val().trim();
	if(!good_title && good_title.length==0){
		alert("장르에는 공백이 올 수 없습니다.");
		$("#good_title").val("");
		$("#good_title").focus();
		return false;
	}
	var good_content = $("#good_content").val().trim();
	if(!good_content && good_content.length==0){
		alert("도서 제목에는 공백이 올 수 없습니다.");
		$("#good_content").val("");
		$("#good_content").focus();
		return false;
	}
	return true;
}
</script>
</body>
</html>