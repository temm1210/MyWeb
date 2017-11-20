<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_board.css"/>">
<script>
	$(document).ready(function(){
		$("#btnWrite").click(function(){
			
			/* 동호회 회원이 아니라면 */
			if(sessionStorage.getItem("isMember")=="none")
				getContentAjax('${location}/club/joinClub.amg?cNum=${map.cNum}');
			else
				getContentAjax('${location}/club/board/boardWrite.amg?cNum=${map.cNum}&category=${map.category}');		
		})
	})
</script>
<div id="board_content">
	<div id="board">
		<h2>게시판</h2>
		<table>
			<tr>
				<td>번호</td>
				<td class="td_title">제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회</td>
				<td>좋아요</td>
			</tr>	

			<tr><td colspan="7" class="boardLine"></td></tr>	
			<!-- C태그 반복문 -->
			<c:forEach var="board" items="${map.board}">
				<tr>
					<td>${board.bNum}</td>
					<td class="td_title"><a href="javascript:getContentAjax('${location}/club/board/boardRead.amg?cNum=${map.cNum}&bNum=${board.bNum}&curPage=${map.pager.curPage}&category=${map.category}')" class="title_link">${board.bTitle}</a></td>
					<td>${board.bWriter}</td>
					<td><fmt:formatDate value="${board.bRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${board.bReadcnt}</td>
					<td>${board.bLike}</td>
				</tr>
				<tr><td colspan="7" class="boardLine"></td></tr>
			</c:forEach>	
		</table>
		
		<!-- 전체글클릭해서 보는경우에는 글쓰기 비활성화 -->
		<c:if test="${map.category != 0}">
			<input type="button" id="btnWrite" value="글쓰기">
		</c:if>
	</div>

	<div class="board_page">
		<!-- 처음페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${map.cNum}&curPage=1&category=${map.category}')"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 이전페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${map.cNum}&curPage=${map.pager.prevBlockPage}&category=${map.category}')"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
		</c:if>
		
		<c:forEach var="num" begin="${map.pager.startPageNo}" end="${map.pager.endPageNo}">
			<c:choose>
				<c:when test="${map.pager.curPage == num}">
					<span class="page_num">${num}</span>
				</c:when>
				
				<c:otherwise>
					<a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${map.cNum}&curPage=${num}&category=${map.category}')" class="page_num">${num}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음페이지로가기  -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${map.cNum}&curPage=${map.pager.nextBlockPage}&category=${map.category}')"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 마지막페이지로가기 -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${map.cNum}&curPage=${map.pager.totalPage}&category=${map.category}')"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
		</c:if>
	</div>		
</div>