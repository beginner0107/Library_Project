<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여기에는 제목</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script   src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
   $(function(){
   
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
	<!-- Navigation-->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">사서 추천 도서</h1>
				</div>
				<br><br>
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
				<td colspan="5" class="info2">조건에 맞는 회원이 존재하지 않습니다.</td>
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
	    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/member_list" method="post">
	    	<div class="search_input">
		   	  	<select name = "type">
		    		<option value = "">--</option>
		    		<option value = "I">ISBN</option>
		    		<option value = "T">제목</option>
		    		<option value = "A">작가</option>
		    		<option value = "G">장르</option>
		    	</select>
	         <input type="text" name="keyword" id = "keyword"/>
	         <button>검 색</button>                				
	   		</div>
	    	</form>
	    </div>
	   </main>
	  </div>
	 </div>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>