<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>	
<title>대분류</title>
</head>
<body>
<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>

		<div class="cont">
		
			<p class="tit_desc_p">
				딱 맞는 멘토를 추천해드립니다.<br>
				<span>원하는 분야의 카테고리를 선택하세요!</span>
			</p>
		
			<ul class="category_card">
				<li>
					<div class="card">
						<div class="card-img-area">
							<img
								src="<%=request.getContextPath()%>/resources/img/category/cook.jpg"
								class="card-img-top" alt="요리 레슨 보러 가기">
						</div>	
						<div class="">
							<p class="card-text">
								<a href="<%=request.getContextPath()%>/lesson/lessonList/cook"
								class="">요리</a>
							</p>
						</div>
					</div>
				</li>
				<li>
					<div class="card">
						<div class="card-img-area">
							<img
								src="<%=request.getContextPath()%>/resources/img/category/it.jpg"
								class="card-img-top" alt="IT 레슨 보러 가기">
						</div>	
						<div class="">
							<p class="card-text">
								<a href="<%=request.getContextPath()%>/lesson/lessonList/it"
								class="">IT</a>
							</p>
						</div>
					</div>					
				</li>
				<li>
					<div class="card">
						<div class="card-img-area">
							<img
								src="<%=request.getContextPath()%>/resources/img/category/music.jpg"
								class="card-img-top" alt="음악 레슨 보러 가기">
						</div>
						<div class="">
							<p class="card-text">
								<a href="<%=request.getContextPath()%>/lesson/lessonList/music"
								class="">음악</a>
							</p>
						</div>
					</div>				
				</li>
				<li>
					<div class="card">
						<div class="card-img-area">
							<img src="<%=request.getContextPath()%>/resources/img/category/exercise.jpg"
							class="card-img-top" alt="운동 레슨 보러 가기">
						</div>
						<div class="">
							<p class="card-text">
							<a href="<%=request.getContextPath()%>/lesson/lessonList/exercise"
								class="">운동</a>
							</p>
						</div>
					</div>
				</li>
				<li>
					<div class="card">
						<div class="card-img-area">
							<img
								src="<%=request.getContextPath()%>/resources/img/category/language.jpg"
								class="card-img-top" alt="언어 레슨 보러 가기">
						</div>		
						<div class="">
							<p class="card-text">
								<a href="<%=request.getContextPath()%>/lesson/lessonList/language"
								class="">언어</a>					
							</p>
						</div>
					</div>
				</li>
			</ul>
					
		</div>	

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/footer.jsp"
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