<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- 비회원 메뉴 -->
<c:if test="${ empty sessionScope.loginMember }">

    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%= request.getContextPath() %>/">MENTORS</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
		        <ul class="navbar-nav ml-auto">
 				  <li class="nav-item"><a href="<%= request.getContextPath() %>/lesson/choiceBigCate" class="nav-link">레슨 찾기</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/regist" class="nav-link"><span></span>회원가입</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/mentee/login" class="nav-link"><span></span>멘티 로그인</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/mentor/login" class="nav-link"><span></span>멘토 로그인</a></li>
		        </ul>
	      </div>
	    </div>
	  </nav>
	  
</c:if>
	  
<!-- 멘티메뉴 -->
<c:if test="${ not empty sessionScope.loginMember and sessionScope.memberType eq 'mentee' }">

	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%= request.getContextPath() %>/">MENTORS</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
		        <ul class="navbar-nav ml-auto">
		          <li class="nav-item active"><a href="<%= request.getContextPath() %>/lesson/choiceBigCate" class="nav-link">레슨 찾기</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/mentee/myLesson" class="nav-link">나의 레슨 정보</a></li>
		          <li class="nav-item open_menu"><a href="<%= request.getContextPath() %>/mentee/myPage" class="nav-link">마이페이지</a></li>
		          <li class="nav-item open_menu"><a href="<%= request.getContextPath() %>/mentee/logout" class="nav-link">로그아웃</a></li>
		          <li class="nav-item top_profile_wrap close_menu">
		          		<p>
			          		<span class="top_profile">
			          		<img src="<%=request.getContextPath()%>/resources/profiles/${empty loginMember.mentee_profile ? 'default_profile.png' : loginMember.mentee_profile}"> </span>
			          		${ sessionScope.loginMember.mentee_name }
				     	</p>
				     	<div class="member_dropbox">
				        	<ul>
		         				<li><a href="<%= request.getContextPath() %>/mentee/myLikeLesson">찜한 레슨</a></li>
		          				<li><a href="<%= request.getContextPath() %>/mentee/myLesson">나의 레슨 정보</a></li>
		          				<li><a href="<%= request.getContextPath() %>/mentee/myPage">마이페이지</a></li>
				        		<li><a href="<%= request.getContextPath() %>/mentee/logout">로그아웃</a></li>
				        	</ul>
				        </div>
		          	</li>
		        	
		        	<li class="nav-item close_menu">
		        		<div class="dropdown alarm">
							<a class="btn btn-sm dropdown-toggle" href="#"
								role="button" id="dropdownMenuLink" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> <span
								class="<%--icon-bell--%>bell_icon"><img src="<%=request.getContextPath()%>/resources/images/mentors/notification.svg"></span><span class="<%--badge badge-light--%>"
								id="unread_count"></span>
							</a>
	
							<div class="dropdown-menu dropdown-menu-right message_alarm" id="message_info"
								aria-labelledby="dropdownMenuLink"></div>
						</div>
		        	</li>
		        </ul>
		        
	      </div>
	    </div>
	  </nav>
	  
	 <script>
	
	function senderListFunction(){
		
		$.ajax({
			type:"post",
			url: "<%=request.getContextPath()%>/chat/unread",
			success:function(data){
				if(data == ""){
					return;
				}
				var message_info = '';
				for (var i = 0 ; i < data.messageSenderList.length ; i++){
					message_info +=addMessageInfo(data.messageSenderList[i].sender_mentor, data.messageSenderList[i].chat_id);	
				}
				if(data.messageSenderList.length == 0){
					$('#message_info').html('<a class="dropdown-item"> 도착한 메시지가 없습니다.</a>');
				}else{
					$('#message_info').html(message_info);
				}
				console.log($('#unread_count').html());
			/* 	if(data.unreadCount > $('#unread_count').html() && $('#unread_count').html() != ''){
					$('.notification').html('메시지가 도착하였습니다.');
					$('.notification').fadeIn(400).delay(1000).fadeOut(400);
				} */
				$('#unread_count').html(data.unreadCount);
			}
		});
	}
	
	function addMessageInfo(sender_mentor, chat_id){
		
		return '<a class="dropdown-item" href="<%= request.getContextPath()%>/chat/detail/'
		+ chat_id + '">' + sender_mentor + '멘토로부터 메시지가 도착하였습니다.</a>';
		
	 }
	
	function getInfiniteSenderList(){
		setInterval(function(){
			senderListFunction();
		}, 3000);
	}
	
	
	$(document).ready(function() {
		senderListFunction();
		getInfiniteSenderList();
	});
</script>

<script>
	
$(document).ready(function() {
	
	$('.top_profile_wrap').click(function(){
		$(".member_dropbox").slideToggle(0);
	});
		
});
	
</script>
	  
</c:if>

<!-- 멘토메뉴 -->
<c:if test="${ not empty sessionScope.loginMember and sessionScope.memberType eq 'mentor' }">
	
    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%= request.getContextPath() %>/">MENTORS</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
		        <ul class="navbar-nav ml-auto">
		          <li class="nav-item active"><a href="<%= request.getContextPath() %>/lesson/choiceBigCate" class="nav-link">레슨 찾기</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/mentor/lesson/write" class="nav-link">레슨 작성</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/mentor/menteelist" class="nav-link">나의 멘티</a></li>
		          <li class="nav-item open_menu"><a href="<%= request.getContextPath() %>/mentor/myPage" class="nav-link">마이페이지</a></li>
		           <li class="nav-item open_menu"><a href="<%= request.getContextPath() %>/mentor/logout" class="nav-link">로그아웃</a></li>
		          <li class="nav-item top_profile_wrap close_menu">
		          		<p>
			          		<span class="top_profile"><img src="<%=request.getContextPath()%>/resources/profiles/${empty loginMember.mentor_profile ? 'default_profile.png' : loginMember.mentor_profile}"> </span>
			          		${ sessionScope.loginMember.mentor_name }
				     	</p>
				     	<div class="member_dropbox">
				        	<ul>
				        		<li><a href="<%= request.getContextPath() %>/mentor/myWriteLesson">내가 등록한 레슨</a></li>
				        		<li><a href="<%= request.getContextPath() %>/mentor/myLessonPicklist">나의 레슨을 찜한 멘티</a></li>
				        		<li><a href="<%= request.getContextPath() %>/mentor/mentoring">멘토링 요청 확인</a></li>
				        		<li><a href="<%= request.getContextPath() %>/mentor/myPage">회원정보수정</a></li>
				        		<li><a href="<%= request.getContextPath() %>/mentor/logout">로그아웃</a></li>
				        	</ul>
				        </div>
		          	</li>
		        	
		        	<li class="nav-item close_menu">
		        		<div class="dropdown alarm">
							<a class="btn btn-sm dropdown-toggle" href="#"
								role="button" id="dropdownMenuLink" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> <span
								class="<%--icon-bell--%>bell_icon"><img src="<%=request.getContextPath()%>/resources/images/mentors/notification.svg"></span><span class="<%--badge badge-light--%>"
								id="unread_count"></span>
							</a>
	
							<div class="dropdown-menu dropdown-menu-right message_alarm" id="message_info"
								aria-labelledby="dropdownMenuLink"></div>
						</div>
		        	</li>
		        </ul>
		        
	      </div>
	    </div>
	  </nav>
	  
	  <script>
	
	function senderListFunction(){
		
		$.ajax({
			type:"post",
			url: "<%=request.getContextPath()%>/chat/unread",
			success:function(data){
				if(data == ""){
					return;
				}
				var message_info = '';
				for (var i = 0 ; i < data.messageSenderList.length ; i++){
					message_info +=addMessageInfo(data.messageSenderList[i].sender_mentee, data.messageSenderList[i].chat_id);	
				}
				if(data.messageSenderList.length == 0){
					$('#message_info').html('<a class="dropdown-item"> 도착한 메시지가 없습니다.</a>');
				}else{
					$('#message_info').html(message_info);
				}
				console.log($('#unread_count').html());
				/* if(data.unreadCount > $('#unread_count').html() && $('#unread_count').html() != ''){
					$('.notification').html('메시지가 도착하였습니다.');
					$('.notification').fadeIn(400).delay(1000).fadeOut(400);
				} */
				$('#unread_count').html(data.unreadCount);
			}
		});
	}
	function addMessageInfo(sender_mentee, chat_id){
		
		return '<a class="dropdown-item" href="<%= request.getContextPath()%>/chat/detail/'
		+ chat_id + '">' + sender_mentee + '멘티로부터 메시지가 도착하였습니다.</a>';
		
	 }	
	function getInfiniteSenderList(){
		setInterval(function(){
			senderListFunction();
		}, 3000);
	}
	$(document).ready(function() {
		senderListFunction();
		getInfiniteSenderList();
	});
</script>

<script>
	
$(document).ready(function() {
	
	$('.top_profile_wrap').click(function(){
		$(".member_dropbox").slideToggle(0);
	});
		
});
	
</script>
	  
</c:if>