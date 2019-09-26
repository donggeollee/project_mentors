<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>
<title>멘토 마이페이지</title>
<script type="text/javascript"
	src='<%=request.getContextPath()%>/resources/js/jquery.js'></script>
<script type="text/javascript">
		
		$(document).ready(function(){
			
			var sortName = "<c:out value='${ sortName }'></c:out>";
			if ( sortName == "" || sortName.length == 0 ){
				return;
			}else{
				$("#select_sorting").val(sortName).attr("selected","true");
			}
		});
		
	function sorting_change() {
			var sort = $(":selected").val();
			location.href="<%=request.getContextPath()%>/mentor/myLessonPicklist/sort/" + sort;
		};
	
	
		function proc(data) {
			var searchValue = $("#mentee_name_item").val();
	
			var str = '';
			var str2 = '';
			
			alert(JSON.stringify(data));
			//alert(data);			
			
			//$.each(data, function (index,item) {
				for(var i=0 in data.Searchresult){
				
				$(".search_list").css("display","none");	
				$(".paginInfo").css("display","none");
				/*$("#searchbox").append(item.mentee_name + " " + item.mentee_email);*/
				$(".first_list").css("display","none");
				str += '<tr class="search_list"><td>' + data.Searchresult[i].mentee_name + '</td>';
				str += '<td>' + data.Searchresult[i].mentee_email + '</td>';
				str += '<td>' + data.Searchresult[i].title + '</td>';
				str += '</tr>';
			}
			
				 var totalPageCount = data.pagingList[0];
	     	     var startPageNo = data.pagingList[1];
	     	     var endPageNo = data.pagingList[2];
	     	     var beforePageNo = data.pagingList[3];
	     	     var afterPageNo = data.pagingList[4];
	     	     var page = data.pagingList[5];
	     	     var totalCount = data.pagingList[6];
				
	     	     
	     	     
	     	    str2 += '<ul class="paginInfo">';
	            if (beforePageNo != -1 ){
	               str2 += '<a href="<%=request.getContextPath()%>/mentor/menteeNameSearch/' ;
	               str2 += searchValue
	               str2 += beforePageNo+'">이전</a>';
	            }
	            
	            
	            for(var pageNo = startPageNo; pageNo <= endPageNo; pageNo = pageNo + 1) {
	               if(page == pageNo)
	                  str2 += '<b>['+pageNo+']</b>';
	               else{
	                  str2 += '<a href="<%=request.getContextPath()%>/mentor/menteeNameSearch/' ;
	                  str2 += searchValue;
	                  str2 += '/'+pageNo+'">'+pageNo+'</a>';
	               }
	                  
	            }
	  
	            if(afterPageNo != -1) {
	               str2 += '<a href="<%=request.getContextPath()%>/mentor/menteeNameSearch/' ;
	               str2 += searchValue;
	               str2 += '/'+afterPageNo+'">다음</a>';
	            }
	            
	            str2 += '</ul>';
    	    
     	    $("#total_list").append(str);
			$("#menteeNum").text("검색 멘티 회원 총"+totalCount+"명");
			$("#pagingNum").append(str2)
			
		};





		$(document).ready(function(){
			// 엔터키 했을 때의 검색 기능 조건 추가 	
			$("#mentee_name_item").keyup(function(e){
				if(e.keyCode == 13)  
					
					var searchObject = new Object();
				searchObject.mentee_name = $("#mentee_name_item").val();
				
				var searchItemObject = JSON.stringify(searchObject);
				
				$.ajax({

					url:'<%=request.getContextPath()%>/mentor/menteeNameSearch',
					type:"post",
					async:false,
					contentType:"application/json; charset=utf-8",
					data:searchItemObject,
					dataType:"json",
					success:function(data){
						//var lessonList = data.lessonList;
					
						//alert(JSON.stringify(data));
							proc(data);	
						
						}, 
					error:function(data){
							$("#select_sorting").css("display","none");
							$(".search_list").css("display","none");
							$("#basicTable").css("display","none");
							$("#pagingNum").css("display","none");
							$(".first_list").css("display","none");
							$("#total_list_size").css("display","none");	
							str = '<tr class="search_list"><td colspan="4">' + "검색된 결과가 존재하지 않습니다." + '</td></tr>';
							$("#total_list").append(str);
					}
					
				});
			});
					
			
			$("#mentee_name_searchbtn").on("click",function(){
					
			
				var searchObject = new Object();
				searchObject.mentee_name = $("#mentee_name_item").val();
				
				var searchItemObject = JSON.stringify(searchObject);
				
				$.ajax({

					url:'<%=request.getContextPath()%>/mentor/menteeNameSearch',
					type:"post",
					async:false,
					contentType:"application/json; charset=utf-8",
					data:searchItemObject,
					dataType:"json",
					success:function(data){
						//var lessonList = data.lessonList;
					
						//alert(JSON.stringify(data));
							proc(data);	
						
						}, 
					error:function(data){
							$("#select_sorting").css("display","none");
							$(".search_list").css("display","none");
							$("#basicTable").css("display","none");
							$("#pagingNum").css("display","none");
							$(".first_list").css("display","none");
							$("#total_list_size").css("display","none");	
							str = '<tr class="search_list"><td colspan="4">' + "검색된 결과가 존재하지 않습니다." + '</td></tr>';
							$("#total_list").append(str);
					}
					
				});
			});
		});
		
	

		
	
	
		
	</script>

</head>
<body>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp" flush="false"></jsp:include>

	<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/admin_advice_chat.jsp"
		flush="false"></jsp:include>

<div id="content_wrap">

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_mentor.jsp" flush="false"></jsp:include>
	
	
	<div id="right_content" class="review_content">
			<h3 class="content_title first_h3">나의 레슨을 찜한 멘티</h3>
			<p class="title_desc">나의 레슨에 찜하기를 누른 멘티를 확인할 수 있습니다</p>
	
	
		<div id="total_list_size">
			<p id="menteeNum" class="title_desc">멘티 총 ${total_count}명</p>
		</div>
	
		<div class="search_box_wp">
			<div class="search_box_by_mentee_name">
				<input type="text" placeholder="이름으로 검색" id="mentee_name_item">
				<span><img src="<%=request.getContextPath()%>/resources/images/mentors/icon/search.png" height="30px" id="mentee_name_searchbtn"></span>
			</div>
		
			<div class="select_wrap select_wrap2">
				<select name="select_sorting" id="select_sorting" onchange="sorting_change()">
					<option value="orderByLikeDesc">최신순</option>
					<option value="orderByName">이름순</option>
					<option value="orderByClass">클래스명</option>
					<option value="orderByLikeAsc">과거순</option>
				</select>
			</div>
		</div>
	
	
		<div>
			<table id="total_list" class="table_style1">
				<thead>
					<tr id="basicTable">
						<th>멘티이름</th>
						<th>이메일</th>
						<th>레슨명</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${ not empty pickme_menteelist}" var="r">
						<c:forEach items="${pickme_menteelist}" var="list">
							<tr class="first_list">
								<td>${list.mentee_name}</td>
								<td>${list.mentee_email}</td>
								<td class="title_td">${list.title}</td>
							</tr>
						</c:forEach>
		
					</c:if>
		
					<c:if test="${not r}">
						<tr>
							<td colspan="4"><p id="none" style="margin-bottom:0;">나의 클래스에 찜하기를 누른 멘티가 존재하지 않습니다.</p></td>
						</tr>
					</c:if>
				</tbody>
			</table>
				
			 <c:if test="${sortType eq 'none' }">
				  <div id="pagingNum" class="pagePart">
					<ul class="paginInfo">
						<c:if test="${beforePageNo ne -1 }">
								<a href="<%=request.getContextPath()%>/mentor/myLessonPicklist/${sort}${beforePageNo}">이전</a>
							</c:if> <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
								<c:if test="${curPage eq pageNo}" var="r">
									<b>[${pageNo}]</b>
								</c:if>
								<c:if test="${not r}">
									<a
										href="<%=request.getContextPath()%>/mentor/myLessonPicklist/${sort}${pageNo}">${pageNo}</a>
								</c:if>
							</c:forEach> <c:if test="${afterPageNo ne -1 }">
								<a
									href="<%=request.getContextPath()%>/mentor/myLessonPicklist/${sort}${afterPageNo}">다음</a>
							</c:if>
					</ul>
				</div>
			</c:if>
				
			<div id="pagingNum" class="pagePart">
			<c:if test="${sortType eq 'searchMentee'}">
				 	<ul class="paginInfo">
					 	<c:if test="${beforePageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/mentor/menteeNameSearch/${search}${beforePageNo}">이전</a>
						</c:if>
						
							<c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
								<c:if test="${curPage eq pageNo}" var="r">
								<b>[${pageNo}]</b>
								</c:if>
								
								<c:if test="${not r}">
									<a href="<%=request.getContextPath()%>/mentor/menteeNameSearch/${search}${pageNo}">${pageNo}</a>
								</c:if>
							</c:forEach> 
						
						<c:if test="${afterPageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/mentor/menteeNameSearch/${search}${afterPageNo}">다음</a>
						</c:if>
					</ul>
					</c:if>
				</div>
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