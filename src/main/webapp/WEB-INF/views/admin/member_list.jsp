<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>관리자 - 회원 목록</title>
	 <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
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

    	<!-- Page Content-->
    	<div class="container px-4 px-lg-5">
       	 <!-- Heading Row-->

        	<div id="layoutSidenav_content">
           	 <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">회원</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">회원 목록</li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/admin/member_hope_list">회원
                                희망 도서</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/admin/member_black_list">블랙
								리스트</a></li>
                    </ol>
		                       
		<table class="table" style="width: 90%;">
			<tr>
				<td colspan="8" class="title"><b>도서 목록</b></td>
			</tr>
			<tr>
				<td colspan="8" class="info" style="text-align: right;"><c:out value="${pv.getPageInfo() }"></c:out></td>
			</tr>
			<tr>
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
					<tr align="center">
						<td>
							<c:out value="${vo.userid }"></c:out>
						</td>	
						<td>
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
		    		<option value = "I">아이디</option>
		    		<option value = "N">이름</option>
		    		<option value = "E">이메일</option>
		    		<option value = "R">등급</option>
		    	</select>
	         <input type="text" name="keyword" id = "keyword"/>
	         <button class='btn btn-primary btn-block'>검 색</button>                				
	   		</div>
	    	</form>
	      </div>
        </div>
      </main>
     </div>
    </div>
    
        <c:import url="/WEB-INF/views/include/admin_bottom_info.jsp" />

 
			<!-- Bootstrap core JS-->
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
			<!-- Core theme JS-->
			<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>


			<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
				crossorigin="anonymous"></script>
			<script src="${pageContext.request.contextPath }/resources/js/dataTables.js"></script>
</body>

</html>
