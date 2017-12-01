<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="memberImg" value="/resources/images/member_images" />
<c:set var="location" value="${pageContext.request.contextPath}"/>
<style>
	.replyPic{
		border-radius: 50%;
		vertical-align:middle;
		font-size: 55px;
	    color: black;
	    padding: 0;
	}
	li.reply_row{
	    border-bottom: 1px solid rgba(0,0,0,.2);
	    margin-bottom: 20px;
	    padding-bottom: 20px;
	}
	li.reply_row > span.replyWriter{
		margin-left: 13px;
    	font-weight: bold;
	}
	li.reply_row > span.replyContent{
	    display: block;
	    margin-left: 80px;
	    font-size: 14px;
	    color: rgba(0,0,0,.6);
	}
	li.reply_row > span.replyDate{
		font-size: 13px;
    	margin-left: 30px;
	}
	li.reply_row > span.modifyLinkWrap{
	    display: inline-block;
	    float: right;
	    margin-top: 15px;
	    margin-right: 10px;
	}
	
	li.reply_row > span.modifyLinkWrap > a{
		color: rgba(0,0,0,.5);
	    font-size: 14px;
	    border-right: 1px solid rgba(0,0,0,.5);
	    padding-right: 10px;
	}
	
	li.reply_row > span.modifyLinkWrap > a:last-child{
		border:none;
	}
	
	li.reply_row > .replyText{
		margin-top: 15px;
	}
	input.replyModifyBtn{
		background: none;
		border: 1px solid rgba(0,0,0,.2);
		width: 80px;
		height: 66px;
		vertical-align: 27px;
		cursor: pointer;
	}
	.viewNone{
		display: none !important;
	}
	
	div.reply_page{
		text-align: center;
		margin-top: 10px;
		margin-bottom: 20px;
		font-size: 23px;
	}
	
	div.reply_page i{
		font-size: 18px;
		width: 25px;
		border: 1px solid rgba(150,150,150,.4);
		background: #eee;
	}
	
	div.reply_page > span{
		display: inline-block;
		width: 22px;
		height: 15px;
		padding-top: 5px;
		color: rgba(0,0,250,.66);
		border: 1px solid rgba(0,0,250,.66);
		vertical-align: 3px;
	} 
	div.reply_page > .page_num{
		margin: 0 2px;
		font-size: 12px;
		vertical-align: 1px;
	}
</style>
<script>
	$(document).ready(function(){
		/* 댓글개수 셋팅 */
		$(".replyCount").text("${map.count}")	
		var master = $("#clubMaster").text();
 		var replyWriter = $(".replyWriter")
 		
 		if(userName=="STW")
 			$(".modifyLinkWrap").removeClass("viewNone")
 			
		if(sessionStorage.getItem('isMember')!= "none"){
			var obj = JSON.parse(sessionStorage.getItem('isMember'))
		
			//현재로그인한 동호회 유저랑 댓글작성한 유저랑 같으면 수정,삭제 버튼 활성화  
			$.each(replyWriter,function(index,element){
				//   댓글작성자랑, 로그인한 동호회 유저가 같을시 버튼활성화 
				if( $(element).text() == obj.cNickname || obj.cNickname == master){
					$(element).siblings(".modifyLinkWrap").removeClass("viewNone")
				}	
			})
			
			if(obj.cNickname == master){
				$(".updateLink").css("display","none");
			}
		}
	});
	
	/* 댓글 수정, 삭제 처리 */
	function changeReply(url,type,data){
		$.ajax({
			type:type,
			url:url,
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data),
			success:function(msg){
				/*  동호회 리스트보기  */
				getListReplyAjax(${map.pager.curPage})
			}
		}) 
	}
	function updateReply(element){
		
		var rNum = $(element).parent().siblings(".rNum").val(); 
		var rContent = $(element).siblings(".rContent").val();
		
		var data={
				rNum:rNum,
				rContent:rContent
		}
		
		if(confirm("수정하시겠습니까?"))
			/* 댓글 수정 아작스 실행  */
			changeReply('${location}/reply/updateReply.amg','PUT',data)
	}
	
	/* 삭제링크 클릭시 */
	function deleteLink(element){
		var rNum = $(element).parent().siblings(".rNum").val()
		
		var data={
			rNum:rNum
		}
		
		if(confirm("삭제 하시겠습니까?"))
			/* 댓글 삭제 아작스 실행  */
			changeReply('${location}/reply/deleteReply.amg','DELETE',data);
	}
	
	/* 수정링크 클릭시 작동 */
	function updateLink(element){
		
		var firstContent = $(element).parent().siblings(".replySpan").text();
		
		$(element).parent().siblings(".replyText").toggleClass("viewNone").children(".replyContent").focus();
		$(element).parent().siblings(".replySpan").toggleClass("viewNone");
		
		if( $(element).text() == "수정" )
			$(element).text("수정취소").css("color","red") 
		else{
			$(element).text("수정").css("color","rgba(0,0,0,.5)")
			$(element).parent().siblings(".replyText").children(".rContent").val(firstContent)
		}
	}

</script>
<div class="replys">
	<ul>
		<c:forEach var="reply" items="${map.reply}" >		
			<li class="reply_row row_${reply.rNum}">
				<c:choose>
					<c:when test="${reply.mPic == null}">
						<span class="basicPic"><i class="fa fa-user-circle replyPic" aria-hidden="true"></i></span>				
					</c:when>							
					<c:otherwise>
						<span><img class="replyPic" height="60px" width="60px" src="${memberImg}/${reply.mPic}"></span>
					</c:otherwise>
				</c:choose>
				
				<span class="replyWriter">${reply.rWriter}</span>
				<span class="replyDate"><fmt:formatDate value="${reply.reRegdate}" pattern="yyyy-MM-dd HH:mm"/></span>

				<span class="modifyLinkWrap viewNone">
					<a class="updateLink" href="javascript:void(0)" onclick="updateLink(this)">수정</a>
					<a class="deleteLink" href="javascript:void(0)" onclick="deleteLink(this)">삭제</a>
				</span>
				
				<div class="replyText viewNone">
					<textarea class="replyContent rContent" cols="80" rows="4" name="rContent">${reply.rContent}</textarea>
					<input type="button" onclick="updateReply(this)" class="replyModifyBtn" value="수정">
				</div>
				<span class="replyContent replySpan">${reply.rContent}</span>
				
				<input type="hidden" value="${reply.rNum}" class="rNum">
			</li>
		</c:forEach>
	</ul>
	
	<div class="reply_page">
		<!-- 처음페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:getListReplyAjax(1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 이전페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:getListReplyAjax(${map.pager.prevBlockPage})"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
		</c:if>
		
		<c:forEach var="num" begin="${map.pager.startPageNo}" end="${map.pager.endPageNo}">
			<c:choose>
				<c:when test="${map.pager.curPage == num}">
					<span class="page_num">${num}</span>
				</c:when>
				
				<c:otherwise>
					<a href="javascript:getListReplyAjax(${num})" class="page_num">${num}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음페이지로가기  -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:getListReplyAjax(${map.pager.nextBlockPage})"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 마지막페이지로가기 -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:getListReplyAjax(${map.pager.totalPage})"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
		</c:if>
	</div>
</div>