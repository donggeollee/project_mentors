<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담 채팅 페이지</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	var wsocket = null;
	var connectType = null;
	var member_name = null;
	var member_id = null;
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

	/*
	function encodeBase64ImageFile (image) {
		  return new Promise((resolve, reject) => {
		    let reader = new FileReader()
		    // convert the file to base64 text
		    reader.readAsDataURL(image)
		    // on reader load somthing...
		    reader.onload = (event) => {
		      resolve(event.target.result)
		    }
		    reader.onerror = (error) => {
		      reject(error)
		    }
		  })
		}
	*/
	$(document).ready(function(){
		$("#chat_window").on("dragenter dragover",function(event){
			event.preventDefault(); 
		});
		// event : jquery 의 이벤트
		// originalEvent : javascript의 이벤트
		$("#chat_window").on("drop",function(event){
			event.preventDefault();
			if ( wsocket == null ){
				alert("문의하기 버튼을 눌러주세요")
				return; 
			}
				
			var files = event.originalEvent.dataTransfer.files;
			/* 첫번째 파일 */
			/* ctrl 누르고 동시에 여러개 올릴수도 있기 때문에 */ 
			var file = files[0];
			// 콘솔에서 파일정보 확인가능
			if ( !checkImageType(file.name) ){
				alert("이미지 형식의 파일만 전송할 수 있습니다 \n ex) jpg,gif,png,jpeg")
				return;
			}
			
			// 이미지를 base64로 인코딩한  문자열이 웹소켓으로 전송되려할 시 close가 발생하는 이유를 모르겠다 
			
			/* encodeBase64ImageFile(file) 
	 	      .then((data) => {
	 	    	 wsocket.send("send," + connectType + "_image" + "," + 
			  				data + "," + member_id);
		      })  */
				
			/* var fileReader = new FileReader();
			var encodingResult;
			
			// websocket 참조변수를 내부에서 사용하려면 아래와 같이 함수 사용
			fileReader.onload = (function (file) { 
				return function (e) { 
		                encodingResult = this.result; 
		                alert("connectType : "+connectType);
		                alert("encodingResult : "+encodingResult);
		                alert("member_id : "+member_id);  
		                wsocket.send("send," + connectType + "_image" + "," + 
				  				encodingResult + "," + member_id);
		            }
		      })(file);
			fileReader.readAsDataURL(file); */
		});
	});  
	
	function checkImageType(fileName) {
		var pattern = /jpg|gif|png|jpeg/i;
		return fileName.match(pattern);
	}

	function connect() { 
		
		$(".modal_wrap").css("display","none");

		if (wsocket != null){ 
			alert("웹 소켓이 이미 존재합니다.");
			return;
		}
			

		var memberType = '${memberType}';

		if (memberType == 'mentee') {
			connectType = "mentee";
			member_name = "${loginMember.name}";
			member_id = "${loginMember.id}";
		} else {
			connectType = "mentor"; 
			member_name = "${loginMember.name}";
			member_id = "${loginMember.id}";
		} 
		// 웹소켓 구동시 구동하는 서버 IP 로 바꿔줘야 합니다. --> adminChat.jsp 도 마찬가지
		url = "ws://182.215.139.141:8080/mentors/inquiryChat";
		wsocket = new WebSocket(url);
 
		wsocket.onopen = function() { 
			wsocket.send("connect," + connectType + "," + member_name + ","
					+ member_id);
		}
		wsocket.onclose = onClose; 
		wsocket.onmessage = onMessage;  
		$("#chat_window").html("<p>문의가 많을 시 답장이 지연될 수 있습니다. 잠시만 기다려주세요.</p>");
		$("#closeBtn").attr("style","display:display");  
	}
	const intervalCall1000 = intervalCall(1000);
	function sendMsg() {
		if (wsocket == null) {
			alert("웹 소켓이 연결되지 않았습니다.");
			return;
		}
		wsocket.send("send," + connectType + "," + $("#writeMsg").val() + ","
				+ member_id);
		$("#writeMsg").val("");    
	}
		
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
		var data = JSON.parse(evt.data);

		if (data.type == "adminSend") {
			var row = data.adminSendMsg.split(':');
			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";
			$("#chat_window").append(
					"<p class=\"adminMsg\">" + row[1] + " <관리자> [" + receive_time + "]" + "</p>");
		} else if (data.type == "mentorSend") {
			var row = data.mentorSendMsg.split(':');
			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";
			$("#chat_window").append(
					"<p class=\"memberMsg\">" + "[" + receive_time + "]"
							+ row[1] + "</p>");
		} else if (data.type == "menteeSend") {
			var row = data.menteeSendMsg.split(':');
			var receive_time = row[2] + "시" + row[3] + "분" + row[4] + "초";
			$("#chat_window").append(
					"<p class=\"memberMsg\">" + "[" + receive_time + "] "
							+ row[1] + "</p>");
		} else if (data.type == "menteeSendImage") {
			var row = data.menteeSendMsg.split(':');
			
			console.log("row[0] : " + row[0]);
			console.log("row[1] : " + row[1]); 
			console.log("row[2] : " + row[2]);
			console.log("row[3] : " + row[3]); 
			console.log("row[4] : " + row[4]);
			console.log("row[5] : " + row[5]); 
			
			var receive_time = row[3] + "시" + row[4] + "분" + row[5] + "초";
			$("#chat_window").append("<p class=\"memberMsg\"><img width=\"100\" height=\"auto\" src=\""
					+ row[1] + ":" + row[2] + "\"></p>"
					 + "<p class=\"memberMsg\"> [" + receive_time + "] "+ "</p>"); 
		}
 

		console.log("scrollHeight : "+$("#chat_window")[0].scrollHeight);
		console.log("scrollTop : "+$("#chat_window").scrollTop());  
		if ( $("#chat_window")[0].scrollHeight - 550 > $("#chat_window").scrollTop() ) 
			is_scroll_focus = false;	
		else 
			is_scroll_focus = true; 
		
		if ( is_scroll_focus )
			$("#chat_window").scrollTop($("#chat_window")[0].scrollHeight);
	}

	function onClose(evt) {  
		alert("현재 문의자가 많으니 잠시후 다시 시도해주시기 바랍니다. ");
		// close(); 
	} 

	function sockClose() { 
		if (wsocket == null) 
			return;
		wsocket.send("close," + connectType + "," + member_id);
		wsocket.close();
		wsocket = null;
		close();
	}
	
</script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<style>

body {
	padding:0 !important;
	margin:0 !important;
	background: #faf9fa;
}

.chat_wrap {
	padding-top:20px;
	box-sizing: border-box;
}

#chat_window {
	width: 430px;
	height:430px;
	overflow-y : auto;
	border: 1px solid #e1e3e2;
	border-radius: 10px;
	margin:0 auto;
	background: #fff;
} 

#chat_window p {
	font-size:13px;
	background: #dde8ec;
	margin:0;
	padding:0.6em 0;
}
 
.adminMsg{
	text-align: left;
}
 
.memberMsg {
	text-align: right;
}

.input_wrap {
	width: 430px;
	margin:0 auto;
	margin-top:10px;
}

.input_wrap #writeMsg {
	width: 70%;
	border: 1px solid #e1e3e2;
	height:50px;
	box-sizing: border-box;
	padding-left:5px;
	vertical-align: top;
	margin-left:4px;
}

.input_wrap input[type=button] {
	border: none;
    padding: 0 10px;
    background: #c5c5c5;
    color: #fff;
    font-size: 12px;
    border-radius: 4px;
    vertical-align: top;
    height:50px;
    line-height:50px;
    cursor:pointer;
}

.input_wrap #sendBtn {
	height: 100%;  
	width: 13%;
	background: #2684fb;
	margin-left:3px;     
}   
.input_wrap #closeBtn {
	height: 100%; 
	width: 12%;    
} 

div.chat_wrap {
	box-sizing:border-box;
	height:530px;
	position: relative;
}

div.modal_wrap {
	width:100%;
	height:100%;
	background:rgba(0,0,0,0.3);
	position: absolute;
	top:0;
	left:0px;
}

div.modal {
	width:250px;
	height:100px;
	background:#fff;
	border:1px solid #ddd;
	text-align: center;
	margin:0 auto;
	margin-top:195px;
	border-radius: 4px;
}


div.modal p {
	margin-top:20px;
	text-align: center;
}

div.modal input {
	border:none;
	color:#fff;
	background:#607d8b;
	padding:3px 10px;
	cursor: pointer;
	border-radius: 4px;
}



</style>
</head> 
<body> 

	<div class="chat_wrap">
		<div class="modal_wrap">
			<div class="modal">
				<p>상담을 시작합니다.</p>
				<input type="button" id="connBtn" value="확인" />
			</div>
		</div>
		
		<div id="chat_window">
		</div>
		<div class="input_wrap">
			<input type="text" id="writeMsg" onkeyup="enterkey();">
			<input type="button" id="sendBtn" value="전송"> 
			<input type="button" id="closeBtn" value="종료">  
		</div>
	</div>
	
<%-- <div>
  <p>base64 이미지 출력 테스트</p>
  <img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUA
    AAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO
        9TXL0Y4OHwAAAABJRU5ErkJggg==" alt="Red dot" />
</div> 
<span>Database image : </span> 
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAATCAIAAAAf7rriAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACISURBVDhPzYvLEYAwFALtzKvF21PEQPSFfHTGizucgF3SB/ryuu0xahtcNi1Gj0Al27uNfoVbtt8oemck22MeKmAoswfWIxoo24Zwu7AVYd+RORjdz69khNuFrQj7Uwa2IeyB9YiGiTwJFSAZ2GMUvTO3DOzXRr9CJQN7x+gRcJk8aqQvvyKlA6eGPYq2034+AAAAAElFTkSuQmCC" alt="Blue Circle"> --%>

</body>
</html>