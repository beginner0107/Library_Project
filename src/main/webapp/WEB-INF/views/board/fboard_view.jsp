<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var = "root" value =  "${pageContext.request.contextPath }/" />
<fmt:requestEncoding value="UTF-8"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Library</title>
<!--  엑시콘사용 : 다운로드받은 폴더를 넣고 CSS파일을 읽는다. -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/axicon/axicon.min.css" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- CDN 한글화 -->
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />

<script>
	$(function(){
		$('#content').summernote(
				{
					lang : 'ko-KR', // default: 'en-US'
					height : 200, // set editor height
					minHeight : null, // set minimum height of editor
					maxHeight : null, // set maximum height of editor
					fontNames : [ '맑은고딕', 'Arial', 'Arial Black',
							'Comic Sans MS', 'Courier New', ],
					fontNamesIgnoreCheck : [ '맑은고딕' ],
					focus : true,
					callbacks : {
						onImageUpload : function(files, editor, welEditable) {
							for (var i = files.length - 1; i >= 0; i--) {
								sendFile(files[i], this);
							}
						}
					}
				});
		$('#content').summernote('disable');
		/*
		// 서머노트에 text 쓰기
		$('#summernote').summernote('insertText', 써머노트에 쓸 텍스트);
		// 서머노트 쓰기 비활성화
		$('#summernote').summernote('disable');
		// 서머노트 쓰기 활성화
		$('#summernote').summernote('enable');
		// 서머노트 리셋
		$('#summernote').summernote('reset');
		// 마지막으로 한 행동 취소 ( 뒤로가기 )
		$('#summernote').summernote('undo');
		// 앞으로가기
		$('#summernote').summernote('redo');
		*/
	});
	function sendFile(file, el) {
		var form_data = new FormData();
	  	form_data.append('file', file);
	  	$.ajax({
	    	data: form_data,
	    	type: "POST",
	    	url: '${pageContext.request.contextPath}/board/imageUpload',
	    	cache: false,
	    	contentType: false,
	    	enctype: 'multipart/form-data',
	    	processData: false,
	    	success: function(img_name) {
	      		$(el).summernote('editor.insertImage', img_name);
	    	},
	    	error : function(){
	    		alert('에러!!!');
	    	}
	  	});
	}
	//-----------------------------------------------------------------------------------------------------------
	// 돌아가기버튼 클릭시 사용할 함수
	function goBack(){
	SendPost("${pageContext.request.contextPath}/board/freeBoard", {"p":${cv.currentPage},"s":${cv.pageSize},"b":${cv.blockSize}});
	}
	function goUpdate(){
		SendPost("${pageContext.request.contextPath}/board/fboard_update", {"p":${cv.currentPage},"s":${cv.pageSize},"b":${cv.blockSize},"idx":${cv.idx}});
	}
	function goDelete(){
		SendPost("${pageContext.request.contextPath}/board/fboard_delete", {"p":${cv.currentPage},"s":${cv.pageSize},"b":${cv.blockSize},"idx":${cv.idx}});
	}
</script>
<style type="text/css">
	table#main_content{width: 80%; margin: auto;}
	th {border: 1px solid gray; background-color: #e3f2fd;padding: 5px; text-align: center;}
	td {border: 1px solid gray; padding: 5px;}
	td.title {border:none; padding: 5px; text-align: center; font-size: 18pt; }
	td.info {border:none; padding: 5px; text-align: right; }
	td.info2 {border: 1px solid gray; padding: 5px; text-align: center; }
	.fileItem { margin-bottom: 3px;}
	td.title2 {color : dodgerblue;}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<div class="container mt-5">
            <!--        중앙정렬-->
            <div class="row">
                <div class="col-lg-12">
                    <!-- Post content-->
                    <article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <h1 class="fw-bolder mb-1">${fv.free_board_title}</h1>
                            <!-- Post meta content-->
                            <div class="text-muted fst-italic mb-2"><fmt:formatDate value="${fv.free_board_regdate }" pattern="yyyy년 MM월 dd일(E) hh:mm:ss"/></div>

                            <!-- Post categories -->
                            <div class="badge bg-secondary text-decoration-none link-light">회원 아이디 : ${fv.userid}</div>
                        </header>
                        <!-- Post content-->
                        <section class="mb-5">
                            <p class="fs-5 mb-4">${fv.free_board_content}</p>
                        </section>
                        <div>
                        <%-- 첨부파일을 다운 받도록 링크를 달아준다. --%>
						<c:if test="${not empty fv.fileList }">
							<c:forEach var="fvo" items="${fv.fileList }">
								<c:url var="url" value="/board/download">
									<c:param name="of" value="${fvo.oriname }"></c:param>
									<c:param name="sf" value="${fvo.savename }"></c:param>
								</c:url>
								<a href="${url }" title="${fvo.oriname }"><i class="${root }resources/axi axi-download2"></i> ${fvo.oriname}</a><br />
							</c:forEach>
						</c:if>
                        </div>
                        <br><br>
                    </article>
                    <table class="table">
                    <tr>
                    	<td style="text-align: right; border: none">
                     <input type="button" value=" 돌아가기 " class="btn btn-outline-success btn-sm" onclick="goBack()" />
						<c:if test="${user!='anonymousUser' && prohibition!=null }">
							<input type="button" value=" 수정하기 " class="btn btn-outline-success btn-sm" onclick="goUpdate()"/>
							<input type="button" value=" 삭제하기 " class="btn btn-outline-success btn-sm" onclick="goDelete()"/>
						</c:if>
                        </td>
                    </tr>
                    </table>
                         <!-- Comments section-->
                    <section class="mb-5">
                        <div class="card bg-light">
                            <div class="card-body">
                                <!-- Comment form-->
                                <!--
                            <form class="mb-4">
                                <textarea class="form-control" rows="3" placeholder="Join the discussion and leave a comment!"></textarea>
                            </form>
-->
                                <!-- 							댓글 추가 창 -->
                                <div class="mb-3">
                                    <div class="card">
                                        <div class="card-header">
                                            <h3 class="text-center font-weight-light my-2">댓글</h3>
                                        </div>
                                        <div class="card-body">
                                            <form action="/board/board_detail?boardID=${boardDTO.boardID}" method="POST">

                                                <div class="form-group">
                                                    <textarea class="form-control" id="inputCommentContent" placeholder="댓글을 입력해주세요." rows="3" name="inputCommentContent"></textarea>
                                                </div>
                                                <div id="inputCommentContentCount">(0 / 1000)</div>

                                                <div class="mt-4 mb-0">
                                                    <div class="d-grid">
                                                        <input type="submit" class="btn btn-primary btn-block" value="댓글 추가" />
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!--                             댓글 나오는 창-->
                                <c:forEach var="commentDTO" items="${commentDTOList}">
                                <div class="d-flex mb-4 ">
                                    <!-- Parent comment-->
                                    <div class="ms-3">
                                        <div class="fw-bold">${commentDTO.commentName}</div>
                                        ${commentDTO.commentContent}
                                    </div>
                                </div>
                                </c:forEach>
                                <!-- Single comment-->
                            </div>
                        </div>
                    </section>
                </div>
                </div>
                </div>
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>