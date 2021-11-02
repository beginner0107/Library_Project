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
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script   src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<!-- 다운로드 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
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
<c:import url = "/WEB-INF/views/include/admin_top_menu.jsp"/>	
<!-- ${pv } -->
<table class="table" style="width: 70%;">
		<tr>
			<td colspan="6" class="title">자유 게시판 - 목록보기</td>
		</tr>
		<tr>
			<td colspan="6" class="info" style="text-align: right;">
				${pv.pageInfo }
				<script type="text/javascript">
					$(function(){
						$("#listCount").change(function(){
							var pageSize = $(this).val();
							SendPost("${pageContext.request.contextPath }/board/freeBoard", {"p":${cv.currentPage},"s":pageSize,"b":${cv.blockSize}});
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
			<th>NO</th>
			<th width="40%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>Y/N</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="6" class="info2">등록된 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center">
					<td>
						<c:out value="${vo.free_board_id}"></c:out>
					</td>
					<td align="left" >
						<a href="#" onclick='SendPost("${pageContext.request.contextPath }/board/fboard_view",{"p":${pv.currentPage },"s":${pv.pageSize },"b":${pv.blockSize },"idx":${vo.free_board_id },"m":"view","h":"true"},"post")'><c:out value="${vo.free_board_title }"></c:out></a>
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
						<c:out value="${vo.black}"></c:out>
					</td>
				</tr>		
			</c:forEach>
		</c:if>
		<tr>
			<td style="border: none;text-align: center;" colspan="6">
				${pv.pageList }
			</td>
		</tr>
	</table>	
	<!-- 검색 영역 -->
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
         <button style="background-color: #0d6efd; color: white; border-radius: 5px; font-size: 10pt">검 색</button>                				
   		</div>
    	</form>
    </div>
    <div class="container px-4 px-lg-5">
				<div class="row justify-content-center">
					<div class="card shadow-lg border-5 rounded-lg mt-5">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-4">게시글 공개 여부 수정</h3>
						</div>
						<div class="card-body">
							<form action="${pageContext.request.contextPath }/admin/fboard_blackOk" method="POST">

								<div class="form-floating mb-3">
									<input class="form-control" id="free_board_id" type="text"
										placeholder="회원의 고유 번호를 입력해주세요." name="free_board_id" /> <label
										for="free_board_id">수정을 원하는 게시글의 고유 번호</label>
								</div>

								<label for="black">회원 게시글 관리</label>
								<div class="">
									<select class="form-control form-control-lg"
										id="black" name="black">
										<option>Y</option>
										<option>N</option>
									</select>
								</div>

								<div class="mt-5 mb-0">
									<div class="d-grid">
										<input type="submit" class="btn btn-primary btn-block"
											value="게시글 공개 여부를 수정합니다." />
									</div>
								</div>

							</form>
						</div>
					</div>
				</div>
			</div>
<c:import url="/WEB-INF/views/include/admin_bottom_info.jsp"/>
</body>
</html>