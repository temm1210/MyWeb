<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<c:url var="memberImg" value="/resources/images/member_images" />
<script>
	//댓글첫화면인지 아닌지 확인해주는 플래그변수
	var isFirstBoard = true;
	$(document).ready(function(){
		getListReplyAjax(1)
		
		if(sessionStorage.getItem('isMember')!= "none"){
			var objJSON = JSON.parse(sessionStorage.getItem('isMember'))
			$("#rWriter").val(objJSON.cNickname)
	
			/* 현재유저 프로필사진 등록 */
			if(objJSON.mPic == null){
				$("#picLabel").html('<i class="fa fa-user-circle nopic" aria-hidden="true"></i>')
			}else{
				$("#picLabel").html('<img id="member_pic" height="60px" width="60px" src=${memberImg}/'+objJSON.mPic+'>')
			}
		}
	})
	
	/* 댓글입력 */
	function writeReplyAjax(url){
		
 		var replyCount = parseInt( $(".replyCount").text() ) +1;
 		var curPage = Math.ceil( replyCount/3.0 );
 		var data;
 		

		data={
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
				// 입력했던 댓글내용 초기화 
				$("#rContent").val("");
				
				// 댓글 작성후,댓글 마지막 페이지로 이동
				getListReplyAjax(curPage);
			}
		});
	}
	
	/* 댓글 리스트 불러오기 */
	function getListReplyAjax(curPage){
		
		var cNum = $("#cNum").val()
		var bNum = $("#bNum").val()
		
		var url = "${location}/reply/getReplys.amg?cNum="+cNum+"&bNum="+bNum+"&curPage="+curPage;
		var path = url.substring(url.lastIndexOf('?')+1 , url.length);
		
		$.ajax({
			type:"GET",
			url:url,
			success:function(replyList){
				/* 불러온 댓글리스트,해당 div영역에 붙여줌 */
				$("#replyList").html(replyList);
				
				//처음으로, 해당화면으로 진입시 
				if(isFirstBoard)
					isFirstBoard=false;
				//처음진입하지 않았다면
				else
					history.pushState({ content:replyList,page:"reply"},'','?'+path)
			}
		})
		
	}
</script>
<style>
	.replyCount{
		display: inline-block;
		margin-bottom: 20px;
	}
	.replyWrap{
		width: 800px;
		background: rgba(220,220,220,.23);
		padding:50px 0 20px 20px;
		height: 100%;
		margin-left: -35px;
	}
	
	#member_pic{
		border-radius: 50%;
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
<div id="replyContainer">
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