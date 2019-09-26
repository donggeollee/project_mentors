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

$(window).resize(function() { 
	reviewContentLocationControl();
});

$(function() {
	
	reviewContentLocationControl();
	
	$(".review_write_btn").on("click", function () {
		
		$("#review_form").css("display","block");	
		
		var $target = $(this).closest("li");
		
		var lesson_id = $target.find(".lesson_id").text();
		var mentor_name = $target.find(".mentor_name").text();
		var title = $target.find(".title").text();
		var lesson_category = $target.find(".lesson_category").text();
		
		console.log(lesson_id);
		console.log(title);
		
		$("#review_form .title").text(title);
		$("#review_form .lesson_id").text(lesson_id);
	})
	
	$(".review_write_submit_btn").on("click", function () {
		
		var $target = $(this).closest("div");
		
		console.log($target.find(".lesson_id").text());
		console.log($target.find(".score").val());
		console.log($target.find(".review_content").val());
		
		var reviewObject = new Object();
			
		reviewObject.lesson_id = $target.find(".lesson_id").text();
		reviewObject.score = $target.find(".score").val();
		reviewObject.content = $target.find(".review_content").val();
		
		
				
		var reviewJsonObject = JSON.stringify(reviewObject);
		
		$.ajax({

			url:'<%=request.getContextPath()%>/mentee/myLesson/review',
			type:"post",
			async:false,
			contentType:"application/json; charset=utf-8",
			data:reviewJsonObject,
			dataType:"json",
			success:function(data){
					var result = eval(data);
					if( result ){
						alert("리뷰 작성 성공");
						$("#review_form").css("display","none");
						window.location.href='<%=request.getContextPath()%>/mentee/myLesson';
					}else {
						alert("리뷰 작성 실패");
					}
				
				}, 
			error:function(data){
				alert("리뷰 작성 과정에서 에러가 발생했습니다.");
			}
			
		})
		
		
	})
	
	
	$(".review_close_btn").on("click", function () {
		$("#review_form").css("display","none");	
	})
	
})


function reviewContentLocationControl() {
	
	var content_height = $("#right_content").height();	
	var document_width = $(document).width();
	
	var review_form_height = $("#review_form").height();
	var review_form_width = $("#review_form").width();

	$("#review_form").css("left",(document_width/2)-(review_form_width/2));
	$("#review_form").css("top",((content_height)/2)-(review_form_height/2));
	
}
</script>
<title>멘토스</title>
</head>
<body>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

	<div id="content_wrap">

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav.jsp" flush="false"></jsp:include>
	
	<div id="right_content" class="review_content">
		<h3 class="content_title first_h3">진행중인 레슨</h3>
		<p class="title_desc">멘토와 진행중인 레슨의 목록을 확인할 수 있습니다.</p>
		
		<c:if test="${ empty pLessonList }">
			<ul class="list_style1 no_data">
				<li>현재 진행중인 레슨이 없습니다.</li>
			</ul>
		</c:if>
		
		<c:if test="${ not empty pLessonList }">
			<ul class="list_style1">
				<c:forEach var="pList" items="${ pLessonList }" >
					<li>
						<p class="category">${ pList.category_big } / ${ pList.category_small }</p>
						<p>${ pList.mentor_name } 님의 </p>
						<p class="title"><a href="<%=request.getContextPath()%>/lesson/detail/${pList.lesson_id}">${ pList.title }</a></p>
						<p class="review">평균 리뷰점수 ${ pList.avg_score }(총  ${ pList.review_count } 개의 리뷰)</p>
					</li>
				</c:forEach>
			</ul>
		</c:if>
		
		<div class="admin_chat_desc">
			<p>진행중인 레슨을 중단하고 싶으신 경우, 관리자에게 채팅으로 문의해주세요.</p>
		</div>
		
		<h3 class="content_title">멘토링 완료된 레슨</h3>
		<p class="title_desc">멘토와 진행이 끝난 레슨의 목록을 확인할 수 있습니다.</p>
		
		<c:if test="${ empty fLessonList }">
			<ul class="list_style1 no_data">
				<li>현재 진행완료된 레슨이 없습니다.</li>
			</ul>
		</c:if>
		
		<c:if test="${ not empty fLessonList }">
			<ul class="list_style1">
				<c:forEach var="fList" items="${ fLessonList }" varStatus="s" >
					<li>
						<p class="lesson_id" style="display:none;">${ fList.lesson_id }</p>
						<p class="category">${ fList.category_big } / ${ fList.category_small }</p>
						<p>${ fList.mentor_name } 님의 </p>
						<p class="title"><a href="<%=request.getContextPath()%>/lesson/detail/${fList.lesson_id}">${ fList.title }</a></p>
						<p class="review">평균 리뷰점수 ${ fList.avg_score }(총  ${ fList.review_count } 개의 리뷰)</p>
						<c:if test="${ fList.lesson_id eq reviewCheckLessonList[s.index] }" var="r" >
							<div class="written_review">리뷰 작성 완료</div>
						</c:if>
						<c:if test="${ not r }">
							<button class="review_write_btn">리뷰 작성</button>
						</c:if>
					</li>
				</c:forEach>
			</ul>
		</c:if>
		
		<!-- 리뷰 작성 -->
		<div id="review_form">
			<h4>리뷰 작성란</h4>
			<span class="lesson_id" style="display:none"></span>
			<p class="title_wrap">[<span class="title"></span>] 레슨은 어떠셨나요?</p>
			<p class="score_desc">별점을 등록해주세요.</p>
			<select class="score">
				<option value="1">1점</option>
				<option value="2">2점</option>
				<option value="3">3점</option>
				<option value="4">4점</option>
				<option value="5">5점</option>
			</select>
			<textarea placeholder="허위 사실이나 근거 없는 비방을 목적으로 리뷰를 달았 을 시, 불이익이 있을 수 있습니다. 리뷰는 작성 후 수정하거나 삭제할 수 없으니 신중히 작성해주세요. (100글자 이내로 작성)" class="review_content"></textarea>
			<p class="button_wrap">
				<button class="review_close_btn">취소</button>
				<button class="review_write_submit_btn">리뷰등록</button>
			</p>
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