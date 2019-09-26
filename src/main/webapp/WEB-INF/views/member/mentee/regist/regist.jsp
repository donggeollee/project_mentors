


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
	href="<%=request.getContextPath()%>/resources/css/mentors/common.css">

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<title>멘티 회원가입</title>



<script type="text/javascript">

    

function email_change() {



var emailSelect = document.getElementById("select_email");

var emailValue = emailSelect.options[emailSelect.selectedIndex].value;

var mentee_name = document.getElementById("mentee_name");

//alert(emailSelect);

//alert(emailValue);

     if( emailValue == '1'){

     document.getElementById("email_type").value = "";

     document.getElementById("email_type").focus();

    

     }else {

    	document.getElementById("email_type").value = emailValue;

     }

    

     if( emailValue == '0'){

     document.getElementById("email_type").value = "이메일을 선택해주세요";

     }

 }





    function email_check( mentee_email ) {

    

     var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

     return (mentee_email != '' && mentee_email != 'undefined' && regex.test(mentee_email));

    }







    function password_check( mentee_password) {

     var regExpPw=/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/;

     return (mentee_password != '' && mentee_password != 'undefined' && regExpPw.test(mentee_password));

    }

    

    

    function name_check( mentee_name ){

        

        var regExpName=/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

        return (mentee_name != '' && mentee_name != 'undefined' && regExpName.test(mentee_name));

        

    }



    $(document).ready(function(){

        

        $("#mentee_name").keyup(function(){

            

            var mentee_name = $("#mentee_name").val();

            if( !name_check(mentee_name) ) {

         //alert('한글 이름으로 입력해주세요');

         $("#checkNameArea").html('<span style=color:red>한글 형식으로 입력해주세요');

         return;

                

            } else {

             $("#checkNameArea").html('<span style=color:green>이름 입력 성공');

            }

        });

        

        

        $("#password_confirm").keyup(function() {

     var password = $("#mentee_password").val();

     var passwordCk = $("#password_confirm").val();

     if (password != "" || passwordCk != "") {

     if (password == passwordCk) {

     $("#checkCorrectPWArea").html("<span style='color:green'>비밀번호 일치</span>");

     } else {

     $("#checkCorrectPWArea").html("<span style=color:red>비밀번호 불일치");

     }

    

     }

    

     });



        

     $("#email_id").keyup(function(){

    

    

          var mentee_email = $("#email_id").val() + "@" + $("#email_type").val();

     if( mentee_email == '' || mentee_email == 'undefined')

     return;

    

    

     if( !email_check(mentee_email) ) {

     $("#checkEmailArea").html('<span style=color:red>잘못된 형식의 이메일 주소입니다</span>');

     return;

     // $(this).focus();

     // return false;

    

     } else {

     $("#checkEmailArea").html('<span style=color:green>올바른 형식의 이메일 주소입니다.</span>');

     }

    

     });

    

    

     $("#email_type").blur(function() {

         

          var mentee_email = $("#email_id").val() + "@" + $("#email_type").val();

         if( mentee_email == '' || mentee_email == 'undefined')

         return;

        

        

         if( !email_check(mentee_email) ) {

         $("#checkEmailArea").html('<span style=color:red>잘못된 형식의 이메일 주소입니다</span>');

         return;

         // $(this).focus();

         // return false;

        

         } else {

         $("#checkEmailArea").html('<span style=color:green>올바른 형식의 이메일 주소입니다.</span>');

         }

        

         

     });



    



$("#select_email").change(function() {

var mentee_email = $("#email_id").val() + "@" + $("#email_type").val();

if( mentee_email == '' || mentee_email == 'undefined')

return;

if( !email_check(mentee_email) ) {

$("#checkEmailArea").html('<span style=color:red>잘못된 형식의 이메일 주소입니다</span>');

return;

// $(this).focus();

// return false;

} else {

$("#checkEmailArea").html('<span style=color:green>올바른 형식의 이메일 주소입니다</span>');

}

});

});






$("#naverLoginBtn").on("click", function () {



    $.ajax({

url:'<%=request.getContextPath()%>/mentee/naverlogin',

type:"get",

contentType:"application/x-www-form-urlencoded; charset=utf-8",

success:function(data){

$("#naverLoginLink").attr("href",data);

$("#naverLoginLink").get(0).click();

},

error:function(data){

alert("error")

}

});

});






$("#naverLoginLink").on("click", function () {

$("#mainBtn").get(0).click();

    });







     function kakaoLogout() {

     Kakao.Auth.logout(function(response) {

     alert(response + 'logout');

     });

     }







     $(function(){

         $("#mentee_password").keyup(function (){

     $("#mentee_password").blur(function() {

    

         var mentee_password = $("#mentee_password").val();

        

         if( mentee_password == '' || mentee_password == 'undefined')

         return;

        

         if(!password_check(mentee_password) ) {

         $("#checkPWArea").html('<span style=color:red>최소 1개의 숫자 혹은 특수 문자 포함(최대20자리)</span>');

        

         $(this).focus();

         return false;

        

         } else {

         $("#checkPWArea").html('<span style=color:green>올바른 형식의 비밀번호입니다</span>');

         }

         });

        

         });

    

     });



    







    var isCheckEmail = false;



// 회원가입 버튼 눌렀을 때 이벤트 처리

function regist_request() {

    

    var mentee_email = $("#email_id").val() + "@" + $("#email_type").val();

    var password = $("#mentee_password").val();

     var passwordCk = $("#mentee_passwordCk").val();

     var name = $("#mentee_name").val();

    

     if( mentee_email == '' || password == '' || passwordCk == '' || name == '' || $("#email_type").val() == '' || $("#email_id").val() == '') {

         alert('회원정보를 모두 입력해주세요!');

         return;

     }

    

     if(!email_check(mentee_email)) {

         alert('올바른 형식의 이메일을 입력해주세요!');

         return;

     }

    


    var menteeObject = new Object();

menteeObject.mentee_email = $("#email_id").val() + "@" + $("#email_type").val();

// 자바스크립트의 JSON 문서 생성






var menteeJsonObject = JSON.stringify(menteeObject);

//alert(menteeJsonObject);





$.ajax({

url:'<%=request.getContextPath()%>/mentee/regist_emailCK',

type:"post",

async: false, // 동기 통신을 가능화하게 하는 기능

contentType: "application/json",

data:menteeJsonObject,

dataType:"json",

success:function(result){



if ( eval(result) ){

//alert('사용 가능한 ID입니다');

$("#checkEmailArea").html("<span style='color:green'>사용 가능한 이메일입니다</span>");

isCheckEmail = true;

ajaxRegistCk();



} else {

alert('이미 사용중인 이메일입니다');

$("#mentee_email").focus();


}



},

error:function(){

alert('이메일 체크 과정에서 문제 발생 - 관리자 문의 요망');

}

});

}






function ajaxRegistCk(){

    

    var menteeObject = new Object();

menteeObject.mentee_email =$("#email_id").val() + "@" + $("#email_type").val();

menteeObject.mentee_password = $("#mentee_password").val();

menteeObject.mentee_name = $("#mentee_name").val();



var menteeJsonObject = JSON.stringify(menteeObject);



//alert(menteeJsonObject);



$.ajax({

url:'<%=request.getContextPath()%>/mentee/regist',

type:"post",

async: false,

contentType:"application/json",

data:menteeJsonObject,

dataType:"json",

success:function(result){

if(eval(result)){

alert('회원가입 성공!');

$("#mainBtn").get(0).click();

} else {

alert('회원가입에 실패했습니다');


}

},

error:function(result){

alert('회원 가입 과정에서 문제 발생 - 관리자 문의 요망');

}

});

};





</script>

</head>

<body>



	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>

	<div class="cont">

		<p class="tit_desc_p">멘토스와 함께 다양한 경험을 누려보세요.</p>

		<div class="progress" style="height: 5px;">

			<div class="progress-bar" role="progressbar" style="width: 66%;"
				aria-valuenow="66" aria-valuemin="0" aria-valuemax="100"></div>

		</div>

		<div class="row h-100 form_wrap">

			<div class="col-sm-10 col-md-9 col-lg-9 mx-auto d-table h-100">

				<div class="d-table-cell align-middle">

					<div class="card" id="loginForm">

						<div class="card-body regist_form_wrap">

							<form action="<%=request.getContextPath()%>/mentor/regist/submit"
								id="mentor_form" method="post" onsubmit="return validation();">

								<input type="hidden" name="mentor_categoryBig" value="${branch}">

								<label class="font-weight-bold">이메일</label>

								<div class="input-group flex-nowrap">

									<input type="text" class="form-control" placeholder="아이디"
										aria-label="userId" aria-describedby="addon-wrapping"
										id="email_id" name="email_id" value="${ email_idd }"
										style="border-radius: 10px 0px 0px 10px; margin-right: -1px;"
										required>

									<div class="input-group-prepend">

										<span class="input-group-text" id="addon-wrapping"><b>@</b></span>

									</div>

									<input type="text" class="form-control" placeholder="이메일"
										aria-label="userEmail" aria-describedby="addon-wrapping"
										id="email_type" name="email_type" value="${ email_typee }"
										required> <select
										class="custom-select custom-select-lg" name="select_email"
										onchange="email_change()" id="select_email"
										style="height: 52px; border-radius: 0px 10px 10px 0px;">

										<option value="0">이메일을 선택하세요</option>

										<option value="daum.net">daum.net</option>

										<option value="naver.com">naver.com</option>

										<option value="gmail.com">gmail.com</option>

										<option value="hanmail.net">hanmail.net</option>

										<option value="nate.com">nate.com</option>

										<option value="yahoo.com">yahoo.com</option>

										<option value="1">직접입력</option>

									</select>

								</div>



								<p id="checkEmailArea">&nbsp;</p>

								<div class="form-group">

									<label class="font-weight-bold">비밀번호</label> <input
										class="form-control js-mytooltip-pw form-control"
										id="mentee_password" type="password" name="mentee_password"
										data-mytooltip-direction="right"
										data-mytooltip-dinamic-content="true"
										data-mytooltip-action="focus"
										data-mytooltip-animate-duration="1"
										placeholder="최소 1개의 숫자 혹은 특수 문자를 포함해주세요."
										style="text-indent: 10px;" maxlength="20">

									<p id="checkPWArea">&nbsp;</p>

								</div>

								<div class="form-group">

									<label class="font-weight-bold">비밀번호 확인</label> <input
										class="form-control" type="password" id="password_confirm"
										name="mentee_passwordCk" placeholder="비밀번호를 확인해주세요."
										style="text-indent: 10px;">

									<p id="checkCorrectPWArea">&nbsp;</p>

								</div>

								<div class="form-group">

									<label class="font-weight-bold">이름</label> <input
										class="form-control" type="text" name="mentee_name"
										id="mentee_name" placeholder="이름(한글)을 입력하세요.">

									<p id="checkNameArea">&nbsp;</p>

								</div>

							</form>

							<div class="regist_btns">

								<a href="<%=request.getContextPath() %>/regist/"
									class="prev_btn">이전으로</a> <a
									href="javascript:regist_request();" class="done_btn">회원가입</a>



							</div>

						</div>

					</div>

				</div>

			</div>

		</div>







		<a id="mainBtn" href="<%=request.getContextPath()%>"
			style="display: none;"></a>

		<!-- 1. 아이디 검증 확인 체크 (ajax)

2. 비밀번호 일치 여부 체크 (정규식점검)

3. 회원가입 성공 여부 체크 (ajax) -->

		<p class="tit_desc_p">카카오 계정이나 네이버 계정이 있으신가요?</p>

		<div class="social_login_box">

			<ul>

				<li><a id="kakao-login-btn"></a></li>

				<li>

					<div id="naver_id_login">

						<button id="naverLoginBtn">

							<img
								src="<%=request.getContextPath()%>/resources/img/social/naverlogin_btn.png" />

						</button>

						<a id="naverLoginLink"></a>

					</div>

				</li>

			</ul>

		</div>

	</div>

	<script type='text/javascript'>



        var resJsonObject = null;

        //<![CDATA[

        //사용할 앱의 JavaScript 키를 설정해 주세요.

        Kakao.init('976799ddb837551832e4f37742249b02');

        //카카오 로그인 버튼을 생성합니다.

        Kakao.Auth.createLoginButton({

        container: '#kakao-login-btn',

        success: function(authObj) {

        //로그인 성공시, API를 호출합니다.

        Kakao.API.request({

        url: '/v2/user/me',

        success: function(res) {

        resJsonObject = JSON.stringify(res);

        console.log(res);



    

    $.ajax({

    

        url:"<%=request.getContextPath()%>/mentee/loginSuccess",

													type : "post",

													data : resJsonObject,

													contentType : 'application/Json',

													dataType : "json",

													success : function(data) {

														alert("success");

														$("#mainBtn").get(0)
																.click();

													},

													error : function(data) {

														alert("error");

													}

												});

										//

									},

									fail : function(error) {

										alert(JSON.stringify(error));

									}

								});

					},

					fail : function(err) {

						alert(JSON.stringify(err));

					}

				});

		//]]>
	</script>



	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/footer.jsp"
		flush="false"></jsp:include>

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