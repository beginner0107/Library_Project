<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>온라인도서관 - 도서상세보기</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
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
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	pre {
		white-space: pre-wrap;
	}
	
</style>
</head>
<body>
	<!-- Navigation-->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Product section-->
		<section class="py-5">
			<div class="container px-4 px-lg-5 my-5">
				<div class="row gx-4 gx-lg-5 align-items-center">
					<div class="col-md-6">
						<div id="uploadResult">
						</div>
					</div>
					<div class="col-md-6">
						<div class="small mb-1"><c:out value="${vo.genre }"></c:out></div>
						<h1 class="display-5 fw-bolder"><c:out value="${vo.title }"></c:out></h1>
						<div class="fs-5 mb-5">
							<span class="">도서 재고 : </span><c:out value="${vo.count}"></c:out> <span></span>
						</div>
						<p class="lead">
							저자 : <c:out value="${vo.author }"></c:out><br /> 출판사 : <c:out value="${vo.publisher }"></c:out>
							<br />
						</p>
						<pre class="lead" style="font-size: 14pt;"><c:out value="${vo.content}"/></pre>
						<div class="d-flex">
						<input type = "hidden" name = "isbn" id = "isbn" value = "${vo.isbn }">
						<input type = "hidden" name = "title" id = "title" value = "${vo.title }">
						<c:if test="${user != 'anonymousUser' && vo.count gt 0 }">
							<!-- <button type="button" value="대여하기"  class="btn btn-outline-dark flex-shrink-0">
								  <i class="bi-cart-fill me-1">대여 하기</i>
							</button>-->
							<input type="button" value="대여하기"  class="btn btn-outline-dark flex-shrink-0" onclick="rentOk()">
						</c:if>
						<c:if test="${vo.count==0 }">
								  <i class="bi-cart-fill me-1">재고가 없습니다.</i>
						</c:if>
						</div>
					</div>
				</div>
			</div>
		</section>
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
	                                                    <span style="color: #aaa;" id="counter">(0 / 최대 200자)</span>
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
	<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	<script type="text/javascript">
		function updateReply(breply_id){
			var content = $("#breply_content"+breply_id).val();
			console.log(content);
			var breply = "breply_content"+breply_id;
			$('textarea[name='+breply+']').attr("readonly",false);
			$('textarea[name='+breply+']').focus();
			$('input[name=updateReplyOk'+breply_id+']').css("display", "inline");
			$('input[name=cancle'+breply_id+']').css("display", "inline");
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
	let isbn = '<c:out value="${vo.isbn}"/>';
	let uploadResult = $("#uploadResult");
	$.getJSON("${pageContext.request.contextPath}/getImageList", {isbn : isbn}, function(arr){	
		if(arr.length === 0){			
			let str = "";
			str += "<div id='result_card'>";
			str += "<img src='${pageContext.request.contextPath}/resources/assets/img/noExist.png'>";
			str += "</div>";
			
			uploadResult.html(str);	
		}	
		let str = "";
		let obj = arr[0];
		
		let fileCallPath = encodeURIComponent(obj.uploadpath + "/s_" + obj.uuid + "_" + obj.filename);
		str += "<div id='result_card'";
		str += "data-path='" + obj.uploadpath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.filename + "'";
		str += ">";
		str += "<img src='${pageContext.request.contextPath}/display?fileName=" + fileCallPath +"'>";
		str += "</div>";		
		
		uploadResult.html(str);						
		
		
		});
		loadReply();
		var staus = false;
		// 댓글 저장
		$("#content").click(function(){
			var userid = '${user}';
			if(userid == 'anonymousUser'){
				var login = confirm('로그인 하시겠습니까?');
				if(login){
				var root = '${pageContext.request.contextPath}';
				location.href = ''+root+'/user/login'	
				}
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
			
						
			var bookReplyVO = {};
			
			bookReplyVO.isbn = $("#isbn").val();
			bookReplyVO.content = $("#content").val();
			
			//ajax 호출
	        $.ajax({
	            url         :   "${pageContext.request.contextPath}/member/book_detail_replyOk",
	            dataType    :   "json",
	            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	            type        :   "post",
	            data        :   bookReplyVO,
	            success     :   function(data){ // 객체로 받는다 . data -> bookReplyVO
	        		//alert('댓글 등록 성공!')
	            	loadReply();
	         		// 댓글 초기화 해준다.
	                 $("#content").val("");
	                 $('#counter').html("(" + 0 + " / 최대200자)");
	                return false;
	        		}
	            ,
	            error : function(request, status, error){
	                console.log("AJAX_ERROR");
	            }
	        });
		})
		function loadReply(){
			var isbn = $("#isbn").val();
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/bookList",
				data : {isbn : isbn},
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
						replyList += '<div class="fw-bold">'+data[i].userid+' / '+data[i].modified_date+'&nbsp&nbsp&nbsp';
						if(userid != "anonymousUser" && userid == data[i].userid){
						replyList += '<input type = "button" onclick="updateReply('+data[i].breply_id+')" value = "수정" style="text-align: right;"/>&nbsp';
						replyList += '<input type = "button" onclick="deleteReplyOk('+data[i].breply_id+')" value = "삭제" style="text-align: right;"/>&nbsp';
						replyList += '<input type = "button" value = "취소하기" onclick = "cancle('+data[i].breply_id+');" id = "cancle'+data[i].breply_id+'" name = "cancle'+data[i].breply_id+'" style="text-align: right; display: none;"/>';
						}
						replyList += '</div>';
						replyList += '<textarea id = "breply_content'+data[i].breply_id+'" name = "breply_content'+data[i].breply_id+'" readonly = "readonly" style = "border: none; width : 100%; resize: none; background-color : #f8f9fa;">'
						replyList += data[i].content+'</textarea></div>';
						replyList += '&nbsp&nbsp&nbsp&nbsp<input type = "button" onclick="updateReplyOk('+data[i].breply_id+')" value = "수정하기" id = "updateReplyOk'+data[i].breply_id+'" name = "updateReplyOk'+data[i].breply_id+'" style="text-align: center; display:none;"/></div>';
					}
					replyList += '</div>'
					$('#reply_area').html(replyList);
					return false;
				},
				error : function(){
					alert('댓글 불러오기 에러 발생');
				}
			});
			
			}
		$('#content').keyup(function() {
			var content = $(this).val();
			$('#counter').html("(" + content.length + " / 최대200자)");
			//글자수 실시간 카운팅 
			if (content.length > 200) {
				alert("최대 200자까지 입력가능합니다.");
				$(this).val(content.substring(0, 200));
				$('#counter').html("(200 / 최대 200자)");
			}
		});
	});	
	function loadReply(){
		var isbn = $("#isbn").val();
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/bookList",
			data : {isbn : isbn},
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
					replyList += '<div class="fw-bold">'+data[i].userid+' / '+data[i].modified_date+'&nbsp&nbsp&nbsp';
					if(userid != "anonymousUser" && userid == data[i].userid){
					replyList += '<input type = "button" onclick="updateReply('+data[i].breply_id+')" value = "수정" style="text-align: right;"/>&nbsp';
					replyList += '<input type = "button" onclick="deleteReplyOk('+data[i].breply_id+')" value = "삭제" style="text-align: right;"/>';
					replyList += '<input type = "button" value = "취소하기" onclick = "cancle('+data[i].breply_id+');" id = "cancle'+data[i].breply_id+'" name = "cancle'+data[i].breply_id+'" style="text-align: right; display: none;"/>';
					}
					replyList += '</div>';
					replyList += '<textarea id = "breply_content'+data[i].breply_id+'" name = "breply_content'+data[i].breply_id+'" readonly = "readonly" style = "border: none; width : 100%; resize: none; background-color : #f8f9fa;">'
					replyList += data[i].content+'</textarea></div>';
					replyList += '&nbsp&nbsp&nbsp&nbsp<input type = "button" onclick="updateReplyOk('+data[i].breply_id+')" value = "수정하기" id = "updateReplyOk'+data[i].breply_id+'" name = "updateReplyOk'+data[i].breply_id+'" style="text-align: center; display:none;"/></div>';
				}
				replyList += '</div>'
				$('#reply_area').html(replyList);
				return false;
			},
			error : function(){
				alert('댓글 불러오기 에러 발생');
			}
		});
		
		}
	function updateReplyOk(breply_id){
		var content = $("#breply_content"+breply_id).val().trim();
		if(content.length>200){
			alert('200자를 넘을 수 없습니다.');
			content = $("#breply_content"+breply_id).val().substring(0, 200);
			$("#breply_content"+breply_id).val(content);
			return false;
		}
		if(!content){
			alert('댓글을 입력해 주세요');
			return false;
		}else{
			//ajax 호출
	        $.ajax({
	            url         :   "${pageContext.request.contextPath}/member/book_detail_updateReplyOk",
	            dataType    :   "json",
	            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	            type        :   "post",
	            data        :   {content : content, breply_id : breply_id},
	            success     :   function(){ // 객체로 받는다 . data -> bookReplyVO
	        		alert('댓글 수정 성공!')
	         		// 댓글 초기화 해준다.
	         		loadReply();
	                return false;
	        		}
	            ,
	            error : function(request, status, error){
	                console.log("왜 오류가 날까");
	                loadReply();
	            }
	        });
		}
	}
	function deleteReplyOk(breply_id){
			var deleteReply = confirm('삭제하시겠습니까?');
			if(deleteReply){
				var user = "${user}";
				
				//ajax 호출
		        $.ajax({
		            url         :   "${pageContext.request.contextPath}/member/book_detail_deleteReplyOk",
		            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
		            type        :   "post",
		            data        :   {breply_id : breply_id},
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
	}
	// 대여가 가능한지 가능 하지 않은지 체크
	function rentOk(){
		var isbn = $("#isbn").val();
		//alert(isbn);
		var title = $("#title").val();
		//alert(title);
		//ajax 호출
		 $.ajax({
	            url         :   "${pageContext.request.contextPath}/member/rentOk",
	            dataType    :   "text",
	            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	            type        :   "post",
	            data        :   {isbn : isbn , title : title},
	            success     :   function(message){ // 객체로 받는다 .
	            	console.log(message);
	            	if(message == "SUCCESS"){
	            		alert('대여 성공!');
	            		location.reload();
	            	}
	            	if(message == "IMPOSSIBILITY"){
	            		alert('대여한 도서와 연체한 도서를 확인해주세요');
	            		return false;
	            	}
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