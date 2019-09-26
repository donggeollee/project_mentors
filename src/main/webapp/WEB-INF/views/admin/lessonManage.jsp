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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/content.css">	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>
<title>레슨 관리</title>

<script type="text/javascript">

	var lesson_link = '';


function lessonDetailContentLocationControl() {
	

	var content_height = $("#right_content").height();	
	var content_width =$("#right_content").width();
	
	var form_height = $("#lesson_detail_form").height();
	var form_width = $("#lesson_detail_form").width();

	$("#lesson_detail_form").css("left",((content_width)/2)-(form_width/2));
	$("#lesson_detail_form").css("top",((content_height)/2)-(form_height/2));
	
}

	$(window).resize(function() { 
		lessonDetailContentLocationControl();
	});


	function proc(data) {
		 var $target = $(this).closest("tr"); 
		 
		 $("#lesson_detail_form").css("display","block");	
		 
		 /* lesson_link = data.lessonDetail.lesson_id; */
		 lesson_link = '<%=request.getContextPath()%>/lesson/detail/'+data.lessonDetail.lesson_id;
		
		<%-- 
		var str = '';
		var str2 = '';
		var menteeCnt = 0;
		str += "<ul class='detailViewForm'>";
		str += "<li>"+data.lessonDetail.category_big+"/"+data.lessonDetail.category_small+"</li>";
		str += "<li>"+data.lessonDetail.title+"</li>";
		str += "<li>"+data.mentorInfoList.mentor_name+"</li>";
  		str += "<li>"+data.mentorInfoList.mentor_email+"</li>";
  		str += "<li>"+data.mentorInfoList.phone+"</li>";
  		str += "<li><img src='<%=request.getContextPath()%>/resources/profiles/";
		str += data.mentorInfoList.mentor_profile+"'></li>";
  		  
		
		str += "<li>멘토링 진행중인 멘티 (총"
		str += menteeCnt + "명)</li>";
		str2 += "<p class='button_wrap'>";
		str2 += "<a href='<%=request.getContextPath()%>/lesson/detail/";
		str2 += data.lessonDetail.lesson_id+"'>레슨 상세 페이지로 이동(새창)>";
		$(".lesson_id").append(str);
		$(".lesson_id").append(str2);
		
		--%>
		
		var menteeCnt = 0;
		
		$("#lesson_detail_form .category").text(data.lessonDetail.category_big+" / "+data.lessonDetail.category_small);
		$("#lesson_detail_form .title").text("["+data.lessonDetail.title+"]");
		$("#lesson_detail_form .mentor_name").text("멘토 "+data.mentorInfoList.mentor_name);
		$("#lesson_detail_form .mentor_email").text(data.mentorInfoList.mentor_email);
		$("#lesson_detail_form .mentor_tel").text(data.mentorInfoList.phone);
		
		$("#lesson_detail_form ul").html("");
		
		for(var i=0 in data.MenteeList){
			menteeCnt += 1;
			$("#lesson_detail_form ul").append("<li>"+data.MenteeList[i].mentee_name+"</li>");
        }
		
		$("#lesson_detail_form h5").text("멘토링 진행중인 멘티(총"+ menteeCnt + "명)");
		
		<%--
		<p class="title"></p>
		<p class="mentor_name"></p>
		<p class="mentor_email"></p>
		<p class="mentor_tel"></p>
		
		--%>
	}
	
	
	$(document).ready(function(){
		
	lessonDetailContentLocationControl();
		
		
	$(".review_close").on("click",function(){
		
		 $("#lesson_detail_form").css("display","none");	
		
	});
	
	 $('.open_lesson').click(function(){ 

	      window.open(lesson_link);

	       return false; 

	  }); 
		
		
		
		
	 $(".lesson_title").on("click",function(){

		 var $target = $(this).closest("tr"); 
		// var lesson_id = $target.find(".lessonSelect").val();
		 var lessonObject = new Object();
		 
		 lessonObject.lesson_id = $target.find(".lessonSelect").val();
		 
		 var lessonJsonObject = JSON.stringify(lessonObject);
		 
		 
			$.ajax({

				url:'<%=request.getContextPath()%>/admin/manage/lessonDetail',
				type:"post",
				async:false,
				contentType:"application/json; charset=utf-8",
				data:lessonJsonObject,
				dataType:"json",
				success:function(data){
					
					proc(data);
					
					}, 
				error:function(data){
					alert("상세보기 과정에서 에러가 발생했습니다");
				}
				
			})
		 
	 })
		
	});


	$(document).ready(function() {
		if($('#orderlist_sel').val() != ''){
			$('#orderList').val($('#orderlist_sel').val())
		}
		$("#orderList").on("change", function() {
			var text = $('#orderList option:selected').text();
			var value = $('#orderList').val();
			if(value == "defaultOrder"){
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson";
			} else if(value == "name") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/order/name";
			} else if(value == "latest") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/order/latest";
			} else if(value == "oldest") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/order/oldest";
			} else if(value == "IT") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/category/IT";
			} else if(value == "Music") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/category/Music";
			} else if(value == "Exercise") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/category/Exercise";
			} else if(value == "Cook") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/category/Cook";
			} else if(value == "Language") {
				window.location = "<%=request.getContextPath()%>/admin/manage/lesson/category/Language";
			}
		});

		$("#searchName").on("focus", function(){
			$("#searchName").val('');
		});
		
		$("#searchBtn").on("click", function () {
			var searchValue = '';
			searchValue =$("#searchName").val();
			
			if(searchValue == ''){
				alert("이름을 입력해주세요");
				return;
			}
			
			
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/lessonSearch',
				type: "post",
		        contentType: "application/json",
		        data: searchValue,
		        dataType: "json",
		        success: function (data) {
					//proc(data);
					$(".first_list").css("display","none");
					$(".firstPage").css("display","none");
					var str = '';

					if(data.lessonSearchResultList == null) {
						str += "<tr class='first_list'>";
						str += "<td colspan='5'>검색된 결과가 존재하지 않습니다</td></tr>";
					}
					
		        	for(var i=0 in data.lessonSearchResultList){
		        		
		        		str += "<tr class='first_list'>";
		        		str += "<td>"+data.lessonSearchResultList[i].mentor_name+"</td>";
		        		str += "<td>"+data.lessonSearchResultList[i].title+"</td>";
						str += "<td>"+data.lessonSearchResultList[i].category_big+"/"+data.lessonSearchResultList[i].category_small+"</td>";
						str += "<td>"+data.lessonSearchResultList[i].mentee_count+"</td>";
						str += "<td>"+data.lessonSearchResultList[i].write_date+"</td>";
						str += "<td><input type='checkbox' class='mentorSelect' value="+data.lessonSearchResultList[i].lesson_id+"></td></tr>";
					
                    }      
					$("#lesson_tb").append(str);
					
					var str2 = '';
					
					var totalPageCount = data.lessonSearchPageResult[0];
					var startPageNo = data.lessonSearchPageResult[1];
					var endPageNo = data.lessonSearchPageResult[2];
					var beforePageNo = data.lessonSearchPageResult[3];
					var afterPageNo = data.lessonSearchPageResult[4];
					var curPage = data.lessonSearchPageResult[5];
					var totalCount = data.lessonSearchPageResult[6];
					
					
					$("#totalLessonCount").text('검색된 레슨 수 '+totalCount+"개");
					
					
					str2 += '<ul class="firstPage">';
					str2 += '<li>';
					if (beforePageNo != -1 ){
						str2 += '<a href="<%=request.getContextPath()%>/admin/lessonSearch/' ;
						str2 += searchValue;
						str2 += '/'+beforePageNo+'">이전</a>';
					}
					
					str2 += '</li>';
					str2 += '<li>';
					
					for(var pageNo = startPageNo; pageNo <= endPageNo; pageNo = pageNo + 1) {
						if(curPage == pageNo)
							str2 += '<b>['+pageNo+']</b>';
						else{
							str2 += '<a href="<%=request.getContextPath()%>/admin/lessonSearch/' ;
							str2 += searchValue;
							str2 += '/'+pageNo+'">'+pageNo+'</a>';
						}
							
					}
					
					str2 += '</li>';
					str2 += '<li>';
					
					if(afterPageNo != -1) {
						str2 += '<a href="<%=request.getContextPath()%>/admin/lessonSearch/' ;
						str2 += searchValue;
						str2 += '/'+afterPageNo+'">다음</a>';
					}
					
					str2 += '</li>';
					str2 += '</ul>';
	
					$("#pagePart").append(str2);
				},
				error: function (data) {
					$(".first_list").css("display","none");
					var str = '';
					
					str += "<tr class='first_list'>";
					str += "<td colspan='6'>검색 결과가 없습니다.</td></tr>";
					
					$("#lesson_tb").append(str);
				}
			});
		});
		$("#selectTotalBtn").on("click", function () {
			var toggleValue = $("#selectTotalBtn").val();
			if(toggleValue == 1){
				$(".lessonSelect").prop("checked", 	true);
				$("#selectTotalBtn").text("선택해제");
				$("#selectTotalBtn").val(0);
			} else {
				$(".lessonSelect").prop("checked", 	false);
				$("#selectTotalBtn").text("전체선택");
				$("#selectTotalBtn").val(1);
			}
		});
		
		var selectedValue = '';
		$("#secessionBtn").on("click", function () {
			$('.lessonSelect:checked').each(function() { 
				
				selectedValue += "," + $(this).val();
		   });
			
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/lessonSucession',
				type: "post",
		        contentType: "application/json",
		        data: selectedValue,
		        dataType: "json",
		        success: function (data) {
					alert("삭제 성공!");
					location.reload();
				},
				error: function (data) {
					alert("삭제실패!");				
				}
			});
		});
	});

</script>
</head>
<body>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/admin_header.jsp" flush="false"></jsp:include>

<div id="content_wrap">


<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_admin.jsp" flush="false"></jsp:include>

	<div id="right_content" class="review_content">
		<h3 class="content_title first_h3">레슨 관리</h3>
		<p class="title_desc">현재 진행중인 레슨 관리</p>

	<div>
		<ul>
			<li id="totalLessonCount" class="title_desc">총 레슨 수 ${ lessonCount }개</li>
			<li><input type="text" id="searchName" placeholder="멘토 이름 검색">
			<img src="<%=request.getContextPath()%>/resources/images/mentors/icon/search.png" height="30px" id="searchBtn">
		    </li>
		</ul>

	</div>
	<div class="select_wrap select_wrap3">
	<input type='hidden' id ='orderlist_sel' value="${sortName}">
		<select id="orderList"  class="select_style1">
			<option value="defaultOrder">정렬</option>
			<option value="name">멘토이름 순</option>
			<option value="latest">등록일 ▼</option>
			<option value="oldest">등록일 ▲</option>
			<option value="IT">IT</option>
			<option value="Music">음악</option>
			<option value="Exercise">운동</option>
			<option value="Cook">요리</option>
			<option value="Language">외국어</option>
		</select>
	</div>
	
	<div class="button_content">
				<button id="selectTotalBtn" value="1">전체선택</button>
				<button id="secessionBtn">강의 삭제</button>
		</div>
	
	<div class="table_content">
		<table id="lesson_tb" class="table_style1 table_style2">
			<colgroup>
				<col width="13%">
				<col>
				<col width="16%">
				<col width="10%">
				<col width="%">
				<col width="10%">
			</colgroup>
			<tr>
				<th>멘토</th>
				<th>레슨명</th>
				<th>카테고리</th>
				<th>멘티수</th>
				<th>등록일</th>
				<th>선택</th>
			</tr>
			<c:if test="${ not empty lessonList }" var="r">
				<c:forEach items="${ lessonList }" var="lessonItem">
					<tr class="first_list">
						<td>${ lessonItem.mentor_name }</td>
						<td class="lesson_title">${ lessonItem.title }</td>
						<td>${ lessonItem.category_big }/${ lessonItem.category_small }</td>
						<td>${ lessonItem.mentee_count }</td>
						<td>${ lessonItem.write_date }</td>
						<td><input type="checkbox" class="lessonSelect" value="${lessonItem.lesson_id}"></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${ not r }">
				<tr class="first_list">
						<td colspan="6">현재 진행하고 있는 레슨이 없습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
	<div id="pagePart" class="pagePart">
	
		<c:if test="${ sortType eq 'none' }">
			<ul class="firstPage">
				<li>
					<c:if test="${beforePageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/manage/lesson/${beforePageNo}">이전</a>
					</c:if>
				</li>
				<li>
				 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
							<c:if test="${curPage eq pageNo}" var="r">
								<b>[${pageNo}]</b>
							</c:if>
							<c:if test="${not r}">
								<a
									href="<%=request.getContextPath()%>/admin/manage/lesson/${pageNo}">${pageNo}</a>
							</c:if>
				</c:forEach> 
				</li>
				<li>
					<c:if test="${afterPageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/manage/lesson/${afterPageNo}">다음</a>
					</c:if>
				</li>
			</ul>
		</c:if>
		<c:if test="${ sortType eq 'order' }">
			<ul class="firstPage">
				<li>
					<c:if test="${beforePageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/manage/lesson/order/${sortName}/${beforePageNo}">이전</a>
					</c:if>
				</li>
				<li>
				 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
							<c:if test="${curPage eq pageNo}" var="r">
								<b>[${pageNo}]</b>
							</c:if>
							<c:if test="${not r}">
								<a
									href="<%=request.getContextPath()%>/admin/manage/lesson/order/${sortName}/${pageNo}">${pageNo}</a>
							</c:if>
				</c:forEach> 
				</li>
				<li>
					<c:if test="${afterPageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/manage/lesson/order/${sortName}/${afterPageNo}">다음</a>
					</c:if>
				</li>
			</ul>
		</c:if>
		<c:if test="${ sortType eq 'category' }">
			<ul class="firstPage">
				<li>
					<c:if test="${beforePageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/manage/lesson/category/${sortName}/${beforePageNo}">이전</a>
					</c:if>
				</li>
				<li>
				 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
							<c:if test="${curPage eq pageNo}" var="r">
								<b>[${pageNo}]</b>
							</c:if>
							<c:if test="${not r}">
								<a
									href="<%=request.getContextPath()%>/admin/manage/lesson/category/${sortName}/${pageNo}">${pageNo}</a>
							</c:if>
				</c:forEach> 
				</li>
				<li>
					<c:if test="${afterPageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/manage/lesson/category/${sortName}/${afterPageNo}">다음</a>
					</c:if>
				</li>
			</ul>
		</c:if>
		<c:if test="${ sortType eq 'search' }">
			<ul class="firstPage">
				<li>
					<c:if test="${beforePageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/lessonSearch/${sortName}/${beforePageNo}">이전</a>
					</c:if>
				</li>
				<li>
				 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
							<c:if test="${curPage eq pageNo}" var="r">
								<b>[${pageNo}]</b>
							</c:if>
							<c:if test="${not r}">
								<a
									href="<%=request.getContextPath()%>/admin/lessonSearch/${sortName}/${pageNo}">${pageNo}</a>
							</c:if>
				</c:forEach> 
				</li>
				<li>
					<c:if test="${afterPageNo ne -1 }">
						<a href="<%=request.getContextPath()%>/admin/lessonSearch/${sortName}/${afterPageNo}">다음</a>
					</c:if>
				</li>
			</ul>
		</c:if>
	</div>
	
		
		<!-- 레슨 상세보기 -->
		<div id="lesson_detail_form">
				<h4>레슨 상세보기</h4>
				<span class="lesson_id"></span>
				<!-- <div class="mentor_profile">사진</div>  -->
				<p class="category"></p>
				<p class="title"></p>
				<p class="mentor_name"></p>
				<p class="mentor_email"></p>
				<p class="mentor_tel"></p>
				
				<h5></h5>
				<ul>
					<li></li>
				</ul>
				
				<div class="button_wrap">
					<button class="open_lesson">레슨 보러가기(새창으로)</button>	
					<button class="review_close">확인</button>
				</div>
		</div>
		
	</div>	
</div>	
	<jsp:include
	page="${ requestScope.contextPath }/WEB-INF/views/include/admin_footer.jsp"
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