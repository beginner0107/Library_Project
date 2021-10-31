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
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script type="text/javascript">
   $(function(){
   
   });
</script>
<style type="text/css">
	table#content{width: 90%; margin: auto;}
	th {border: 1px solid gray; background-color: #e3f2fd;padding: 5px; text-align: center;}
	td {border: 1px solid gray; padding: 5px;}
	td.title {border:none; padding: 5px; text-align: center; font-size: 18pt;}
	td.info {border:none; padding: 5px; text-align: right; }
	td.info2 {border: 1px solid gray; padding: 5px; text-align: center; }
</style>
</head>
<body>
<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
<div>
${pv }
<table id="content">
		<tr>
			<td colspan="5" class="title">자유 게시판 - 목록보기</td>
		</tr>
		<tr>
			<td colspan="5" class="info">
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
			<th>No</th>
			<th width="60%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="5" class="info2">등록된 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center">
					<td>${vo.free_board_id}</td>
					<td align="left" >
						<a href="#" onclick='SendPost("${pageContext.request.contextPath }/board/view",{"p":${pv.currentPage },"s":${pv.pageSize },"b":${pv.blockSize },"idx":${vo.free_board_id },"m":"view","h":"true"},"post")'><c:out value="${vo.free_board_title }"></c:out></a>
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
				</tr>		
			</c:forEach>
			<tr>
				<td style="border: none;text-align: center;" colspan="5">
					${pv.pageList }
				</td>
			</tr>
		</c:if>
		<tr>
			<td class="info" colspan="5">
				<button type="button" class="btn btn-outline-success btn-sm" 
			        onclick='SendPost("${pageContext.request.contextPath }/board/insertForm",{"p":${pv.currentPage },"s":${pv.pageSize },"b":${pv.blockSize }},"post")'>글쓰기</button>
			</td>
		</tr>
	</table>	
</div>
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>