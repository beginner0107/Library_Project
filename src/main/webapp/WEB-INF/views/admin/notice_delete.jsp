<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
						<div class="card-body">현재 추가 하고자 하는 공지 사항이 존재하는지 미리 확인하세요!</div>
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
					<option value="40" ${cv.pageSize==50 ? " selected='selected' " : "" }>50개</option>
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
 	<!-- 검색 영역 -->
    <div class="search_wrap" style="text-align: center;">
    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/member_list" method="post">
    	<div class="search_input">
	   	  	<select name = "type">
				<option value = "">--</option>
	    		<option value = "N">NO</option>
	    		<option value = "T">제목</option>
	    		<option value = "TC">제목+내용</option>
	    	</select>
         <input type="text" name="keyword" id = "keyword"/>
         <button style="background-color: #0d6efd; color: white; border-radius: 5px; font-size: 10pt">검 색</button>                				
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
								<form action="${pageContext.request.contextPath }/admin/noticeDeleteOk" method="POST">

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
</body>
</html>