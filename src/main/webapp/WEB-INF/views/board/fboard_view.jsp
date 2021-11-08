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
							<input type = "hidden" id = "free_board_id" name = "free_board_id" value ="${fv.free_board_id }"/>
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
                 </div>
               </div>
                   <!-- Comments section-->
				<div class="container mt-5">
		            <!--        중앙정렬-->
		            <div class="row">
		        <section class="mb-5">
		                  <div class="card bg-light">
		     	               <div class="card-body">
		                     <!-- Comment form-->
		                                <!-- 댓글 추가 창 -->
		                                <div class="mb-3">
		                                    <div class="card">
		                                        <div class="card-header">
		                                            <h3 class="text-center font-weight-light my-2">한줄평</h3>
		                                        </div>
		                                        <div class="card-body">
		                                                <div class="form-group">
			                                                    <textarea class="form-control" id="content" placeholder="댓글을 입력해주세요." rows="3" name="content" readonly="readonly"></textarea>
		                                                </div>
			                                                     <div class="mt-5 mb-0">
		                                                    <div class="d-grid">
		                                                        <button id = "reply_save" name = "reply_save" class="btn btn-primary btn-block">댓글 등록</button>
		                                                    </div>
		                                                	</div>
		                                        </div>
		                                    </div>
		                                </div>
		
		                                <!--                             댓글 나오는 창-->
		               <div id = "reply_area">
		               </div>
		              </div>
		             </div>
		          </section>
				</div>
				</div>
                </div>
              
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script type="text/javascript">
		function updateReply(fboard_reply_id){
			var content = $("#replyContent"+fboard_reply_id).val();
			console.log(content);
			var breply = "replyContent"+fboard_reply_id;
			$('textarea[name='+breply+']').attr("readonly",false);
			$('textarea[name='+breply+']').focus();
			$('input[name=updateReplyOk'+fboard_reply_id+']').css("display", "inline");
			$('input[name=cancle'+fboard_reply_id+']').css("display", "inline");
			//$("textarea").attr('readonly', false);
		}
		function cancle(breply_id){
			//$('input[name=updateReplyOk'+breply_id+']').css("display", "none");
			//$('input[name=cancle'+breply_id+']').css("display", "none");
			//$('textarea[name=breply_content'+breply_id+']').attr("readonly","readonly");
			loadReply();
		}

	</script>
	<script type="text/javascript">
	$(function() {
		loadReply();
		var staus = false;
		// 댓글 저장
		$("#content").click(function(){
			var userid = '${user}';
			if(userid == 'anonymousUser'){
				alert('로그인 해야 이용 가능합니다');
			}else{
				$("#content").attr("readonly", false);
			}
		});
		
		$("#reply_save").click(function(){
			if($("#content").val().trim()==""){
				alert("댓글 내용을 입력하세요");
				$("#content").focus();
				return false;
			}
			
						
			var freeBoardReplyVO = {};
			
			freeBoardReplyVO.free_board_id = $("#free_board_id").val();
			freeBoardReplyVO.fboard_reply_content = $("#content").val();
			alert(freeBoardReplyVO.free_board_id);
			alert(freeBoardReplyVO.fboard_reply_content);
			//ajax 호출
	        $.ajax({
	            url         :   "${pageContext.request.contextPath}/member/fboardReplyOk",
	            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	            type        :   "post",
	            data        :   freeBoardReplyVO,
	            success     :   function(){ // 객체로 받는다 . data -> bookReplyVO
	        		//alert('댓글 등록 성공!')
	            	loadReply();
	         		// 댓글 초기화 해준다.
	                 $("#content").val("");
	                return false;
	        		}
	            ,
	            error : function(request, status, error){
	                console.log("AJAX_ERROR");
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
	        });
		})
		function loadReply(){
			var free_board_id = parseInt($("#free_board_id").val());
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/member/fboardList",
				data : {free_board_id : free_board_id},
				dataType : "json",
				success : function(data){
					//console.log(data.list);
					//let str = JSON.stringify(data.list);
					//alert(str);
					console.log(data);
					var userid = "${user}";
					var replyList = '<div id = "reply_area">';
					for(var i = 0; i<data.length; i++){
						replyList += '<div class="d-flex mb-4 ">';
						replyList += '<div class="ms-3" style = "width : 90%;">';
						replyList += '<div class="fw-bold">'+data[i].userid+' / '+data[i].fboard_reply_regdate+'&nbsp&nbsp&nbsp';
						if(userid != "anonymousUser" && userid == data[i].userid){
						replyList += '<input type = "button" onclick="updateReply('+data[i].fboard_reply_id+')" value = "수정" style="text-align: right;"/>&nbsp';
						replyList += '<input type = "button" onclick="deleteReplyOk('+data[i].fboard_reply_id+')" value = "삭제" style="text-align: right;"/>';
						replyList += '<input type = "button" value = "취소하기" onclick = "cancle('+data[i].fboard_reply_id+');" id = "cancle'+data[i].fboard_reply_id+'" name = "cancle'+data[i].fboard_reply_id+'" style="text-align: right; display: none;"/>';
						}
						replyList += '</div>';
						replyList += '<textarea id = "replyContent'+data[i].fboard_reply_id+'" name = "replyContent'+data[i].fboard_reply_id+'" readonly = "readonly" style = "border: none; width : 100%; resize: none; background-color : #f8f9fa;">'
						replyList += data[i].fboard_reply_content+'</textarea></div>';
						replyList += '&nbsp&nbsp&nbsp&nbsp<input type = "button" onclick="updateReplyOk('+data[i].fboard_reply_id+')" value = "수정하기" id = "updateReplyOk'+data[i].fboard_reply_id+'" name = "updateReplyOk'+data[i].fboard_reply_id+'" style="text-align: center; display:none;"/></div>';
					}
					replyList += '</div>'
					$('#reply_area').html(replyList);
					return false;
				},
				error : function(request, status, error){
					//alert('댓글 불러오기 에러 발생');
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
			}
	});	
	function loadReply(){
		var free_board_id = parseInt($("#free_board_id").val());
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/member/fboardList",
			data : {free_board_id : free_board_id},
			dataType : "json",
			success : function(data){
				//console.log(data.list);
				//let str = JSON.stringify(data.list);
				//alert(str);
				console.log(data);
				var userid = "${user}";
				var replyList = '<div id = "reply_area">';
				for(var i = 0; i<data.length; i++){
					replyList += '<div class="d-flex mb-4 ">';
					replyList += '<div class="ms-3" style = "width : 90%;">';
					replyList += '<div class="fw-bold">'+data[i].userid+' / '+data[i].fboard_reply_regdate+'&nbsp&nbsp&nbsp';
					if(userid != "anonymousUser" && userid == data[i].userid){
					replyList += '<input type = "button" onclick="updateReply('+data[i].fboard_reply_id+')" value = "수정" style="text-align: right;"/>&nbsp';
					replyList += '<input type = "button" onclick="deleteReplyOk('+data[i].fboard_reply_id+')" value = "삭제" style="text-align: right;"/>';
					replyList += '<input type = "button" value = "취소하기" onclick = "cancle('+data[i].fboard_reply_id+');" id = "cancle'+data[i].fboard_reply_id+'" name = "cancle'+data[i].fboard_reply_id+'" style="text-align: right; display: none;"/>';
					}
					replyList += '</div>';
					replyList += '<textarea id = "replyContent'+data[i].fboard_reply_id+'" name = "replyContent'+data[i].fboard_reply_id+'" readonly = "readonly" style = "border: none; width : 100%; resize: none; background-color : #f8f9fa;">'
					replyList += data[i].fboard_reply_content+'</textarea></div>';
					replyList += '&nbsp&nbsp&nbsp&nbsp<input type = "button" onclick="updateReplyOk('+data[i].fboard_reply_id+')" value = "수정하기" id = "updateReplyOk'+data[i].fboard_reply_id+'" name = "updateReplyOk'+data[i].fboard_reply_id+'" style="text-align: center; display:none;"/></div>';
				}
				replyList += '</div>'
				$('#reply_area').html(replyList);
				return false;
			},
			error : function(request, status, error){
				//alert('댓글 불러오기 에러 발생');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		}
	function updateReplyOk(reply_id){
		var content = $("#replyContent"+reply_id).val().trim();
		var fboard_reply_id = parseInt(reply_id);
		var free_board_id = parseInt($("#free_board_id").val());
		alert(content);
		if(!content){
			alert('댓글을 입력해 주세요');
			return false;
		}else{
			//ajax 호출
	        $.ajax({
	            url         :   "${pageContext.request.contextPath}/member/fboard_updateReplyOk",
	            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	            type        :   "post",
	            data        :   {content : content, fboard_reply_id : fboard_reply_id, free_board_id : free_board_id},
	            success     :   function(){ // 객체로 받는다 . data -> bookReplyVO
	        		//alert('댓글 수정 성공!')
	         		// 댓글 초기화 해준다.
	         		loadReply();
	                return false;
	        		}
	            ,
	            error : function(request, status, error){
	                console.log("왜 오류가 날까");
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
	        });
		}
	}
	function deleteReplyOk(reply_id){
			var fboard_reply_id = parseInt(reply_id);
			var user = "${user}";
			
			//ajax 호출
	        $.ajax({
	            url         :   "${pageContext.request.contextPath}/member/fboard_deleteReplyOk",
	            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	            type        :   "post",
	            data        :   {fboard_reply_id : fboard_reply_id},
	            success     :   function(){ // 객체로 받는다 . data -> bookReplyVO
	        		alert('댓글 삭제 성공!')
	         		// 댓글 초기화 해준다.
	                loadReply();
	                return false;
	        		}
	            ,
	            error : function(request, status, error){
	                console.log("왜 오류가 날까");
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
	        });
	}
	</script>
</body>
</html>