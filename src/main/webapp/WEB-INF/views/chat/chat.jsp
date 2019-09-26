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
<!-- <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet"> -->
<title>채팅 목록</title>
<style type="text/css">
h3 {
	font-size: 16px;
	font-weight: bold;
}

p.title_desc {
	font-size:13px;
	color:#666;
}

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

table.chat_list_tb {
	background:#fff;
	margin-top:30px;
	border-top:2px solid #17a2b8;
	width:80%;
}

table.chat_list_tb thead th {
	  border-bottom: 1px solid #e3e3e3;
	  text-align:center;
	  color:#252a2b;
}

table.chat_list_tb tbody td, table.chat_list_tb tbody th {
	  text-align:center;
}

</style>
</head>

<body>

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>
		
			<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>


<div id="content_wrap">

	<c:if test="${ not empty sessionScope.loginMember and sessionScope.memberType eq 'mentee' }">
		<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav.jsp" flush="false"></jsp:include>
	</c:if>
	
	<c:if test="${ not empty sessionScope.loginMember and sessionScope.memberType eq 'mentor' }">
		<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_mentor.jsp" flush="false"></jsp:include>
	</c:if>
	
	<div id="right_content" class="review_content">

		<h3>나의 메시지</h3>
		<p class="title_desc">메시지를 보내고, 채팅 목록을 확인할 수 있습니다.</p>

			<table class="table table-hover chat_list_tb">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">대화 상대</th>
						<th scope="col">최근 메시지</th>
						<th scope="col">시간</th>
						<th scope="col">읽지 않은 메시지</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${memberType eq 'mentor'}" var="memberDistinction"> 
					<c:if test="${empty chatList}">
						<tr>
							<td colspan="5">메시지가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty chatList}">
					<c:forEach var="chatList" items="${chatList}" varStatus="status">
						<tr style="cursor: pointer;"  onclick="location.href='<%=request.getContextPath()%>/chat/detail/${chatList.chat_id}'">
							<th scope="row">${status.count}</th>
							<td>${chatList.mentee_name}</td>
							<td>${chatList.contents }</td>
							<td>${chatList.time}</td>
							<td>${chatList.unread_count}</td>
						</tr>
					</c:forEach>
					</c:if>
				</c:if>
				<c:if test="${!memberDistinction}">
					<c:if test="${empty chatList}">
						<tr>
							<td colspan="5">메시지가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty chatList}">
					<c:forEach var="chatList" items="${chatList}" varStatus="status">
						<tr style="cursor: pointer;"  onclick="location.href='<%=request.getContextPath()%>/chat/detail/${chatList.chat_id}'">
							<th scope="row">${status.count}</th>
							<td>${chatList.mentor_name}</td>
							<td>${chatList.contents }</td>
							<td>${chatList.time}</td>
							<td>${chatList.unread_count}</td>
						</tr>
					</c:forEach>
					</c:if>
				</c:if>
				
				</tbody>
			</table>
		</div>
	</div>	
	
	<button class="open-button" onclick="openForm()" style="display: none;">문의하기</button>

<div class="chat-popup" id="myForm">
  <form action="/action_page.php" class="form-container">
    <h1>문의하기</h1>
    <div class="container" style="height:75px;">
    	<p>aaa</p>
    	<p>bbb</p>
    </div>

    <label for="msg"><b>메시지 내용</b></label>
    <textarea placeholder="Type message.." name="msg" required></textarea>

    <button type="submit" class="btn">보내기</button>
    <button type="button" class="btn cancel" onclick="closeForm()">닫기</button>
  </form>
</div>
	
	
	<script>
function openForm() {
  document.getElementById("myForm").style.display = "block";
}

function closeForm() {
  document.getElementById("myForm").style.display = "none";
}
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