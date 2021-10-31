<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>도서관</title>
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
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>
</head>
<body>
	<!-- Navigation-->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Product section-->
	<form action="${pageContext.request.contextPath }/member/book_rentOk"
		method="POST">
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
							저자 : <c:out value="${vo.author }"></c:out><br /> 출판사 : <c:out value="${vo.publisher }"></c:out><br /><c:out value="${vo.content }"></c:out>
						</p>
						<div class="d-flex">
						<input type = "hidden" name = "isbn" id = "isbn" value = "${vo.isbn }">
						<input type = "hidden" name = "title" id = "title" value = "${vo.title }">
						<c:if test="${user != 'anonymousUser' && vo.count gt 0 }">
							<button type="submit" value="대여하기"  class="btn btn-outline-dark flex-shrink-0">
								  <i class="bi-cart-fill me-1">대여 하기</i>
							</button>
						</c:if>
						<c:if test="${vo.count==0 }">
								  <i class="bi-cart-fill me-1">재고가 없습니다.</i>
						</c:if>
						</div>
					</div>
				</div>
			</div>
		</section>
	</form>
	
		<!-- Comments section-->
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
                                            <form action="${pageContext.request.contextPath }/member/book_detail_replyOk" method="POST">

                                                <div class="form-group">
                                                	<c:if test="${user != 'anonymousUser' }">
	                                                    <textarea class="form-control" id="content" placeholder="댓글을 입력해주세요." rows="3" name="content"></textarea>
                                                	</c:if>
                                                	<c:if test="${user == 'anonymousUser' }">
	                                                    <textarea class="form-control" id="content" placeholder="로그인 해야 입력이 가능합니다." rows="3" name="content" readonly="readonly"></textarea>
                                                	</c:if>
                                                </div>
                                                <div id="content">(0 / 1000)</div>
												<input type = "hidden" name = "isbn" id = "isbn" value ="${vo.isbn }">
													<c:if test="${user != 'anonymousUser' }">
	                                                     <div class="mt-5 mb-0">
                                                    <div class="d-grid">
                                                        <input type="submit" class="btn btn-primary btn-block" value="댓글 추가" />
                                                    </div>
                                                	</div>
                                                	</c:if>
                                                	<c:if test="${user == 'anonymousUser' }">
	                                                    <div class="mt-5 mb-0">
                                                    <div class="d-grid">
                                                        <a href = "${pageContext.request.contextPath }/user/login" class="btn btn-primary btn-block">로그인</a>
                                                    </div>
                                                	</div>
                                                	</c:if>
                                            </form>
                                           
                                        </div>
                                    </div>
                                </div>

                                <!--                             댓글 나오는 창-->
                <c:forEach var="vo" items="${pv.list}">
                    <div class="d-flex mb-4 ">
                <!-- Parent comment-->
                		 <div class="ms-3">
                         <div class="fw-bold">${vo.userid} / ${vo.modified_date }</div>
                          ${vo.content}
                      </div>
                    </div>
                </c:forEach>
                <c:if test="${not empty pv.list }">
	                 ${pv.pageList }
                </c:if>
                <!-- Single comment-->
                  </div>
              </div>
          </section>
                
	<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
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
	});	
	</script>
</body>
</html>