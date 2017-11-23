<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<c:url var="memberImg" value="/resources/images/member_images" />
<script>
	$(document).ready(function(){
	
		var obj = JSON.parse(sessionStorage.getItem('isMember'))
		
		$("#rWriter").val(obj.cNickname)
		
		getListReplyAjax()
		/* 현재유저 프로필사진 등록 */
		if(obj.mPic == null){
			$("#picLabel").html('<i class="fa fa-user-circle nopic" aria-hidden="true"></i>')
		}else{
			$("#picLabel").html('<img id="pr_pic" height="60px" width="60px" src=${memberImg}/'+obj.mPic+'>')
		}
		
	})
	
	/* 댓글입력 */
	function writeReplyAjax(url){
 		
		var data={
				cNum:$("#cNum").val(),
				bNum:$("#bNum").val(),
				rWriter:$("#rWriter").val(),
				rContent:$("#rContent").val()
		}
		
 		$.ajax({
			type:"POST",
			url:url,
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data),
			success:function(msg){
				alert(msg)
				/* 입력했던 댓글내용 초기화 */
				$("#rContent").val("");
				
				/* 동호회 댓글리스트만 다시불러오기 */
				getListReplyAjax()
			}
		}) 
	}
	
	/* 댓글 리스트 불러오기 */
	function getListReplyAjax(){
		
		var cNum = $("#cNum").val()
		var bNum = $("#bNum").val()
		
		$.ajax({
			type:"GET",
			url:"${location}/reply/getReplys.amg?cNum="+cNum+"&bNum="+bNum,
			success:function(replyList){
				/* 불러온 댓글리스트,해당 div영역에 붙여줌 */
				$("#replyList").html(replyList);
			}
		})
		
	}
</script>
<style>
	.replyWrap{
		width: 800px;
		background: rgba(220,220,220,.23);
		padding:50px 0 20px 20px;
		height: 100%;
		margin-left: -35px;
	}
	
	#pr_pic{
		margin-bottom: 6px;
		margin-right: 10px;
	}
	
	#writeBtn{
		background: none;
	    border: 1px solid rgba(0,0,0,.2);
	    width: 80px;
	    height: 65px;
	    vertical-align: 27px;
	    cursor: pointer;
	}
	.nopic{
		font-size: 55px;
	    display: block;
	    float: left;
	    padding: 0;
	    color: black;
	    margin: 0 10px 6px 0;
	}
</style>
<div>
	댓글수:<span class="replyCount"></span>
	<div class="replyWrap">
	<form id="reply_form">
		<div class="reply_row">
		
			<!-- 댓글목록 불러오기 -->
			<div id="replyList">
			
			</div>
			
			<div class="reply_content">
				<span id="picLabel"></span>
				<textarea cols="80" rows="4" id="rContent" name="rContent"></textarea>
				<input type="hidden" name="rWriter" id="rWriter">
							
				<input type="button" value="등록" onclick="writeReplyAjax('${location}/reply/writeReply.amg')" id="writeBtn">
			</div>
		</div>
	</form>
	</div>
</div>