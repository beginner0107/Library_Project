<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>데모도서관</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" type="text/css" />
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
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
	<!-- Navigation-->
	<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
	<!-- Page Content-->
    <div class="container px-4 px-lg-5">
    	<div class="row gx-4 gx-lg-5 align-items-center my-5">
            <div class="col-lg-5">
                <h1 class="font-weight-light">Library<br /> My Page</h1>
                	   <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href = "${pageContext.request.contextPath }/member/mypage">대여 도서 목록</a></li>
                        <li class="breadcrumb-item active">대여 했던 도서 목록</li>
        	     	   </ol>
                <p>
                ${mvo.username }님 안녕하세요! <br /> 
                ${mvo.username }님의 행복한 하루를 기원합니다.<br /> <br /> 
                저희 도서관은 정상 반납한 횟수와 연체 반납 횟수를 종합해 계산하여 회원님이 대여하실 수 있는 도서의 권수를 조정해드립니다.
                </p>
            </div>
        </div>
	   
        <!-- Heading Row-->

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">대여 도서</h1>
		<br><br>

       	<table class="table">
		<tr>
			<td colspan="5" class="info" style="text-align: right;">
				${pv.pageInfo }
				<script type="text/javascript">
					$(function(){
						$("#listCount").change(function(){
							var pageSize = $(this).val();
							SendPost("${pageContext.request.contextPath }/member/mypage_borrowedList", {"p":${cv.currentPage},"s":pageSize,"b":${cv.blockSize}});
						});	
					});
				</script>
				<select id="listCount">
					<option value="5" ${cv.pageSize==5 ? " selected='selected' " : "" }> 5개</option>
					<option value="10" ${cv.pageSize==10 ? " selected='selected' " : "" }>10개</option>
					<option value="20" ${cv.pageSize==20 ? " selected='selected' " : "" }>20개</option>
					<option value="30" ${cv.pageSize==30 ? " selected='selected' " : "" }>30개</option>
					<option value="40" ${cv.pageSize==50 ? " selected='selected' " : "" }>50개</option>
				</select>씩 보기	
			</td>
		</tr>
		<tr style="text-align: center">
			<th>회원 아이디</th>
			<th>isbn</th>
			<th>도서 제목</th>
			<th>빌린 날짜</th>
			<th>반납 일</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="5" class="info2">대여한 책이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center">
					<td>
						<c:out value="${vo.userid}"></c:out>
					</td>
					<td>
						<c:out value="${vo.isbn}"></c:out>
					</td>
					<td>
						<c:out value="${vo.title}"></c:out>
					</td>
					<td>
						<fmt:formatDate value="${vo.rent_date}" type="date" dateStyle="short"/>
					</td>
					<td>
						<fmt:formatDate value="${vo.return_date}" type="date" dateStyle="short"/>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<tr>
			<td style="border: none;text-align: center;" colspan="5">
				${pv.pageList }
			</td>
		</tr>
	</table>	
			<!-- 검색 영역 -->
	    <div class="search_wrap" style="text-align: center;">
	    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/member_list" method="post">
	    	<div class="search_input">
		   	  	<select name = "type">
		    		<option value = "">--</option>
		    		<option value = "I">ISBN</option>
		    		<option value = "T">제목</option>
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
	<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>