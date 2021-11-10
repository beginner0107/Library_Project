<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% response.setHeader("Cache-Control","no-store"); 
   response.setHeader("Pragma","no-cache"); 
   response.setDateHeader("Expires",0); 
   if (request.getProtocol().equals("HTTP/1.1")) 
	   response.setHeader("Cache-Control", "no-cache"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Row Border in DataGrid - jQuery EasyUI Demo</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<style type="text/css">
	.table {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 90%; 
      margin: auto;
    }  
	* { font-size: 10pt; }
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
	<c:import url="/WEB-INF/views/include/admin_top_menu.jsp" />
	<div class="container-fluid px-4">
		<h1 class="mt-4">회원</h1>
	  <ol class="breadcrumb mb-4">
		<li class = "breadcrumb-item">
		<label>
		<form action="${pageContext.request.contextPath }/admin/member_list" method = "post" style="margin: 0px;" >
			<input type = "submit" value = "회원 목록" style="border: none; background-color: white; text-decoration: underline; color: blue; font-size: 10pt; margin: 0px;" />
		</form>
		</label>
		</li>
		<li class="breadcrumb-item active"><label>회원 희망도서</label></li>
		<li class = "breadcrumb-item">
		<label>
		<form action="${pageContext.request.contextPath }/admin/member_black_list" method = "post" class = "breadcrumb-item" style="margin: 0px;">
			<input type = "submit" value = "블랙리스트" style="border: none; background-color: white; text-decoration: underline; color: blue; font-size: 10pt; margin: 0px;" />
		</form>
		</label>
		</li>
	  </ol>
	 </div>
    	<table class = "table" style="width: 90%">
		<tr>
			<td colspan="8" class="title">회원 목록</td>
		</tr>
		<tr class = "bheader">
			<th>회원아이디</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>가입날짜</th>
			<th>등급</th>
			<th>반납횟수</th>
			<th>대여가능 횟수</th>
		</tr>
		<c:if test="${empty pv.list}">
		<tr>
			<td colspan="8" class="info2">조건에 맞는 회원이 존재하지 않습니다.</td>
		</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center" class = "subject">
					<td>
						<c:out value="${vo.userid }"></c:out>
					</td>	
					<td align="center" >
						<c:out value="${vo.username }"></c:out>
					</td>
					<td>
						<c:out value="${vo.phone }"></c:out>
					</td>
					<td>
						<c:out value="${vo.email }"></c:out>
					</td>
					<td>
						<fmt:formatDate value="${vo.regdate }" type="date" dateStyle="short"/>
					</td>
					<td>
						<c:out value="${vo.rank }"></c:out>
					</td>
					<td>
						<c:out value="${vo.nomal_return }"></c:out>
					</td>
					<td>
						<c:out value="${vo.rent_available }"></c:out>
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
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<c:import url="/WEB-INF/views/include/admin_bottom_info.jsp" />
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
</body>
</html>