<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$(".lesson_totalBtn").on("click",function(){
		window.location.href='<%=request.getContextPath()%>/lesson/choiceBigCate';
	})
	
})

</script>
<title>멘토 마이페이지</title>
</head>
<body>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

	<div id="content_wrap">
	
		<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_mentor.jsp" flush="false"></jsp:include>
		
		
		<div id="right_content" class="review_content">
		 	<h3 class="content_title first_h3">내가 등록한 레슨</h3>
		 	<p class="title_desc">내가 등록한 레슨의 목록을 확인할 수 있습니다</p>
		
		<div class="select_wrap">
			<button class="lesson_totalBtn">전체 레슨 목록 이동</button>	
		</div>
		
		<div>	
		 	<c:if test="${ empty mentor_classlist}" var="r">
		<ul class="list_style1 no_data">
		 		<li>작성한 게시글이 존재하지 않습니다</li>
		 	</ul>
		 	</c:if>
		 	
		 	<c:if test="${not r}">
			 	<c:forEach items="${mentor_classlist}" var="list">
			 		<ul class="list_style1">
			 		  <li>
			 			<p class="title">${list.title}</p>
			 			<p class="review">평균 리뷰 점수 ${list.avg_score} (총 ${list.review_count}개의 평가)</p>
			 			<a href="<%=request.getContextPath()%>/lesson/detail/${list.lesson_id}">상세보기</a>
			 			<%-- <a href="<%=request.getContextPath()%>/lesson/update/detail/${list.lesson_id}">수정</a>  --%>
			 		  </li>	
			 		</ul>
			 	</c:forEach>
		 	</c:if>
		</div>
		
	 </div>	 
		 <div id="pagingNum" class="pagePart">
		   <ul> 
				<c:if test="${beforePageNo ne -1 }">
			    <a href="<%=request.getContextPath()%>/mentor/myWriteLesson/${beforePageNo}">이전</a>
				</c:if>
		  
				<c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
					<c:if test="${curPage eq pageNo}" var="r">
					<b>[${pageNo}]</b>
					</c:if>
			
				<c:if test="${not r}">
					<a href="<%=request.getContextPath()%>/mentor/myWriteLesson/${pageNo}">${pageNo}</a>
				</c:if>
			</c:forEach> 
			
			<li class="pagingFirst">
			<c:if test="${afterPageNo ne -1 }">
				<a href="<%=request.getContextPath()%>/mentor/myWriteLesson/${afterPageNo}">다음</a>
			</c:if>
			</ul>
		</div>
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