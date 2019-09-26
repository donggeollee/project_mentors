<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	href="<%=request.getContextPath()%>/resources/css/mentors/header_add.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/common.css">		
		
<style>
#header {
	width: 100%;
	background-color: gray;
}
table,th,td{
	border:1px solid;
}
</style>
 <style type="text/css">
/* 찜 css */ 
.like-content {
    display: inline-block;
    width: 100%;
    margin: 40px 0 0;
    padding: 40px 0 0;
    font-size: 18px;
    border-top: 10px dashed #eee;
    text-align: center;
}
.like-content span {
	color: #9d9da4;
	font-family: monospace;
}
.like-content .btn-secondary {
	  display: block;
	  margin: 40px auto 0px;
    text-align: center;
    background: #ed2553;
    border-radius: 3px;
    box-shadow: 0 10px 20px -8px rgb(240, 75, 113);
    padding: 10px 17px;
    font-size: 18px;
    cursor: pointer;
    border: none;
    outline: none;
    color: #ffffff;
    text-decoration: none;
    -webkit-transition: 0.3s ease;
    transition: 0.3s ease;
}
.like-content .btn-secondary:hover {
	  transform: translateY(-3px);
}
.like-content .btn-secondary .fa {
	  margin-right: 5px;
}
.animate-like {
	animation-name: likeAnimation;
	animation-iteration-count: 1;
	animation-fill-mode: forwards;
	animation-duration: 0.65s;
}
@keyframes likeAnimation {
  0%   { transform: scale(30); }
  100% { transform: scale(1); } 
}

</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	
	function pushLike(param_value, param_lesson_id){
		var likeValue = param_value;
		var lesson_id = param_lesson_id;
		$.ajax({
			url : "<%=request.getContextPath()%>/like/pushLike",
			type : "post",
			data : {"likeValue" : likeValue , "lesson_id" : lesson_id},	
			success : function (data) {
				if( data == 0 ){
					$("#likeBtn_"+lesson_id).html('찜 취소');
					$("#likeBtn_"+lesson_id).val('1');
					$("#likeBtn_"+lesson_id).attr("onclick","pushLike(1,"+lesson_id+")");
					alert("찜하기 성공")
				}else{
					$("#likeBtn_"+lesson_id).html('찜 하기');
					$("#likeBtn_"+lesson_id).val('0');
					$("#likeBtn_"+lesson_id).attr("onclick","pushLike(0,"+lesson_id+")");
					alert("찜취소 성공")
				}
			},
			error : function(request,status,error) {
			}
		});
	}
	
	$(function() {  
		
		$(".cate_check").on("click",function(){
			var totalCateLength = $(".cate_check").length;
			var checkedCateLength = 0;
			for( var i = 0 ; i < totalCateLength ; i++){
				if($("input:checkbox[id='smallCate_"+i+"']").is(":checked")){ 
					checkedCateLength++;
				}	
			}
			if (totalCateLength != checkedCateLength){
				$("#selectTotalBox").prop("checked",false);
			}
		});
		
		$("#selectTotalBox").on("change", function () {
			if ( $("#selectTotalBox").is(":checked") ){
				$(".cate_check").prop("checked", true);
				categorySearch();
			} else {
				$(".cate_check").prop("checked", false);
				categorySearch();
			}
		});
		
		// 정렬 눌렀을때
		$("#listAlignment").on("change",function(){
			
			var alignment= $("#listAlignment option:selected").val();
			var catelength = $("input:checkbox").length;
			var checkedSmallCate = "";
			for ( var i = 0 ; i < catelength ; i++ ) {
				if ($("input:checkbox[id='smallCate_"+i+"']").is(":checked")){
					checkedSmallCate += $("input:checkbox[id='smallCate_"+i+"']").val() + ",";		
				}	
			}
			var sido = $("#sido").val();
			var gugun = $("#gugun").val();
			var locationVal = sido+","+gugun;
			
			var filterObject = new Object();
			filterObject.alignment = alignment;
			filterObject.checkedSmallCate = checkedSmallCate;
			filterObject.location = locationVal;
			var filterJsonObject = JSON.stringify(filterObject);
			
			var resourceSetting =
				"?alignment="+alignment+"&"+"checkedSmallCate="+checkedSmallCate+"&"+"location="+locationVal;
			
			$.ajax({
				url : "<%=request.getContextPath()%>/lesson/lessonList/${bigCate}",
				type : "post",
				dataType : "json",
				contentType: 'application/json',
				data : filterJsonObject,				
				success : function (data) {
					var lessonList = data.lessonList;
					var pageMap = data.pageMap;
					var likeList = data.likeList;
					
					<%-- 
					if( data == null ) {
						var lessonListSetting = "";
						lessonListSetting = "<li>";
						lessonListSetting += "레슨이 존재하지 않습니다.";
						lessonListSetting += "</li>";
						$("#lessonList ul").append(lessonListSetting);
						return;
					}
					--%>
					
					/******************** 레슨목록 세팅 *******************/
					$(".lessonListDefault").css("display","none");
					var lessonListSetting = "<ul>";
					
					if ( lessonList == null ){
						lessonListSetting += "<li class='empty_lesson_msg'>";
						lessonListSetting += "레슨이 없습니다.";
						lessonListSetting += "</li></ul>";
						$("#lessonList").html(lessonListSetting);
						return;
					}
					
					$.each(lessonList, function(i, value){
						console.log("value.title : "+value.title);
						lessonListSetting += "<li>";
						lessonListSetting += "<div class=\"lesson_img_area\">";
						lessonListSetting += "<img src=\"<%=request.getContextPath()%>/resources/img/"+value.lesson_thumnail+"\" class=\"card-img\" alt=\"...\">";
						lessonListSetting += "</div>";
						lessonListSetting += "<div class=\"lesson_desc_area\">";
						lessonListSetting += "<p class=\"title\"><a href=\"<%=request.getContextPath()%>/lesson/detail/"+value.lesson_id+"\">"+value.title+"</a></p>";
						lessonListSetting += "<p class=\"category_and_location\">"+value.category_small+"/"+value.location+"</p>";
						lessonListSetting += "<p class=\"price_and_time\">"+value.price+"원 / "+value.total_round+"회</p>";
						lessonListSetting += "<p class=\"score_and_review\"><img src=\"<%=request.getContextPath()%>/resources/images/mentors/star.svg\">";
						lessonListSetting += "<span>"+ value.avg_score +"</span> (리뷰"+ value.review_count +" 건)</p>";
						lessonListSetting += "<div class=\"like_area\">";
						if ( likeList != null ){
							var isPrint = false;
							$.each(likeList,function(j,like_check){
								if( like_check.lesson_id == value.lesson_id ){
									lessonListSetting += "<button class=\"btn-secondary like-review\" id=\"likeBtn_"+value.lesson_id
									+"\" value=\"1\" onclick=\"pushLike(1,"+value.lesson_id+")\">찜 취소</button>";
									isPrint = true;
								} 
							})
							if( !isPrint ){
								lessonListSetting += "<button class=\"btn-secondary like-review\" id=\"likeBtn_"+value.lesson_id
								+"\" value=\"0\"  onclick=\"pushLike(0,"+value.lesson_id+")\">찜 하기</button>";
							} 
						}
						lessonListSetting += "</div></div></li>";
					});
					 lessonListSetting += "</ul>"
					$("#lessonList").html(lessonListSetting);
					
					/*****************  페이징 href 세팅하기    **************/
					var pageLinkInit = "/mentors/lesson/lessonList/<c:out value="${ values.bigCate }"></c:out>/";
					var pageSetting = "";
					if( pageMap.beforePage != -1 ){
						pageSetting +=  "<a href ='"+ pageLinkInit + pageMap.beforePage + resourceSetting + "'>[이전]</a>"
					}
					for( var i = pageMap.startPage ; i <= pageMap.endPage ; i++ ) {
						if( pageMap.curPage == i ){
							pageSetting += "["+ i +"]"
						} else {
							pageSetting += "<a href ='"+ pageLinkInit + i + resourceSetting + "'>"+ i +"</a>"	
						}
					}
					if( pageMap.afterPage != -1 ){
						pageSetting +=  "<a href ='"+ pageLinkInit + pageMap.afterPage + resourceSetting + "'>[다음]</a>"
					}
					$("#paging").html(pageSetting);
					
					
				},
				error : function(request,status,error) {
					var lessonListSetting = "";
					lessonListSetting = "<ul><li class='empty_lesson_msg'>";
					lessonListSetting += "레슨이 존재하지 않습니다.";
					lessonListSetting += "</li></ul>";
					$("#lessonList").html(lessonListSetting);
					var pageSetting = ""; 
					pageSetting += "[1]"
					$("#paging").html(pageSetting);
				}
			})
		});
		
	});
	
	function categorySearch(){
		
		/**************** 정렬값 ****************/
		var alignment =  $("#listAlignment option:selected").val();

		/**************** 카테고리 값 가져오기 ***************/
		var catelength = $("input:checkbox").length;
		var checkedSmallCate = "";
		for ( var i = 0 ; i < catelength ; i++ ) {
			if ($("input:checkbox[id='smallCate_"+i+"']").is(":checked")){
				checkedSmallCate += $("input:checkbox[id='smallCate_"+i+"']").val() + ",";		
			}	
		}
		
		/**************** 주소값가져오기 ******************/
		var sido = $("#sido").val();
		var gugun = $("#gugun").val();

		var location = sido+","+gugun;
		var resourceSetting =
			"?alignment="+alignment+"&"+"checkedSmallCate="+checkedSmallCate+"&"+"location="+location;
		
		var filterObject = new Object();
		filterObject.alignment = alignment;
		filterObject.checkedSmallCate = checkedSmallCate;
		filterObject.location = location;
		
		/* JSON 객체 생성 */
		var filterJsonObject = JSON.stringify(filterObject);
		
		/* 비동기 통신 */
		$.ajax({
			url : "<%=request.getContextPath()%>/lesson/lessonList/${bigCate}",
			type : "post",
			dataType : "json",
			contentType: 'application/json',
			data : filterJsonObject,				
			success : function (data) {
				var lessonList = data.lessonList;
				var pageMap = data.pageMap;
				var likeList = data.likeList;
				/******************** 레슨목록 세팅 *******************/
				$(".lessonListDefault").css("display","none");
				var lessonListSetting = "<ul>";
				
				if ( lessonList == null ){
					lessonListSetting += "<li class='empty_lesson_msg'>";
					lessonListSetting += "작성된 레슨이 없습니다.";
					lessonListSetting += "</li></ul>";
					$("#lessonList").html(lessonListSetting);
					return;
				}
				
				$.each(lessonList, function(i, value){
					console.log("value.title : "+value.title);
					
					var thum = value.lesson_thumnail;
					if( thum == null ){
						thum = "no_image.jpg";
					}
					
					lessonListSetting += "<li>";
					lessonListSetting += "<div class=\"lesson_img_area\">";
					lessonListSetting += "<div class=\"lesson_img\">";
					lessonListSetting += "<img src=\"<%=request.getContextPath()%>/resources/lessonImage/"+thum+"\" alt=\"...\">";
					lessonListSetting += "</div>";
					lessonListSetting += "</div>";
					lessonListSetting += "<div class=\"lesson_desc_area\">";
					lessonListSetting += "<p class=\"title\"><a href=\"<%=request.getContextPath()%>/lesson/detail/"+value.lesson_id+"\">"+value.title+"</a></p>";
					lessonListSetting += "<p class=\"category_and_location\">"+value.category_small+" / "+value.location+"</p>";
					lessonListSetting += "<p class=\"price_and_time\">"+value.price+"원 / "+value.total_round+"회</p>";
					lessonListSetting += "<p class=\"score_and_review\"><img src=\"<%=request.getContextPath()%>/resources/images/mentors/star.svg\">";
					lessonListSetting += "<span>"+ value.avg_score +"</span> (리뷰"+ value.review_count +" 건)</p>";
					lessonListSetting += "<div class=\"like_area\">";
					if ( likeList != null ){
						var isPrint = false;
						$.each(likeList,function(j,like_check){
							if( like_check.lesson_id == value.lesson_id ){
								lessonListSetting += "<button class=\"btn-secondary like-review\" id=\"likeBtn_"+value.lesson_id
								+"\" value=\"1\" onclick=\"pushLike(1,"+value.lesson_id+")\">찜 취소</button>";
								isPrint = true;4
							}  
						})
						if( !isPrint ){
							lessonListSetting += "<button class=\"btn-secondary like-review\" id=\"likeBtn_"+value.lesson_id
							+"\" value=\"0\"  onclick=\"pushLike(0,"+value.lesson_id+")\">찜 하기</button>";
						} 
					}
					lessonListSetting += "</div></div></li>";
				}); 
				 lessonListSetting += "</ul>"
				$("#lessonList").html(lessonListSetting);
				
				/*****************  페이징 href 세팅하기    **************/
				var pageLinkInit = "/mentors/lesson/lessonList/<c:out value="${ values.bigCate }"></c:out>/";
				var pageSetting = "";
				if( pageMap.beforePage != -1 ){
					pageSetting +=  "<a href ='"+ pageLinkInit + pageMap.beforePage + resourceSetting + "'>[이전]</a>"
				}
				for( var i = pageMap.startPage ; i <= pageMap.endPage ; i++ ) {
					if( pageMap.curPage == i ){
						pageSetting += "["+ i +"]"
					} else {
						pageSetting += "<a href ='"+ pageLinkInit + i + resourceSetting + "'>"+ i +"</a>"	
					}
				}
				if( pageMap.afterPage != -1 ){
					pageSetting +=  "<a href ='"+ pageLinkInit + pageMap.afterPage + resourceSetting + "'>[다음]</a>"
				}
				$("#paging").html(pageSetting);
				
				
			},
			error : function(request,status,error) {
				var lessonListSetting = "";
				lessonListSetting = "<ul><li class='empty_lesson_msg'>";
				lessonListSetting += "레슨이 존재하지 않습니다.";
				lessonListSetting += "</li></ul>";
				$("#lessonList").html(lessonListSetting);
				var pageSetting = ""; 
				pageSetting += "[1]"
				$("#paging").html(pageSetting);
			}
		})
	} 
	function locSearch(){
		/**************** 주소값가져오기 ******************/
		var sido = $("#sido").val();
		var gugun = $("#gugun").val();
		var urlLoc = sido + "," + gugun;
		var bigCate = "<c:out value="${ values.bigCate }"></c:out>";
		var smallCates = "";
		<c:forEach items="${values.arrSmallCate}" var="smallCate">
			smallCates += "${smallCate}" + ",";  
		</c:forEach>
		window.location.href = 
		"<%=request.getContextPath()%>/lesson/lessonList/"+bigCate+"/1?alignment=theLatest&checkedSmallCate="+smallCates+"&location="+urlLoc;
	}
	
	
</script>
<title>레슨 목록</title>
</head>
<body>

<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>
		
		<div class="category_nav" style="background:url('<%=request.getContextPath()%>/resources/images/mentors/category_bg_${ bigCate }.jpg') center center no-repeat" >
			<p>${ bigCate }</p>
		</div>
		
		<div class="cont cont_wrap">
			
			<div class="lesson_left_area">
				<!-- 카테고리 필터 -->
				<div id="categoryBox">
					<ul>
						<li><input type="checkbox" id="selectTotalBox" checked><span>카테고리 전체</span></li>
						<c:if test="${ empty values.arrCheckedSmallCate }" var="result">
							<c:forEach items="${ values.arrSmallCate }" var="smallCate" varStatus="r">
									<li><label> 
									<input class="cate_check" type="checkbox"
											id="smallCate_${r.index}" value="${ smallCate }" onchange="categorySearch()" /><span>${ smallCate }</span>
									</label></li>
							</c:forEach>
						</c:if>
						
						<c:if test="${ not result }">	
							<c:forEach items="${ values.arrSmallCate }" var="smallCate" varStatus="row">
							<c:set var="isPrint" value="false" />
								<c:forEach items="${ values.arrCheckedSmallCate }" var="CheckedsmallCate">
									<c:if test="${ CheckedsmallCate eq smallCate }" var="r2">
										<li><label>
										<input class="cate_check" type="checkbox"
												id="smallCate_${row.index}" value="${ smallCate }" checked onchange="categorySearch()" /><span>${ smallCate }</span>
										</label></li>
										<c:set var="isPrint" value="true"/>
									</c:if>
								</c:forEach>
								<c:if test="${ not isPrint }">
										<li><label>
										<input class="cate_check" type="checkbox"
												id="smallCate_${row.index}" value="${ smallCate }" onchange="categorySearch()" /><span>${ smallCate }</span>
										</label></li>
								</c:if>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
		
			<div class="lesson_right_area">
				<div id="search_and_align">
					<!-- 지역 검색 필터-->
					<div id="searchBox">
						<jsp:include page="/WEB-INF/views/include/juso.jsp"></jsp:include>
						<button id="locSearchBtn" type="button" onclick="locSearch()">지역으로 검색</button>
					</div>
					<!-- 정렬필터 -->
					<div id="alignBox">
						<select id="listAlignment">
							<option value="theLatest">최신 순</option>
							<option value="theOldest">오래된 순</option>
							<option value="highScore">높은 평점순</option>
							<option value="lowScore">낮은 평점순</option>
						</select>
					</div>
				</div>
		
				<!-- 게시글 리스트 -->
				<div id="lessonList">
				<ul>
					
					<c:if test="${ empty values.lessonList }" var="emp_list" >
						<li class="empty_lesson_msg">검색된 레슨이 없습니다.</li>
					</c:if>
					
					<c:if test="${ not emp_list }">
					 
						<c:forEach items="${ values.lessonList }" var="lesson">
						<li>
							<div class="lesson_img_area">
								<div class="lesson_img">
									<%-- <img src="<%=request.getContextPath()%>/resources/lessonImage/${ lesson.lesson_thumnail  }" > --%>
									 <img src="<%=request.getContextPath()%>/resources/lessonImage/${ empty lesson.lesson_thumnail ? 'no_image.jpg' : lesson.lesson_thumnail }" >
								</div>
							</div>
							<div class="lesson_desc_area">
								<p class="title"><a href="<%=request.getContextPath()%>/lesson/detail/${lesson.lesson_id}">${ lesson.title }</a></p>
								<p class="category_and_location">${ lesson.category_small } / ${ lesson.location }</p>
								<p class="price_and_time">${lesson.price }원 / ${ lesson.total_round }회</p>
								<p class="score_and_review"><img src="<%=request.getContextPath()%>/resources/images/mentors/star.svg"> <span>${ lesson.avg_score }</span> (리뷰 ${ lesson.review_count }건)</p>
								<div class="like_area">
								<c:if test="${ memberType eq 'mentee' }">
									<c:if test="${not empty values.likeList}">
							  			<c:set var="isPrint" value="false"/>
								        <c:forEach items="${ values.likeList }" var="like_check">
								        	<c:if test="${ like_check.lesson_id eq lesson.lesson_id }">
												<button class="btn-secondary like-review" id="likeBtn_${lesson.lesson_id}" 
													value="1" onclick="pushLike(1,${lesson.lesson_id})">
													찜 취소
													</button>
													<c:set var="isPrint" value="true"/>
											</c:if>
								        </c:forEach>
							       		 <c:if test="${ not isPrint }">
											<button id="likeBtn_${lesson.lesson_id}" 
													value="0"  onclick="pushLike(0,${lesson.lesson_id})">찜 하기</button>
										</c:if>
								     </c:if>
								</c:if>
								</div>								
							</div>
						</li>
					</c:forEach>
						
					</c:if> 
					
				</ul>
			</div>
				
						<%-- 
						<div class="lessonListDefault">
						<div class="card mb-3 align-middle" style="max-width: 540px;">
						  <div class="row no-gutters">
						    <div class="col-md-4 border">
						      <img src="<%=request.getContextPath()%>/resources/img/lesson${ lesson.lesson_thumnail }" class="card-img" alt="...">
						    </div>
						    <div class="col-md-8">
						      <div class="card-body">
						        <h5 class="card-title"><a href="<%=request.getContextPath()%>/lesson/detail/${lesson.lesson_id}">${ lesson.title }</a></h5>
						        <p class="card-text">${ lesson.category_small } / ${ lesson.location }</p>
						        <p class="card-text"><small class="text-muted">${lesson.price }원 ${ lesson.total_round }회</small></p>
						        <p class="card-text"><small class="text-muted">평점:${ lesson.avg_score } (리뷰 ${ lesson.review_count }건)</small>
						        <c:if test="${not empty values.likeList}">
						  			<c:set var="isPrint" value="false"/>
							        <c:forEach items="${ values.likeList }" var="like_check">
							        	<c:if test="${ like_check.lesson_id eq lesson.lesson_id }">
												<button class="btn-secondary like-review" id="likeBtn_${lesson.lesson_id}" 
													value="1" onclick="pushLike(1,${lesson.lesson_id})">찜 취소</button>
													<c:set var="isPrint" value="true"/>
										</c:if>
							        </c:forEach>
							       		 <c:if test="${ not isPrint }">
												<button class="btn-secondary like-review" id="likeBtn_${lesson.lesson_id}" 
													value="0"  onclick="pushLike(0,${lesson.lesson_id})">찜하기</button>
										</c:if>
							     </c:if>
								</p>
						      </div>
						    </div>
						  </div>
						</div>
						</div>
					--%>
				
				
				<!-- 페이징 -->
				<div id="paging">
					<c:if test="${ values.pageMap.beforePage ne -1}">
						<a id="pageLink_before" href=
							"<%=request.getContextPath()%>/lesson/lessonList/${bigCate}?page=${values.pageMap.beforePage}">[이전]
							</a>
					</c:if>
					<c:forEach begin="${ values.pageMap.startPage}" end="${ values.pageMap.endPage}" var="page" varStatus="r">
						<c:if test="${  values.pageMap.curPage eq page }" var="result"><b>[${page}]</b></c:if>
						<c:if test="${ not result }">
							<a id="pageLink_${r.index+1}" href=
							"<%=request.getContextPath()%>/lesson/lessonList/${bigCate}?page=${page}">${page}
							</a>
						</c:if>
					</c:forEach>
					<c:if test="${ values.pageMap.afterPage ne -1}">
						<a id="pageLink_after" href=
							"<%=request.getContextPath()%>/lesson/lessonList/${bigCate}?page=${values.pageMap.afterPage}">[다음]
							</a>
					</c:if>
				</div>
			</div>
		
	</div>	 
		

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

<script type="text/javascript">
	// 페이지 로딩된 이후에 무조건 전체로 체크되어있음
	// 전체 체크박스 change에 이벤트를 걸거니깐 여기는 그냥 전체 체크해놓는 것만.
	var first = <c:out value="${values.first}"></c:out>
	if (first == true){
		$("#selectTotalBox").prop("checked", true);	
		$(".cate_check").prop("checked", true);
		categorySearch();
	} else {
		var totalCateLength = $(".cate_check").length;
		var checkedCateLength = 0;
		for( var i = 0 ; i < totalCateLength ; i++){
			if($("input:checkbox[id='smallCate_"+i+"']").is(":checked")){ 
				checkedCateLength++;
			}	
		}
		if (totalCateLength != checkedCateLength){
			$("#selectTotalBox").prop("checked",false);
		}
	}
	
	var resourceSetting = "";
	var alignmentParam = "<c:out value="${ values.alignmentParam }"></c:out>";
	var location_si = "<c:out value="${ values.si }"></c:out>";
	var location_gu = "<c:out value="${ values.gu }"></c:out>";
	
	<c:forEach var="entry" items="${values.pageMap}">
		var	${entry.key} = ${entry.value};
	</c:forEach> 

	if( alignmentParam != "" ){
		
		/**************** 체크된 카테고리 세팅 및 값가져오기 ***************/
		var checkedSmallCate = "";
		var catelength = $("input:checkbox").length;
		for ( var i = 0 ; i < catelength ; i++ ) {
			if ($("input:checkbox[id='smallCate_"+i+"']").is(":checked")){
				checkedSmallCate += $("input:checkbox[id='smallCate_"+i+"']").val() + ",";		
			}	
		}
		/**************** 정렬값 세팅 및 값 가져오기 ****************/
		$("#listAlignment").val(alignmentParam).attr("selected",true);
		var alignment = alignmentParam;
		/**************** 주소값 세팅 및 가져오기 ******************/
		$("#sido").val(location_si).attr("selected",true); 
		gugunview(location_si);
		$("#gugun").val(location_gu).attr("selected",true);
		var locationTotal = location_si+","+location_gu;
		
		resourceSetting = 
		"?alignment="+alignment+"&"+"checkedSmallCate="+checkedSmallCate+"&"+"location="+locationTotal;
		/*****************  페이징 href 세팅하기    **************/
		var pageLinkInit = "/mentors/lesson/lessonList/${bigCate}/";
		var pageSetting = "";
		if( beforePage != -1 ){
			pageSetting +=  "<a href ='"+ pageLinkInit + beforePage + resourceSetting + "'>[이전]</a>"
		}
		for( var i = startPage ; i <= endPage ; i++ ) {
			if( curPage == i ) { 
				pageSetting += "["+ i +"]"
			} else {
				pageSetting += "<a href ='"+ pageLinkInit + i + resourceSetting + "'>"+ i +"</a>";	
			}
		}
		if( afterPage != -1 ){
			pageSetting += "<a href ='"+ pageLinkInit + afterPage + resourceSetting + "'>[다음]</a>";
		}
		$("#paging").html(pageSetting);
	}
</script> 
	
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