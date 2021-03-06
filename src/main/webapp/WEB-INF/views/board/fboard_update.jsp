<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:requestEncoding value="UTF-8"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실 수정하기</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- CDN 한글화 -->
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>

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
                  <form action="${pageContext.request.contextPath}/board/updateOk" method="post" enctype="multipart/form-data" onsubmit="return formCheck();" >
                    <article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <h1 class="fw-bolder mb-1"><input type="text" id="free_board_title" name="free_board_title" value="${fv.free_board_title }" placeholder="제목" required="required"/></h1>
                            <!-- Post categories -->
                            <div class="badge bg-secondary text-decoration-none link-light">회원 아이디 : ${fv.userid }</div>
                        </header>
                        <!-- Post content-->
                        <section class="mb-5">
                            <p class="fs-5 mb-4"><textarea name="free_board_content" id="free_board_content">${fv.free_board_content }</textarea></p>
                        </section>
                        <div>
			   			   <c:if test="${not empty fv.fileList }">
								<c:forEach var="fvo" items="${fv.fileList }" varStatus="vs">
									<%-- 파일명 출력 --%>
									<i class="axi axi-download2"></i> ${fvo.oriname } 
									<%-- 삭제 아이콘을 표시 :  클릭시 삭제여부를 물어보고 삭제 표시를 한다. --%>
									<i style="font-size: 15pt;color:red;cursor: pointer;" class="axi axi-delete2" onclick="deleteFile(${fvo.fboard_upload_id}, ${vs.count })"></i>
									<input type="hidden" name="delfile" id="delfile${vs.count }" size="5" value="0">
									<span id="msg${vs.count }" style="color:red;"></span>
									<br />
								</c:forEach>
							</c:if>	
                        </div>
                        <input type="button" value=" + " class="btn btn-outline-success btn-sm" style="margin-bottom: 5px;" onclick="addFile();"/>
						<input type="button" value=" - " class="btn btn-outline-success btn-sm" style="margin-bottom: 5px;" onclick="removeFile();"/>
						<span style="color:red;font-size: 9pt;">※ 이미지는 내용에 직접 첨부하세요!!!</span>
						<br />
						<div id="fileBox">
							<div id="fileItem1" class="fileItem"> <input type="file" name="upfile"/></div>
						</div>
                        <br><br>
                    </article>
                    <table class="table">
                    <tr>
						<td colspan="4" class="info">
							<input type="submit" value=" 수정하기 " class="btn btn-outline-success btn-sm" />
							<input type="button" value=" 돌아가기 " class="btn btn-outline-success btn-sm" onclick="goBack()"/>
						</td>
					</tr>
                    </table>
                    <input type="hidden" name="p"  value="${cv.currentPage }"/>
					<input type="hidden" name="s"  value="${cv.pageSize }"/>
					<input type="hidden" name="b"  value="${cv.blockSize }"/>
					<input type="hidden" name="idx"  value="${cv.idx }"/>
                 </form>
             </div>
             </div>
            </div>
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
<script>
	$(function(){
		$("#free_board_title").keyup(function() {
			var content = $("#free_board_title").val();
			if(content.length>40){
				content = content.substring(0, 40);
				$("#free_board_title").val(content);
				alert('40글자 제한이 있습니다.');
			}
		});
		
		$('#free_board_content').summernote(
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
	// 첨부 파일 개수 증감하는 스크립트
	var minLimit = 0;  // 최소 파일 갯수
	var maxLimit = 5; // 최대 파일 갯수
	var fileCount = 1; // 현재 파일 갯수
	function addFile(){ // 추가
		if(fileCount>=maxLimit){
			alert('첨부 파일은 최대 ' + maxLimit + "까지만 허용합니다.");
			return;
		}
		fileCount++;
		$("#fileBox").append("<div id='fileItem"+fileCount+"' class='fileItem'><input type='file' name='upfile'></div>");
	}
	function removeFile(){ // 삭제
		if(fileCount<=minLimit){
			alert('첨부 파일은 최소 ' + minLimit + "개는 있어야 합니다.");
			return;
		}
		$("#fileItem"+fileCount).remove();
		fileCount--;
	}
	//-----------------------------------------------------------------------------------------------------------
	// 돌아가기버튼 클릭시 사용할 함수
	function goBack(){
		SendPost("${pageContext.request.contextPath}/board/fboard_view", {"p":${cv.currentPage},"s":${cv.pageSize},"b":${cv.blockSize},"idx":${cv.idx}});
	}
	// 폼의 값 유효성 검사하기 스크립트
	function formCheck(){
		var value = $("#free_board_title").val();
		if(!value || value.trim().length==0){
			alert('제목은 반드시 입력해야 합니다.');
			$("#free_board_title").val("");
			$("#free_board_title").focus();
			return false; 
		}
		var value = $("#free_board_content").summernote('code');
		// alert("값 : " + value);
		if(!value || value.trim()=="<p><br></p>"){
			alert('내용은 반드시 입력해야 합니다.');
			$("#free_board_content").val("");
			$("#free_board_content").focus();
			return false; 
		}
		return true;
	}
	function deleteFile(idx, count){
		alert("idx " + idx + "count " + count)
		var value = $("#delfile"+count).val();
		if(value==0){
			if(confirm(idx+"번 첨부파일을 정말로 삭제하시겠습니까?")){
				$("#delfile"+count).val(idx)
				$("#msg"+count).html('삭제')
			}
		}else{
			if(confirm(idx+"번 첨부파일을 삭제를 취소 하시겠습니까?")){
				$("#delfile"+count).val(0)
				$("#msg"+count).html('')
			}
		}
	}
</script>	
</body>
</html>