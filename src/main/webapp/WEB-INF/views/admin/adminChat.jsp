﻿<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	href="<%=request.getContextPath()%>/resources/css/mentors/content.css">
	
	

<title>웹소켓 채팅 테스트</title>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	var adminChattingMember = null;
	var adminChattingMemberType = null;
	var messageTarget = null;
	var wsocket = null;
	var connectType = "admin";
	var memberMsg = null;
	var is_scroll_focus = true; 
	$(document).ready(function() {
		$("#connBtn").click(function() {
			connect();
		})
		$("#sendBtn").click(function() {
			sendMsg();
		})
		$("#closeBtn").click(function() {
			sockClose();
		})
	});
 
	function connect() {

		if (wsocket != null)
			return; 
 		// 웹소켓 구동시 구동하는 서버 IP 로 바꿔줘야 합니다. --> memberChat.jsp 도 마찬가지 
		wsocket = new WebSocket("ws://182.215.139.141:8080/mentors/inquiryChat");
 
		var connectMsg = "connect,admin"; 

		wsocket.onopen = function() {
			wsocket.send(connectMsg);
		}
		wsocket.onclose = onClose;
		wsocket.onmessage = onMessage;
		wsocket.onerror = onError;
		$("#connectStatus").html("상담이 진행 중입니다.");
	}

	function sendMsg() {
		if (wsocket == null) {
			alert("웹 소켓이 연결되지 않았습니다.")
			return;
		}
		var sendMsg = $("#writeMsg").val();

		wsocket.send("send," + "admin" + "," + sendMsg + ","
				+ adminChattingMember + "," + adminChattingMemberType);
		$("#writeMsg").val("");  
	}
	const intervalCall1000 = intervalCall(1000);
	function enterkey() {
		if (window.event.keyCode == 13){
        	intervalCall1000(() => {
        		sendMsg();
  		    })
        }
	}
	
	function intervalCall(interval){
		  // interval 시간 안에 다시 호출된 함수 콜은 무시한다
		  let elapsed = true
		  return (fn) => {
		    if(!elapsed){
		      return    // 마지막 호출 후 제한된 경과시간이 지나지 않은 경우 리턴
		    }
		    elapsed = false
		    fn()
		    setTimeout(() => {elapsed = true}, interval)
		  }
		}
	
	function onMessage(evt) {
		var NoJsonData = evt.data
		var data = JSON.parse(evt.data);
		var tagChatRoomText = "";
		if (data.type == "adminConnect") {
			var mentorChatRoom = data.mentorChatRoom;
			var menteeChatRoom = data.menteeChatRoom;
			for ( var key in mentorChatRoom) {
				var info = key.split(',');
				tagChatRoomText = "<p id=\"chatRoom_mentor_" + info[0]
						+ "\" onclick=\"chatShow('" + info[0] + ",mentor');\">"
						+ info[1] + "(" + info[0] + ")";
				tagChatRoomText += "<span class=\"lastMsg\" id=\"lastMessage_mentor_"+info[0]+"\"></span></p>"
				var tagChattingText = "<div id=\"chatting_mentor_"+info[0]+"\" style=\"display:none\"><div>"

				$("#mentorChatList").append(tagChatRoomText);
				$("#nowChatting").append(tagChattingText);
				$.each(mentorChatRoom[key], function(i, value) {
					var message = value.split(',');
					$.each(message, function(i, value) {
						var row = value.split(':');
						var receive_time = row[2] + "시" + row[3] + "분" + row[4]
								+ "초";
						if (row[0] == "mentor") {
							$("#chatting_mentor_" + info[0]).append(
									"<p>" + row[1] + " [" + receive_time + "]"
											+ "</p>");
						} else if (row[0] == "admin") {
							$("#chatting_mentor_" + info[0]).append(
									"<p class=\"adminMsg\">" + "[" + receive_time + "] " + row[1]
											+ "</p>");
						}

						if (i == message.length - 1) {
							$("#lastMessage_mentor_" + info[0]).html(
									"[" + row[0] + "]" + row[1]);
						}
					});
				});
			}
			for ( var key in menteeChatRoom) {
				var info = key.split(',');
				tagChatRoomText = "<p id=\"chatRoom_mentee_" + info[0]
						+ "\" onclick=\"chatShow('" + info[0] + ",mentee');\">"
						+ info[1] + "(" + info[0] + ")";
				tagChatRoomText += "<span class=\"lastMsg\" id=\"lastMessage_mentee_"+info[0]+"\"></span></p>";
				var tagChattingText = "<div id=\"chatting_mentee_"+info[0]+"\" style=\"display:none\"><div>";

				$("#menteeChatList").append(tagChatRoomText);
				$("#nowChatting").append(tagChattingText);
				$.each(menteeChatRoom[key], function(i, value) {
					var message = value.split(',');
					$.each(message, function(i, value) {
						var row = value.split(':')
						var receive_time = row[2] + "시" + row[3] + "분" + row[4]
								+ "초";
						if (row[0] == "mentee") {
							$("#chatting_mentee_" + info[0]).append(
									"<p>" + row[1] + " [" + receive_time + "]"
											+ "</p>");
						} else if (row[0] == "admin") {
							$("#chatting_mentee_" + info[0]).append(
									"<p class=\"adminMsg\">" + "[" + receive_time + "] " + row[1]
											+ "</p>");
						}

						if (i == message.length - 1) {
							$("#lastMessage_mentee_" + info[0]).html(
									"[" + row[0] + "]" + row[1]);
						}
					});
				});
			}

		} else if (data.type == "mentorConnect") {
			// 새로운 멤버가 접속했을 시 채팅방 개설 
			var mentorInfo = data.mentorInfo.split(',');
			if ($("#chatRoom_mentor_"+mentorInfo[1]).length > 0 ){
				return;
			}
			tagChatRoomText = "<p id=\"chatRoom_mentor_" + mentorInfo[1]
					+ "\" onclick=\"chatShow('" + mentorInfo[1]
					+ ",mentor');\">" + mentorInfo[0] + "(" + mentorInfo[1]
					+ ")";
			tagChatRoomText += "<span  class=\"lastMsg\" id=\"lastMessage_mentor_"+mentorInfo[1]+"\"></span></p>";
			var tagChattingText = "<div id=\"chatting_mentor_"+mentorInfo[1]+"\" style=\"display:none\"><div>";

			$("#mentorChatList").append(tagChatRoomText);
			$("#nowChatting").append(tagChattingText);
			// 새로운 문의 메세지 세팅 -> 채팅방, 마지막 메세지
			var mentorConnectMsg = data.mentorConnectMsg;
			var row = mentorConnectMsg.split(':');

			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";
			$("#chatting_mentor_" + mentorInfo[1]).append(
					"<p style=\"border:1px solid black\">" + row[1] + " [" + receive_time + "] " + "</p>");
			$("#lastMessage_mentor_" + mentorInfo[1]).html(
					"[" + row[0] + "]" + row[1]);

		} else if (data.type == "menteeConnect") {
			// 새로운 멤버가 접속했을 시 채팅방 개설 
			var menteeInfo = data.menteeInfo.split(',');
			if ($("#chatRoom_mentee_"+menteeInfo[1]).length > 0 ){
				return;
			}

			tagChatRoomText = "<p id=\"chatRoom_mentee_" + menteeInfo[1]
					+ "\" onclick=\"chatShow('" + menteeInfo[1]
					+ ",mentee');\">" + menteeInfo[0] + "(" + menteeInfo[1]
					+ ")";
			tagChatRoomText += "<span class=\"lastMsg\" id=\"lastMessage_mentee_"+menteeInfo[1]+"\"></span></p>";
			var tagChattingText = "<div id=\"chatting_mentee_"+menteeInfo[1]+"\" style=\"display:none\"><div>";

			$("#menteeChatList").append(tagChatRoomText);
			$("#nowChatting").append(tagChattingText);
			// 새로운 문의 메세지 세팅 -> 채팅방, 마지막 메세지
			var menteeConnectMsg = data.menteeConnectMsg;
			var row = menteeConnectMsg.split(':');

			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";
			$("#chatting_mentee_" + menteeInfo[1]).append(
					"<p style=\"border:1px solid black\">" + row[1] + " [" + receive_time + "] " + "</p>");
			$("#lastMessage_mentee_" + menteeInfo[1]).html(
					"[" + row[0] + "]" + row[1]);
			
		} else if (data.type == "adminSend") {
			var row = data.adminSendMsg.split(':');
			var memberInfo = data.memberInfo.split(',');
			
			if( data.emptyMentor == true ) { 
				alert("해당 멤버의 세션이 종료되었습니다. 채팅방을 삭제합니다"); 
				$("#chatting_" + memberInfo[0] + "_" + memberInfo[1]).remove();
				$("#chatRoom_" + memberInfo[0] + "_" + memberInfo[1]).remove();
			} else if ( data.emptyMentee == true ){
				alert("해당 멤버의 세션이 종료되었습니다. 채팅방을 삭제합니다"); 
				$("#chatting_" + memberInfo[0] + "_" + memberInfo[1]).remove();
				$("#chatRoom_" + memberInfo[0] + "_" + memberInfo[1]).remove();
			}
			
			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";
			$("#chatting_" + memberInfo[0] + "_" + memberInfo[1]).append(
					"<p class=\"adminMsg\">" + " [" + receive_time + "] " + row[1] + "</p>");
			$("#lastMessage_" + memberInfo[0] + "_" + memberInfo[1]).html(
					"[" + row[0] + "]" + row[1]);
		} else if (data.type == "mentorSend") {
			var mentor_id = data.mentorInfo;
			var row = data.mentorSendMsg.split(':');
			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";

			$("#chatting_mentor_" + mentor_id).append(
					"<p>" + row[1] + " [" + receive_time + "]" + "</p>");
			$("#lastMessage_mentor_" + mentor_id).html("[mentor]" + row[1]);
		} else if (data.type == "menteeSend") {
			var mentee_id = data.menteeInfo;
			var row = data.menteeSendMsg.split(':');
			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";

			$("#chatting_mentee_" + mentee_id).append(
					"<p>" + row[1] + " [" + receive_time + "]" + "</p>");
			$("#lastMessage_mentee_" + mentee_id).html("[mentee]" + row[1]);
		} else if (data.type == "closeMentor") {
			var mentor_id = data.mentor_id;
			// 채팅 목록에서 삭제 
			$("#chatRoom_mentor_" + mentor_id).remove();
			// 채팅방 삭제 (display:none 일수도 있음 표가 안남)
			$("#chatting_mentor_" + mentor_id).remove();
		} else if (data.type == "closeMentee") {
			var mentee_id = data.mentee_id;
			// 채팅 목록에서 삭제
			$("#chatRoom_mentee_" + mentee_id).remove();
			// 채팅방 삭제 (display:none 일수도 있음 표가 안남)
			$("#chatting_mentee_" + mentee_id).remove();
		} else if (data.type == "menteeSendImage"){
			var mentee_id = data.menteeInfo; 
			var row = data.menteeSendMsg.split(':');
			var receive_time = row[3] + "시" + row[4] + "분" + row[5] + "초";
			$("#chatting_mentee_" + mentee_id).append(
					"<p class=\"adminMsg\"><img width=\"200\" height=\"auto\" src=\""
					+ row[1] + ":" + row[2] + "\"></p>"
					 + "<p class=\"adminMsg\"> [" + receive_time + "] "+ "</p>"); 
			$("#lastMessage_mentee_" + mentee_id).html("[mentee] 사진이 도착했습니다." );
		} 
		
		 
		/* 스크롤 설정 */ 
		if ( $("#nowChatting")[0].scrollHeight - 700 > $("#nowChatting").scrollTop() ){
			is_scroll_focus = false;	
		} else {   
			is_scroll_focus = true; 
		} 
		 
		if ( is_scroll_focus ){
			$("#nowChatting").scrollTop($("#nowChatting")[0].scrollHeight);
		}  
	}

	function onClose(evt) {
		wsocket.close()
	}
	function sockClose() {
		if (wsocket == null)
			return;
		wsocket.send("close,admin");
		wsocket.close();
		window.location.href="adminChat";  
 	}

	function onError(evt) {

	}

	function chatShow(member_info) {
		var memberInfo = member_info.split(",");
		adminChattingMember = memberInfo[0];
		adminChattingMemberType = memberInfo[1];
		$("#nowChatting").children().attr("style", "display:none");
		$("#chatting_" + adminChattingMemberType + "_" + adminChattingMember)
				.attr("style", "display:true")
		
	}
</script>
<style>
 p{
	text-color : blue;
} 
 .adminMsg{
 	text-align : right;
 	text-color : red; 
 }
 .lastMsg{
 	<%-- border : 1px solid black;--%>
 	text-align : right;
 }
</style>
</head>
<body>
	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_header.jsp"
		flush="false"></jsp:include>
		
	
	<div class="cont">

	<h3>문의목록</h3>
	<button type="button" id="connBtn" class="btn btn-info">상담시작하기</button>
	<button type="button" id="closeBtn" class="btn btn-secondary" data-toggle="tooltip"
	 data-placement="right" title="상담을 종료해도 사용자가 종료할 때 까지 상담내용은 저장됩니다.">상담종료하기</button>
	 <span id="connectStatus">상담 연결이 해제된 상태 입니다.</span>
	<div class="chat_content_wrap"> 
		<div class="chat_list_area">
			<div class="mentorChatList_wrap">
				<p>멘토 문의 목록</p>
				<div id="mentorChatList" class="list_scroll">
					
				</div>
			</div>
			<div class="menteeChatList_wrap">
				<p>멘티 문의 목록</p>
				<div id="menteeChatList" class="list_scroll"></div>
			</div>
		</div>
		<div class="chatting_area">
			<p>채팅중인 대화방</p>
			<div id="nowChatting"></div>
			<div class="chat_input_box">
				<input type="text" id="writeMsg" onkeyup="enterkey();" ><input type="button" id="sendBtn" value="전송">
			</div>
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