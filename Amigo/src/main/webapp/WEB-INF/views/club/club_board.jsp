<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#board_content{
		max-width: 80%;
		min-width: 950px;
	}
	#board{
		padding-bottom: 40px;
		border-bottom: 1px solid rgba(0,0,0,.4);
	}
	#board h2{
		font-size: 25px;
		font-weight: bold;
		color:black;
		
	}
	#board table {
		border-top: 1px solid rgba(0,0,0,.4);
		width:100%;
		text-align: center;
		padding: 20px;
		margin-right: 20px;
	}
	 
	#board table tr:nth-child(2n+1) td{
		padding:10px 0;
	}
	
	a.title_link:hover{
		color:rgba(0,0,0,.6);
	}
	
	.td_title{
		width:450px;
	}
	
	.boardLine{
		border:1px solid #dad8d7;
		padding:0;
	}
	
	.paging_num{
		display: block;
		text-align: center;
	}
	
	#btnWrite{
		float: right;
		padding: 10px;
		margin-right: 20px;
		margin-top: -15px;
		font-weight: bold;
		background: none;
		border: 1px solid rgba(0,0,0,.3);
		cursor: pointer;
	}
	
	div.board_page{
		text-align: center;
		margin-top: 10px;
		font-size: 23px;
	}
	
	div.board_page i{
		font-size: 22px;
		width: 25px;
		border: 1px solid rgba(150,150,150,.4);
		background: #eee;
	}
	
	div.board_page > span{
		display: inline-block;
		width: 27px;
		height: 19px;
		padding-top: 5px;
		color: rgba(0,0,250,.66);
		border: 1px solid rgba(0,0,250,.66);
		vertical-align: 3px;
	} 
	div.board_page > .page_num{
		margin: 0 5px;
		font-size: 15px;
		vertical-align: 3px;
	}
</style>
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
					<td class="td_title"><a href="#" class="title_link">${board.bTitle}</a></td>
					<td>${board.bWriter}</td>
					<td><fmt:formatDate value="${board.bRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${board.bReadcnt}</td>
					<td>${board.bLike}</td>
				</tr>
				<tr><td colspan="7" class="boardLine"></td></tr>
			</c:forEach>	
		</table>
		<input type="button" id="btnWrite" value="글쓰기">
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