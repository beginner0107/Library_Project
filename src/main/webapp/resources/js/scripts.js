/*!
* Start Bootstrap - Landing Page v6.0.0 (https://startbootstrap.com/theme/landing-page)
* Copyright 2013-2021 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-landing-page/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project

/*!
* Start Bootstrap - Landing Page v6.0.0 (https://startbootstrap.com/theme/landing-page)
* Copyright 2013-2021 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-landing-page/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project



function formCheck(){
	var value = $("#userid").val();
	if (value!=null&&value.length < 4) {
		alert("사용자 아이디는 3글자 이상이여야 합니다.");
		$("#userid").focus();
		return false;
	}
	if(value!=null && value.trim().length==0){
		alert("사용자 아이디는 반드시 입력해야 합니다.");
		$("#userid").val("");
		$("#userid").focus();
		return false;
	}
	var value = $("#username").val();
	var nameRegExp = /^[가-힣]{2,4}$/;
	if (value!=null&&!nameRegExp.test(value)) {
	    alert("이름이 올바르지 않습니다.");
	    $("#username").val("");
		$("#username").focus();
	    return false;
	}
	var value = $("#password").val();
	if(value!=null&&!value && value.trim().length==0){
		alert("사용자 비밀번호는 반드시 입력해야 합니다.");
		$("#password").val("");
		$("#password").focus();
		return false;
	}
	var value = $("#password2").val();
	if (!value && value.trim().length == 0) {
		alert('비밀번호 확인은 반드시 입력해야 합니다.');
		$("#password2").val("");
		$("#password2").focus();
		return false;
	}
	// 비밀번호 일치를 확인해야 한다.
	var pwd1 = $("#password").val();
	var pwd2 = $("#password2").val();
	if (pwd1 != pwd2) {
		alert("비번이 일치하지 않습니다.");
		$("#password2").val("");
		$("#password2").focus();
		return false;
	}
	var value = $("#email").val();
	if (value!=null&&!verifyEmail(value)) {
		alert('올바른 이메일 주소가 아닙니다.\n이메일 주소는 정확하게 입력해야 합니다.');
		$("#email").val("");
		$("#email").focus();
		return false;
	}
	var value = $("#phone").val();
	if (value!=null && value.trim().length == 0) {
		alert('전화번호는 반드시 입력해야 합니다.');
		$("#phone").val("");
		$("#phone").focus();
		return false;
	}
	
	
	return true;
}
