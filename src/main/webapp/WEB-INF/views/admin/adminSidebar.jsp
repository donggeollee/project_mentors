<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자메뉴</title>
</head>
<body>
<ul>
	<li>회원관리</li>
	<li><a href="<%=request.getContextPath()%>/admin/manage/mentor">멘토관리</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/manage/mentee">멘티관리</a></li>
	<li>클래스관리</li>
	<li><a href="<%=request.getContextPath()%>/admin/manage/lesson">레슨목록</a></li>
	<li><a href="<%=request.getContextPath()%>/adminChat">문의 목록</a></li>
</ul>
</body>
</html>