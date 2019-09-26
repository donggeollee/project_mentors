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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<title>멘티관리</title>

<script type="text/javascript">
$(document).ready(function(){
	
	var sortName = "<c:out value='${ sortName }'></c:out>";
	if ( sortName == "" || sortName.length == 0 ){
		return;
		
	}else{
		
		if (sortName == 'name') {
		$("#orderList").val('name').attr("selected","true");
		
		} else if( sortName == 'latest'){
		$("#orderList").val('theLatest').attr("selected","true");
		} else if ( sortName = 'oldest'){
		$("#orderList").val('theOldest').attr("selected","true");
		} else if ( sortName = 'simpleLogin'){
		$("#orderList").val('simpleLogin').attr("selected","true");
		}
	}
});


	$(document).ready(function() {
		if($('#orderlist_sel').val() != '') $('#orderList').val($('#orderlist_sel').val())
		$("#orderList").on("change", function() {
			var text = $('#orderList option:selected').text();
			var value = $('#orderList').val();
			if(value == "defaultOrder"){
				window.location = "<%=request.getContextPath()%>/admin/manage/mentee";
			} else if(value == "name") {
				window.location = "<%=request.getContextPath()%>/admin/manage/mentee/order/name";
			} else if(value == "latest") {
				window.location = "<%=request.getContextPath()%>/admin/manage/mentee/order/latest";
			} else if(value == "oldest") {
				window.location = "<%=request.getContextPath()%>/admin/manage/mentee/order/oldest";
			} else if(value =="simpleLogin"){
				window.location = "<%=request.getContextPath()%>/admin/manage/mentee/order/simpleLogin";
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
				url:'<%=request.getContextPath()%>/admin/menteeSearch',
				type: "post",
		        contentType: "application/json",
		        data: searchValue,
		        dataType: "json",
		        success: function (data) {
					$(".first_list").css("display","none");
					$(".pagingFirst").css("display","none");
					var str = '';
					var str2 = '';			
					
					if(data.resultList == null) {
						str += "<tr class='first_list'>";
						str += "<td colspan='5'>검색된 결과가 존재하지 않습니다</td></tr>";
					}
					
		        	for(var i=0 in data.resultList){
		        		
		        		str += "<tr class='first_list'>";
		        		str += "<td>"+data.resultList[i].mentee_name+"</td>";
		        		str += "<td>"+data.resultList[i].mentee_email+"</td>";
						str += "<td>"+data.resultList[i].regist_date+"</td>";
						str += "<td>"+data.resultList[i].simple_login_CK+"</td>";
						str += "<td><input type='checkbox' class='menteeSelect' value="+data.resultList[i].mentee_id+"></td></tr>";
	                }      
		        	
		        	    var totalPageCount = data.pagingList[0];
		        	    var startPageNo = data.pagingList[1];
		        	    var endPageNo = data.pagingList[2];
		        	    var beforePageNo = data.pagingList[3];
		        	    var afterPageNo = data.pagingList[4];
		        	    var page = data.pagingList[5];
		        	    var totalCount = data.pagingList[6];
		        	    
		        		
		        	    str2 += '<ul class="pagingFirst">';
		                str2 += '<li>';
		                if (beforePageNo != -1 ){
		                   str2 += '<a href="<%=request.getContextPath()%>/admin/menteeSearch/' ;
		                   str2 += searchValue;
		                   str2 += '/'+beforePageNo+'">?�전</a>';
		                }
		                
		                str2 += '</li>';
		                str2 += '<li>';
		                
		                for(var pageNo = startPageNo; pageNo <= endPageNo; pageNo = pageNo + 1) {
		                   if(page == pageNo)
		                      str2 += '<b>['+pageNo+']</b>';
		                   else{
		                      str2 += '<a href="<%=request.getContextPath()%>/admin/menteeSearch/' ;
		                      str2 += searchValue;
		                      str2 += '/'+pageNo+'">'+pageNo+'</a>';
		                   }
		                      
		                }
		                
		                str2 += '</li>';
		                str2 += '<li>';
		                
		                if(afterPageNo != -1) {
		                   str2 += '<a href="<%=request.getContextPath()%>/admin/menteeSearch/' ;
		                   str2 += searchValue;
		                   str2 += '/'+afterPageNo+'">다음</a>';
		                }
		                
		                str2 += '</li>';
		                str2 += '</ul>';
		        	    
					$("#mentee_tb").append(str);
					$("#menteeNum").text("검색 멘티 회원 총"+totalCount+"명");
					$("#pagingNum").append(str2)
					
				},
				error: function (data) {
					$(".first_list").css("display","none");
					$("#menteeNum").css("display","none");
					var str = '';
					
					str += "<tr class='first_list'>";
					str += "<td colspan='5'>검색된 결과가 존재하지 않습니다</td></tr>";
					
					$("#mentee_tb").append(str);
				}
			});
		});

	 
		$("#selectTotalBtn").on("click", function () {
			var toggleValue = $("#selectTotalBtn").val();
			if(toggleValue == 1){
				$(".menteeSelect").prop("checked", 	true);
				$("#selectTotalBtn").text("?�택?�제");
				$("#selectTotalBtn").val(0);
			} else {
				$(".menteeSelect").prop("checked", 	false);
				$("#selectTotalBtn").text("?�체?�택");
				$("#selectTotalBtn").val(1);
			}
		});
		
		var selectedValue = '';
		$("#secessionBtn").on("click", function () {
			$('.menteeSelect:checked').each(function() { 
				
				selectedValue += "," + $(this).val();
		   });
			
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/menteeSucession',
				type: "post",
		        contentType: "application/json",
		        data: selectedValue,
		        dataType: "json",
		        success: function (data) {
					alert("??�� ?�공!");
					alert("회원 삭제 성공!");
					location.reload();
				},
				error: function (data) {
					alert("??��?�패!");				
					alert("회원 삭제 실패!");				
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


<input type='hidden' id = 'orderlist_sel' value = '${sortName}'>
	
	 <div id="right_content">
		<h3 class="content_title first_h3">멘티관리</h3>
		<p class="title_desc">멘티 회원을 관리할 수 있습니다.</p>
	
	
	<div>
		<ul>
		 <c:if test="${sortType eq 'nameSearch' }" var="searchCount">
			<li id="menteeNum" class="title_desc">검색 멘티 회원 총 ${ menteeCount }명</li>
		</c:if>
			
			<c:if test="${not searchCount }">
				<li id="menteeNum">멘티 회원 총 ${ menteeCount }명</li>
			</c:if>	
			
			<li><input type="text" id="searchName" placeholder="이름 검색">
				<img src="<%=request.getContextPath()%>/resources/images/mentors/icon/search.png" height="30px" id="searchBtn">
			</li>
		</ul>

	</div>
	<div class="select_wrap select_wrap3">
		<select id="orderList" class="select_style1">
			<option value="defaultOrder">정렬</option>
			<option value="name">이름 순</option>
			<option value="latest">최신 순 정렬</option>
			<option value="oldest">오래된 순 정렬</option>
			<option value="simpleLogin">회원 유형</option> 
		</select>
	</div>
	
	<div class="button_content">
				<button id="selectTotalBtn" value="1">전체선택</button>
				<button id="secessionBtn">회원 탈퇴</button>
		</div>
	
	<div class="table_content">
		<table id="mentee_tb" class="table_style1 table_style2">
			<tr>
				<th>이름</th>
				<th>이메일</th>
				<th>가입일</th>
				<th>회원유형</th>
				<th>선택</th>
			</tr>
			<c:if test="${ not empty menteelist }" var="totalList">
				<c:forEach items="${ menteelist }" var="menteeItem">
					<tr class="first_list">
						<td>${ menteeItem.mentee_name }</td>
						<td>${ menteeItem.mentee_email }</td>
						<td>${ menteeItem.regist_date }</td>
						<td>${ menteeItem.simple_login_CK }</td>
						<td><input type="checkbox" class="menteeSelect" value="${menteeItem.mentee_id}"></td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${not totalList}">
				<tr>
					<td>검색된 결과가 존재하지 않습니다</td>
				</tr>
			</c:if>
		</table>
	</div>

	
	<div id="pagingNum" class="pagePart">
	  <c:if test="${sortType eq 'none'}">
		<ul> 
		<li class="pagingFirst">
			<c:if test="${beforePageNo ne -1 }">
		    <a href="<%=request.getContextPath()%>/admin/manage/mentee/${beforePageNo}">이전</a>
			</c:if>
		</li>
	  
		 <li class="pagingFirst">	
			<c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
				<c:if test="${curPage eq pageNo}" var="r">
				<b>[${pageNo}]</b>
				</c:if>
		
			<c:if test="${not r}">
				<a href="<%=request.getContextPath()%>/admin/manage/mentee/${pageNo}">${pageNo}</a>
			</c:if>
		</c:forEach> 
		</li>
		
		<li class="pagingFirst">
		<c:if test="${afterPageNo ne -1 }">
			<a href="<%=request.getContextPath()%>/admin/manage/mentee/${afterPageNo}">다음</a>
		</c:if>
	</ul>
	</c:if> 
	
	
	 <c:if test="${sortType eq 'order'}">
	 	<ul>
	 		<li class="pagingFirst">
		 	<c:if test="${beforePageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/manage/mentee/order/${sort}${beforePageNo}">?�전</a>
			</c:if>
			</li>	
			
			<li class="pagingFirst">
				<c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
					<c:if test="${curPage eq pageNo}" var="r">
					<b>[${pageNo}]</b>
					</c:if>
					
					<c:if test="${not r}">
						<a href="<%=request.getContextPath()%>/admin/manage/mentee/order/${sort}${pageNo}">${pageNo}</a>
					</c:if>
				</c:forEach> 
			</li>
			
			<li class="pagingFirst">
			<c:if test="${afterPageNo ne -1 }">
				<a href="<%=request.getContextPath()%>/admin/manage/mentee/order/${sort}${afterPageNo}">?�음</a>
			</c:if>
			</li>
		</ul>
	 </c:if>
	 
	  <c:if test="${sortType eq 'nameSearch'}">
	 	<ul>
	 		<li class="pagingFirst">
		 	<c:if test="${beforePageNo ne -1 }">
							<a href="<%=request.getContextPath()%>/admin/menteeSearch/${search}${beforePageNo}">?�전</a>
			</c:if>
			</li>	
			
			<li class="pagingFirst">
				<c:forEach var="pageNo" begin="${startPageNo}" end="${endPageNo}">
					<c:if test="${curPage eq pageNo}" var="r">
					<b>[${pageNo}]</b>
					</c:if>
					
					<c:if test="${not r}">
						<a href="<%=request.getContextPath()%>/admin/menteeSearch/${search}${pageNo}">${pageNo}</a>
					</c:if>
				</c:forEach> 
			</li>
			
			<li class="pagingFirst">
			<c:if test="${afterPageNo ne -1 }">
				<a href="<%=request.getContextPath()%>/admin/menteeSearch/${search}${afterPageNo}">?�음</a>
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