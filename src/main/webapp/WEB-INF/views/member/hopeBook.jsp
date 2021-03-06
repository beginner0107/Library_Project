<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>온라인도서관 - 희망도서신청</title>
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
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<script type="text/javascript">
	$(function() {

	});
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">희망 도서 신청</h1>
					<br>
					<!--                도서 추가 파트-->
					<div class="container px-4 px-lg-5">
						<div class="row justify-content-center">
							<div class="card shadow-lg border-5 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">희망 도서 신청</h3>
									<div class="card-body">
										<form
											action="${pageContext.request.contextPath }/member/requestOk"
											method="POST" onsubmit="return spaceCheck();" >

											<!--                                    ISBN10 & 제목-->
											<div class="row mb-3">
												<div class="col-md-6">
													<div class="form-floating mb-3 mb-md-0">
														<input class="form-control" id="request_isbn" type="text"
															placeholder="ISBN 코드를 입력해주세요." name="request_isbn" required="required" pattern="[0-9]+"/> <label
															for="request_isbn">ISBN 코드</label>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-floating">
														<input class="form-control" id="request_title" type="text"
															placeholder="제목 명을 입력해주세요." name="request_title" required="required"/> <label
															for="request_title">도서 제목</label>
													</div>
												</div>
											</div>


											<!--                                    링크-->
											<div class="form-floating mb-3">
												<input class="form-control" id="request_link" type="text"
													placeholder="해당 도서에 대한 링크를 입력해주세요." name="request_link"/>
												<label for="request_link">도서 링크</label>
											</div>

											<div class="mt-5 mb-0">
												<div class="d-grid">
													<input type="submit" class="btn btn-primary btn-block"
														value="해당 도서를 신청합니다." />
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					</div>
			</main>
		</div>
	</div>
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
<script type="text/javascript">
	$(function() {
		$("#request_isbn").on("keyup", function() {
			var isbn = $("#request_isbn").val().trim();
			if(isbn.length>15){
				alert('15글자를 넘어갈 수 없습니다.');
				$("#request_isbn").val(isbn.substring(0,15));
			}
		})
		$("#request_title").on("keyup", function() {
			var title = $("#request_title").val().trim();
			if(title.length>210){
				alert('210글자를 넘어갈 수 없습니다.');
				$("#request_title").val(title.substring(0,210));
			}
		})
		$("#request_link").on("keyup", function() {
			var link = $("#request_link").val().trim();
			if(link.length>210){
				alert('210글자를 넘어갈 수 없습니다.');
				$("#request_link").val(link.substring(0,210));
			}
		})
	});
	function spaceCheck(){
		var isbn = $("#request_isbn").val().replaceAll(" ", "");
		if(!isbn&&isbn.trim().length==0){
			alert('ISBN코드 입력창의 내용이 비어있습니다.');
			$("#request_isbn").val("");
			$("#request_isbn").focus();
			return false;
		}
		
		
		var title = $("#request_title").val().replaceAll(" ", "");
		if(!title&&title.trim().length==0){
			alert('도서 제목 입력창의 내용이 비어있습니다.');
			$("#request_title").val("");
			$("#request_title").focus();
			return false;
		}
		
		
		var link = $("#request_link").val().replaceAll(" ", "");
		if(!link&&link.trim().length==0){
			$("#request_link").val("");
		}
		return true;
		
	}
</script>
</body>
</html>