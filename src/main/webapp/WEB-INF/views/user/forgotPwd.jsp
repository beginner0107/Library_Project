<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Library</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</head>
<body class="bg-primary">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">비밀번호 찾기</h3>
								</div>
								<div class="card-body">
									<div class="small mb-3 text-muted">아이디와 이메일을 입력하면, 이메일로 임시 비밀번호가 발급됩니다.</div>
									<form action="${pageContext.request.contextPath }/user/forgotPwdOk" method="POST" onsubmit="return formCheck();">
										<div class="form-floating mb-3">
											<input class="form-control" id="userid" 
												placeholder="아이디입력" name="userid" /> <label for="userid">아이디 입력</label>
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="email" type="email"
												placeholder="name@example.com" name="email" /> <label for="email">이메일 입력</label>
										</div>
										<div
											class="d-flex align-items-center justify-content-between mt-4 mb-0">
											<a class="small" href="${pageContext.request.contextPath }/user/login">Return to login</a>
											<input type="submit" class="btn btn-primary" value="Reset Password" />
										</div>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="${pageContext.request.contextPath }/user/join">Need an account? Sign up!</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<c:import url="/WEB-INF/views/include/bottom_info2.jsp"></c:import>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
</body>
</html>