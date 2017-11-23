<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<script src="<c:url value="/resources/script/club/club_join.js"/>"></script>
<style>
	#join_content{
		text-align: center;
		margin-top: 100px;
	}
	
	#join_content > h2{
		font-weight: bold;
		font-size: 25px;
		margin-bottom: 20px;
	}
	
	#join_content > #cNickname{
		height: 24px;
	}
	
	#join_content > #joinClubBtn{
		background: none;
		border: 1px solid rgba(0,0,0,.3);
		vertical-align: -1.5px;
		width: 70px;
		height: 30px;
		cursor: pointer;
	}
	
	#resultCheck{
		margin-top:30px;
	}
	.green{
		color: green;
	}
	.red{
		color: red;
	}
</style>
<div id="join_content">
	<h2>동호회가입</h2>
	<label for="cNickname">사용할 닉네임:</label>
	<input type="text" id="cNickname" name="cNickname">
	<input type="button" id="joinClubBtn" value="가입">
	<div id="resultCheck"></div>
	
	<input type="hidden" value="${cNum}" id="cNum">
	<input type="hidden" value="${location}" id="loc">
</div>
