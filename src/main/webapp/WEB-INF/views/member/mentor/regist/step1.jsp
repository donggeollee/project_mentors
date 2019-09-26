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
		<!-- Content here -->

		<p class="tit_desc_p">
			멘토님, 반갑습니다.<br>
			어떤 서비스를 제공할 수 있으신가요?<br>
			<span>한번 선택된 분야는 변경하실 수 없으며, 해당 분야의 글만 게시하실 수 있습니다.</span>
		</p>

		<%-- 
		<div class="progress" style="height: 5px;">
			<div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
		</div>
		
		--%>

		<div class="card-deck">
			<div class="card" style="cursor: pointer;" onclick="step2('IT');">
				<img
					src="<%=request.getContextPath()%>/resources/img/home/category-it.png"
					class="card-img-top" alt="">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">I T</h5>
					<p class="card-text">웹, 앱, 프로그래밍, 데이터베이스, 운영체제, 그 외</p>
				</div>
			</div>
			<div class="card" style="cursor: pointer;" onclick="step2('Music');">
				<img
					src="<%=request.getContextPath()%>/resources/img/home/category-music.png"
					class="card-img-top" alt="">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">음 악</h5>
					<p class="card-text">보컬, 악기, 음향, 그 외</p>
				</div>
			</div>
			<div class="card" style="cursor: pointer;" onclick="step2('Exercise');">
				<img
					src="<%=request.getContextPath()%>/resources/img/home/category-ex.png"
					class="card-img-top" alt="">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">운 동</h5>
					<p class="card-text">요가, 필라테스, PT, 헬스, 스포츠, 그 외</p>
				</div>

			</div>
			<div class="card" style="cursor: pointer;" onclick="step2('Cook');">
				<img
					src="<%=request.getContextPath()%>/resources/img/home/category-cook.png"
					class="card-img-top" alt="">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">요 리</h5>
					<p class="card-text">요리, 제과제빵, 주류, 바리스타, 그 외</p>
				</div>

			</div>
			<div class="card" style="cursor: pointer;" onclick="step2('Language');">
				<img
					src="<%=request.getContextPath()%>/resources/img/home/category-lan.jpg"
					class="card-img-top" alt="">
				<div class="card-body">
					<h5 class="card-title font-weight-bold">어 학</h5>
					<p class="card-text">영어, 제2외국어, 자격증, 시험준비, 그 외</p>
				</div>
			</div>
		</div>
	</div>

	<form id="category_choice" method="post" action="<%=request.getContextPath()%>/mentor/regist/step2">
		<input type="hidden" name="branch" value="">
	</form>

	<script type="text/javascript">
		function step2(category) {
			$('input[name="branch"]').val(category);
			$('#category_choice').submit();
		}
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