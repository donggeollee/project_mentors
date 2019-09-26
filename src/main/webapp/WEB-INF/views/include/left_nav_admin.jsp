<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<div id="left_nav" class="left_nav_admin">
		<ul>
			<li>
				<h2 class="first_h2">회원관리</h2>
				<ul class="menu">
					<li><a href="<%=request.getContextPath()%>/admin/manage/mentor">멘토관리</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/manage/mentee">멘티관리</a></li>
				</ul>
			</li>
			<li>
				<h2>레슨 관리</h2>
				<ul>
					<li><a href="<%=request.getContextPath()%>/admin/manage/lesson">레슨목록</a></li>
				</ul>
			</li>	
			<li>
				<h2>문의 글 관리</h2>
				<ul>
					<li><a href="<%=request.getContextPath()%>/adminChat">문의 글 내역</a></li>
				</ul>
			</li>		
		</ul>
	</div>