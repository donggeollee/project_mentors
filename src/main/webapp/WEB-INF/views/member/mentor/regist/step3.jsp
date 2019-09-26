<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토스 회원가입</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/content.css">
</head>
<body>
	${mentor.mentor_info}
	<h2>멘토 가입 서비스</h2>
	<div>진행 바 영역</div>
	<h3>마지막으로 멘티들에게 어필할 자기소개 란을 작성해 주세요.</h3>
	<textarea rows="" cols="">
		최대 100 글자 까지 작성하실 수 있으며, 추후 클래스 등록 시 멘티들에게 프로필 형식으로 보여지게 됩니다. 마이페이지에서 수정 가능
	</textarea>
	
	<button>가입완료</button>
	
	<form action="<%=request.getContextPath()%>/mentor/regist/step2" method="post">
		
	<input type="submit" value="이전으로">
	</form>

</body>
</html>