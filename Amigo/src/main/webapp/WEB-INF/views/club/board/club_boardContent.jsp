<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.boardTop{
		margin-bottom: 40px;
	}
	.boardTop h2{
		font-size: 25px;
		font-weight: bold;
		color:black;
	}

	div#order{
		margin:10px 0;
	}
	
	div#order > a.order_row{
		color: rgba(0,0,0,.5);
		border-right: 1px solid rgba(0,0,0,.5);
		font-size: 12px;
		padding: 0 5px;
	}
	
	div#order > a.order_row:last-child {
		border: none;
	}
	
	div#order > a.order_row:hover{
		color:rgba(0,0,0,.8);	
	}
	
	.orderClick{
		font-weight: bold;
		color:black !important;
	}
</style>
<script>
	var isFirst = true;
	$(document).ready(function(){
		
		getFirstView()
		$("#order > a").click(function(){
			$("#order > a").removeClass("orderClick");
			$(this).addClass("orderClick");
			
			/* 선택한 정렬 기준에따라 게시글 가져옴 */
			getBoardByCondition("${criteria.curPage}");
		})	
	})
	
	function getFirstView(){
		var url='${location}/club/board/boardListAll.amg?cNum=${criteria.cNum}&curPage=${criteria.curPage}&category=${criteria.category}&searchOption=${criteria.searchOption}&searchWord=${criteria.searchWord}&orderByWord=${criteria.orderByWord}'
		getBoardAjax(url);
	}
	
	/* 게시판컨텐츠 SPA담당 */
	function getBoardAjax(url){
		
		var path = url.substring(url.lastIndexOf('?')+1 , url.length);
		var start = path.indexOf('orderByWord');
		/* 정렬기준 추출 */
		var orderWord = path.substring(path.indexOf('=',start)+1);
		
		$.ajax({
			type:"GET",
			url:url,
			success:function(content){
				$("#boardList").html(content);
				
				/* 처음으로 게시물을 가져올때는, club.jsp에서 history.pushState를 한번시행함. 그래서 여기서 또 해줘버리면 중복 저장이되버림. 중복저장을 막는코딩.
					url을 참조하면 처음에는 검색옵션이 url뒤에 안붙음.
				*/
				if(!isFirst)
			 		history.pushState({ content:content,page:"board",orderWord:orderWord},'','?'+path)
			 	else
			 		isFirst = false;
			}
		});
	}
</script>
<div class="boardTop">
	<div class="boardHeader">
		<h2>
			<c:if test="${criteria.category == 0 }">
				<h2>전체글보기</h2>
			</c:if>
			
			<c:if test="${criteria.category == 1 }">
				<h2>자기소개</h2>
			</c:if>
			
			<c:if test="${criteria.category == 2 }">
				<h2>QnA</h2>
			</c:if>
			
			<c:if test="${criteria.category == 3 }">
				<h2>등업</h2>
			</c:if>
			
			<c:if test="${criteria.category == 4 }">
				<h2>자유게시판</h2>
			</c:if>
			
			<c:if test="${criteria.category == 5 }">
				<h2>공지사항</h2>
			</c:if>
		</h2>
		
		<div id="order">
			<a href="javascript:void(0);" class="orderClick order_row">최신순</a>
			<a href="javascript:void(0);" class="order_row">조회수</a>
			<a href="javascript:void(0);" class="order_row">좋아요수</a>
		</div>
	</div>
	
	<div id="boardList">
	
	</div>

</div>