<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_boardWrite.css"/>">
<script src="<c:url value="/resources/script/club/club_boardWrite.js"/>"></script>
<div id="boardContent">
	<form id="writeForm">
		<h2>게시글쓰기</h2>
		<div class="write_row">
			<label for="bCategory">카테고리  </label>
			<select id="bCategory" name="bCategory">
				<option value="1" <c:out value="${category == '1'?'selected':''}"/>>자기소개</option>
				<option value="2" <c:out value="${category == '2'?'selected':''}"/>>QnA</option>
				<option value="3" <c:out value="${category == '3'?'selected':''}"/>>등업게시판</option>
				<option value="4" <c:out value="${category == '4'?'selected':''}"/>>자유게시판</option>
				<option value="5" id="masterCategory" <c:out value="${category == '5'?'selected':''}"/>>공지사항</option>
			</select>
		</div>
		
		<div class="write_row">
			<label for="bTitle">제목  </label>
			<input type="text" id="bTitle" size="60" name="bTitle">
		</div>
		
		<div class="write_row">
			<label for="bWriter">작성자  </label>
			<input type="text" id="bWriter" readonly="readonly" name="bWriter">
		</div>
		
		<div class="write_row">
			<textarea cols="100" rows="25" id="bContent" name="bContent" placeholder="내용을 작성하세요"></textarea>
		</div>
		
		<input type="hidden" name="cNum" id="cNum" value="${cNum}">
		
		<div class="button_wrap">	
			<input type="button" onclick="writeAjax('${location}/club/board/boardWrite.amg')" value="작성">
			<input type="button" id="cancelBtn" value="취소">
		</div>
	</form>
</div>