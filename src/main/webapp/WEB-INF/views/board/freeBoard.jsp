<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[자유게시판]</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/axicon/axicon.min.css" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<script type="text/javascript">
   $(function(){
   
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
<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">자유 게시판</h1>
				</div>
				<br><br>
	<table class="table" style="width: 90%;">
		<tr>
			<td colspan="5" class="title"><b>자유 게시판 - 목록보기</b></td>
		</tr>
		<tr>
			<td colspan="5" class="info" style="text-align: right;">
				${pv.pageInfo }
				<script type="text/javascript">
					$(function(){
						$("#listCount").change(function(){
							var pageSize = $(this).val();
							SendPost("${pageContext.request.contextPath }/board/freeBoard", {"p":${cv.currentPage},"s":pageSize,"b":${cv.blockSize},"keyword":'${cv.keyword}',"type":'${cv.type}'});
						});	
					});
				</script>
				<select id="listCount">
					<option value="5" ${cv.pageSize==5 ? " selected='selected' " : "" }> 5개</option>
					<option value="10" ${cv.pageSize==10 ? " selected='selected' " : "" }>10개</option>
					<option value="20" ${cv.pageSize==20 ? " selected='selected' " : "" }>20개</option>
					<option value="30" ${cv.pageSize==30 ? " selected='selected' " : "" }>30개</option>
					<option value="50" ${cv.pageSize==50 ? " selected='selected' " : "" }>50개</option>
				</select>씩 보기	
			</td>
		</tr>
		<tr>
			<th width="40%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>상세보기</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="5" class="info2">등록된 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center">
					<td style="text-align: left;">
						<c:out value="${vo.free_board_title }"></c:out>
					</td>
					<td>
						<c:out value="${vo.userid}"></c:out>
					</td>
					<td>
						<fmt:formatDate value="${vo.free_board_regdate}" type="date" dateStyle="short"/>
					</td>
					<td>
						<%-- 첨부파일을 다운 받도록 링크를 달아준다. --%>
						<c:if test="${not empty vo.fileList }">
							<c:forEach var="fvo" items="${vo.fileList }">
								<c:url var="url" value="/board/download">
									<c:param name="of" value="${fvo.oriname }"></c:param>
									<c:param name="sf" value="${fvo.savename }"></c:param>
								</c:url>
								<a href="${url }" title="${fvo.oriname }"><span class="material-icons">file_download</span></a>
							</c:forEach>
						</c:if>
					</td>
					<td>
						<a href="#" onclick='SendPost("${pageContext.request.contextPath }/board/fboard_view",{"p":${pv.currentPage },"s":${pv.pageSize },"b":${pv.blockSize },"idx":${vo.free_board_id },"m":"view"},"post")'>
						자세히
						</a>
					</td>
				</tr>		
			</c:forEach>
		</c:if>
		<tr>
			<td style="border: none;text-align: center;" colspan="5">
				${pv.pageList }
			</td>
		</tr>
		<c:if test="${user != 'anonymousUser' }">
		<tr>
			<td class="info" colspan="5" style="text-align: right; border:none">
				<button type="button" class="btn btn-outline-success btn-sm" 
			        onclick='SendPost("${pageContext.request.contextPath }/board/fboard_insertForm",{"p":${pv.currentPage },"s":${pv.pageSize },"b":${pv.blockSize }},"post")'>글쓰기</button>
			</td>
		</tr>
		</c:if>
	</table>	
	<!-- 검색 영역 -->
	    <div class="search_wrap" style="text-align: center;">
	    	<form id="searchForm" action="${pageContext.request.contextPath }/board/freeBoard" method="post">
	    	<div class="search_input">
		   	  	<select name = "type">
		    		<option value = "">--</option>
		    		<option value = "T">제목</option>
		    		<option value = "C">내용</option>
		    		<option value = "I">작성자</option>
		    		<option value = "TC">제목+내용</option>
		    	</select>
	         <input type="text" name="keyword" id = "keyword" maxlength="50"/>
	         <button class='btn btn-primary btn-block' onclick="search();" >검 색</button>                				
	   		</div>
	    	</form>
	    </div>
    </main>
    </div>
    </div>
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
<script type="text/javascript">
	document.oncontextmenu = function() { return false; };
	function search(){
		var keyword = $('#keyword').val();
		keyword = $.trim(keyword);
		$('#keyword').val(keyword);
	}

});
</script>
</body>
</html>