<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Library</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<script>
	if(window.history.replaceState){
		window.history.replaceState(null, null, window.location.href);
	}

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
    	<!-- Page Content-->
    	<div class="container px-4 px-lg-5">
       	 <!-- Heading Row-->

        	<div id="layoutSidenav_content">
           	 <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">도서</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item "><a href="${pageContext.request.contextPath }/admin/book_add">도서 추가</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/admin/book_delete">도서
                                삭제</a></li>
                        <li class="breadcrumb-item active">도서
                                수정</li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/admin/rent_overdue">연체
								도서</a></li>
                    </ol>
                	</div>
		<table class="table" style="width: 90%;">
			<tr>
				<td colspan="9" class="title"><b>도서 목록</b></td>
			</tr>
			<tr>
				<td colspan="9" class="info" style="text-align: right;"><c:out value="${pv.getPageInfo() }"></c:out></td>
			</tr>
			<tr>
				<th>ISBN</th>
				<th>제목</th>
				<th>작가</th>
				<th>출판사</th>
				<th>장르</th>
				<th>권수</th>
				<th>등록일자</th>
				<th>해당 도서 페이지</th>
				<th>수정하기</th>
			</tr>
			<c:if test="${empty pv.list}">
			<tr>
				<td colspan="9" class="info2">조건에 맞는 회원이 존재하지 않습니다.</td>
			</tr>
			</c:if>
			<c:if test="${not empty pv.list }">
				<c:forEach var="vo" items="${pv.list }" varStatus="vs">
					<tr align="center">
						<td>
							<c:out value="${vo.isbn }"></c:out>
						</td>	
						<td>
							<c:out value="${vo.title }"></c:out>
						</td>
						<td>
							<c:out value="${vo.author }"></c:out>
						</td>
						<td>
							<c:out value="${vo.publisher }"></c:out>
						</td>
						<td>
							<c:out value="${vo.genre }"></c:out>
						</td>
						<td>
							<c:out value="${vo.count }"></c:out>
						</td>
						<td>
							<fmt:formatDate value="${vo.regdate }" type="date" dateStyle="short"/>
						</td>
						<td>
							<a href = "${pageContext.request.contextPath }/book_detail?isbn=${vo.isbn }">자세히</a>
						</td>
						<td>
							<form action="${pageContext.request.contextPath}/admin/book_update" method="post">
								<input type="hidden" name = "isbn" value = "<c:out value='${vo.isbn }' />">
								<input type = "submit" value="수정">
							</form>
						</td>
					</tr>		
				</c:forEach>
					<tr>
					<td style="border: none;text-align: center; padding-top: 20px;" colspan="9">
					${pv.pageList }
					</td>
				</tr>
			</c:if>
		</table>
		<!-- 검색 영역 -->
	    <div class="search_wrap" style="text-align: center;">
	    	<form id="searchForm" action="${pageContext.request.contextPath }/admin/book_update" method="post">
	    	<div class="search_input">
		   	  	<select name = "type">
		    		<option value = "">--</option>
		    		<option value = "I">ISBN</option>
		    		<option value = "T">제목</option>
		    		<option value = "A">작가</option>
		    		<option value = "G">장르</option>
		    	</select>
	         <input type="text" name="keyword" id = "keyword"/>
	         <button class='btn btn-primary btn-block'>검 색</button>                				
	   		</div>
	    	</form>
	    </div>
	    <c:if test="${bvo!=null }">
	    
	    
                <!--                도서 수정 파트-->
                <div class="container px-4 px-lg-5">
                    <div class="row justify-content-center">
                        <div class="card shadow-lg border-5 rounded-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center font-weight-light my-4">도서 수정</h3>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath }/admin/bookUpdateOk" method="POST" enctype="multipart/form-data" onsubmit="return bookUpdateCheck();">

                                    <!--                                    ISBN & 장르-->
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <input class="form-control" id="isbn" type="text" placeholder="ISBN 코드를 입력해주세요." name="isbn" value="${bvo.isbn }" readonly="readonly" /> <label for="isbn">ISBN 코드</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <input class="form-control" id="genre" type="text" placeholder="장르를 입력해주세요." name="genre" value="${bvo.genre }" /> <label for="genre">장르</label>
                                            </div>
                                        </div>
                                    </div>


                                    <!--                                    제목 저자 출판사-->
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <input class="form-control" id="title" type="text" placeholder="제목 명을 입력해주세요." name="title" value="${bvo.title}"/> <label for="title">제목</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <input class="form-control" id="author" type="text" placeholder="저자 명을 입력해주세요." name="author" value="${bvo.author }" /> <label for="author">저자</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <input class="form-control" id="publisher" type="text" placeholder="출판사 명을 입력해주세요." name="publisher" value="${bvo.publisher }" /> <label for="publisher">출판사</label>
                                            </div>
                                        </div>
                                    </div>

                                    <!--                                    권수-->
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="count" type="number" placeholder="권수를 입력해주세요." name="count" maxlength="3" value = "${bvo.count }" oninput="numberMaxLength(this)"/> <label for="count">권수</label>
                                    </div>
                                    <div class="form-group">
										<textarea class="form-control" id="content"
											placeholder="줄거리를 입력해주세요." rows="10" name="content">${bvo.content }</textarea>
									</div>
									<div id="content">(0 / 1000)</div>
									 <!--책 이미지-->
                                    	<div class="form_section">
			                    			<div class="form_section_title">
			                    				<label>상품 이미지</label>
			                    			</div>
			                    			<div class="form_section_content">
												<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;" >
												<div id="uploadResult">
												</div>
			                    			</div>
			                    		</div>  
			                    		
			                    		
								   <script type="text/javascript">
								   /* 이미지 업로드 */
									$("input[type='file']").on("change", function(e){
										
										/* 이미지 존재시 삭제 */
										if($(".imgDeleteBtn").length > 0){
											deleteFile();
										}
										
										let formData = new FormData();
										let fileInput = $('input[name="uploadFile"]');
										let fileList = fileInput[0].files;
										let fileObj = fileList[0];
										;
										
										if(!fileCheck(fileObj.name, fileObj.size)){
											return false;
										}
										
										formData.append("uploadFile", fileObj);
										
										$.ajax({
											url: '/library/admin/uploadAjaxAction',
									    	processData : false,
									    	contentType : false,
									    	data : formData,
									    	type : 'POST',
									    	dataType : 'json',
									    	success : function(result){
									    		console.log(result);
									    		showUploadImage(result);
									    	},
									    	error : function(result){
									    		alert("이미지 파일이 아닙니다.");
									    	}
										});	
									});
								   
									/* var, method related with attachFile */
									let regex = new RegExp("(.*?)\.(jpg|png)$");
									let maxSize = 1048576; //1MB	
									
									function fileCheck(fileName, fileSize){

										if(fileSize >= maxSize){
											alert("파일 사이즈 초과");
											return false;
										}
											  
										if(!regex.test(fileName)){
											alert("해당 종류의 파일은 업로드할 수 없습니다.");
											return false;
										}
										
										return true;		
										
									}
									
									/* 이미지 출력 */
									function showUploadImage(uploadResultArr){
										/* 전달받은 데이터 검증 */
										if(!uploadResultArr || uploadResultArr.length == 0){return}
										
										let uploadResult = $("#uploadResult");
										
										let obj = uploadResultArr[0];
										let str = "";
										
										let fileCallPath = encodeURIComponent(obj.uploadpath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.filename);
										str += "<div id='result_card'>";
										str += "<img src='/library/display?fileName=" + fileCallPath +"'>";
										str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
										str += "<input type='hidden' name='imageList[0].filename' value='"+ obj.filename +"'>";
										str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
										str += "<input type='hidden' name='imageList[0].uploadpath' value='"+ obj.uploadpath +"'>";		
										str += "</div>";
										
										uploadResult.append(str);     
									}
									/* 이미지 삭제 버튼 동작 */
									$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
										deleteFile();
									});
									/* 파일 삭제 메서드 */
									function deleteFile(){
										
										let targetFile = $(".imgDeleteBtn").data("file");
										
										let targetDiv = $("#result_card");
										
											$.ajax({
												url: '/library/admin/deleteFile',
												data : {fileName : targetFile},
												dataType : 'text',
												type : 'POST',
												success : function(result){
													console.log(result);
													
													targetDiv.remove();
													$("input[type='file']").val("");
													
												},
												error : function(result){
													console.log(result);
													
													alert("파일을 삭제하지 못하였습니다.")
													}
												});
										}
									
									
								   </script>
								    <label><input type="checkbox" name="no_image" value="no_image"> 이미지 없이 등록</label>
                                    <div class="mt-5 mb-0">
                                        <div class="d-grid">
                                            <input type="submit" class="btn btn-primary btn-block" value="도서정보를 수정합니다." />
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
               
			</c:if>
            </main>
		</div>
		</div>
          <c:import url="/WEB-INF/views/include/admin_bottom_info.jsp"/>
<script type="text/javascript">
	$(function() {
	let isbn = '<c:out value="${bvo.isbn}"/>';
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
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "</div>";		
		
		uploadResult.html(str);						
		
		
		});
	});	
	function numberMaxLength(e){
	      if(e.value.length > e.maxLength){
	          e.value = e.value.slice(0, e.maxLength);
	      }
	}
	
	function bookUpdateCheck(){
		var isbn = $("#isbn").val().trim();
		if(!isbn && isbn.length==0){
			alert("isbn에는 공백이 올 수 없습니다.");
			$("#isbn").val("");
			$("#isbn").focus();
			return false;
		}
		var genre = $("#genre").val().trim();
		if(!genre && genre.length==0){
			alert("장르에는 공백이 올 수 없습니다.");
			$("#genre").val("");
			$("#genre").focus();
			return false;
		}
		var title = $("#title").val().trim();
		if(!title && title.length==0){
			alert("도서 제목에는 공백이 올 수 없습니다.");
			$("#title").val("");
			$("#title").focus();
			return false;
		}
		var author = $("#author").val().trim();
		if(!author && author.length==0){
			alert("저자에는 공백이 올 수 없습니다.");
			$("#author").val("");
			$("#author").focus();
			return false;
		}
		var count = $("#count").val().trim();
		if(!count&&count.length==0||count=="0"||count<1){
			alert("권수를 입력해주세요");
			$("#count").val("");
			$("#count").focus();
			return false;
		}
		
		var publisher = $("#publisher").val().trim();
		if(!publisher && publisher.length==0){
			alert("출판사에는 공백이 올 수 없습니다.");
			$("#publisher").val("");
			$("#publisher").focus();
			return false;
		}
		var content = $("#content").val().trim();
		if(!content && content.length==0){
			alert("내용에는 공백이 올 수 없습니다.");
			$("#content").val("");
			$("#content").focus();
			return false;
		}
		
		return true;
	}
</script>
 

</body>

</html>
