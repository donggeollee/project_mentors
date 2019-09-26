<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
	href="<%=request.getContextPath()%>/resources/css/mentors/common.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/header_add.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mentors/content.css">	
<title>멘토스</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수
            
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            
            //결과 필드에 삽입***
            document.getElementById("location").value = roadAddr;

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            /*
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            */
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            /*
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }
            */
			/*
            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
            */
        },
 
    onclose: function(state) {
        //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
        if(state === 'FORCE_CLOSE'){
            //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.

        } else if(state === 'COMPLETE_CLOSE'){
        }
    }
    
    }).open();
}
</script>
<script type="text/javascript">

var clickCnt = 0;

window.onload = function(){
	document.getElementById('lesson_write_btn').addEventListener('click', ajaxWriteSubmit);	
}


function ajaxWriteSubmit() {
	
	if( $('#location').val().length == 0 ){
		alert('주소가 입력되지 않았습니다.');
		return;
	}
	else if( $('#total_round').val().length == 0 ){
		alert('회 차가 입력되지 않았습니다.');
		return;
	}
	else if( $('#price').val().length == 0 ){
		alert('금액이 입력되지 않았습니다.');
		return;
	}
	else if( $('#title').val().length == 0 ){
		alert('제목이 입력되지 않았습니다.');
		return;
	}
	else if( $('#lesson_info').val().length == 0 ){
		alert('소개가 입력되지 않았습니다.');
		return;
	}
	else if( $('#curriculum').val().length == 0 ){
		alert('커리큘럼이 입력되지 않았습니다.');
		return;
	}
	else if( clickCnt == 0 ){
		alert('사진을 한장은 등록하셔야합니다.');
		return;
	}
	
	var mentorWriteObject = new Object();
	
	mentorWriteObject.category_small = document.getElementById('category_small').value;
	mentorWriteObject.location = document.getElementById('location').value;
	mentorWriteObject.title = document.getElementById('title').value;
	mentorWriteObject.lesson_info = document.getElementById('lesson_info').value;
	mentorWriteObject.price = document.getElementById('price').value;
	mentorWriteObject.total_round = document.getElementById('total_round').value;
	mentorWriteObject.curriculum = document.getElementById('curriculum').value;
	mentorWriteObject.lesson_thumnail = document.getElementById('thumnail').value;
	
	var mentorWriteJsonObject = JSON.stringify(mentorWriteObject);
	var bigCategory = document.getElementById('lessonBigCategory').value;
	
	$.ajax({
		
		url:"<%=request.getContextPath()%>/mentor/lesson/write",
		type:"post",
		contentType:"application/json",
		data:mentorWriteJsonObject,
		dataType:"json",
		async:false,
		
		success:function(result){
						
			if(result > 0){	
				alert("레슨 작성 성공");
				/*지금은 그냥 멘토 홈을 연결해놨지만, 나중에는 레슨 리스트 페이지로 이동시키기*/
				
				var imageList = document.getElementById('lessonImageList').value;
				var lessonID = result;
				$.ajax({
					url:"<%=request.getContextPath()%>/lesson/lessonImageListUpload/"+lessonID,
					type:"post",
					contentType:"application/json",
					data:imageList,
					dataType:"json",
					async:false,
					success:function(data){
						if(eval(data)){
							alert("레슨 이미지 업로드 성공!");
							location.href = "<%=request.getContextPath()%>/lesson/lessonList/"+bigCategory;
						}
						else
							alert('레슨 이미지 업로드 과정에서 문제가 발생했습니다.');
					},
					error:function(data){
						alert('레슨 이미지 업로드 과정에서 문제가 발생했습니다.');
						return;
					}
				});
				
				
			}
			 else {	
				 alert("레슨 작성 실패");
			 }				
		},
		// ajax 호출이 실패한 경우 실행되는 함수
		error:function(result){
			alert('레슨 작성 과정에서 문제가 발생했습니다.');
			return;
		}
	});
	
}

var str = '';
var appendData = '<input type="file" multiple="multiple" name="file" placeholder="사진추가"><button class="imgUploadBtn" onclick=upload('+clickCnt+')>등록</button>';

function upload(data) {
	if(clickCnt == 3){
		alert("사진은 최대 3장까지 등록이 가능합니다!");
		return;
	}
	
	var formData = new FormData();
	 
	// 파일태그
	formData.append("file",$("input[name=file]")[data].files[0]);
	 if( !$("input[name=file]")[data].files[0]){
		alert("파일을 선택해주세요!");
		return;
    }
		 
	 alert(formData);
		
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/lesson/lessonImageUpload",
		data : formData,
		dataType : "text",
		/*  processData: false => post방식
		contentType: false => multipart/form-data */
		processData : false,
		contentType : false,
		success : function(data){
			if (data != null) {
				alert("레슨 사진 등록 성공!");
				str += (","+data.substring(2));
				$("#lessonImageList").val(str);
				clickCnt += 1;
				if(clickCnt < 3)
					$(".imageUpload").append('<input type="file" multiple="multiple" name="file" placeholder="사진추가"><button class="imgUploadBtn" onclick=upload('+clickCnt+')>등록</button>');
				return;
			} else if (data == null) {
				alert("레슨 사진 등록 실패!")
				return;
			}
   		}
		
	});
}

$(document).ready(function () {
	

	$("#uploadBtn").on("click", function () {
		var formData = new FormData();
		 
		// 파일태그
		formData.append("file",$("input[name=file]")[0].files[0]);
		 if( !$("input[name=file]")[0].files[0]){
			alert("파일을 선택해주세요!");
			return;
	    }
			 
		 alert(formData);
			
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/lesson/firstImageUpload",
			data : formData,
			dataType : "text",
			/*  processData: false => post방식
			contentType: false => multipart/form-data */
			processData : false,
			contentType : false,
			success : function(data){
				if (data != null) {
					alert("레슨 사진 등록 성공!");
					$(this).html('등록 완료'); 
					str += data.substring(2);
					clickCnt += 1;
					$("#thumnail").val(data);
					$(".imageUpload").append('<div class="input_file_wrap"><input type="file" multiple="multiple" name="file" placeholder="사진추가"><button class="imgUploadBtn" onclick=upload('+clickCnt+')>등록</button></div>');
					$("#lessonImageList").val(str);
					return;
				} else if (data == null) {
					alert("레슨 사진 등록 실패!")
					return;
				}
	   		}
			
		});
	});
	
	
	
});
</script>

</head>
<body>

<jsp:include
		page="${ requestScope.contextPath }/WEB-INF/views/include/header.jsp"
		flush="false"></jsp:include>

	<div class="cont">
	
	<h3 class="normal_title">새로운 레슨을 작성합니다</h3>
	
	<div id="lesson_write">
		
			<ul>
				<li>
					<h4><span>*</span>카테고리 분류</h4>
					<div>
				    <select id="category_small" name="category_small" onchange="category_change()" style="width:18%;padding-left:10px;">
				    	
				    	<c:if test="${ not empty small_category }">
				    		<c:forEach items="${ small_category }" varStatus="s" >
				    			<option value="${ small_category[s.index] }">${small_category[s.index]}</option>
				    		</c:forEach>
				    	</c:if>
			        </select>
			        </div>
				</li>
				<li>
					<h4><span>*</span>장소(대표)</h4>
					<div>
						<ul id="location_list">
						</ul>
						<input type="text" value="" name="location" id="location"><button id="add_location" onclick="sample4_execDaumPostcode();">주소검색</button><br>
						<p class="loca_desc">(상세주소는 받지 않습니다. 검색된 주소가 지도에 표시됩니다.)</p>
					</div>
				</li>
				<li>
					<h4><span>*</span>회차</h4>
					<div>
						<input type="number" placeholder="횟수 입력" id="total_round" name="total_round">회
					</div>
				</li>
				<li>
					<h4><span>*</span>금액</h4>
					<div>
						<input type="number" placeholder="금액 입력" id="price" name="price">원
					</div>	
				</li>
				<li>		
					<h4><span>*</span>제목</h4>
					<div>
						<input type="text" name="title" id="title" maxlength="30" placeholder="제목을 입력해주세요 (총 30자 이내)">
					</div>
				</li>
				<li>
					<h4><span>*</span>소개</h4>
					<div>
						<textarea rows="" cols="" placeholder="클래스에 대한 소개를 작성해주세요 (200자 이내)" maxlength="200" id="lesson_info" name="lesson_info"></textarea>
					</div>
				</li>	
				<li>
					<h4><span>*</span>커리큘럼</h4>
					<div>
						<textarea rows="" cols="" placeholder="커리큘럼에 대하여 자세하게 작성해주세요.(500자 이내)" maxlength="500" id="curriculum" name="curriculum"></textarea>
					</div>
				</li>
				<li>
					<h4><span>*</span>미디어</h4>
					<div>
						<div class="imageUpload">
							<div class="input_file_wrap">
								<input type="file" multiple="multiple" name="file" placeholder="사진추가"><button id="uploadBtn">등록</button>
							</div>
						</div>
						<p class="upload_desc">
							<span>*사진은 한장 이상 등록해야합니다. 파일 선택 후, 등록 버튼까지 눌러주세요.</span><br><br>
							권장사항 : 840 x 540 픽셀 (jpg/jpeg/png파일)<br>
							최대 3 장까지 등록 가능 합니다.<br>
							첫번째 사진이 대표 썸네일 이미지로 등록됩니다<br>
							<br>
							*주의* 다음 사진은 인용이 불가합니다. <br>
							- 인위적인 홍보문구가 포함된 사진 <br>
							- 타인의 리뷰를 무단으로 발췌 및 도용한 사진 <br>
							- 반복적인 사진이 포함된 사진 
						</p>
					</div>
				</li>				
				<input type="hidden" id="thumnail">
				<input type="hidden" id="lessonImageList">
				<input type="hidden" id="lessonBigCategory" value="${ loginMember.mentor_categoryBig }">
			</ul>

			<button id="lesson_write_btn">레슨 등록</button>
		</div>	
	
	</div>
	
	<jsp:include page="${ requestScope.contextPath }/WEB-INF/views/include/footer.jsp" flush="false"></jsp:include>

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