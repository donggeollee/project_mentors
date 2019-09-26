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
<title>강의 상세보기 페이지</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d6c1dace5c6136ad6ad1b9541ba466e4&libraries=services"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
 
	function pushLike(){
		if ( <c:out value='${empty loginMember}'/> ){
			alert("로그인 후 서비스 이용이 가능합니다.");
			return;
		}
		if ( "<c:out value='${memberType}'/>" == "mentor") {
			alert("멘티만 가능한 서비스 입니다.");
			return;
		}
		var likeValue = $("#likeBtn").val();
		var lesson_id = "<c:out value='${targetLesson.lesson_id}'/>";
		$.ajax({
			url : "<%=request.getContextPath()%>/like/pushLike",
			type : "post",
			data : {"likeValue" : likeValue , "lesson_id" : lesson_id},	
			success : function (data) {
				if( data == 0 ){
					$("#likeBtn").html('찜취소');
					$("#likeBtn").val('1');	
				}else{
					$("#likeBtn").html('찜하기');
					$("#likeBtn").val('0');	
				}
			},
			error : function(request,status,error) {
			}
		});
	}

	
	function requestChat(){
		$.ajax({
			type: 'post',
			url: '<%=request.getContextPath()%>/chat/request',
			data: {mentor_id : <c:out value='${targetMentor.mentor_id}'/>},
			success: function(data){
				location.href="<%=request.getContextPath()%>/chat/detail/" + data
			}
		});
	}
	
	$(document).ready(function () {
		
		$("#applyBtn").on("click", function () {
			
			var con_test = confirm("멘토링을 요청 하시겠습니까?");
			var lessonIDNumber = $("#lessonID").val();
			var mentorIDNumber = $("#mentorID").val();
			var target = new Object();
			target.lesson_id = lessonIDNumber;
			target.mentor_id = mentorIDNumber;
			
			var targetObject = JSON.stringify(target);
			if(con_test == true) {
				$.ajax({
					
					url:"<%=request.getContextPath()%>/lesson/applyMentoring",
					type:"post",
					contentType:"application/json",
					data:targetObject,
					dataType:"json",
					success:function(result){			
						if(eval(result)){	
							alert("멘토링 신청이 완료되었습니다.");
							location.reload();
						}
						 else {	
							alert('멘토링 신청 과정에서 문제가 발생했습니다.');
							return;
						 }				
					},
					// ajax 호출이 실패한 경우 실행되는 함수
					error:function(result){
						alert('멘토링 신청 과정에서 문제가 발생했습니다.');
						return;
					}
					
				});
				
			} else {
				return;
			}
			
		});
	});
	
</script>
</head>
<body>


	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>
	
	<div class="cont">

		<div id="mentor_profile_wrap">
			<div id="mentor_profile">
				<h4>멘토 프로필</h4>
				<div class="image_frame">
					<img src="<%=request.getContextPath()%>/resources/profiles/${ targetMentor.mentor_profile}">
				</div>
	
				<p class="name">${ targetMentor.mentor_name } 멘토님</p>
				<p class="email">${ targetMentor.mentor_email }</p>
				<p class="info">${ targetMentor.mentor_info }</p>
				<c:if test="${ memberType eq 'mentee' }">
					<button onclick="javascript:requestChat();">메시지로 문의하기</button>
				</c:if>
			</div>
		</div>

		<div id="mentor_lesson_wrap">
			<div id="mentor_lesson">
				
				<input type="hidden" id="lessonID" value="${ targetLesson.lesson_id }">
				<input type="hidden" id="mentorID" value="${ targetMentor.mentor_id }">
			
				<div class="lesson_header">
					<h4 class="title">${ targetLesson.title }</h4>
					<input type="hidden" id="location" value="${ targetLesson.location }" >
					<p class="loca"><img class="dl_ico" src="<%=request.getContextPath()%>/resources/images/mentors/location.svg">${ targetLesson.location }</p>
					<p class="round_and_price">
						<img class="dl_ico" src="<%=request.getContextPath()%>/resources/images/mentors/timer.svg">${ targetLesson.total_round }회 / ${ targetLesson.price }원</p>
					<p class="review"><img class="dl_ico" src="<%=request.getContextPath()%>/resources/images/mentors/star.svg">${ targetLesson.avg_score } (리뷰 ${ empty targetReviewList ? '0' : targetReviewList.size() }건)</p>
					<c:if test="${ memberType eq 'mentee' }">
						<c:if test="${ like_check eq 1 }">
							<button class="btn-secondary like-review" id="likeBtn" 
								value="0" onclick="pushLike()">찜하기</button>
						</c:if>
						<c:if test="${ like_check eq 0 }">
							<button class="btn-secondary like-review" id="likeBtn" 
								value="1" onclick="pushLike()">찜취소</button>
						</c:if>					
						<button id="applyBtn">멘토링 신청하기</button>
					</c:if>
				</div>
			
				<ul>
					<li>
						<p>소개</p>
						<div>
							${ targetLesson.lesson_info }
						</div>
					</li>
					<li>
						<p>커리큘럼</p>
						<div>${ targetLesson.curriculum }</div>
					</li>
					<li>
						<p>미디어</p>
						<div class="thum">
							<c:if test="${ empty targetImageList }" var="r">
								등록한 이미지가 없습니다.
							</c:if> 
							<c:if test="${ not r }">
								<c:forEach items="${ targetImageList }" var="img">
										<img src="<%=request.getContextPath()%>/resources/lessonImage/${img}">	
								</c:forEach>
							</c:if>
						</div>
					</li>
					<li>
						<p>위치</p>
						<div id="map" style="width: 82%; height: 400px;"></div>
					<script>
						var address = document.getElementById("location").value;
						var container = document.getElementById('map');
						var options = {
							center : new kakao.maps.LatLng(33.450701, 126.570667),
							level : 3
						};
	
						var geocoder = new daum.maps.services.Geocoder();
						geocoder.addressSearch(address, function(result, status) {
							  
							  if (status == daum.maps.services.Status.OK) {
							   
							   var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
							   y = result[0].x;
							   x = result[0].y;
	
							   var marker = new daum.maps.Marker({
							    map: map,
							    position: coords
							   });
	
	
							   map.setCenter(coords);
	
							  }
							 });
						
						var map = new kakao.maps.Map(container, options);
					</script>
					
					</li>				
				</ul>
				
			</div> <!-- lesson close -->
		
			<div id="review_area">
				
				<p>리뷰 ${  empty targetReviewList ? '0' : targetReviewList.size() } 건 </p>
				
				<ul class="review_list">
					<c:if test="${ empty targetReviewList }" var="isEmptyReview">
						<li>등록된 리뷰가 없습니다.</li>
					</c:if>
					
					<c:if test="${ not isEmptyReview }">
						<c:forEach items="${ targetReviewList }" var="review" varStatus="rv" >
							<li>
								<div>
									<%-- <img src="<%=request.getContextPath()%>/resources/profiles/${targetReviewWriterList.mentee_profile}">  --%>
									<p class="mentee_name">${targetReviewWriterList[rv.index].mentee_name} 님의 리뷰 <span>[리뷰 점수 ${ review.score }.0]</span></p>
									<p class="review_cont">${ review.content }</p>
									<p class="review_date">${ review.write_date } 작성</p>
								</div>
							</li>
						</c:forEach>
					</c:if>
				</ul>
					
			</div>
		
		</div>  <!-- lesson_wrap close -->

	</div> <!-- cont close -->
	
	
	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/footer.jsp" flush="false"></jsp:include>

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