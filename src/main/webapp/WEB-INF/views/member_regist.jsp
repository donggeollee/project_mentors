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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mentors/common.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<title>멘토스 회원가입</title>
</head>
<body>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>

	<div class="cont">

		<%-- 
		<div class="progress" style="height: 5px;">
			<div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
		</div>
		 --%>
		<!-- 
		<div class="mt-4 row">
			<div class="col-sm">
				<h3 class="text-center font-weight-bold">안녕하십니까? 멘토스입니다.</h3>
			</div>
		</div>
		<div class="mt-4 row">
			<div class="col-sm">
				<h5 class="text-center" style="font-size:0.9rem;">멘토스 회원은 멘티와 멘토로 구분되어지며,</h5>
				<h5 class="text-center" style="font-size:0.9rem;">회원가입 시 멘토스의 모든 서비스를 이용하실 수 있습니다.</h5>
			</div>
		</div><div class="mt-4 row">
			<div class="col-sm">
				<h5 class="text-center" style="font-size:0.9rem;">(&#8251;멘티와 멘토는 서로 전환되지 않습니다.)</h5>
			</div>
		</div>
		 -->
		 
		 <div id="select_regist_type">
		 
		 	<p class="tit_desc_p">
				안녕하십니까? 멘토스 입니다.<br>
				<span>회원가입 시 멘토스의 모든 서비스를 이용하실 수 있습니다.<br>
				어떤 회원 유형으로 가입하시겠어요?
				</span>
				
			</p>
		 
		 	<ul>
		 		<li>
		 			<div onclick="location.href='<%=request.getContextPath()%>/mentee/regist'">멘티 가입</div>
		 		</li>
		 		<li>
		 			<div onclick="location.href='<%=request.getContextPath()%>/mentor/regist'">멘토 가입</div>
		 		</li>
		 	</ul>
		 </div>
	</div>

	<%-- 

	<div class="mt-5 mb-5 w-75 container">


		<div class="card-deck" style="padding:50px;">
		<div class="card m-4" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/mentee/regist'">
				<img src="<%=request.getContextPath()%>/resources/img/home/category-mentee.png"	class="card-img-top" alt=""
				style="padding:20px;">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">멘티로 가입</h5>
				</div>
			</div>
			<div class="card m-4" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/mentor/regist'">
				<img
					src="<%=request.getContextPath()%>/resources/img/home/category-mentor.png"
					class="card-img-top" alt="" style="padding:20px;">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">멘토로 가입</h5>
				</div>
			</div>
			
		</div>
	</div>
	
	 --%>


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