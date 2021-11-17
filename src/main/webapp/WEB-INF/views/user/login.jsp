<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>

<script type="text/javascript">

</script>
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
									<h3 class="text-center font-weight-light my-4">로그인</h3>
								</div>
								<div class="card-body">
									 <form class="form-signin" method="post" action="<c:url value="/login"/>" onsubmit="return formCheck();">
									  <div class="input-group input-sm" style="margin-bottom: 10px;font-size: 8pt;">
										<c:if test="${not empty error}">
											<span style="color:red;font-weight: bold;">${error } </span> 
										</c:if>
										<c:if test="${not empty msg}">
											<span style="color:green;font-weight: bold;">${msg } </span> 
										</c:if>
									 </div>
										<div class="form-floating mb-3">
											<input class="form-control" id="userid" type="text" placeholder="아이디 입력" name="userid" required autofocus />
											<label for="userid" >아이디 입력</label>
											<!-- required autofocus -->
											<!-- <div class="check_font" id="id_check"></div> -->
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="password" type="password" placeholder="패스워드 입력" name="password" required />
											<label for="password">비밀번호 입력</label>
										</div>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<label for="idSaveCheck" style="cursor:pointer"><input type="checkbox" id="idSaveCheck">&nbsp아이디 기억하기</label>
										<div
											class="d-flex align-items-center justify-content-between mt-4-1 mb-0">
											<a class="small" href="${pageContext.request.contextPath }/user/forgotId">Forgot
												ID?</a> 
											<input type="submit" class="btn btn-primary" value="Login" />
										</div>
											<a class="small" href="${pageContext.request.contextPath }/user/forgotPwd">Forgot
												Password?</a> 
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="${pageContext.request.contextPath }/user/join">계정이 없으신가요? 회원가입</a>
									</div>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	 
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $("#userid").val(key); 
     
    if($("#userid").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#userid").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#userId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#userid").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

</script>
</body>
</html>