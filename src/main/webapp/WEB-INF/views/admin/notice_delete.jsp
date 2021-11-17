<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[공지사항 삭제]</title>
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
	<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->
		<main>
		<div id="layoutSidenav_content">
				<div class="container-fluid px-4">
					<h1 class="mt-4">공지사항</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active"><a href = "${pageContext.request.contextPath }/admin/notice_add">공지 사항 추가</a></li>
						<li class="breadcrumb-item active">
						공지 사항 삭제</li>
					</ol>

					<!--                    공지 사항 목록-->
					<div class="card mb-4">
						<div class="card-body">현재 삭제 하고자 하는 공지 사항이 존재하는지 미리 확인하세요!</div>
					</div>
									<table class="table">
		<tr>
			<td colspan="4" class="info" style="text-align: right;">
				${pv.pageInfo }
				<script type="text/javascript">
					$(function(){
						$("#listCount").change(function(){
							var pageSize = $(this).val();
							SendPost("${pageContext.request.contextPath }/admin/notice_add", {"p":${cv.currentPage},"s":pageSize,"b":${cv.blockSize}});
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
		<tr style="text-align: center">
			<th>NO</th>
			<th width="40%">제목</th>
			<th>작성일</th>
			<th>상세보기</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="4" class="info2">등록된 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center">
					<td>
						<c:out value="${vo.notice_id}"></c:out>
					</td>
					<td align="left" >
						<c:out value="${vo.notice_title }"></c:out>
					</td>
					<td>
						<fmt:formatDate value="${vo.notice_regdate}" type="date" dateStyle="short"/>
					</td>
					<td>
						<a href="#" onclick='SendPost("${pageContext.request.contextPath }/notice_detail",{"p":${pv.currentPage },"s":${pv.pageSize },"b":${pv.blockSize },"idx":${vo.notice_id }},"post")'>자세히</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<tr>
			<td style="border: none;text-align: center;" colspan="4">
				${pv.pageList }
			</td>
		</tr>
	</table>	
 	<!-- 검색 영역 -->
    <div class="search_wrap" style="text-align: center;">
    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/notice_delete" method="post">
    	<div class="search_input">
	   	  	<select name = "type">
				<option value = "">--</option>
	    		<option value = "N">NO</option>
	    		<option value = "T">제목</option>
	    		<option value = "TC">제목+내용</option>
	    	</select>
         <input type="text" name="keyword" id = "keyword"/>
         <button class='btn btn-primary btn-block'>검 색</button>             				
   		</div>
    	</form>
    </div>
					</div>
				</div>

				<div class="container px-4 px-lg-5">
					<div class="row justify-content-center">
						<div class="card shadow-lg border-5 rounded-lg mt-5">
							<div class="card-header">
								<h3 class="text-center font-weight-light my-4">공지 사항 삭제</h3>
							</div>
							<div class="card-body">
								<form action="${pageContext.request.contextPath }/admin/noticeDeleteOk" method="POST" onsubmit="return noticeDeleteCheck()">

									<!--                                    NO확인-->
									<div class="row mb-3">
										<div class="col-md-6">
											<div class="form-floating mb-3 mb-md-0">
												<input class="form-control" id="notice_id" type="text"
													placeholder="번호를 입력하십시오." name="notice_id" /> <label for="notice_id">NO</label>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-floating mb-3 mb-md-0">
												<input class="form-control" id="notice_id2"
													type="text" placeholder="번호가 맞는지 확인하십시오." name="notice_id2" /> <label
													for="notice_id2">No 확인</label>
											</div>
										</div>
									</div>

									<div class="mt-5 mb-0">
										<div class="d-grid">
											<input type="submit" class="btn btn-primary btn-block"
												value="공지 사항을 삭제합니다." />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

			</main>
		</div>
<c:import url="/WEB-INF/views/include/admin_bottom_info.jsp" />
<script type="text/javascript">
function noticeDeleteCheck(){
	var notice_id = $("#notice_id").val().trim();
	var notice_id2 = $("#notice_id2").val().trim();
	if(notice_id != notice_id2){
		alert("번호가 일치하지 않습니다.");
		$("#notice_id").val("");
		$("#notice_id2").val("");
		$("#notice_id").focus();
		return false;
	}
	if(!notice_id && notice_id.length==0){
		alert("No가 비어있습니다");
		$("#notice_id").val("");
		$("#notice_id").focus();
		return false;
	}
	if(!notice_id2 && notice_id2.length==0){
		alert("No 확인이 비어있습니다");
		$("#notice_id2").val("");
		$("#notice_id2").focus();
		return false;
	}
}
</script>
</body>
</html>