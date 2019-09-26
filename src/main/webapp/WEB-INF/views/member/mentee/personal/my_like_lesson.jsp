<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<!DOCTYPE html>
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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/left_nav.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/content.css">				
<title>멘토스</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var alignment = "${alignment}";
	$("#select_align").val(alignment).attr("selected","true");
	
	if( ${not empty deleteMsg }){
		alert('${deleteMsg}');
	}
})


function align() {
	var likedListAlign = $("#select_align option:selected").val();
	$.ajax({
		url : "<%=request.getContextPath()%>/mentee/myLikeLesson/alignAjax",
		type : "post",
		data : { "align" : likedListAlign },	
		success : function (data) {
			var likedList = data.likedList;
			var pageMap = data.pageMap;
			var listSetting = "";
			$.each(likedList, function(i,value){
				listSetting += "<li>";
				listSetting += "<p class=\"category\">"+value.category_big+"/"+value.category_small+"</p>";
				listSetting += "<p class=\"\">"+value.mentor_name+"멘토님의 </p>";
				listSetting += "<p class=\"title\">"+value.title+"</p>";
				listSetting += "<p id=\"title_"+value.lesson_id+"\"class=\"review\">평균 리뷰점수"+value.avg_score+"(총 "+value.review_count+" 개의 리뷰)</p>";
				listSetting += "<p>" 
				listSetting += "<button id=\"likeDeleteBtn_"+value.lesson_id+"\" onclick=\"deleteLike("+value.lesson_id+")\">찜 취소하기";
				listSetting += "</button></p>"
				listSetting += "</li>";
			})
			
						
			$("#listSetting").html(listSetting);
			
			var pageLinkInit = "/mentors/mentee/myLikeLesson/";
			var pageSetting = "";
			if( pageMap.beforePage != -1 ){
				pageSetting +=  "<a href ='"+ pageLinkInit + pageMap.beforePage +"?align="+likedListAlign + "'>[이전]</a>"
			}
			for( var i = pageMap.startPage ; i <= pageMap.endPage ; i++ ) {
				if( pageMap.curPage == i ){
					pageSetting += "["+ i +"]"
				} else {
					pageSetting += "<a href ='"+ pageLinkInit + i  +"?align="+likedListAlign + "'>"+ i +"</a>"	
				}
			}
			if( pageMap.afterPage != -1 ){
				pageSetting +=  "<a href ='"+ pageLinkInit + pageMap.afterPage  +"?align="+likedListAlign + "'>[다음]</a>"
			}
			$("#paging").html(pageSetting);
		},
		error : function(request,status,error) {
			alert(error)
		}
	});
	
}

	function deleteLike(lesson_id){
		var page = '${pageMap.curPage}';
		var title = $("#title_"+lesson_id).text();
		location.href = "<%=request.getContextPath()%>/mentee/myLikeLesson/"+page+"?lesson_id="+lesson_id+"&title="+title;
	}

</script>
</head>
<body>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

<div id="content_wrap">

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav.jsp" flush="false"></jsp:include>

	<div id="right_content">
		<h3 class="content_title first_h3">내가 찜 한 레슨</h3>
		<p class="title_desc">
			내가 찜 한 레슨들의 목록을 확인할 수 있습니다.<br/>
			분야 별로 정렬, 찜 한 날짜 순으로 정렬할 수 있습니다.
		</p>
	
		<div>
			
		</div>
	
		<div class="select_wrap">
			<select class="select_style1" id="select_align" onchange="align()">
				<option value="desc">찜한 순 </option>
				<option value="asc">찜한 순 ↑</option>
			</select>
		</div>
		
				
		<c:if test="${ empty likedList }">
		<ul class="list_style1 no_data">
			<li>현재 찜한 레슨이 없습니다.</li>
		</ul>
		</c:if>
		
		<c:if test="${ not empty likedList }">
			<ul class="list_style1 like_lesson" id="listSetting">
				<c:forEach var="lList" items="${ likedList }" >
					<li>
						<p class="category">${ lList.category_big } / ${ lList.category_small }</p>
						<p class="">${ lList.mentor_name } 멘토님의 </p>
						<p class="title" id="title_${lList.lesson_id}"><a href="<%=request.getContextPath()%>/lesson/detail/${lList.lesson_id}">${ lList.title }</a></p>
						<p class="review">평균 리뷰점수  ${ lList.avg_score }(총  ${ lList.review_count } 개의 리뷰)</p>
						<p class="like_cancle_btn">
							<button id="likeDeleteBtn_${lList.lesson_id}" onclick="deleteLike(${lList.lesson_id})">찜 취소하기
						</button>
						</p>
					</li>
				</c:forEach>
			</ul>
		</c:if>
		
		<div id="paging">
		<c:if test="${ pageMap.beforePage ne -1}">
		
			<a id="pageLink_before" href="<%=request.getContextPath()%>/mentee/myLikeLesson/${pageMap.beforePage}?align=${alignment}">[이전]
			</a>
		</c:if>
		<c:forEach begin="${ pageMap.startPage}" end="${ pageMap.endPage}" var="page" varStatus="r">
			<c:if test="${  pageMap.curPage eq page }" var="result"><b>[${page}]</b></c:if>
			<c:if test="${ not result }">
				<a id="pageLink_${r.index+1}" href=
				"<%=request.getContextPath()%>/mentee/myLikeLesson/${page}?align=${alignment}">${page}
				</a>
			</c:if>
		</c:forEach>
		<c:if test="${ pageMap.afterPage ne -1}"> 
			<a id="pageLink_after" href=
				"<%=request.getContextPath()%>/mentee/myLikeLesson/${pageMap.afterPage}?align=${alignment}">[다음]
			</a>
		</c:if>
	</div>
	</div>
</div>

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