<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<script src="<c:url value="/resources/script/club/club_leave.js"/>"></script>
<style>

	#leaveContainer{
		width: 800px;
	}
	#leaveContainer h2.article_title{
		font-weight: bold;
		font-size: 22px;
		margin-bottom: 40px;
		color: rgba(62,91,71,.8);
	}
	
	.agreeWrap{
		width: 100%;
		text-align: center;
		margin-top: 30px;
	}
	
	.agreeWrap > #agree_leave{
	 	vertical-align:-1px;
	}
	 
	#leaveBtn{
		display: block;
		width: 60px;
		height: 32px;
		cursor: pointer;
		background: none;
		text-align: center;
		margin: 30px auto;
		border: 1px solid rgba(0,0,0,.2);
	}
</style>
<div id="leaveContainer">
	<div class="article">
		<h2 class="article_title">* 동호회 탈퇴 후에도 등록한 게시물은 전부 삭제됩니다.</h2>
		<span class="article_sub">
			동호회 게시판에 올린 게시글 및 댓글은 탈퇴 시 자동 삭제됩니다.<br/>
			탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, 게시글을 임의로 복구해드릴 수 없습니다.<br/>
		</span>
	</div>			
	
	<div class="agreeWrap">
		<label for="agree_leave">위 내용에 동의 하십니까?</label>
		<input type="checkbox" id="agree_leave">
	</div>
	
	<input type="button" value="탈퇴" id="leaveBtn" onclick="leaveClub('${location}/clubMember/leaveClub.amg?cNum=${cNum}')">
	<input type="hidden" value="${cNum}" id="hdnCnum">
</div>