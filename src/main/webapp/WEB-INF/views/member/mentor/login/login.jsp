<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/animate.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/magnific-popup.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/aos.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/ionicons.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery.timepicker.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/flaticon.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/icomoon.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/base.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/header_add.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/common.css">		
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<title>Mentors</title>
<script type="text/javascript">


	function email_change() {
	    if (document.loginForm.select_email.options[document.loginForm.select_email.selectedIndex].value == '0') {
	    	
	    }
	    else if (document.loginForm.select_email.options[document.loginForm.select_email.selectedIndex].value == '1') {
	       document.loginForm.email_type.value = "";
	       document.loginForm.email_type.focus();
	    } else {
	       document.loginForm.email_type.value = document.loginForm.select_email.options[document.loginForm.select_email.selectedIndex].value;
	      
	       // 전체선택
	       /*  $("input:text[name='mentor_email']").select(); */
	       
	       // 마지막 선택
	       document.loginForm.mentor_email.focus();
	       document.loginForm.mentor_email.setSelectionRange(document.loginForm.mentor_email.value.length, document.loginForm.mentor_email.value.length);
	    }
	 }
	 

	
		
	var mentorObject = new Object();
	
	$(function() {

		$("#login_submit_btn").on("click", function () {
			
	        mentorObject.mentor_email = $("#mentor_email").val() + "@" + $("#email_type").val();
	        mentorObject.mentor_password = $("#mentor_password").val();
	        ajaxLoginformCk();
					
		})
		
		/*
		keyup 이벤트 추가 
		Author 종찬
		*/
		$('#mentor_password').on('keypress', function(e){
			if(e.keyCode == 13) {
				mentorObject.mentor_email = $("#mentor_email").val() + "@" + $("#email_type").val();
				mentorObject.mentor_password = $("#mentor_password").val();
				ajaxLoginformCk();
			}
		});
		
	})
	
	function ajaxLoginformCk() {
		
		var mentorJsonObject = JSON.stringify(mentorObject);

		$.ajax({
			
			url:"<%=request.getContextPath()%>/mentor/login",
			type:"post",
			contentType:"application/json",
			data:mentorJsonObject,
			dataType:"json",
			async:false,
			
			success:function(result){			
				if(eval(result)){	
					ajaxSendCookie();
					alert("로그인 성공");
				}
				 else {	
					 alert("로그인 실패");
				 }				
			},
			// ajax 호출이 실패한 경우 실행되는 함수
			error:function(result){
				alert('로그인 과정에서 문제가 발생했습니다.');
				return;
			}
		})
	
	}
	
	
	function ajaxSendCookie() {
		
		var rememberEmail = $("#save_email").prop("checked"); 
		rememberEmailJsonObject = JSON.stringify(rememberEmail);
		
		$.ajax({
			
			url:"<%=request.getContextPath()%>/mentor/login/cookie",
			type:"post",
			contentType:"application/json",
			data: rememberEmailJsonObject,
			dataType:"json",
			async:false,		
			success:function(result){
				if(eval(result)){
					location.href = "<%=request.getContextPath()%>";
				}
				 else {	
					 alert("아이디 저장 실패");
				 }	
			},
			// ajax 호출이 실패한 경우 실행되는 함수
			error:function(result){
				alert('쿠키를 보내는 과정에서 문제가 발생했습니다.');
				return;
			}
		})
	
	}
	
	
			
</script>
<%--
<style type="text/css">

input[type="text"], input[type="password"], option, select {
	background-color: #e8f0fe !important;
}

span[id="addon-wrapping"] {
	background-color: #f2f3f8;
}
</style>
--%>
</head>
<body>

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>

	<div class="cont">
		<!-- Content here -->

		<p class="tit_desc_p">멘토 회원으로 로그인 합니다.</p>
		
		<!-- 입력 폼 div -->
		<div class="container form_wrap" style="border: 1px solid #e1e3e2; border-radius: 10px; background-color:white;">
			<!-- 마진값 준 컨테이너 -->
				<form action="<%=request.getContextPath()%>/mentor/login"
					method="post" name="loginForm">
					<p>
						<label for="inputEmail">이메일</label>
					</p>
					<div class="input-group flex-nowrap mb-4">
						<input type="text" class="form-control" placeholder="아이디"
							aria-label="userId" aria-describedby="addon-wrapping"
							id="mentor_email" name="mentor_email" value="${ email_idd }"
							style="border-radius: 10px 0px 0px 10px;margin-right: -1px;" required>
						<div class="input-group-prepend">
							<span class="input-group-text" id="addon-wrapping"><b>@</b></span>
						</div>
						<input type="text" class="form-control" placeholder="이메일"
							aria-label="userEmail" aria-describedby="addon-wrapping"
							id="email_type" name="email_type" value="${ email_typee }"
							required>
						<select class="custom-select custom-select-lg"
							name="select_email" onchange="email_change()"
							id="inputGroupSelect01"
							style="height: 52px; border-radius: 0px 10px 10px 0px;">
							<option value="0">이메일을 선택하세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="yahoo.com">yahoo.com</option>
							<option value="1">직접입력</option>
						</select>
					</div>
					<label for="inputPassword">비밀번호</label> <input type="password"
						id="mentor_password" name="mentor_password" class="form-control"
						aria-describedby="passwordHelpBlock" style="border-radius: 10px;">
					<div class="custom-control custom-checkbox mt-3 mb-3">
						<input type="checkbox" class="custom-control-input"
							id="save_email"> <label class="custom-control-label"
							for="save_email">접속정보를 저장합니다.</label>
					</div>
				</form>
				<div class="align-middle container login_btn_wrap">
					<button id="login_submit_btn" type="button"
						class="btn btn-primary btn-lg btn-block"
						style="border-radius: 15px;">로 그 인</button>
				</div>
		</div>
		<!-- 로그인 아래 영역 -->
		<div class="mt-4 mb-4">
			<p class="text-center">
			<a href="<%=request.getContextPath()%>/mentor/regist">계정이 없으신가요?</a>
			</p>
		</div>
		
	</div>


	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/footer.jsp" flush="false"></jsp:include>	
		
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-migrate-3.0.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/popper.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.waypoints.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.stellar.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/owl.carousel.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.magnific-popup.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/aos.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.animateNumber.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/scrollax.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/main.js"></script>
	

</body>
</html>