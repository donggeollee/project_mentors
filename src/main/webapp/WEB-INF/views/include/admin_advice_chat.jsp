<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:if test="${ not empty loginMember }">
<%-- 관리자와 채팅상담하기 --%>		 
<script type="text/javascript">
function newPopup() { 
window.open(   
		'<%=request.getContextPath()%>/memberChat',
		'popUpWindow',    
		'height=520,width=490,left=10,top=10,resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no,directories=no,status=yes')
} 
</script>
<style> 
.floating { position: fixed; right: 50px; bottom: 30px; text-align:center; z-index:100;}
.floating button {background:#fff; border: none; width:70px; height:70px; border-radius: 35px; padding:10px;
    -webkit-box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
    box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);}
.floating button img {width:40px; height:40px;}
.floating p {color:#292929;margin-top:3px;}
@media (max-width: 1200px) {
	.floating .btn-danger {
		
	}
}
</style>
<div class="floating"> 
	<button type="button" onclick="newPopup();">
		<img src="<%=request.getContextPath()%>/resources/images/mentors/conversation.png" >
	</button>
	<p>관리자 상담</p>
</div>
</c:if>