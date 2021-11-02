<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<meta charset="UTF-8">
<title>[희망도서]</title>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="${pageContext.request.contextPath }/resources/css/styles.css"
	rel="stylesheet" />
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="${pageContext.request.contextPath }/resources/css/styles2.css"
	rel="stylesheet" />
<script type="text/javascript">
	$(function() {

	});
</script>
<style type="text/css">
body {
	font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Page Content-->
	<div class="container px-4 px-lg-5">
		<!-- Heading Row-->

		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">도서 검색</h1>
					<br>
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
											method="POST">

											<!--                                    ISBN10 & 제목-->
											<div class="row mb-3">
												<div class="col-md-6">
													<div class="form-floating mb-3 mb-md-0">
														<input class="form-control" id="request_isbn" type="text"
															placeholder="ISBN 코드를 입력해주세요." name="request_isbn" /> <label
															for="request_isbn">ISBN 코드</label>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-floating">
														<input class="form-control" id="request_title" type="text"
															placeholder="제목 명을 입력해주세요." name="request_title" /> <label
															for="request_title">도서 제목</label>
													</div>
												</div>
											</div>


											<!--                                    링크-->
											<div class="form-floating mb-3">
												<input class="form-control" id="request_link" type="text"
													placeholder="해당 도서에 대한 링크를 입력해주세요." name="request_link" />
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
</body>
</html>