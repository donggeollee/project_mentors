<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	

function ajaxUpdateSubmit() {
	
	var mentorWriteObject = new Object();
	
	mentorWriteObject.lesson_id = document.getElementById('lessonIDValue').value;
	mentorWriteObject.category_small = document.getElementById('category_small').value;
	mentorWriteObject.location = document.getElementById('location').value;
	mentorWriteObject.title = document.getElementById('title').value;
	mentorWriteObject.lesson_info = document.getElementById('lesson_info').value;
	mentorWriteObject.price = document.getElementById('price').value;
	mentorWriteObject.total_round = document.getElementById('total_round').value;
	mentorWriteObject.curriculum = document.getElementById('curriculum').value;
	
	var mentorWriteJsonObject = JSON.stringify(mentorWriteObject);
	var bigCategory = document.getElementById('lessonBigCategory').value;
	
	$.ajax({
		
		url:"<%=request.getContextPath()%>/mentor/lesson/update",
		type:"post",
		contentType:"application/json",
		data:mentorWriteJsonObject,
		dataType:"json",
		async:false,
		
		success:function(result){
						
			if(result > 0){	
				alert("레슨 수정 성공");
				/*지금은 그냥 멘토 홈을 연결해놨지만, 나중에는 레슨 리스트 페이지로 이동시키기*/
			}
			 else {	
				 alert("레슨 수정 실패");
			 }				
		},
		// ajax 호출이 실패한 경우 실행되는 함수
		error:function(result){
			alert('레슨 수정 과정에서 문제가 발생했습니다.');
			return;
		}
	});
	
}

var str = '';
var clickCnt = 0;
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
					str += data.substring(2);
					clickCnt += 1;
					$("#thumnail").val(data);
					$(".imageUpload").append('<input type="file" multiple="multiple" name="file" placeholder="사진추가"><button class="imgUploadBtn" onclick=upload('+clickCnt+')>등록</button>');
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

<h3>레슨 수정하기</h3>

<ul>
	<li>
		<h4>카테고리 분류</h4>
	    <select id="category_small" name="category_small" onchange="category_change()">
	    	
	    	<c:if test="${ not empty small_category }">
	    		<c:forEach items="${ small_category }" varStatus="s" >
	    			<c:if test="${ targetLesson.category_small eq small_category[s.index]  }" var="isSameCate">
		    			<option value="${ small_category[s.index] }" selected>${small_category[s.index]}</option>
	    			</c:if>
	    			<c:if test="${ not isSameCate }">
	    				<option value="${ small_category[s.index] }">${small_category[s.index]}</option>
	    			</c:if>
	    		</c:forEach>
	    	</c:if>
        </select>
	</li>
	<li>
		<h4>장소(대표)</h4>
		<ul id="location_list">
		</ul>
		<input type="text" value="${ targetLesson.location }" name="location" id="location"><button id="add_location" onclick="sample4_execDaumPostcode();">주소검색</button><br>
		<p>상세주소는 받지 않습니다.</p>
	</li>
	<li>
		<h4>회차</h4>
		<input type="text" value="${ targetLesson.total_round }" id="total_round" name="total_round">회
	</li>
	<li>
		<h4>금액</h4>
		<input type="text" value="${ targetLesson.price }" id="price" name="price">원
	</li>
	<li>
		<h4>제목</h4>
		<input type="text" value="${ targetLesson.title }" name="title" id="title">
	</li>
	<li>
		<h4>소개</h4>
		<textarea rows="" cols="" id="lesson_info" name="lesson_info">${ targetLesson.lesson_info }</textarea>
	</li>	
	<li>
		<h4>커리큘럼</h4>
		<textarea rows="" cols="" id="curriculum" name="curriculum">${ targetLesson.curriculum }</textarea>
	</li>
<%-- 	<li>
		<h4>미디어</h4>
		<div class="imageUpload">
		<c:forEach items="${ targetImageList }" var="imageItem">
			이미지
		</c:forEach>
		</div>
		<p>
			권장사항 : 840 x 540 픽셀 (jpg/jpeg/png파일)<br>
			최대 3 장까지 등록 가능 합니다.<br>
			첫번째 사진이 대표 썸네일 이미지로 등록됩니다<br>
			<br>
			*주의* 다음 사진은 인용이 불가합니다. <br>
			- 인위적인 홍보문구가 포함된 사진 <br>
			- 타인의 리뷰를 무단으로 발췌 및 도용한 사진 <br>
			- 반복적인 사진이 포함된 사진 
		</p>
	</li>	 --%>			
	<input type="hidden" id="imageCnt" value="${ targetImageList }">
	<input type="hidden" id="lessonIDValue" value="${ targetLesson.lesson_id }">
	<input type="hidden" id="lessonImageList">
	<input type="hidden" id="lessonBigCategory" value="${ loginMember.mentor_categoryBig }">
</ul>

<button id="lesson_update_btn" onclick="ajaxUpdateSubmit()">레슨 수정하기</button>

</body>
</html>