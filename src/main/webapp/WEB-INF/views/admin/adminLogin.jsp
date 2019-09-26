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
	href="<%=request.getContextPath()%>/resources/css/mentors/left_nav.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/content.css">	
<title>관리자페이지</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("#adminLoginBtn").on("click", function () {
			
			var adminAccount = new Object();
			adminAccount.admin_id = $("#admin_ID").val();
			adminAccount.admin_password = $("#admin_PW").val();
			
			adminJsonAccountObject = JSON.stringify(adminAccount);
			
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/login',
				type: "post",
		        contentType: "application/json",
		        data: adminJsonAccountObject,
		        dataType: "json",
		        success: function (data) {
					if(eval(data)) {
						alert("로그인 성공!");
						window.location = "<%=request.getContextPath()%>/admin/main#";
					} else {
						$("#pwCheck").text("아이디와 비밀번호를 확인해주세요.");
					}
				},
				error: function () {
					alert("로그인 과정 중에 문제가 발생했습니다!");
				}
			});
		});
	});
</script>
</head>
<body>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav_mentor.js"></script>

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/admin_header.jsp" flush="false"></jsp:include>
	
	<div id="content_wrap">
		<div class="login">
			<div class="loginForm">
				<h3 class="content_title">ADMIN LOGIN</h3>
			  	<div class="input-box">
						<input type="text" id="admin_ID" name="admin_ID" placeholder="Admin" required>
					</div>
					<div class="input-box">
						<input type="password" id="admin_PW" name="admin_PW" placeholder=" Password" required>
					</div>
			    <button id="adminLoginBtn">관리자 로그인</button>
				    <p>멘토스 관리자만 로그인 가능합니다</p>
		 	 </div>
		</div>
  </div>

	
	
	
	
	<jsp:include
	page="${ requestScope.contextPath }/WEB-INF/views/include/admin_footer.jsp"
	flush="false"></jsp:include>
	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-migrate-3.0.1.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/popper.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.easing.1.3.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.waypoints.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.stellar.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/owl.carousel.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.magnific-popup.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/aos.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.animateNumber.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/scrollax.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/main.js"></script>
	
</body>
</html>