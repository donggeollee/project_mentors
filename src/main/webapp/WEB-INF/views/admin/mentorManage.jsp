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
<title>멘토관리</title>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		if($('#orderlist_sel').val() != '') $('#orderList').val($('#orderlist_sel').val())
		$("#orderList").on("change", function() {
			var text = $('#orderList option:selected').text();
			var value = $('#orderList').val();
			if(value == "defaultOrder"){
				window.location = "<%=request.getContextPath()%>/admin/manage/mentor";
			} else if(value == "name") {
				window.location = "<%=request.getContextPath()%>/admin/manage/mentor/order/name";
			} else if(value == "latest") {
				window.location = "<%=request.getContextPath()%>/admin/manage/mentor/order/latest";
			} else if(value == "oldest") {
				window.location = "<%=request.getContextPath()%>/admin/manage/mentor/order/oldest";
			}
		});

		
		$("#searchBtn").on("click", function () {
			var searchValue = '';
			searchValue =$("#searchName").val();
			
			if(searchValue == ''){
				alert("이름을 입력해주세요");
				return;
			}
			
			
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/mentorSearch',
				type: "post",
		        contentType: "application/json",
		        data: searchValue,
		        dataType: "json",
		        success: function (data) {
					//proc(data);
					$(".first_list").css("display","none");
					$(".firstPage").css("display","none");
					
					var str = '';
					if(data.mentorSearchResultList == null) {
						str += "<tr class='first_list'>";
						str += "<td colspan='5'>검색된 결과가 존재하지 않습니다</td></tr>";
					}
		        	for(var i=0 in data.mentorSearchResultList){
		        		
		        		str += "<tr class='first_list'>";
		        		str += "<td>"+data.mentorSearchResultList[i].mentor_name+"</td>";
		        		str += "<td>"+data.mentorSearchResultList[i].mentor_email+"</td>";
						str += "<td>"+data.mentorSearchResultList[i].phone+"</td>";
						str += "<td>"+data.mentorSearchResultList[i].regist_date+"</td>";
						str += "<td><input type='checkbox' class='mentorSelect' value="+data.mentorSearchResultList[i].mentor_id+"></td></tr>";
					
                    }
					$("#mentor_tb").append(str);
					
					var str2 = '';
					
					var totalPageCount = data.mentorSearchPageResult[0];
					var startPageNo = data.mentorSearchPageResult[1];
					var endPageNo = data.mentorSearchPageResult[2];
					var beforePageNo = data.mentorSearchPageResult[3];
					var afterPageNo = data.mentorSearchPageResult[4];
					var curPage = data.mentorSearchPageResult[5];
					var totalCount = data.mentorSearchPageResult[6];
					
					$("#totalMentorcount").text('검색된 멘토 결과 '+totalCount+"개");
					
					
					str2 += '<ul class="firstPage">';
					str2 += '<li>';
					if (beforePageNo != -1 ){
						str2 += '<a href="<%=request.getContextPath()%>/admin/mentorSearch/' ;
						str2 += searchValue;
						str2 += '/'+beforePageNo+'">이전</a>';
					}
					
					str2 += '</li>';
					str2 += '<li>';
					
					for(var pageNo = startPageNo; pageNo <= endPageNo; pageNo = pageNo + 1) {
						if(curPage == pageNo)
							str2 += '<b>['+pageNo+']</b>';
						else{
							str2 += '<a href="<%=request.getContextPath()%>/admin/mentorSearch/' ;
							str2 += searchValue;
							str2 += '/'+pageNo+'">'+pageNo+'</a>';
						}
							
					}
					
					str2 += '</li>';
					str2 += '<li>';
					
					if(afterPageNo != -1) {
						str2 += '<a href="<%=request.getContextPath()%>/admin/mentorSearch/' ;
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
					str += "<td colspan='5'>검색 결과가 없습니다.</td></tr>";
					
					$("#mentor_tb").append(str);
				}
			});
		});
		$("#selectTotalBtn").on("click", function () {
			var toggleValue = $("#selectTotalBtn").val();
			if(toggleValue == 1){
				$(".mentorSelect").prop("checked", 	true);
				$("#selectTotalBtn").text("선택해제");
				$("#selectTotalBtn").val(0);
			} else {
				$(".mentorSelect").prop("checked", 	false);
				$("#selectTotalBtn").text("전체선택");
				$("#selectTotalBtn").val(1);
			}
		});
		
		var selectedValue = '';
		$("#secessionBtn").on("click", function () {
			$('.mentorSelect:checked').each(function() { 
				
				selectedValue += "," + $(this).val();
		   });
			
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/mentorSucession',
				type: "post",
		        contentType: "application/json",
		        data: selectedValue,
		        dataType: "json",
		        success: function (data) {
					alert("삭제 성공!");
					location.reload();
				},
				error: function (data) {
					alert("삭제 실패!");				
				}
			});
		});
	});

	function mentorCheck() {
		

	}
</script>
</head>
<body>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/left_nav.js"></script>

<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/admin_header.jsp" flush="false"></jsp:include>

<div id="content_wrap">

	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/left_nav_admin.jsp" flush="false"></jsp:include>

  <div id="right_content">
	<input type='hidden' id = 'orderlist_sel' value = '${sortName}'>
		<h3 class="content_title first_h3">멘토관리</h3>
		<p class="title_desc">멘토 회원을 관리할 수 있습니다.</p>
		<div class="">
			<ul>
				<li id="totalMentorcount" class="title_desc">멘토 회원 총 ${ mentorCount }명</li>
				<li><input type="text" id="searchName" placeholder="이름 검색">
					<img src="<%=request.getContextPath()%>/resources/images/mentors/icon/search.png" height="30px" id="searchBtn">
		 	   </li>
			</ul>
	
		</div>
		<div class="select_wrap select_wrap3">
			<select id="orderList" class="select_style1">
				<option value="defaultOrder">정렬  </option>
				<option value="name">이름 순</option>
				<option value="latest">최신 가입 회원 순</option>
				<option value="oldest">오래된 회원 순</option>
			</select>
		</div>
		
		<div class="button_content">
				<button id="selectTotalBtn" value="1">전체선택</button>
				<button id="secessionBtn">회원 탈퇴</button>
		</div>
		
		
		
		<div class="table_content">
			<table id="mentor_tb" class="table_style1 table_style2">
				<tr>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>가입일</th>
					<th>선택</th>
				</tr>
				<c:if test="${ not empty mentorList }" var="r">
					<c:forEach items="${ mentorList }" var="mentorItem">
						<tr class="first_list">
							<td>${ mentorItem.mentor_name }</td>
							<td>${ mentorItem.mentor_email }</td>
							<td>${ mentorItem.phone }</td>
							<td>${ mentorItem.regist_date }</td>
							<td><input type="checkbox" class="mentorSelect" value="${mentorItem.mentor_id}"></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${ not r }">
					<tr class="first_list">
							<td colspan="5">가입된 멘토가 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	
		<div class="pagePart">
		
			<c:if test="${ sortType eq 'none' }">
				<ul class="firstPage">
					<li>
						<c:if test="${beforePageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/manage/mentor/${beforePageNo}">이전</a>
						</c:if>
					</li>
					<li>
					 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
								<c:if test="${curPage eq pageNo}" var="r">
									<b>[${pageNo}]</b>
								</c:if>
								<c:if test="${not r}">
									<a
										href="<%=request.getContextPath()%>/admin/manage/mentor/${pageNo}">${pageNo}</a>
								</c:if>
					</c:forEach> 
					</li>
					<li>
						<c:if test="${afterPageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/manage/mentor/${afterPageNo}">다음</a>
						</c:if>
					</li>
				</ul>
			</c:if>
			<c:if test="${ sortType eq 'order' }">
				<ul class="firstPage">
					<li>
						<c:if test="${beforePageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/manage/mentor/order/${sortName}/${beforePageNo}">이전</a>
						</c:if>
					</li>
					<li>
					 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
								<c:if test="${curPage eq pageNo}" var="r">
									<b>[${pageNo}]</b>
								</c:if>
								<c:if test="${not r}">
									<a
										href="<%=request.getContextPath()%>/admin/manage/mentor/order/${sortName}/${pageNo}">${pageNo}</a>
								</c:if>
					</c:forEach> 
					</li>
					<li>
						<c:if test="${afterPageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/manage/mentor/order/${sortName}/${afterPageNo}">다음</a>
						</c:if>
					</li>
				</ul>
			</c:if>
			<c:if test="${ sortType eq 'search' }">
				<ul class="firstPage">
					<li>
						<c:if test="${beforePageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/mentorSearch/${sortName}/${beforePageNo}">이전</a>
						</c:if>
					</li>
					<li>
					 <c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
								<c:if test="${curPage eq pageNo}" var="r">
									<b>[${pageNo}]</b>
								</c:if>
								<c:if test="${not r}">
									<a
										href="<%=request.getContextPath()%>/admin/mentorSearch/${sortName}/${pageNo}">${pageNo}</a>
								</c:if>
					</c:forEach> 
					</li>
					<li>
						<c:if test="${afterPageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/mentorSearch/${sortName}/${afterPageNo}">다음</a>
						</c:if>
					</li>
				</ul>
			</c:if>
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