<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_board.css"/>">
<script>
	$(document).ready(function(){
		
		/* 글쓰기 클릭시 */
		$("#btnWrite").click(function(){		
			/* 동호회 회원이라면 */
			console.log(userName)
			if(sessionStorage.getItem("isMember") != "none" || userName=="STW"){
				
				getBoardAjax('${location}/club/board/boardWrite.amg?cNum=${map.criteria.cNum}&category=${map.criteria.category}');		
			}
			else 
				getContentAjax('${location}/club/checkMember.amg?cNum=${map.criteria.cNum}&content=join');
						
		})
		
		/* 검색버튼 클릭시 */
		$("#searchBtn").click(function(){
			getBoardByCondition(${map.pager.curPage})
		})
	});
	
	/* 다음버튼,다음페이지 눌렀을때 띄워줄 화면 설정 */
	function getBoardByCondition(num){
		var searchOption = $("#searchOption").val();
		var searchWord = $("#searchWord").val();
		var orderByWord = $(".orderClick").text();
		
		var path = '${location}/club/board/boardListAll.amg?cNum=${map.criteria.cNum}&curPage='+num+'&category=${map.criteria.category}' 
				
		/* 페이징처리 주소뒤에 검색변수 추가 */
		path+='&searchOption='+searchOption
		path+='&searchWord='+searchWord
		path+='&orderByWord='+orderByWord
	
		/* 게시판 가져오는 아작스 실행 */
		 getBoardAjax(path)  
	}
	
	/* 글보기 클릭시 */
	function checkIsMember(num){
		/* 동호회 회원이 아니라면 */
		if(sessionStorage.getItem("isMember") != "none" || userName=="STW"){
			getBoardAjax('${location}/club/board/boardRead.amg?cNum=${map.criteria.cNum}&curPage=${map.criteria.curPage}&category=${map.criteria.category}&bNum='+num+'&searchOption=${map.criteria.searchOption}&searchWord=${map.criteria.searchWord}&orderByWord=${map.criteria.orderByWord}')
		}
		else
			getContentAjax('${location}/club/checkMember.amg?cNum=${map.criteria.cNum}&content=join');
	}
</script>
<div id="board_content">
	<div id="board">
	<span class="boardCount">게시글수:${map.totalCount}</span>
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
			<c:forEach var="board" items="${map.board}" >
				<tr>		
					<!-- 공지사항을 먼저 출력해줌 -->
					<c:if test="${board.bCategory == 5}">
						<td class="notice">공지</td>
						<c:choose>
							<c:when test="${board.bCategory == 6}">
								<!-- "삭제된 게시물입니다" 를 보여주고싶을때 여기서 처리 -->
							</c:when>
							
							<c:otherwise>
								<td class="td_title notice">
									<a id="isMemberCheck" href="javascript:void(0)" onclick="checkIsMember(${board.bNum})" class="title_link">
										${board.bTitle}
										<c:if test="${board.replyCount != 0}">
											<span style="color: rgba(200,20,20,.6);">(${board.replyCount})</span>
										</c:if>
									</a>
								</td>
							</c:otherwise>
						</c:choose>
						
						<td class="notice">${board.bWriter}</td>
						<td class="notice"><fmt:formatDate value="${board.bRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td class="notice">${board.bReadcnt}</td>
						<td class="notice">${board.bLike}</td>
					</c:if>
					
					<!-- 공지사항 이외의글 -->
					<c:if test="${board.bCategory < 5}">	
						<td>${board.bNum}</td>
						<c:choose>
							
							<c:when test="${board.bCategory == 6}">
							</c:when>
							
							<c:otherwise>
								<td class="td_title">
									<a id="isMemberCheck" href="javascript:void(0)" onclick="checkIsMember(${board.bNum})" class="title_link">${board.bTitle}
										<c:if test="${board.replyCount != 0}">
											<span style="color: rgba(200,20,20,.6);">(${board.replyCount})</span>
										</c:if>
									</a>	
								</td>
							</c:otherwise>
						</c:choose>
						<td>${board.bWriter}</td>
						<td><fmt:formatDate value="${board.bRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>${board.bReadcnt}</td>
						<td>${board.bLike}</td>
					</c:if>
				</tr>
				<tr><td colspan="7" class="boardLine"></td></tr>
			</c:forEach>	
		</table>
		
		<!-- 전체글클릭해서 보는경우에는 글쓰기 비활성화 -->
		<c:if test="${map.criteria.category != 0}">
			<input type="button" id="btnWrite" value="글쓰기">
		</c:if>
	</div>

	<div class="board_page">
		<!-- 처음페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:getBoardByCondition(1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 이전페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:getBoardByCondition(${map.pager.prevBlockPage})"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
		</c:if>
		
		<c:forEach var="num" begin="${map.pager.startPageNo}" end="${map.pager.endPageNo}">
			<c:choose>
				<c:when test="${map.pager.curPage == num}">
					<span class="page_num">${num}</span>
				</c:when>
				
				<c:otherwise>
					<a href="javascript:getBoardByCondition(${num})" class="page_num">${num}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음페이지로가기  -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:getBoardByCondition(${map.pager.nextBlockPage})"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 마지막페이지로가기 -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:getBoardByCondition(${map.pager.totalPage})"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
		</c:if>
	</div>

	<div class="searchForm">
		<select name="searchOption" id="searchOption">
			<option value="all" <c:out value="${map.criteria.searchOption == 'all'?'selected':''}"/>>제목+내용+작성자</option>
			<option value="btitle" <c:out value="${map.criteria.searchOption == 'btitle'?'selected':''}"/>>제목</option>
			<option value="bwriter" <c:out value="${map.criteria.searchOption == 'bwriter'?'selected':''}"/>>작성자</option> 
			<option value="bcontent" <c:out value="${map.criteria.searchOption == 'bcontent'?'selected':''}"/>>내용</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" value="${map.criteria.searchWord}">
		<input type="button" id="searchBtn" value="검색">
	</div>	
</div>