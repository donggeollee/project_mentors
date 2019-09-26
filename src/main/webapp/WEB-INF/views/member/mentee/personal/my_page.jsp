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
<title>멘토스</title>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#updateProfileBtn").on("click",function(){
		$("#imgSelectBtn").trigger("click");
	});
	
	$("#imgSelectBtn").change(function(e){
		
		var formData = new FormData();
		 
		// 파일태그
		formData.append("file",$("input[name=file]")[0].files[0]);
		
		 if( !$("input[name=file]")[0].files[0]){
			alert("파일을 선택해주세요!");
			return;
	    }
		
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/mentee/myPage/profilUpdate",
			data : formData,
			dataType : "text",
			//  processData: false => post방식 contentType: false => multipart/form-data
			processData : false,
			contentType : false,
			success : function(data){
				if (data != null) {
					alert(data);
					alert("프로필 사진 변경 완료!");
					location.reload();
				} else if (data == null) {
					alert("프로필 사진 등록 실패!")
					return;
				}
	   		}
			
		});
	
	});
	
});



function password_check( mentee_password) {
	
	var regExpPw=/(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;
	return (mentee_password != '' && mentee_password != 'undefined' && regExpPw.test(mentee_password));
	
}


$(document).ready(function(){

	  $("#mentee_password").keyup(function (){
		   $("#mentee_password").blur(function() {
	        var mentor_password = $("#mentee_password").val();
		
	        if( mentor_password == '' || mentor_password == 'undefined') 
	        	return;
	        if(!password_check(mentor_password) ) {
	        	$("#checkPWArea").css("color","red");
	        	$("#checkPWArea").text('잘못된 형식의 비밀번호입니다.');
	            $(this).focus();
	            return false;
	        } else {
	        	$("#checkPWArea").css("color","green");
	        	$("#checkPWArea").text('올바른 형식의 비밀번호입니다.');
	        	return;
	        }
	  	  });

		});
	  


  $(function(){
	  $("#mentee_passwordCk").keyup(function() {
			var password = $("#mentee_password").val();
			var passwordCk = $("#mentee_passwordCk").val();
			if (password != "" || passwordCk != "") {
				if (password == passwordCk) {
					$("#checkCorrectPWArea").html("<span style='color:green'>비밀번호 일치</span>");
				} else {
					$("#checkCorrectPWArea").html("<span style='color:red'>비밀번호 불일치");
				}
			}
		});
	  });

	
	
	function ajaxPWCK() {
		
			
			var menteeObject = new Object();
			menteeObject.mentee_id = ${loginMember.mentee_id};
			menteeObject.mentee_password = $("#mentee_password").val();
				
			var menteeJsonObject = JSON.stringify(menteeObject);
		    alert(menteeJsonObject);
			
			
			$.ajax({
				
				url:'<%=request.getContextPath()%>/mentee/myPage/updatePasswordCk',
				type:"post",
				async: false,
				contentType:"application/json",
				data:menteeJsonObject,
				dataType:"json",
				success:function(result){
					if(eval(result)){
						alert('비밀번호 변경 성공!');
						$("#checkInfoArea").html('<span style=color:green>저장 완료!</span>');
						location.reload();
					} else {
						alert('변경사항 저장 실패');
						$("#checkInfoArea").html('<span style=color:red>변경 실패</span>');
					}
				},
				
				error:function(result){
					alert('회원정보 저장 과정에서 문제 발생 - 관리자 문의 요망');
				}
	
			});
		};	
		
		
	
	
	
	
$("#password_update_btn").on("click",function(){
	
		
		var menteeObject = new Object();
		menteeObject.mentee_id = ${loginMember.mentee_id};
		menteeObject.mentee_password = $("#origin_password").val();
			
		var menteeJsonObject = JSON.stringify(menteeObject);
	    alert(menteeJsonObject);
		
		$.ajax({
			
			url:'<%=request.getContextPath()%>/mentee/myPage/passwordCheck',
			type:"post",
			async: false,
			contentType:"application/json",
			data:menteeJsonObject,
			dataType:"json",
			success:function(result){
				if(eval(result)){
					alert('비밀번호 일치!');
					ajaxPWCK();
				} else {
					alert('비밀번호를 확인해주세요');
				}
			},
			
			error:function(result){
				alert('비밀번호 변경 과정에서 문제 발생 - 관리자 문의 요망');
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

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav.jsp" flush="false"></jsp:include>

	<div id="right_content">
	
		<h3 class="content_title first_h3">프로필 사진 변경</h3>
		<p class="title_desc">사이트에서 사용할 프로필 사진을 등록합니다.</p>
		
		<div class="change_img_box">
			<div class="img">
				<img src="<%=request.getContextPath()%>/resources/profiles/${empty loginMember.mentee_profile ? 'default_profile.png' : loginMember.mentee_profile}" id="profile_pic_area">
			</div>
			<div>
				<p>
					JPEG, PNG, GIF 중 하나여야 하며 1MB를 초과할 수 없습니다.<br>
					개인정보 보호를 위해 활동 이미지는 신중히 올려주세요.<br>
					최적 사이즈 150*150 / 최대 500KB
				</p>
				<button id="updateProfileBtn">프로필 이미지 수정</button>
			<input type="file" id="imgSelectBtn" multiple="multiple" name="file" style="display:none;">
			</div>
		</div>
		
		<c:if test="${ loginMember.simple_login_CK eq '멘토스' }">
			
			<h3 class="content_title">프로필 설정</h3>
			<p class="title_desc">비밀번호 외의 정보는 변경하실 수 없습니다.</p>
	
			<div class="profile_area">
				<ul>
					<li>
						<span>이름</span><input type="text" value="${ loginMember.mentee_name }" readonly="readonly">
					</li>
					<li>
						<span>이메일</span><input type="text" value="${ loginMember.mentee_email }" readonly="readonly">
					</li>
					<li>
						<span>현재 비밀번호</span><input class="blank" type="password" name="" id="origin_password" placeholder="현재 비밀번호 입력해주세요">
					</li>		
					<li>
						<span>변경할 비밀번호</span><input class="blank" type="password" name="" id="mentee_password">
					</li>
					<li>
					<p id="checkPWArea" class="blank"></p>
					</li>
					<li>
						<span>비밀번호 확인</span><input class="blank" type="password" name="" id="mentee_passwordCk">
					</li>		
					<li>
					<p id="checkCorrectPWArea"></p>
				</li>
					<li class="info_change_btn_wrap">
							<button id="password_update_btn">변경사항 저장</button>
					</li>										
				</ul>
			</div>
			</c:if>
			
			<c:if test="${ loginMember.simple_login_CK != '멘토스' }">
			<h3 class="content_title">프로필 (현재 ${ loginMember.simple_login_CK }로 로그인 중)</h3>
			<p>카카오나 네이버 로그인을 이용한 경우 프로필 사진 외에는 정보 변경이 불가능합니다.</p>
			
			<div class="profile_area simple_login_profile">
				<ul>
					<li>
						<span>이름</span><input type="text" value="${ loginMember.mentee_name }" readonly="readonly">
					</li>
					<li>
						<span>이메일</span><input type="text" value="${ loginMember.mentee_email }" readonly="readonly">
					</li>						
				</ul>
			</div>
			
		</c:if>
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