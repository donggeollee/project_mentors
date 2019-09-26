<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


	<%--

	 <div class="top">
    	<div class="container">
    		<div class="row d-flex align-items-center">
    			<div class="col">
    				<p class="social d-flex">
    					<a href="#"><span class="icon-facebook"></span></a>
    					<a href="#"><span class="icon-twitter"></span></a>
    					<a href="#"><span class="icon-google"></span></a>
							<a href="#"><span class="icon-pinterest"></span></a>
    				</p>
    			</div>
    			<div class="col d-flex justify-content-end">
    				<p class="num"><span class="icon-phonee"></span></p>
    			</div>
    		</div>
    	</div>
    </div>
    
     --%>

    <c:if test="${ not empty sessionScope.adminLogon }" var="r">
   	 <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%= request.getContextPath() %>/admin/main#">MENTORS ADMIN</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
		        <ul class="navbar-nav ml-auto">
		  			 <li class="nav-item active"><a href="<%= request.getContextPath() %>/admin/main" class="nav-link">홈</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/manage/mentor" class="nav-link">멘토 관리</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/manage/mentee" class="nav-link">멘티 관리</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/manage/lesson" class="nav-link">레슨 관리</a></li>
		          <li class="nav-item"><a href="<%= request.getContextPath() %>/admin/logout" class="nav-link">로그아웃</a></li>
		          <li class="nav-item active"><a href="<%= request.getContextPath() %>" target="_blank" class="nav-link">멘토스</a></li>
		        </ul>
	      </div>
	    </div>
	  </nav>
   </c:if>
   
   <c:if test="${not r}">
      <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%= request.getContextPath() %>/admin"><span>MENTORS ADMIN</span></a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>
   		</div>
   	  </nav>
   </c:if>

	  



