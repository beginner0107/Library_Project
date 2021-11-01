<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여기에는 제목</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {

	});
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<!-- Page Content-->

	<!--                도서 추가 파트-->
	<div class="container px-4 px-lg-5">
		<div class="row justify-content-center">
			<div class="card shadow-lg border-5 rounded-lg mt-5">
				<div class="card-header">
					<h3 class="text-center font-weight-light my-4">희망 도서 신청</h3>
				</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath }/member/requestOk" method="POST">

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
								placeholder="해당 도서에 대한 링크를 입력해주세요." name="request_link" /> <label
								for="request_link">도서 링크</label>
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
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>