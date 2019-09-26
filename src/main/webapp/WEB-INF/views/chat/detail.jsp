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
	href="<%=request.getContextPath()%>/resources/css/mentors/left_nav.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/content.css">	
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>
<title>멘토스 채팅</title>
<style>
body {
	background: #eee;
}

.chat-list {
	padding: 0;
	font-size: .8rem;
}

.chat-list li {
	margin-bottom: 10px;
	overflow: auto;
	color: #ffffff;
}

.chat-list .chat-img {
	float: left;
	width: 48px;
}

.chat-list .chat-img img {
	-webkit-border-radius: 50px;
	-moz-border-radius: 50px;
	border-radius: 50px;
	width: 100%;
}

.chat-list .chat-message {
	-webkit-border-radius: 50px;
	-moz-border-radius: 50px;
	border-radius: 50px;
	background: #f1f1f1;
	display: inline-block;
	padding: 10px 20px;
	position: relative;
}

.chat-list .chat-message:before {
	content: "";
	position: absolute;
	top: 15px;
	width: 0;
	height: 0;
}

.chat-list .chat-message h5 {
	margin: 0 0 5px 0;
	font-weight: 600;
	line-height: 100%;
	font-size: .9rem;
}

.chat-list .chat-message p {
	line-height: 18px;
	margin: 0;
	padding: 0;
}

.chat-list .chat-body {
	margin-left: 20px;
	float: left;
	width: 70%;
}

.chat-list .in .chat-message:before {
	left: -12px;
	border-bottom: 20px solid transparent;
	border-right: 20px solid #f1f1f1;
}

.chat-list .out .chat-img {
	float: right;
}

.chat-list .out .chat-body {
	float: right;
	margin-right: 20px;
	text-align: right;
}

.chat-list .out .chat-message {
	background: #aafbad;
}

.chat-list .out .chat-message:before {
	right: -12px;
	border-bottom: 20px solid transparent;
	border-left: 20px solid #aafbad;
}

.card .card-header:first-child {
	-webkit-border-radius: 0.3rem 0.3rem 0 0;
	-moz-border-radius: 0.3rem 0.3rem 0 0;
	border-radius: 0.3rem 0.3rem 0 0;
}

.card .card-header {
	background: #17202b;
	border: 0;
	font-size: 1rem;
	padding: .65rem 1rem;
	position: relative;
	font-weight: 600;
	color: #ffffff;
}

.content {
	margin-top: 40px;
	margin-bottom: 40px;
}

.notification {
	width: 250px;
	height: 20px;
	height: auto;
	position: fixed;
	left: 50%;
	margin-left: -125px;
	bottom: 100px;
	z-index: 9999;
	background-color: #383838;
	color: #F0F0F0;
	font-family: Calibri;
	font-size: 15px;
	padding: 10px;
	text-align: center;
	border-radius: 2px;
	-webkit-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1);
	-moz-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1);
	box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1);
}
</style>


</head>
<body>


	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>
		
		<div id="content_wrap">

	<c:if test="${ not empty sessionScope.loginMember and sessionScope.memberType eq 'mentee' }">
		<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav.jsp" flush="false"></jsp:include>
	</c:if>
	
	<c:if test="${ not empty sessionScope.loginMember and sessionScope.memberType eq 'mentor' }">
		<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_mentor.jsp" flush="false"></jsp:include>
	</c:if>
	
	<div id="right_content" class="review_content">


	<div class="container content" id="scrollArea"style="height: 500px; overflow: scroll;">
		<div class="row">
			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
				<div class="card">
					<div class="card-header">Chat</div>
					<div class="card-body height3">
						<ul class="chat-list">
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
	<div class="input-group mb-3">
			<input type="text" class="form-control" id="input_message"
				placeholder="메시지를 입력하세요" aria-label="input_message"
				aria-describedby="input_message" style="border-radius: 10px 0px 0px 10px;">
			<div class="input-group-append">
				<button class="btn btn-outline-secondary" type="button"
					id="button-addon2" style="border-radius: 0px 10px 10px 0px;">전 송</button>
			</div>
		</div>
	</div>
	</div>
	</div>


<div class='notification' style='display:none'></div>


	<script type="text/javascript">
function chatListFunction(){
	var result = '';
	
	$.ajax({
		type:"post",
		url : "<%=request.getContextPath()%>/chat/list",
		data : {'chat_id' : '${chat_id}'},
		success: function(data){
			if($('.chat-list li:last .send_time').text() == parsingTime(data[data.length - 1].write_date))
				return;
			for(var i = 0 ; i < data.length ; i++){
				result += addChat(data[i].sender_name, data[i].sender_type, data[i].mentor_name, data[i].mentee_name, data[i].contents, parsingTime(data[i].write_date));
			}
			$('.chat-list').html(result);
			$("#scrollArea").scrollTop($("#scrollArea")[0].scrollHeight);
		},
		error: function(){
			$('.notification').html('ajax 요청중에 에러가 발생하였습니다.');
			$('.notification').fadeIn(400).delay(1000).fadeOut(400);
		}
	});
}

function parsingTime(write_date) {
	if(!write_date[4])
		write_date[4] = '00';
	if(!write_date[5])
		write_date[5] = '00';
	var parsed_write_date = write_date[0] + '년' +
		write_date[1] + '월' + write_date[2] + '일 '+
		write_date[3] + '시' + write_date[4] + '분' +
		write_date[5] + '초';
	return parsed_write_date;
}


function addChat(sender_name, sender_type, mentor_name, mentee_name, contents, write_date){
	if(sender_type == '${memberType}'){
		var chat = '<li class="out">' +
		'<div class="chat-img">' +
		'<img alt="Avtar" src="<%=request.getContextPath()%>/resources/images/mentors/profile/default_profile.png">' +
		'</div>' +
		'<div class="chat-body">' +
		'<div class="chat-message">' +
		'<h5>' +
		${memberType}_name +
		'</h5>' +
		'<p>' + 
		contents +
		'</p>' +
		'<p class="send_time" style="color:black;">' +
		write_date +
		'</p>' +
		'</div>' +
		'</div>' +
		'</li>';
	} else if('${memberType}' == 'mentor'){
		var chat = '<li class="in">' +
		'<div class="chat-img">' +
		'<img alt="Avtar" src="<%=request.getContextPath()%>/resources/images/mentors/profile/default_profile.png">' +
		'</div>' +
		'<div class="chat-body">' +
		'<div class="chat-message">' +
		'<h5>' +
		mentee_name +
		'</h5>' +
		'<p>' +
		contents +
		'</p>' +
		'<p class="send_time" style="color:black;">' +
		write_date +
		'</p>' +
		'</div>' +
		'</div>' +
		'</li>';
	} else {
		var chat = '<li class="in">' +
		'<div class="chat-img">' +
		'<img alt="Avtar" src="<%=request.getContextPath()%>/resources/images/mentors/profile/default_profile.png">' +
		'</div>' +
		'<div class="chat-body">' +
		'<div class="chat-message">' +
		'<h5>' +
		mentor_name +
		'</h5>' +
		'<p>' + 
		contents +
		'</p>' +
		'<p class="send_time" style="color:black;">' +
		write_date +
		'</p>' +
		'</div>' +
		'</div>' +
		'</li>';
	}
	return chat;
	/* $('.chat-list').append(chat); */
}

function getInfiniteChat(){
	setInterval(function(){
		chatListFunction();
	}, 1000);
}

function sendMessage(){
	var request_content = new Object();
	var chat_id = ${chat_id};
	var contents = $("#input_message").val();
	request_content.chat_id = chat_id;
	request_content.contents = contents;
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/chat/submit",
		data : JSON.stringify(request_content),
		dataType : "json",
		contentType : "application/json",
		success : function(data){
			$("#input_message").val('');
			$("#input_message").focus();
			$('.notification').html('메시지를 전송했습니다.');
			$('.notification').fadeIn(400).delay(1000).fadeOut(400);
		}
	});
}
$(function(){
	$("#button-addon2").on("click",function(){
		if($("#input_message").val().length == 0)
			return;
		sendMessage();
	});
	$("#input_message").on("keyup",function(e){
		if(this.value.length == 0)
			return;
		if(e.keyCode == '13')
			sendMessage();
	});
});

$(document).ready(function() {
	chatListFunction();
	getInfiniteChat();
});


</script>

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