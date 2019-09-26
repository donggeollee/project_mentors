<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">    
<title>MENTORS</title>
<link rel="icon" href="<%=request.getContextPath()%>/resources/img/Fevicon.png" type="image/png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/linericon/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/vendors/Magnific-Popup/magnific-popup.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean" rel="stylesheet">	
</head>
<body>

<!--================ Header Top Area Start =================-->
  <!--================ Header Top Area end =================-->

  <!--================ Header Menu Area start =================-->
  <header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container box_1620">
          <a class="navbar-brand logo_h" href="index.html"><img src="<%=request.getContextPath()%>/resources/img/logo.png" alt=""></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
<c:if test="${ empty loginMember }" var="login">
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav justify-content-end">
              <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/mentor/regist">멘토가입</a></li> 
              <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/mentee/regist">멘티가입</a></li>
              <li class="nav-item submenu dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">로그인</a>
                <ul class="dropdown-menu">
                  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/mentor/login">멘토 로그인</a></li>
                  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/mentee/login">멘티 로그인</a></li>
                </ul>
				</li>
            </ul>
          </div>
          
          </c:if>
          <c:if test="${ !login}">
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav justify-content-end">
              <li class="nav-item submenu dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">내 정보</a>
                <ul class="dropdown-menu">
                  <li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
                  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/chat">메시지 테스트</a></li>
                  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/mentor/logout">로그아웃</a></li>
                </ul>
				</li>
            </ul>
          </div>
          </c:if>
        </div>
      </nav>
    </div>
  </header>
  
  
<h3>어서오세요. ${ loginMember.mentor_name } ${ memberType }님 환영합니다.</h3>
<p> ${ memberType }의 정보 </p>

<p>카드형식 링크 리스트 4개</p>

<a href="<%=request.getContextPath()%>/mentor/lesson/write">레슨 작성</a>

</body>
</html>