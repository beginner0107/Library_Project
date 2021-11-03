<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" ></script>
<script type="text/javascript">
$(function() {
	$("#userid").keyup(function() {
		var value = $(this).val();
		// alert(value);
		// 아이디가 3글자 이하면 검사 생략
		if (value.length <= 3) {
			$("#idMessage").html("").css('color', 'black');
			return false;
		}
		if (value.includes(" ")) {
			alert("아이디에는 공백을 포함할 수 없습니다.");
			$(this).val("");
			$(this).focus();
			return false;
		}
		var idRegExp = /^[a-zA-z0-9]{4,12}$/; //아이디 유효성 검사
        if (!idRegExp.test(value)) {
            alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!");
            $(this).val("");
			$(this).focus();
            return false;
        }
		// 여기까지오면 3자이상에 공백이 없다는 것이다.
		$.ajax('idCheck', {
			type : "get",
			data : {
				"userid" : value
			},
			success : function(data) {
				// alert(data + "\n" + typeof(data));
				if (data * 1 >= 1) {
					$("#idMessage").html("사용 불가능").css('color', 'red');
				} else {
					$("#idMessage").html("사용가능").css('color', 'blue');
				}
			},
			error : function() {
				alert("에러!!!");
			}
		});
	});
	$("#username").keyup(function() {
		var value = $(this).val();
		if (value.includes(" ")) {
			alert("이름에는 공백을 포함할 수 없습니다.");
			$(this).val("");
			$(this).focus();
			return false;
		}
	});
	$("#email").keyup(function() {
		var value = $(this).val();
		if (value.includes(" ")) {
			alert("이메일 주소에는 공백을 포함할 수 없습니다.");
			$(this).val("");
			$(this).focus();
			return false;
		}
	});
});
</script>
</head>
<body class="bg-primary">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-7">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">개인정보수정</h3>
								</div>
								<div class="card-body">
									<form action="<c:url value="modifyOk"/>" method="post"
										class="form-horizontal" onsubmit="return formCheck();">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<div class="form-floating mb-3">
											<input type="text" class="form-control" id="userid"
											 	name="userid" placeholder="사용자 아이디 입력" value = "${userid }" readonly="readonly"/> <label for="userid">아이디</label>
										<div id="idMessage"
										style="margin-left: 5px; line-height: 30px; vertical-align: middle; font-size: small;"></div>
										</div>
										<div class="form-floating mb-3">
											<input type="text" class="form-control" id="email"
												name="email" placeholder="이메일 주소 입력" value = "${email }" required/> <label for="email">이메일 주소</label>
										</div>
										<div class="row mb-3">
											<div class="col-md-6">
												<div class="form-floating mb-3 mb-md-0">
													<input type="password"
														class="form-control" id="password" name="password"
														placeholder="사용자 비밀번호 입력" required/> <label
														for="password">비밀번호</label>
												</div>
											</div>
											
											<div class="col-md-6">
												<div class="form-floating mb-3 mb-md-0">
													<input type="password"
														class="form-control" id="password2" name="password2"
														placeholder="사용자 비밀번호 입력" required/> <label
														for="password2">비밀번호</label>
												</div>
											</div>
											<c:if test="${not empty message}">
												<span style="color:red;font-weight: bold;">${message } </span> 
											</c:if>
										</div>
										<div class="form-floating mb-3">
											<input type="text" class="form-control"
												pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" id="phone" name="phone"
												placeholder="010-1234-5678" value = "${phone }" required/> 
												<label for="phone">이메일 주소</label>
										</div>
										<div class="mt-5 mb-0">
											<div class="d-grid">
												<input type="submit" class="btn btn-primary btn-block" value="수정완료" />
											</div>
										</div>
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="${pageContext.request.contextPath }/">홈으로</a>
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
</body>
</html>