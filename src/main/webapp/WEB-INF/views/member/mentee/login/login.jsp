<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/animate.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/magnific-popup.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/aos.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/ionicons.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/jquery.timepicker.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/flaticon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/icomoon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/base.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/header_add.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/common.css">	
<title>MENTEE_LOGIN</title>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
	function email_change() {
		if (document.loginForm.select_email.options[document.loginForm.select_email.selectedIndex].value == '0') {
			document.loginForm.email_type.value = "";
		}
		if (document.loginForm.select_email.options[document.loginForm.select_email.selectedIndex].value == '1') {
			document.loginForm.email_type.value = "";
			document.loginForm.email_type.focus();
		} else {
			document.loginForm.email_type.value = document.loginForm.select_email.options[document.loginForm.select_email.selectedIndex].value;
		}
	}

	$(document).ready(function () {
		$("#naverLoginBtn").on("click", function () {
			$.ajax({
				
				url:'<%=request.getContextPath()%>/mentee/naverlogin',
				type:"get",
				contentType:"application/x-www-form-urlencoded; charset=utf-8",
				success:function(data){
					$("#naverLoginLink").attr("href",data);
					$("#naverLoginLink").get(0).click();
				}
				
			});
		});
		
		$("#naverLoginLink").on("click", function () {
			$("#mainBtn").get(0).click();
		});
		
		$("#localLoginBtn").on("click", function () {
			
			 var menteeObject = new Object();
			
			 menteeObject.mentee_email = $("#email_id").val() + "@" +  $("#email_type").val();
			 menteeObject.mentee_password = $("#mentee_password").val();
			 var rememberEmail = $("#save_email").prop("checked"); 
			 
			 
			 menteeJsonObject = JSON.stringify(menteeObject);
			 rememberEmailJsonObject = JSON.stringify(rememberEmail);
			$.ajax({
				url:'<%=request.getContextPath()%>/mentee/login',
				type: "post",
		        async: false,
		        contentType: "application/json",
		        data: menteeJsonObject,
		        dataType: "json",
				success:function(data) {
					if(eval(data)){
						alert("로그인에 성공했습니다!");
						//$("#loginBtn").trigger("click");
						$.ajax({
							url:'<%=request.getContextPath()%>/mentee/login/cookie',
							type: "post",
					        async: false,
					        contentType: "application/json",
					        data: rememberEmailJsonObject,
					        dataType: "json",
					        success:function(data) {
								$("#mainBtn").get(0).click();
					        }
						});
						$("#mainBtn").get(0).click();
					}else{
						alert("아이디와 패스워드를 확인해주세요!");
					}
				},
				
				error:function() {
					alert("로그인 과정에서 문제 발생 (관리자에게 문의하세요.)");
					
				}
			});
		});
	});
	
	 function kakaoLogout() {
			Kakao.Auth.logout(function(response) {
				alert(response + 'logout');
			}); 
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

		<p class="tit_desc_p">멘티 회원으로 로그인 합니다.</p>
		
		<!-- 입력 폼 div -->
		<div class="container form_wrap" style="border: 1px solid #e1e3e2; border-radius: 10px; background-color:white;">
				<form action="<%=request.getContextPath()%>/mentor/login"
					method="post" name="loginForm">
					<p>
						<label for="inputEmail">이메일</label>
					</p>
					<div class="input-group flex-nowrap mb-4">
						<input type="text" class="form-control" placeholder="아이디"
							aria-label="userId" aria-describedby="addon-wrapping"
							id="email_id" name="email_id" value="${ email_idd }"
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
						id="mentee_password" name="mentee_password" class="form-control"
						aria-describedby="passwordHelpBlock" style="border-radius: 10px;">
					<div class="custom-control custom-checkbox mt-3 mb-3">
						<input type="checkbox" class="custom-control-input" name="save_email"
							id="save_email"> <label class="custom-control-label"
							for="save_email">접속정보를 저장합니다.</label>
					</div>
				</form>
				<div class="align-middle container login_btn_wrap">
					<button id="localLoginBtn" type="button"
						class="btn btn-primary btn-lg btn-block"
						style="border-radius: 15px;">로 그 인</button>
				</div>
		</div>
	
	
	<p class="tit_desc_p">카카오 계정이나 네이버 계정이 있으신가요?</p>
 	<div class="social_login_box">
	 
	 <ul>
	 	<li>
	 		 <a id="kakao-login-btn"></a>	
	 	</li>
	 	<li>
		 	<div id="naver_id_login">
				<button id="naverLoginBtn">
					<img src="<%=request.getContextPath()%>/resources/img/social/naverlogin_btn.png" />
				</button>
				<a id="naverLoginLink"></a>
			</div>
	 	</li>
	 </ul>
 
 	</div>


	<a id="mainBtn" href="<%=request.getContextPath()%>" style="display: none;"></a>
	
	
	</div>

	<script type='text/javascript'>
  
  	var resJsonObject  = null;
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('976799ddb837551832e4f37742249b02');
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        // 로그인 성공시, API를 호출합니다.
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(res) {
             resJsonObject = JSON.stringify(res);
             console.log(res);
            
            $.ajax({
            	
            	url:"<%=request.getContextPath()%>/mentee/loginSuccess",
							type : "post",
							data : resJsonObject,
							contentType : 'application/Json',
							dataType : "json",
							success : function(data) {
								alert("success");
								$("#mainBtn").get(0).click();
							},
							error : function(data) {
								alert("error");
							}

						});

						// 
					},
					fail : function(error) {
						alert(JSON.stringify(error));
					}
				});
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
		//]]>
	</script>
	
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