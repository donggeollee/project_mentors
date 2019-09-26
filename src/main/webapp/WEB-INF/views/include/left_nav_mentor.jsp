<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<div id="left_nav">
		<ul>
			<li>
				<h2 class="first_h2">나의 레슨</h2>
				<ul class="menu">
					<li><a href="<%=request.getContextPath()%>/mentor/myWriteLesson">내가 등록한 레슨</a></li>
					<li><a href="<%=request.getContextPath()%>/mentor/myLessonPicklist">나의 레슨을 찜한 멘티</a></li>
					<li><a href="<%=request.getContextPath()%>/mentor/mentoring">멘토링 요청 확인</a></li>
					<li><a href="<%=request.getContextPath()%>/mentor/menteelist">나의 멘티</a></li>
				</ul>
			</li>
			<li>
				<h2>받은 문의함</h2>
				<ul>
					<li><a href="<%=request.getContextPath()%>/chat">나의 메시지</a></li>
				</ul>
			</li>			
			<li>
				<h2>마이페이지</h2>
				<ul>
					<li><a href="<%=request.getContextPath()%>/mentor/myPage">회원정보수정</a></li>
				</ul>
			</li>			
		</ul>
	</div>