<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<script>
	$(document).ready(function(){
		$(window).scrollTop(0);
		$("#boardList .title").append($("#clubTitle").val())
		$("#boardList .content").append($("#clubContent").val())
	})
	
	
	function path(category){
		var $aLink = $(".sub_ul > li")
		
		$.each($aLink,function(index,element){
			
			if( $(".subCategory_"+category).text() == $(element).children("a").text() ){
				$aLink.children("a").removeClass("click")
				$(element).children("a").addClass("click")
			}
		})
		getContentAjax('${location}/club/board/boardContent.amg?cNum=${criteria.cNum}&curPage=1&category='+category)
	}
	
	/* 글보기 클릭시 */
	function checkIsMember(num){
		/* 동호회 회원이 아니라면 */
		if(sessionStorage.getItem("isMember") == "none"){
			getContentAjax('${location}/club/checkMember.amg?cNum=${criteria.cNum}');
		}
		else{
			getContentAjax('${location}/club/board/boardRead.amg?cNum=${criteria.cNum}&curPage=${criteria.curPage}&category=${criteria.category}&bNum='+num+'&searchOption=${criteria.searchOption}&searchWord=${criteria.searchWord}&orderByWord=${criteria.orderByWord}')
		}
	}
</script>
<style>
	#boardList table {
		border-top: 1px solid rgba(0,0,0,.4);
		width:400px; 
		text-align: center;
		padding: 20px;
		font-size: 13px;
		margin-right: 20px;
	}
	
	#boardList table tr:nth-child(2n+1) td{
		padding:10px 0;
	}
	.content{
		color: rgba(0,0,0,.5);
    	font-size: 19px;
	}
	.board_row{
		display: flex;
	    flex-flow: row wrap;
	    justify-content: end;
	    margin-bottom: 80px;
	}
	.boardWrap{
	    width: 400px;
    	margin-right: 40px;
	}
	a.title_link:hover{
		color:rgba(0,0,0,.6);
	}
	.boardKind h2{
		display: inline-block;
		font-weight: bold;
		font-size: 20px;
	}
	.td_title{
		width: 130px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		display: inline-block;
	}
	
	.boardLine{
		border:1px solid #dad8d7;
		padding:0;
	}
	.clubInfo{
		margin-bottom: 80px;
		text-align: center;
	}
	.title{
		font-size: 40px;
	}
</style>
<div id="boardList">
	<div class="clubInfo">
		<span class="title"></span><br/>
		<span class="content"></span>
	</div>
	<c:forEach var="category" begin="1" end="${size}" step="1" >
		<c:if test="${category%2 != 0 }">
			<div class="board_row board_${category}">
		</c:if>
		<div class="boardWrap row_${category}">
		<span class="boardKind">
			<a href="javascript:void(0)" onclick="path(${category})">
				<c:if test="${category == 1 }">
					<h2 class="subCategory_${category}">자기소개</h2>
				</c:if>
				
				<c:if test="${category == 2 }">
					<h2 class="subCategory_${category}">QnA</h2>
				</c:if>
				
				<c:if test="${category == 3 }">
					<h2 class="subCategory_${category}">등업</h2>
				</c:if>
				
				<c:if test="${category == 4 }">
					<h2 class="subCategory_${category}">자유게시판</h2>
				</c:if>
				
				<c:if test="${category == 5 }">
					<h2 class="subCategory_${category}">공지사항</h2>
				</c:if>
			</a>
		</span>
			<table>
				<c:forEach var="board" items="${board}" >
					<c:if test="${board.bCategory == category}">
						<tr>
							<td class="td_title"><a id="isMemberCheck" href="javascript:void(0)" onclick="checkIsMember(${board.bNum})" class="title_link">${board.bTitle}</a></td>
							<td>${board.bWriter}</td>
							<td><fmt:formatDate value="${board.bRegdate}" pattern="yyyy-MM-dd"/></td>
							<td>${board.bReadcnt}</td>
						</tr>
						<tr><td colspan="7" class="boardLine"></td></tr>
					</c:if>
				</c:forEach>	
			</table>
		</div>
		
		<c:if test="${category%2 == 0}">
			</div>
		</c:if>
	</c:forEach>
</div>
