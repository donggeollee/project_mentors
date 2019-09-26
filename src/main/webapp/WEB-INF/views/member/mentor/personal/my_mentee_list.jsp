<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>나의 멘티</title>
<script type="text/javascript"
	src='<%=request.getContextPath()%>/resources/js/jquery.js'></script>
<style type="text/css">
</style>


<script type="text/javascript">
	var str='';
	var title=$(".title");
	
	$(document).ready(function(){
		
		$(".complete_btn").on("click",function(){
			
			var $target = $(this).closest("ul");
			
			var lesson_id =$target.find($(".lesson_id")).text();
			var mentee_id = $target.find($(".mentee_id")).text();
			
			console.log(lesson_id);
			console.log(mentee_id);
			
			var lessonObject = new Object();
			lessonObject.mentee_id = mentee_id;
			lessonObject.lesson_id = lesson_id;
			
			var lessonSubmitObject = JSON.stringify(lessonObject);
			alert(lessonSubmitObject);
			
			$.ajax({

				url:'<%=request.getContextPath()%>/mentor/menteelist/complete',
				type : "post",
				async : false,
				contentType : "application/json; charset=utf-8",
				data : lessonSubmitObject,
				dataType : "json",
				success : function(data) {
				if (eval(data)) {
					alert(JSON.stringify(data));
					alert(data);
					alert("멘토링 완료 성공!")
					location.reload();
				} else {
					alert("멘토링 완료 실패!")
					return;
				}
       	},
				error : function(data) {
			   alert('멘토링 완료 과정에서 문제 발생 - 관리자 문의 요망')
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
			<h3 class="content_title first_h3">나의 멘티</h3>
			<p class="title_desc">현재 나의 멘티들에 대한 정보를 확인할 수 있습니다</p>
			<div id="contents">
				<div id="js-load" class="main">
					<c:if test="${not empty title_list}">
					<c:forEach items="${title_list}" var="r2">
						<div class="mentee_list_wrap">
						<p class="lesson_title">레슨 [${ r2.title }]</p>
						<div class="total">
							<c:forEach items="${mentee_list}" var="result_list"
								varStatus="status">
								<c:if test="${ r2.lesson_id eq result_list[0].lesson_id}"
									var="menteeR">
									<p class="mentee_count">
										멘토링 진행중인 멘티 총 <span class="list_count">${ result_list.size() }</span>명
									</p>
									<c:forEach items="${result_list}" var="real">
										<ul class="lists">
											<li class="list" style="display: none">
												<p>
													<span class="lesson_id">${real.lesson_id}</span> <span
														class="mentee_id">${real.mentee_id}</span>
												</p>
											</li>
											<%-- <li>${ real.mentee_profile }</li> --%>
											<li>멘티 이름 : ${ real.mentee_name }</li>
											<li>멘티 이메일 : ${ real.mentee_email }</li>
											<li><input type="button" value="멘토링 완료하기"
												class="complete_btn"></li>
										</ul>
									</c:forEach>
								</c:if>
							</c:forEach>
							<!--  <a id="more_btn_a">더보기</a> -->
							</div>
						</div>
						
					</c:forEach>
					
					</c:if>
					
					<c:if test="${empty title_list}">
						<ul class="list_style1 no_data">
					 		<li> 현재 멘토링중인 멘티가 없습니다. </li>
					 	</ul>
					</c:if>

				</div>
			</div>

		</div>


		<form id="searchTxtForm">
		<input type="hidden" name="viewCount" id="viewCount" value="0">
		<input type="hidden" name="startCount" id="startCount" value="0">
	</form>

	
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