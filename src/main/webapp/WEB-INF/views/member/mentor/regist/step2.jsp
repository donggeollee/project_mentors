<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/animate.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/magnific-popup.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/aos.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/ionicons.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery.timepicker.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/flaticon.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/icomoon.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/base.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mentors/common.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<!-- tooltip css and js -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myTooltip.css">
<script type="text/javascript" src='<%=request.getContextPath()%>/resources/js/myTooltip.js'></script>
<script src="https://sdk.accountkit.com/ko_KR/sdk.js"></script>
<title>멘토스 회원가입</title>

<style type="text/css">
#checkEmailArea, #passwordArea, #checkPasswordArea, #checkNameArea, #checkPhoneArea, #checkInfoArea{
	color:red;
}

.card {
    margin-bottom: 1.5rem;
    box-shadow: 0 1px 15px 1px rgba(52,40,104,.08);
}

.card {
    position: relative;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-direction: column;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid #e5e9f2;
    border-radius: .2rem;
}
	
	</style>

	<script type="text/javascript">
	
	var email_validation;
	var duplicate_validation;
	var password_validation;
	var password_equal_validation;
	var name_validation;
	var phone_validation;
	var info_validation;
	
	function validation() {
		if(!email_validation){
			emailValidation();
		}
		if(!password_validation){
			var value = $("input:password[name='mentor_password']").val();
			$('.js-mytooltip-pw').myTooltip('updateContent', getPwContent(value));
		}
		if(!password_equal_validation){
		}
		if(!name_validation){
			nameValidation();
		}
		if(!phone_validation){
			$("#checkPhoneArea").text("핸드폰 인증이 필요합니다.");
		}
		if(!info_validation){
			infoValidation();
		}
		
		/*
		console.log("email_validation :   " +email_validation);
		console.log("duplicate_validation :   "+duplicate_validation);
		console.log("password_validation :   "+password_validation);
		console.log("password_equal_validation :   "+password_equal_validation);
		console.log("name_validation :   "+name_validation);
		console.log("phone_validation :   "+phone_validation);
		console.log("info_validation :   "+info_validation);
		*/
		if(email_validation && duplicate_validation && password_validation && password_equal_validation && name_validation && phone_validation && info_validation){
			alert($("input:text[name='phone']").val());
			
			return true;
		}
		else
			return false;
	}
	
	
	
	// Email 중복여부 ajax
		$(function () {
			
			$("input[name='mentor_email']").on("blur", function () {
				emailValidation();
				if(!email_validation){
					return;
				}
				var mentor_email = $("#mentor_form [name='mentor_email']").val();
				$.ajax({
					url: '<%=request.getContextPath()%>/mentor/regist/check',
					type: "post",
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					data: "mentor_email=" + mentor_email,
					dataType: "text",
					success: function (result) {
						if (eval(result)) {
							duplicate_validation = true;
							$("#checkEmailArea").html('사용가능한 이메일 입니다.');
							$("#checkEmailArea").css("color", "green");
						} else {
							$("#checkEmailArea").html('이미 존재하는 이메일 입니다.');
							duplicate_validation = false;
							
						}
						
					},
					// ajax 호출 실패
					error: function (result) {
						alert('ID 체크 과정에서 문제 발생');
					}
				});
			});
		});

	// 이메일 형식 검증 함수
	function emailValidation() {
		var emailRule = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
		var mentor_email = $("input:text[name='mentor_email']").val();
		var checkEmailArea = document.getElementById("checkEmailArea");
		if(!mentor_email.length) {
			checkEmailArea.textContent="이메일은 필수입력 항목입니다.";
			return;
		}
		if(emailRule.test(mentor_email)){
			checkEmailArea.textContent="";
			email_validation = true;
		}else{
			checkEmailArea.textContent="이메일 형식에 맞게 입력해주세요.";
			email_validation = false;
		}
	}
	
	function nameValidation(){
		var nameRule = /^[가-힣]+$/;
		var mentor_name = $("input:text[name='mentor_name']").val();
		if(!mentor_name) {
			$("#checkNameArea").text("이름은 필수입력사항 입니다.");
			return;
		}
		if(nameRule.test(mentor_name)){
			$("#checkNameArea").text("\u00A0");
			name_validation = true;
		}else{
			$("#checkNameArea").text("이름은 한글만 입력이 가능합니다.");
			name_validation = false;
		}
	}
	


		// Facebook Account Kit 초기화 with CSRF protection
		AccountKit_OnInteractive = function () {
			AccountKit.init({
				appId: "485838472165654",
				state: "04c02f08ec6654e6eab0fc0b3f3ab771",
				version: "v1.0",
				fbAppEventsEnabled: true,
				debug: "true",
				locale: "ko_KR",
				display: "modal"

			});
		};

		//  Facebook Account Kit callback
		function callback(response) {
			if (response.status === "PARTIALLY_AUTHENTICATED") {
				// document.getElementById("code").value = response.code;
				// document.getElementById("csrf").value = response.state;
				// document.getElementById("login_success").submit();
				$("#checkPhoneArea").text("핸드폰 인증이 완료되었습니다.");
				$("#checkPhoneArea").css("color", "green");
				$("input:text[name='phone']").prop("readonly", "readonly");
				$("#smsRequest").prop("disabled", true);
				console.log(response);
				phone_validation = true;
			} else if (response.status === "NOT_AUTHENTICATED") {
				phoneValidation = false;
				// handle authentication failure
			} else if (response.status === "BAD_PARAMS") {
				alert("bad_params");
				// handle bad parameters
			}
		}

		// phone form submission handler
		function smsLogin() {
			var countryCode = document.getElementById("country_code").value;
			var phoneNumber = document.getElementById("phone_number").value;
			AccountKit.login('PHONE', {
				countryCode: countryCode,
				phoneNumber: phoneNumber
			}, // will use default values if not specified
				callback);
		}
/*
		$("#login_success").submit(function () {

			var csrf = $("input[name=csrf]").val();
			var code = $("input[name=code]").val();
			//ajax 방식으로 전송한다.
			alert("test");
			$.post("insert", { "name": name, "addr": addr }, function (data) {
				alert(data);
			});
		});
 */


		var phoneRule = /^[가-힣]+$/;
		function hangul() {
			/* var test = $("input[id='mentor_name']").val().length;
			alert(test); */
			if ($("input[id='mentor_name']").val().length == 0) {
				alert("필수 입력값입니다.");
				return;
			}
			if (!phoneRule.test($("input[id='mentor_name']").val())) {
				alert("한글로 입력해주세요.");
			} else {
				// 한글 입력했을시 한글체크값 true
			}
		}

		/* $(function() {
			$("input:text[name='mentor_name']").on("keypress", function() {			
				$(this).val($(this).val().replace(/^[가-힣]/g, ""));
			});
		}); */

		
		
	/*  	// 패스워드창 벗어났을 때 이벤트
		$(function () {
			var target = document.getElementById("ch_new_pw").value;
			$("input:password[name='mentor_password']").on("blur", function () {
				if(!target.length){					
					$("#passwordArea").text("패스워드는 필수 입력사항입니다.");
					alert(target.length);
					return;
				}
				else
					$("#passwordArea").text("d");
			});
		}); */ 
		
		// 이름 입력창을 벗어났을 때 이벤트
		$(function () {
			$("input:text[name='mentor_name']").on("blur", function () {
				nameValidation();
			});
		});
		
		// 이름은 한글만 입력 가능(자음이나 모음만 입력은 불가능)
		function nameValidation(){
			var nameRule = /^[가-힣]+$/;
			var mentor_name = $("input:text[name='mentor_name']").val();
			if(!mentor_name) {
				$("#checkNameArea").text("이름은 필수입력사항 입니다.");
				return;
			}
			if(nameRule.test(mentor_name)){
				$("#checkNameArea").text("\u00A0");
				name_validation = true;
			}else{
				$("#checkNameArea").text("이름은 한글만 입력이 가능합니다.");
				name_validation = false;
			}
		}



		// 핸드폰번호 숫자만 입력 가능
		$(function () {
			$("input:text[name='phone']").on("keypress", function () {
				$(this).val($(this).val().replace(/[^0-9]/g, ""));
			});
		});

		// 핸드폰번호 숫자만 입력 가능
		$(function () {
			$("input:text[name='phone']").on("keyup", function () {
				$(this).val($(this).val().replace(/[^0-9]/g, ""));
			});
		});
		
		// 패스워드 일치 검증
		$(function(){
			$("input:password[name='password_confirm']").on("keyup", function(){
				equalValidation();
			});
		});
		
		function equalValidation(){
			var target = $("input:password[name='mentor_password']").val();
			var confirm = $("input:password[name='password_confirm']").val();
			var area = $("#checkPasswordArea").val();
			if(confirm.length == 0){
				$("#checkPasswordArea").text("\u00A0");
				return;
			}
			if(target.length == 0){
				$("#checkPasswordArea").text("패스워드를 먼저 입력하세요.");
				return;
			}
			if(target == confirm){
				$("#checkPasswordArea").text("패스워드가 일치합니다.");
				$("#checkPasswordArea").css("color", "green");
				password_equal_validation = true;
			} else {
				$("#checkPasswordArea").text("패스워드가 일치하지 않습니다.");
				$("#checkPasswordArea").css("color", "red");
				password_equal_validation = false;
			}
		}
		
		
		// 자기소개는 10자이상
		$(function(){
			$("textarea[name='mentor_info']").on("blur",function(){
				infoValidation();
			});
		});
		
		function infoValidation(){
			var info = $("textarea[name='mentor_info']").val();
			if(!info.length){
				$("#checkInfoArea").text("자기소개는 필수입력사항 입니다.");
			} else if(info.length < 10) {
				$("#checkInfoArea").text("자기소개는 10자 이상으로 입력해주세요.");
				info_validation = false;
			} else if(info.length > 100) {
				$("#checkInfoArea").text("자기소개는 100자 이하로 입력해주세요.");
				info_validation = false;
			} else {
				$("#checkInfoArea").text("\u00A0");
				info_validation = true;
			}
		}
		
</script>
<style>
input[name="mentor_email"], input[name="mentor_password"], input[name="password_confirm"], input[name="mentor_name"], textarea {
border-radius: 10px !important;
}
input[name="phone"]{
border-radius: 10px 0px 0px 10px;
}
#loginForm{
border-radius: 5px;
}
</style>
</head>
<body>
<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>
<div class="cont">

		<p class="tit_desc_p">
			멘토 회원가입을 진행합니다.<br>
			<span>가입을 통해 멘티님들과 다양한 소통과 경험을 해보세요.</span>
		</p>


		<div class="progress" style="height: 5px;">
			<div class="progress-bar" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
		</div>
		
    		<div class="row h-100">
				<div class="col-sm-10 col-md-9 col-lg-9 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">


						<div class="card regist_form_wrap" id="loginForm">
									<form action="<%=request.getContextPath()%>/mentor/regist/submit" name="mentor_regist_form" id="mentor_form" method="post" onsubmit="return validation();">
									<input type="hidden" name="mentor_categoryBig" value="${branch}">
									
										<div class="form-group">
											<label class="font-weight-bold">이메일</label>
											<input class="form-control" id = "mentor_email" type="text" name="mentor_email" placeholder="이메일을 입력하세요.">
											<p id="checkEmailArea">&nbsp;</p>
										</div>
										<div class="form-group">
											<label class="font-weight-bold">비밀번호</label>
											<input class="form-control js-mytooltip-pw form-control" id="ch_new_pw" type="password" name="mentor_password" data-mytooltip-direction="right" data-mytooltip-dinamic-content="true"
					data-mytooltip-action="focus" data-mytooltip-animate-duration="1" placeholder="비밀번호를 입력하세요." style="text-indent:10px;">
											<p id="passwordArea">&nbsp;</p>
										</div>
										<div class="form-group">
											<label class="font-weight-bold">비밀번호 확인</label>
											<input class="form-control" type="password" id="password_confirm" name="password_confirm" placeholder="비밀번호를 확인하세요."
											style="text-indent:10px;">
											<p id="checkPasswordArea">&nbsp;</p>
										</div>
										<div class="form-group">
											<label class="font-weight-bold">이름</label>
											<input class="form-control" type="text" name="mentor_name" placeholder="이름을 입력하세요.">
											<p id="checkNameArea">&nbsp;</p>
										</div>
										<div class="form-group">
										<label class="font-weight-bold">연락처</label>
										<input type="hidden" value="+82" id="country_code" />
										<div class="input-group flex-nowrap">
												<input class="form-control" type="text"name="phone" id="phone_number"
													placeholder="연락처를 입력하세요." style="border-right:none;">
													<input type="button" value="인 증" class="btn btn-primary font-weight-bold" onclick="smsLogin();" style="border-radius: 0px 10px 10px 0px;">
											<!-- <div class="input-group-prepend">
												<span class="input-group-text" id="addon-wrapping" style="background-color:white;">
													<a href="javascript:smsLogin()" class="btn btn-primary">인 증</a>
												</span>
											</div> -->
										</div>
										<p id="checkPhoneArea">&nbsp;</p>
										</div>
										<div class="form-group">
											<label class="font-weight-bold">자기소개</label>
											<textarea class="form-control" name="mentor_info" rows="10" cols="50" placeholder="최대 100 글자 까지 작성하실 수 있으며, 추후 클래스 등록 시 멘티들에게 프로필 형식으로 보여지게 됩니다.
마이페이지에서 수정 가능"></textarea>
<p id="checkInfoArea">&nbsp;</p>
										</div>
										
										
										<%-- 
										<div class="row justify-content-between">
									    <div class="col-3">
									  <a href="<%=request.getContextPath() %>/mentor/regist/" class="btn btn-primary text-center"><b>이전으로</b></a>
									    </div>
									    <div class="col-3">
									   <input type="submit" value="회원가입" class="btn btn-primary text-center" style="float:right;">
									    </div>
									    </div>
									    
										--%>	
									</form>
									
									
									<div class="regist_btns">
										<a href="<%=request.getContextPath() %>/mentor/regist/"
											class="prev_btn">이전으로</a>
	
										<a href="javascript:document.mentor_regist_form.submit();"
											class="done_btn">회원가입</a>
									</div>
									 
										
							</div>
						</div>
				</div>
			</div>
		</div>

<%-- 	<form action="<%=request.getContextPath()%>/mentor/regist/submit" id="mentor_form" method="post" onsubmit="return validation();">
		<input type="hidden" name="mentor_categoryBig" value="${branch}">
		<ul>



			<li>
				<p>이메일주소</p>
				<input type="text" id = "mentor_email" name="mentor_email" placeholder="">
				<p id="checkEmailArea"></p>
			</li>
			<li>

				<p>비밀번호</p>
				<input class="js-mytooltip-pw form-control" id="ch_new_pw" type="password" name="mentor_password"
					style="" data-mytooltip-direction="right" data-mytooltip-dinamic-content="true"
					data-mytooltip-action="focus" data-mytooltip-animate-duration="1">
				<p id="passwordArea"></p>

			</li>

			<li>
				<p>비밀번호 확인</p>
				<input type="password" name="password_confirm" id="password_confirm">
				<p id="checkPasswordArea"></p>
			</li>
			<li>
				<p>이름<span>(한번 등록한 이름은 변경하실 수 없습니다.)</span></p>
				<input type="text" name="mentor_name" id="mentor_name" style="ime-mode:active;">
				<p id="checkNameArea"></p>
			</li>
			<li>
				<p>휴대폰번호(-를 빼고입력해주세요)</p>
				<input type="hidden" value="+82" id="country_code" />
				<input type="text" placeholder="핸드폰 번호를 입력하세요." id="phone_number" name="phone" />
				<button type="button" id="smsRequest" onclick="smsLogin();">핸드폰 인증</button>
				<p id="checkPhoneArea"></p>
			</li>
			<li>
				<p>자기소개</p>
				<textarea name="mentor_info" rows="10" cols="50" placeholder="최대 100 글자 까지 작성하실 수 있으며, 추후 클래스 등록 시 멘티들에게 프로필 형식으로 보여지게 됩니다.
마이페이지에서 수정 가능"></textarea>
				<p id="checkInfoArea"></p>
			</li>
		</ul>

		<button type="button" onclick="location.href='<%=request.getContextPath() %>/mentor/regist/'">이전</button>
		<button type="submit" >회원가입</button>


	</form> --%>
	<script>
	
	isNull = function (object) {
		try {
			if (typeof object == "boolean") {
				return false;
			} else {
				return (object == null || typeof object == "undefined" || object === "" || object == "undefined");
			}
		} catch (e) {
			alert("isNull: " + object + "::" + e.message);
			WebSquare.exception.printStackTrace(e);
		}
	};
	//신규 비밀번호 체크 
	function getPwContent(key) {
		var pwd = key;
		var passed = validatePassword(pwd);
		return passed;
	}

	//비밀번호 안정성 체크
	function validatePassword(pw, options) {
		var o = {
			length: [6, 16],
			lower: 1,
			upper: 1,
			alpha: 1, /* lower + upper */
			numeric: 1,
			special: 1,
			custom: [ /* regexes and/or functions */],
			badWords: [],
			badSequenceLength: 5,
			noQwertySequences: true,
			spaceChk: true,
			noSequential: false
		};

		// 공백 체크
		if (o.spaceChk && /\s/g.test(pw)) {
			password_validation = false;
			return "<p style='line-height:200%;'><span style='color:#E3691E; font-weight:bold;'>사용불가</span> : 비밀번호 재작성 필요"
				+ "<br/>"
				+ "<span style='color:#999; font-weight:bold;'>공백은 사용하실 수 없습니다.</span></p>";
		}
		
		// 길이 0 체크
		if(pw.length == 0){
			password_validation = false;
			$("#passwordArea").text("패스워드는 필수 입력사항입니다.");
		}else{
			$("#passwordArea").html("");
		}
		
		
		//password 길이 체크
		if (pw.length < o.length[0]){
			password_validation = false;
			if(pw.length!=0){
			$("#passwordArea").text("패스워드는 " + o.length[0] + "자 이상 입력하셔야 합니다.");
			}
			return "<p style='line-height:200%;'><span style='color:#E3691E; font-weight:bold;'>사용불가</span>"
				+ "<br/>"
				+ "<span style='color:#999; font-weight:bold;'>비밀번호는 "
				+ o.length[0] + "자 이상 입력하셔야 합니다.</span></p>";
		}

		if (pw.length != 0 && pw.length > o.length[1]){
			password_validation = false;
			$("#passwordArea").text("패스워드는 " + o.length[1] + "자 이내로 입력하셔야 합니다.");
			return "<p style='line-height:200%;'><span style='color:#E3691E; font-weight:bold;'>사용불가</span>"
				+ "<br/>"
				+ "<span style='color:#999;'>비밀번호는 " + o.length[1] + "자 이내로 입력하셔야 합니다.</span></p>";
		}
		// bad sequence check
		if (o.badSequenceLength && pw.length >= o.length[0]) {
			var lower = "abcdefghijklmnopqrstuvwxyz",
				upper = lower.toUpperCase(),
				numbers = "0123456789",
				qwerty = "qwertyuiopasdfghjklzxcvbnm",
				start = o.badSequenceLength - 1,
				seq = "_" + pw.slice(0, start);
			for (i = start; i < pw.length; i++) {
				seq = seq.slice(1) + pw.charAt(i);
				if (lower.indexOf(seq) > -1 || upper.indexOf(seq) > -1 || numbers.indexOf(seq) > -1 || (o.noQwertySequences && qwerty.indexOf(seq) > -1)) {
					password_validation = true;
					return "<p style='line-height:200%;'>비밀번호 안전도 <span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>낮음</span> "
						+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
						+ "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
						+ "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
						+ "<br/>" + "<span style='color:#999; font-weight:bold;'>안전도가 높은 비밀번호를 권장합니다.</span></p>";
				}
			}
		}


		//password 정규식 체크
		var re = {
			lower: /[a-z]/g,
			upper: /[A-Z]/g,
			alpha: /[A-Z]/gi,
			numeric: /[0-9]/g,
			special: /[\W_]/g
		},
			rule, i;
		var lower = (pw.match(re['lower']) || []).length > 0 ? 1 : 0;
		var upper = (pw.match(re['upper']) || []).length > 0 ? 1 : 0;
		var numeric = (pw.match(re['numeric']) || []).length > 0 ? 1 : 0;
		var special = (pw.match(re['special']) || []).length > 0 ? 1 : 0;


		//숫자로만 이루어지면 낮음
		if (pw.length != 0 && (pw.match(re['numeric']) || []).length == pw.length) {
			password_validation = false;
			$("#passwordArea").text("영문 대소문자, 숫자 및 특수문자를 사용해주세요.");
			return "<p style='line-height:200%;'><span style='color:#E3691E; font-weight:bold;'>사용불가</span> : 비밀번호 재작성 필요"
				+ "<br/>" + "<span style='color:#999; font-weight:bold;'>영문 대소문자, 숫자 및 특수문자 사용</span></p>";
		}

		//숫자, 알파벳(대문자, 소문자), 특수문자 2가지 조합
		else if (pw.length != 0 && lower + upper + numeric + special <= 2) {
			password_validation = true;
			$("#passwordArea").text("");
			return "<p style='line-height:200%;'>비밀번호 안전도 <span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>낮음</span> "
				+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
				+ "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
				+ "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
				+ "<br/>" + "<span style='color:#999; font-weight:bold;'>안전도가 높은 비밀번호를 권장합니다.</span></p>";
		}

		//숫자, 알파벳(대문자, 소문자), 특수문자 4가지 조합
		else if (pw.length != 0 && lower + upper + numeric + special <= 3) {
			password_validation = true;
			$("#passwordArea").text("");
			return "<p style='line-height:200%;'>비밀번호 안전도 <span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>적정</span> "
				+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
				+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
				+ "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
				+ "<br/>" + "<span style='color:#999; font-weight:bold;'>안전하게 사용하실 수 있는 비밀번호 입니다.</span></p>";
		}
		//숫자, 알파벳(대문자, 소문자), 특수문자 4가지 조합
		else {
			if(pw.length != 0){
			password_validation = true;
			$("#passwordArea").text("");
			return "<p style='line-height:200%;'>비밀번호 안전도 <span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>높음</span> "
				+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
				+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
				+ "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
				+ "<br/>" + "<span style='color:#999; font-weight:bold;'>예측하기 힘든 비밀번호로 더욱 안전합니다.</span></p>";
			}
		}

		// enforce the no sequential, identical characters rule

		if (o.noSequential && /([\S\s])\1/.test(pw))
			return "no sequential";

		// enforce word ban (case insensitive)

		for (i = 0; i < o.badWords.length; i++) {
			if (pw.toLowerCase().indexOf(o.badWords[i].toLowerCase()) > -1)
				return "bad word";
		}

		// enforce custom regex/function rules 

		for (i = 0; i < o.custom.length; i++) {
			rule = o.custom[i];
			if (rule instanceof RegExp) {
				if (!rule.test(pw))
					return "custom";
			} else if (rule instanceof Function) {
				if (!rule(pw))
					return "custom";
			}
		}
	};


	$(document).ready(function () {
		$("#ch_new_pw").off("focus").on("focus", function () {
			equalValidation();
			var value = $(this).val();
			$('.js-mytooltip-pw').myTooltip('updateContent', getPwContent(value));
		});

		$("#ch_new_pw").off("click").on("click", function () {
			var value = $(this).val();
			if (!isNull(value)) {
				$('.js-mytooltip-pw').myTooltip('updateContent', getPwContent(value));
			}
		});

		$("#ch_new_pw").off("keyup").on("keyup", function () {
			 $("#ch_new_pw").blur();
			$("#ch_new_pw").focus();
		});

		//비밀번호 안정성 tooltip
		$('.js-mytooltip-pw').myTooltip({
			'offset': 20,
			'theme': 'light',
			'customClass': 'mytooltip-content',
			'content': '<p>t</p>'
		});
	});
	
	</script>


	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/footer.jsp" flush="false"></jsp:include>	
		
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-migrate-3.0.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/popper.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.waypoints.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.stellar.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/owl.carousel.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.magnific-popup.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/aos.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.animateNumber.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/scrollax.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/main.js"></script>
	

</body>

</html>