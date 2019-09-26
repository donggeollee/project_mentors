<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<div id="left_nav">
		<ul>
			<li>
				<h2 class="first_h2">나의 레슨</h2>
				<ul class="menu">
					<li><a href="<%=request.getContextPath()%>/mentee/myLesson/">나의 모든 레슨</a></li>
					<li><a href="<%=request.getContextPath()%>/mentee/myLikeLesson/">내가 찜한 레슨</a></li>
					<li><a href="<%=request.getContextPath()%>/mentee/myMentor/">나의 멘토</a></li>
					<li><a href="<%=request.getContextPath()%>/chat">나의 메시지</a></li>
				</ul>
			</li>
			<li>
				<h2>마이페이지</h2>
				<ul>
					<li><a href="<%=request.getContextPath()%>/mentee/myPage">회원정보수정</a></li>
				</ul>
			</li>
		</ul>
	</div>