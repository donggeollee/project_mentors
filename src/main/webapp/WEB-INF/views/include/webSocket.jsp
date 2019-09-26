<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹소켓 팝업</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<style type="text/css">
* {box-sizing: border-box;}

/* Button used to open the chat form - fixed at the bottom of the page */
.open-button {
  background-color: #555;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 28px;
  width: 280px;
  z-index: 8;
}

/* The popup chat - hidden by default */
.chat-popup {
  display: none;
  position: fixed;
  bottom: 0;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
}

/* Full-width textarea */
.form-container textarea {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
  resize: none;
  min-height: 100px;
}

/* When the textarea gets focus, do something */
.form-container textarea:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/send button */
.form-container .btn {
  background-color: #4CAF50;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  width: 100%;
  margin-bottom:10px;
  opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}

</style>
</head>
<body>

<button class="open-button" onclick="openForm()" id="connBtn">문의하기</button>

<div class="chat-popup" id="myForm">
  <form action="/action_page.php" class="form-container">
    <h5 style="font-color:gray">문의하기</h5> 
   
    <textarea rows="15" cols="30"  placeholder="Type message.." name="msg" id="writeMsg" required></textarea>
	<input type="text" >
    <button type="submit" class="btn" id="sendBtn">보내기</button>
    <button type="button" class="btn cancel" id="closeBtn" onclick="closeForm()">닫기</button>
  </form>
</div>
	
<script type="text/javascript">
	var wsocket = null;
	var connectType = null;
	var member_name = null;
	var messageTarget = null;
	
	$(document).ready(function() {
		$("#connBtn").click( function() { connect(); } )		
		$("#sendBtn").click( function() { sendMsg(); } )
		$("#closeBtn").click( function() { sockClose(); } )
	});
	
	function connect(){ 
		
		if( wsocket != null )
			return;
		 
		var memberType = "${memberType}"; 
		alert(memberType);
		if ( memberType == "mentee") {
			connectType = "mentee";
			member_name = "${loginMember.mentee_name}";
		} else { 
			connectType = "mentor";
			member_name = "${loginMember.mentor_name}";
		} 
		url = "ws://localhost:8080/mentors/inquiryChat";
		wsocket = new WebSocket(url);
		
		wsocket.onopen = function() {
			wsocket.send( "connectType," + connectType + "," + member_name);
		}
		wsocket.onclose = onClose;
		wsocket.onmessage = onMessage;
		
		var message = $("#chat-window").html("관리자와 채팅을 시작합니다(연결성공)");
	}
	
	function sockClose() {
		if( wsocket == null )
			return;
		wsocket.close()
	}
	
	function sendMsg() {
		if( wsocket == null ) { 
			alert("웹 소켓이 연결되지 않았습니다.")
			return;
		}
		wsocket.send( "sendType," + connectType + "," + $("#writeMsg").val() );
	}
	
	function onMessage(evt) {
		var data = evt.data;
		$("#chat_window").append(data);
		var target_new = "newClient:"
		var target_close = "closed:"
	}
	
	function onClose(evt) {
		var message = $("#chat-window").html()
		message += "클라이언트가 퇴장했습니다."
		$("#chat-window").html(message);	
	}
	
	 
</script>	
<script>
	function openForm() {
	  document.getElementById("myForm").style.display = "block";
	}
	
	function closeForm() {
	  document.getElementById("myForm").style.display = "none";
	}
</script>
</body>
</html>