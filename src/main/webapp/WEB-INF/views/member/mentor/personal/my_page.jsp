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
			url : "<%=request.getContextPath()%>/mentor/myPage/profilUpdate",
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
	
	<%--
	$("#imgUpload").on("click",function(){
		var formData = new FormData();
		 
		// 파일태그
		formData.append("file",$("input[name=file]")[0].files[0]);
		
		 if( !$("input[name=file]")[0].files[0]){
			alert("파일을 선택해주세요!");
			return;
	    }
		 
		
			 
		 alert(formData);
			
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/mentor/myPage/profilUpdate",
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

	--%>
	
});



	function password_check( mentor_password) {
		
		var regExpPw=/(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;
		return (mentor_password != '' && mentor_password != 'undefined' && regExpPw.test(mentor_password));
		
	}
	
	
	$(document).ready(function(){
	
		  $("#mentor_password").keyup(function (){
			   $("#mentor_password").blur(function() {
		        var mentor_password = $("#mentor_password").val();
			
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
		 });	  


	  $(function(){
		  $("#mentor_passwordCk").keyup(function() {
				var password = $("#mentor_password").val();
				var passwordCk = $("#mentor_passwordCk").val();
				if (password != "" || passwordCk != "") {
					if (password == passwordCk) {
						$("#checkCorrectPWArea").html("<span style='color:green'>비밀번호 일치</span>");
					} else {
						$("#checkCorrectPWArea").html("<span style='color:red'>비밀번호 불일치");
					}
				}
			});
		  });

	$(document).ready(function(){
		
		$("#info_update_btn").on("click",function(){
			var info = $("#myinfo").val();
		
			if( info.length > 100) {
				alert("100글자 이내로만 작성가능합니다");
				$("#myinfo").focus();
				return;
			}
			
			var mentor_id = ${loginMember.mentor_id};
			
			var infoObject = new Object();
			infoObject.mentor_info = info;
			infoObject.mentor_id = mentor_id
			
			var infoSubmitObject = JSON.stringify(infoObject);
			alert(infoSubmitObject);
			
			$.ajax({
	
				url:'<%=request.getContextPath()%>/mentor/myPage/infoupdate',
				type : "post",
				async : false,
				contentType : "application/json; charset=utf-8",
				data : infoSubmitObject,
				dataType : "json",
				success : function(data) {
				if (eval(data)) {
					alert(JSON.stringify(data));
					alert(data);
					$("#checkInfoArea").html('<span style=color:green>저장 완료!</span>');
					location.reload();
				} else {
					$("#checkInfoArea").html('<span style=color:red>저장 실패</span>');
					return;
				}
	   	},
				error : function(data) {
			   alert('자기소개 수정 과정에서 문제 발생 - 관리자 문의 요망')
			}
	
			});
	
		});
		
		
		function ajaxPWCK() {
			
				
				var mentorObject = new Object();
				mentorObject.mentor_id = ${loginMember.mentor_id};
				mentorObject.mentor_password = $("#mentor_password").val();
					
				var mentorJsonObject = JSON.stringify(mentorObject);
			    alert(mentorJsonObject);
				
				
				$.ajax({
					
					url:'<%=request.getContextPath()%>/mentor/myPage/updatePasswordCk',
					type:"post",
					async: false,
					contentType:"application/json",
					data:mentorJsonObject,
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
		
			
			var mentorObject = new Object();
			mentorObject.mentor_id = ${loginMember.mentor_id};
			mentorObject.mentor_password = $("#origin_password").val();
				
			var mentorJsonObject = JSON.stringify(mentorObject);
		    alert(mentorJsonObject);
			
			$.ajax({
				
				url:'<%=request.getContextPath()%>/mentor/myPage/passwordCheck',
				type:"post",
				async: false,
				contentType:"application/json",
				data:mentorJsonObject,
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

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_mentor.jsp" flush="false"></jsp:include>

	<div id="right_content">
	
	
		<h3 class="content_title first_h3">프로필 사진 변경</h3>
		<p class="title_desc">사이트에서 사용할 프로필 사진을 등록합니다.</p>
		
		<div class="change_img_box">
			<div class="img">
				<img src="<%=request.getContextPath()%>/resources/profiles/${empty loginMember.mentor_profile ? 'default_profile.png' : loginMember.mentor_profile}" id="profile_pic_area">
			</div>
				<p>
					JPEG, PNG, GIF 중 하나여야 하며 1MB를 초과할 수 없습니다.<br>
					개인정보 보호를 위해 활동 이미지는 신중히 올려주세요.<br>
					최적 사이즈 150*150 / 최대 500KB
				</p>
			<button id="updateProfileBtn">프로필 이미지 수정</button>
			<input type="file" id="imgSelectBtn" multiple="multiple" name="file" style="display:none;">
		</div>
			
		<h3 class="content_title">나의 카테고리</h3> 
		<p class="title_desc">가입 시 등록한 카테고리 정보(변경 불가능)</p>		
				
		<div class="category_box">
			<h5>${loginMember.mentor_categoryBig }</h5>
		</div>	
		
		<h3 class="content_title">나의 자기소개란</h3>
		<p class="title_desc">최대 100글자까지 작성 가능하며, 추후 클래스 등록 시 멘티들에게 보여지는 프로필입니다 </p>
		
		<div class="my_profile_box">
			<textarea id="myinfo">${loginMember.mentor_info}</textarea>
		  		
			  <div class="info_update_btn">		
				<button id="info_update_btn" class="update_btn">변경사항 저장</button>
	
			  </div>	
	    </div>
		
		
		<h3 class="content_title">프로필 설정</h3>
		<p>계정의 세부정보 식별 변경</p>
		
		<div class="profile_area">
			<ul>
				<li>
					<span>이름</span><input type="text" value="${ loginMember.mentor_name }" readonly="readonly">
				</li>
				<li>
					<span>이메일</span><input type="text" value="${ loginMember.mentor_email }" readonly="readonly">
				</li>
				<li>
					<span>연락처</span><input type="text" value="${loginMember.phone}" readonly="readonly">
				</li>
				<li>
					<span>현재 비밀번호</span><input class="blank" type="password"  id="origin_password" placeholder="현재 비밀번호 입력해주세요" >
				</li>		
				<li>
					<span>변경할 비밀번호</span><input class="blank" type="password" id="mentor_password">
				</li>
				<li>
					<p id="checkPWArea" class="blank"></p>
				</li>
				<li>
					<span>비밀번호 확인</span><input class="blank" type="password" id="mentor_passwordCk">
				</li>	
				<li>
					<p id="checkCorrectPWArea"></p>
				</li>						
			</ul>
			
				<div class="info_change_btn_wrap">
					<button id="password_update_btn">변경사항 저장</button>
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