<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<style>
	#board_check{
		margin-top: 100px;
	}
	
	input#joinBtn{
		display: block;
		background: none;
		height: 30px;
		margin-top: 40px;
		font-weight: 700;
		cursor: pointer;
		border: 1px solid rgba(0,0,0,.3);
	}
</style>
<script>
	$(document).ready(function(){
		$("#joinBtn").on("click",function(){
			getContentAjax('${location}/club/joinClub.amg?cNum=${cNum}')
		})
	})
</script>
<div id="board_check">
	<span>동호회에 가입하셔야 서비스를 이용하실 수 있습니다.</span>
	<input type='button' id='joinBtn' value='가입하기'>
</div>