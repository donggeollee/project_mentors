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
<title>멘토 마이페이지</title>
<script type="text/javascript" src='<%=request.getContextPath()%>/resources/js/jquery.js'></script>

<script type="text/javascript">
	var str='';
	var title=$(".title_search_li");
	
	$(document).ready(function(){
		
		$(".mentoring_no_btn").on("click",function(){
			
			var $target = $(this).closest("ul");
			
			var lesson_id =$target.closest("ul").find(".lesson_id").text();
			var mentee_id = $target.closest("ul").find(".mentee_id").text();
			
			console.log(lesson_id);
			console.log(mentee_id);
			
			var lessonObject = new Object();
			lessonObject.mentee_id = mentee_id;
			lessonObject.lesson_id = lesson_id;
			
			var lessonSubmitObject = JSON.stringify(lessonObject);
			alert(lessonSubmitObject);
			
			$.ajax({

				url:'<%=request.getContextPath()%>/mentor/mentoring/reject',
				type:"post",
				async:false,
				contentType:"application/json; charset=utf-8",
				data:lessonSubmitObject,
				dataType:"json",
				success:function(data){
					if( eval(data)){
					alert(JSON.stringify(data));
					alert(data);
					alert("요청거절 완료!")
					location.reload();
				} else {
					alert("요청거절 실패!")
					return;
				} 
					
			}, 
				error:function(data){
					alert('요청 거절 과정에서 문제 발생 - 관리자 문의 요망')
				}
				
			});
			
		});
		
		
	$(".mentoring_ok_btn").on("click",function(){
			
			var $target = $(this).closest("ul");
			
			var lesson_id =$target.closest("ul").find(".lesson_id").text();
			var mentee_id = $target.closest("ul").find(".mentee_id").text();
			
			console.log(lesson_id);
			console.log(mentee_id);
			
			var lessonObject = new Object();
			lessonObject.mentee_id = mentee_id;
			lessonObject.lesson_id = lesson_id;
			
			var lessonSubmitObject = JSON.stringify(lessonObject);
			alert(lessonSubmitObject);
			
			$.ajax({

				url:'<%=request.getContextPath()%>/mentor/mentoring/accept',
				type:"post",
				async:false,
				contentType:"application/json; charset=utf-8",
				data:lessonSubmitObject,
				dataType:"json",
				success:function(data){
					if( eval(data)){
					alert(JSON.stringify(data));
					alert(data);
					alert("요청수락 성공!")
					location.reload()
				} else {
					alert("요청수락 실패!")
					return;
				} 
					
			}, 
				error:function(data){
					alert('요청 수락 과정에서 문제 발생 - 관리자 문의 요망')
				}
				
			});
			
		});
		
	});
	

	

</script>
</head>
<body>

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>
	
		<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

<div id="content_wrap">

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_mentor.jsp" flush="false"></jsp:include>
	
		<div id="right_content" class="review_content">
			 	<h3 class="content_title first_h3">멘토링 요청 확인</h3>
			 	<p>멘티들로부터 도착한 멘토링 요청을 관리할 수 있습니다</p>
			
			<div>
			   <c:if test="${not empty mentoring_list}" var="r">
			   	 <c:forEach items="${mentoring_list}" var="list">
				<ul class="list_style1">
					<li class="title_search_li">
						<p class="title">레슨명 [${list.title}]</p>
					 	<p style="display:none">
					 		<span class="lesson_id">${list.lesson_id}</span>
					 		<span class="mentee_id">${list.mentee_id}</span>
					 	</p>
					<p class="name">${list.mentee_name} (${list.mentee_email}) 회원 님으로부터 멘토링 요청</p>
					<div class="mentoring_confirm">
						<button class="mentoring_ok_btn">요청수락</button>
						<button class="mentoring_no_btn">요청거절</button>
					</div>
					</li>
				</ul>
				 </c:forEach>
				</c:if>
				
				<c:if test="${not r}">
					<ul class="list_style1 no_data">
					<li>멘티로부터의 요청이 존재하지 않습니다.</li>
				</ul>
				</c:if>
			</div>
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