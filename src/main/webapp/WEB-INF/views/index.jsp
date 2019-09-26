<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<style>
.notification {
	width: 250px;
	height: 20px;
	height: auto;
	position: fixed;
	left: 50%;
	margin-left: -125px;
	bottom: 100px;
	z-index: 9999;
	background-color: #383838;
	color: #F0F0F0;
	font-family: Calibri;
	font-size: 15px;
	padding: 10px;
	text-align: center;
	border-radius: 2px;
	-webkit-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1);
	-moz-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1);
	box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1);
}
</style>
<title>멘토스</title>
</head>
<body>
	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

<div class='notification' style='display:none'></div>
	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>
		
	<section class="home-slider owl-carousel">
	
	<c:if test="${ not empty mainList }">
		<c:forEach var="mList" items="${ mainList }" varStatus="ml" >
			<div class="slider-item"
			style="background-image:url(<%=request.getContextPath()%>/resources/img/mentors/main_bg/${ mList.category_big }.jpg);">
			<div class="overlay">
				<p class="main_list_desc">현재 멘토스에서 가장 인기있는 레슨<br><span>평점 순으로 자동 등록되며, 갱신됩니다.</span></p>
			</div>
			<div class="container">
				<div
					class="row no-gutters slider-text align-items-md-end align-items-center justify-content-end">
					<div class="col-md-6 text p-4 ftco-animate">
						<h1 class="mb-3">${ mList.title }</h1>
						<span class="location d-block mb-3"><i
							class="icon-my_location"></i>${ mList.location }</span>
						<p>${ mList.lesson_info }</p>
						<span class="price">${ mList.total_round }회 / ${ mList.price }원</span> <a href="<%=request.getContextPath()%>/lesson/detail/${mList.lesson_id}"
							class="btn-custom p-3 px-4 bg-primary">View Details <span
							class="icon-plus ml-1"></span></a>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
	</c:if>
	
	<c:if test="${ empty mainList }">
		<div class="slider-item"
			style="background-image:url(<%=request.getContextPath()%>/resources/img/mentors/bg1.jpg);">
			<div class="overlay">
				<p class="main_list_desc">현재 멘토스에서 가장 인기있는 레슨</p>
			</div>
			<div class="container">
				<div
					class="row no-gutters slider-text align-items-md-end align-items-center justify-content-end">
					<div class="col-md-6 text p-4 ftco-animate">
						<h1 class="mb-3">${ mList.title }</h1>
						<span class="location d-block mb-3"><i
							class="icon-my_location"></i>${ mList.location }</span>
						<p>${ mList.lesson_info }</p>
						<span class="price">￦${ mList.price }</span> <a href="<%=request.getContextPath()%>/lesson/detail/${mList.lesson_id}"
							class="btn-custom p-3 px-4 bg-primary">View Details <span
							class="icon-plus ml-1"></span></a>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	</section>
	
	<%--
	
	 <section class="ftco-section ftco-counter img" id="section-counter" style="background-image: url(<%=request.getContextPath()%>/resources/images/bg_1.jpg);">
    	<div class="container">
    		<div class="row justify-content-center mb-3 pb-3">
          <div class="col-md-7 text-center heading-section heading-section-white ftco-animate">
            <h2 class="mb-4">지금 멘토스 회원이 되어보세요!</h2>
          </div>
        </div>
    		<div class="row justify-content-center">
    			<div class="col-md-10">
		    		<div class="row">
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="9000">0</strong>
		                <span>Happy Customers</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="10000">0</strong>
		                <span>Properties</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="1000">0</strong>
		                <span>Agents</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18 text-center">
		              <div class="text">
		                <strong class="number" data-number="100">0</strong>
		                <span>Awards</span>
		              </div>
		            </div>
		          </div>
		        </div>
	        </div>
        </div>
    	</div>
    </section>
    
    --%>
    
    <%--

	<section class="ftco-search">
		<div class="container">
			<div class="row">
				<div class="col-md-12 search-wrap">
					<!-- 
					<h2 class="heading h5 d-flex align-items-center pr-4">
						<span class="ion-ios-search mr-3"></span>멘토 찾기
					</h2>
					 -->
					<form action="#" class="search-property">
						<div class="row">
							<!-- 
	        			<div class="col-md align-items-end">
	        				<div class="form-group">
	        					<label for="#">Keyword</label>
	          				<div class="form-field">
	          					<div class="icon"><span class="icon-pencil"></span></div>
			                <input type="text" class="form-control" placeholder="Keyword">
			              </div>
		              </div>
	        			</div>
	        			<div class="col-md align-items-end">
	        				<div class="form-group">
	        					<label for="#">Location</label>
	          				<div class="form-field">
	          					<div class="icon"><span class="icon-pencil"></span></div>
			                <input type="text" class="form-control" placeholder="City/Locality Name">
			              </div>
		              </div>
	        			</div>
	        			-->
							<div class="col-md align-items-end">
								<div class="form-group">
									<label for="#">카테고리</label>
									<div class="form-field">
										<div class="select-wrap">
											<div class="icon">
												<span class="ion-ios-arrow-down"></span>
											</div>
											<select name="" id="" class="form-control">
												<option value="">Type</option>
												<option value="">Commercial</option>
												<option value="">- Office</option>
												<option value="">Residential</option>
												<option value="">Villa</option>
												<option value="">Condominium</option>
												<option value="">Apartment</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md align-items-end">
								<div class="form-group">
									<label for="#">??</label>
									<div class="form-field">
										<div class="select-wrap">
											<div class="icon">
												<span class="ion-ios-arrow-down"></span>
											</div>
											<select name="" id="" class="form-control">
												<option value="">Type</option>
												<option value="">Rent</option>
												<option value="">Sale</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md align-items-end">
								<div class="form-group">
									<label for="#">�?/�?/??</label>
									<div class="form-field">
										<div class="select-wrap">
											<div class="icon">
												<span class="ion-ios-arrow-down"></span>
											</div>
											<select name="" id="" class="form-control">
												<option value="">Any</option>
												<option value="">Jonh Doe</option>
												<option value="">Doe Mags</option>
												<option value="">Kenny Scott</option>
												<option value="">Emily Storm</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md align-self-end">
								<div class="form-group">
									<div class="form-field">
										<input type="submit" value="조건?? �? 맞는 멘토 찾기" class="form-control btn btn-primary">
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	
	 --%>
	
	 <section class="ftco-section bg-light">
      <div class="container">
        <div class="row d-flex">
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services py-4 d-block text-center">
              <div class="d-flex justify-content-center"><div class="icon"><span class="flaticon-pin"></span></div></div>
              <div class="media-body p-2 mt-2">
                <h3 class="heading mb-3">위치 기반<br>멘토 찾기 서비스</h3>
                <p>내 위치와 가까운 레슨은 물론, 원하는 지역의 멘토와 레슨을 찾아보세요!</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services py-4 d-block text-center">
              <div class="d-flex justify-content-center"><div class="icon"><span class="flaticon-detective"></span></div></div>
              <div class="media-body p-2 mt-2">
                <h3 class="heading mb-3">믿을 수 있는<br>멘토</h3>
                <p>멘토스에서는 보증된 신원을 위해 멘토의 개인정보를 저장하며, 이 외의 용도로는 사용하지 않습니다. </p>
              </div>
            </div>    
          </div>
          <div class="col-md-3 d-flex align-sel Searchf-stretch ftco-animate">
            <div class="media block-6 services py-4 d-block text-center">
              <div class="d-flex justify-content-center"><div class="icon"><span class="flaticon-house"></span></div></div>
              <div class="media-body p-2 mt-2">
                <h3 class="heading mb-3">멘토와 멘티의 <br> 채팅 서비스</h3>
                <p>1:1 채팅을 통해, 멘토와 레슨에 대해 문의하고 상담하실 수 있습니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services py-4 d-block text-center">
              <div class="d-flex justify-content-center"><div class="icon"><span class="flaticon-purse"></span></div></div>
              <div class="media-body p-2 mt-2">
                <h3 class="heading mb-3">합리적인 조건의<br> 레슨</h3>
                <p>멘토님의 조건에 맞는 레슨들을 찾아 합리적인 비용으로 멘토링을 받아보세요!</p>
              </div>
            </div>      
          </div>
        </div>
      </div>
    </section>
    
    <%--
    
    <section class="ftco-section ftco-properties">
    	<div class="container">
    		<div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 heading-section text-center ftco-animate">
          	<span class="subheading">Recent Posts</span>
            <h2 class="mb-4">Recent Properties</h2>
          </div>
        </div>
    		<div class="row">
    			<div class="col-md-12">
    				<div class="properties-slider owl-carousel ftco-animate">
    					<div class="item">
		    				<div class="properties">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-1.jpg);">
		    						<div class="icon d-flex justify-content-center align-items-center">
		    							<span class="icon-search2"></span>
		    						</div>
		    					</a>
		    					<div class="text p-3">
		    						<span class="status sale">Sale</span>
		    						<div class="d-flex">
		    							<div class="one">
				    						<h3><a href="#">North Parchmore Street</a></h3>
				    						<p>Apartment</p>
			    						</div>
			    						<div class="two">
			    							<span class="price">$20,000</span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="properties">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-2.jpg);">
		    						<div class="icon d-flex justify-content-center align-items-center">
		    							<span class="icon-search2"></span>
		    						</div>
		    					</a>
		    					<div class="text p-3">
		    						<div class="d-flex">
		    							<span class="status rent">Rent</span>
		    							<div class="one">
				    						<h3><a href="#">North Parchmore Street</a></h3>
				    						<p>Apartment</p>
			    						</div>
			    						<div class="two">
			    							<span class="price">$2,000 <small>/ month</small></span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="properties">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-3.jpg);">
		    						<div class="icon d-flex justify-content-center align-items-center">
		    							<span class="icon-search2"></span>
		    						</div>
		    					</a>
		    					<div class="text p-3">
		    						<span class="status sale">Sale</span>
		    						<div class="d-flex">
		    							<div class="one">
				    						<h3><a href="#">North Parchmore Street</a></h3>
				    						<p>Apartment</p>
			    						</div>
			    						<div class="two">
			    							<span class="price">$20,000</span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="properties">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-4.jpg);">
		    						<div class="icon d-flex justify-content-center align-items-center">
		    							<span class="icon-search2"></span>
		    						</div>
		    					</a>
		    					<div class="text p-3">
		    						<span class="status sale">Sale</span>
		    						<div class="d-flex">
		    							<div class="one">
				    						<h3><a href="#">North Parchmore Street</a></h3>
				    						<p>Apartment</p>
			    						</div>
			    						<div class="two">
			    							<span class="price">$20,000</span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="properties">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-5.jpg);">
		    						<div class="icon d-flex justify-content-center align-items-center">
		    							<span class="icon-search2"></span>
		    						</div>
		    					</a>
		    					<div class="text p-3">
		    						<span class="status rent">Rent</span>
		    						<div class="d-flex">
		    							<div class="one">
				    						<h3><a href="#">North Parchmore Street</a></h3>
				    						<p>Apartment</p>
			    						</div>
			    						<div class="two">
			    							<span class="price">$900 <small>/ month</small></span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
	    				<div class="item">
		    				<div class="properties">
		    					<a href="#" class="img d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-6.jpg);">
		    						<div class="icon d-flex justify-content-center align-items-center">
		    							<span class="icon-search2"></span>
		    						</div>
		    					</a>
		    					<div class="text p-3">
		    						<span class="status sale">Sale</span>
		    						<div class="d-flex">
		    							<div class="one">
				    						<h3><a href="#">North Parchmore Street</a></h3>
				    						<p>Apartment</p>
			    						</div>
			    						<div class="two">
			    							<span class="price">$20,000</span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </section>

    <section class="ftco-section bg-light">
    	<div class="container">
				<div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 heading-section text-center ftco-animate">
          	<span class="subheading">Special Offers</span>
            <h2 class="mb-4">Most Recommended Properties</h2>
          </div>
        </div>    		
    	</div>
    	<div class="container-fluid">
    		<div class="row">
    			<div class="col-sm col-md-6 col-lg ftco-animate">
    				<div class="properties">
    					<a href="#" class="img img-2 d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-1.jpg);">
    						<div class="icon d-flex justify-content-center align-items-center">
    							<span class="icon-search2"></span>
    						</div>
    					</a>
    					<div class="text p-3">
    						<span class="status sale">Sale</span>
    						<div class="d-flex">
    							<div class="one">
		    						<h3><a href="#">North Parchmore Street</a></h3>
		    						<p>Apartment</p>
	    						</div>
	    						<div class="two">
	    							<span class="price">$20,000</span>
    							</div>
    						</div>
    						<p>Far far away, behind the word mountains, far from the countries</p>
    						<hr>
    						<p class="bottom-area d-flex">
    							<span><i class="flaticon-selection"></i> 250sqft</span>
    							<span class="ml-auto"><i class="flaticon-bathtub"></i> 3</span>
    							<span><i class="flaticon-bed"></i> 4</span>
    						</p>
    					</div>
    				</div>
    			</div>
    			<div class="col-sm col-md-6 col-lg ftco-animate">
    				<div class="properties">
    					<a href="#" class="img img-2 d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-2.jpg);">
    						<div class="icon d-flex justify-content-center align-items-center">
    							<span class="icon-search2"></span>
    						</div>
    					</a>
    					<div class="text p-3">
    						<span class="status sale">Sale</span>
    						<div class="d-flex">
    							<div class="one">
		    						<h3><a href="#">North Parchmore Street</a></h3>
		    						<p>Apartment</p>
	    						</div>
	    						<div class="two">
	    							<span class="price">$20,000</span>
    							</div>
    						</div>
    						<p>Far far away, behind the word mountains, far from the countries</p>
    						<hr>
    						<p class="bottom-area d-flex">
    							<span><i class="flaticon-selection"></i> 250sqft</span>
    							<span class="ml-auto"><i class="flaticon-bathtub"></i> 3</span>
    							<span><i class="flaticon-bed"></i> 4</span>
    						</p>
    					</div>
    				</div>
    			</div>
    			<div class="col-sm col-md-6 col-lg ftco-animate">
    				<div class="properties">
    					<a href="#" class="img img-2 d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-3.jpg);">
    						<div class="icon d-flex justify-content-center align-items-center">
    							<span class="icon-search2"></span>
    						</div>
    					</a>
    					<div class="text p-3">
    						<span class="status rent">Rent</span>
    						<div class="d-flex">
    							<div class="one">
		    						<h3><a href="#">North Parchmore Street</a></h3>
		    						<p>Apartment</p>
	    						</div>
	    						<div class="two">
	    							<span class="price">$800 <small>/ month</small></span>
    							</div>
    						</div>
    						<p>Far far away, behind the word mountains, far from the countries</p>
    						<hr>
    						<p class="bottom-area d-flex">
    							<span><i class="flaticon-selection"></i> 250sqft</span>
    							<span class="ml-auto"><i class="flaticon-bathtub"></i> 3</span>
    							<span><i class="flaticon-bed"></i> 4</span>
    						</p>
    					</div>
    				</div>
    			</div>
    			<div class="col-sm col-md-6 col-lg ftco-animate">
    				<div class="properties">
    					<a href="#" class="img img-2 d-flex justify-content-center align-items-center" style="background-image: url(<%=request.getContextPath()%>/resources/images/properties-4.jpg);">
    						<div class="icon d-flex justify-content-center align-items-center">
    							<span class="icon-search2"></span>
    						</div>
    					</a>
    					<div class="text p-3">
    						<span class="status sale">Sale</span>
    						<div class="d-flex">
    							<div class="one">
		    						<h3><a href="#">North Parchmore Street</a></h3>
		    						<p>Apartment</p>
	    						</div>
	    						<div class="two">
	    							<span class="price">$20,000</span>
    							</div>
    						</div>
    						<p>Far far away, behind the word mountains, far from the countries</p>
    						<hr>
    						<p class="bottom-area d-flex">
    							<span><i class="flaticon-selection"></i> 250sqft</span>
    							<span class="ml-auto"><i class="flaticon-bathtub"></i> 3</span>
    							<span><i class="flaticon-bed"></i> 4</span>
    						</p>
    					</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </section>


    <section class="ftco-section testimony-section bg-light">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-8 ftco-animate">
          	<div class="row ftco-animate">
		          <div class="col-md-12">
		            <div class="carousel-testimony owl-carousel ftco-owl">
		              <div class="item">
		                <div class="testimony-wrap py-4 pb-5">
		                  <div class="user-img mb-4" style="background-image: url(<%=request.getContextPath()%>/resources/images/person_1.jpg)">
		                    <span class="quote d-flex align-items-center justify-content-center">
		                      <i class="icon-quote-left"></i>
		                    </span>
		                  </div>
		                  <div class="text text-center">
		                    <p class="mb-4">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
		                    <p class="name">Roger Scott</p>
		                    <span class="position">Clients</span>
		                  </div>
		                </div>
		              </div>
		              <div class="item">
		                <div class="testimony-wrap py-4 pb-5">
		                  <div class="user-img mb-4" style="background-image: url(<%=request.getContextPath()%>/resources/images/person_2.jpg)">
		                    <span class="quote d-flex align-items-center justify-content-center">
		                      <i class="icon-quote-left"></i>
		                    </span>
		                  </div>
		                  <div class="text text-center">
		                    <p class="mb-4">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
		                    <p class="name">Roger Scott</p>
		                    <span class="position">Agent</span>
		                  </div>
		                </div>
		              </div>
		              <div class="item">
		                <div class="testimony-wrap py-4 pb-5">
		                  <div class="user-img mb-4" style="background-image: url(<%=request.getContextPath()%>/resources/images/person_3.jpg)">
		                    <span class="quote d-flex align-items-center justify-content-center">
		                      <i class="icon-quote-left"></i>
		                    </span>
		                  </div>
		                  <div class="text text-center">
		                    <p class="mb-4">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
		                    <p class="name">Roger Scott</p>
		                    <span class="position">Client</span>
		                  </div>
		                </div>
		              </div>
		              <div class="item">
		                <div class="testimony-wrap py-4 pb-5">
		                  <div class="user-img mb-4" style="background-image: url(<%=request.getContextPath()%>/resources/images/person_1.jpg)">
		                    <span class="quote d-flex align-items-center justify-content-center">
		                      <i class="icon-quote-left"></i>
		                    </span>
		                  </div>
		                  <div class="text text-center">
		                    <p class="mb-4">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
		                    <p class="name">Roger Scott</p>
		                    <span class="position">Client</span>
		                  </div>
		                </div>
		              </div>
		              <div class="item">
		                <div class="testimony-wrap py-4 pb-5">
		                  <div class="user-img mb-4" style="background-image: url(<%=request.getContextPath()%>/resources/images/person_1.jpg)">
		                    <span class="quote d-flex align-items-center justify-content-center">
		                      <i class="icon-quote-left"></i>
		                    </span>
		                  </div>
		                  <div class="text text-center">
		                    <p class="mb-4">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
		                    <p class="name">Roger Scott</p>
		                    <span class="position">Client</span>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
          </div>
        </div>
      </div>
    </section>


    <section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 heading-section text-center ftco-animate">
            <span class="subheading">Read Articles</span>
            <h2>Recent Blog</h2>
          </div>
        </div>
        <div class="row d-flex">
          <div class="col-md-3 d-flex ftco-animate">
            <div class="blog-entry align-self-stretch">
              <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/resources/images/image_1.jpg');">
              </a>
              <div class="text mt-3 d-block">
                <h3 class="heading mt-3"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
                <div class="meta mb-3">
                  <div><a href="#">Dec 6, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3 d-flex ftco-animate">
            <div class="blog-entry align-self-stretch">
              <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/resources/images/image_2.jpg');">
              </a>
              <div class="text mt-3">
                <h3 class="heading mt-3"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
                <div class="meta mb-3">
                  <div><a href="#">Dec 6, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3 d-flex ftco-animate">
            <div class="blog-entry align-self-stretch">
              <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/resources/images/image_3.jpg');">
              </a>
              <div class="text mt-3">
                <h3 class="heading mt-3"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
                <div class="meta mb-3">
                  <div><a href="#">Dec 6, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3 d-flex ftco-animate">
            <div class="blog-entry align-self-stretch">
              <a href="blog-single.html" class="block-20" style="background-image: url('<%=request.getContextPath()%>/resources/images/image_4.jpg');">
              </a>
              <div class="text mt-3">
                <h3 class="heading mt-3"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
                <div class="meta mb-3">
                  <div><a href="#">Dec 6, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
		
		<%--
		
		<section class="ftco-section-parallax">
      <div class="parallax-img d-flex align-items-center">
        <div class="container">
          <div class="row d-flex justify-content-center">
            <div class="col-md-7 text-center heading-section heading-section-white ftco-animate">
              <h2>Subcribe to our Newsletter</h2>
              <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in</p>
              <div class="row d-flex justify-content-center mt-5">
                <div class="col-md-8">
                  <form action="#" class="subscribe-form">
                    <div class="form-group d-flex">
                      <input type="text" class="form-control" placeholder="Enter email address">
                      <input type="submit" value="Subscribe" class="submit px-3">
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    --%>

    

	<c:if test="${ not empty loginMember }" >
		
	</c:if>
	 
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
