<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_boardRead.css"/>">
<script src="<c:url value="/resources/script/club/club_boardRead.js"/>"></script>
<style>
	#likeBtn{
		display: inline-block;
		margin-left: 47%;
		font-size: 20px;
		text-align: center;
	}
</style>
<script>
	$(document).ready(function(){
		/* 댓글가져오기 */
		getReplyAjax()
		
		$(".boardHeader").css("display","none")
		
		if(userName=="STW"){
			$(".button_wrap").css("display","block");
		}
		/* 동호회회원이 자기글 아닌글을 클릭시에는 수정삭제버튼 안보이게함 */
		if(sessionStorage.getItem('isMember')!= "none"){
			var obj = JSON.parse(sessionStorage.getItem('isMember'))
		
			if(obj.cNickname == "${board.bWriter}"){
				$(".button_wrap").css("display","block");
			}
		}
	})
	
	function getReplyAjax(){
		$.ajax({
			type:"get",
			url:"${location}/reply/reply.amg?",
			success:function(replyContent){
				$(".replyContainer").html(replyContent)
			}
		})
	}
	
	/* 수정,삭제처리 */
	function boardAjax(url,type){
	
		var data = $("#updateForm").serializeObject();
		
		$.ajax({
			type:type,
			url:url,
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data),
			success:function(msg){
				
				/* 홈이아닌 게시판컨텐츠에서 게시판서비스 사용할때 이전페이지로 가기 */
				if(${criteria.curPage != 0})
					getBoardAjax(path+'/club/board/boardListAll.amg?cNum=${board.cNum}&curPage=${criteria.curPage}&category=${criteria.category}&searchOption=${criteria.searchOption}&searchWord=${criteria.searchWord}&orderByWord=${criteria.orderByWord}')
				else{
				/* 홈버튼 클릭시켜서, 홈버튼에서 바로 넘어온경우는 서비스후 바로 홈으로이동  */
					$("#first_link").click();
				}
				
				$(".boardHeader").css("display","inline-block")
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</script>
<div id="boardContent">
	<form id="updateForm">
		<div class="onlyRead">
			<div class="write_row">
				<label for="bTitle" id="labelbTitle" class="bTitle">제목:</label>
				<input type="text" id="bTitle" class="bTitle" name="bTitle" value="${board.bTitle}" readonly="readonly">
				<div class="sub_info">
					<select id="bCategory" name="bCategory" disabled="disabled">
						<option value="1" <c:out value="${board.bCategory == '1'?'selected':''}"/> >자기소개</option>
						<option value="2" <c:out value="${board.bCategory == '2'?'selected':''}"/> >QnA</option>
						<option value="3" <c:out value="${board.bCategory == '3'?'selected':''}"/> >등업게시판</option>
						<option value="4" <c:out value="${board.bCategory == '4'?'selected':''}"/> >자유게시판</option>
						<option value="4" <c:out value="${board.bCategory == '5'?'selected':''}"/> >공지사항</option>
					</select>
					<label for="uptDate" id="uptLabel">수정일</label>
					<span id="uptDate"><fmt:formatDate value="${board.bUpdate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
				</div>
			</div>
			
			<div class="write_row">
				<label for="bWriter">작성자  </label> 
				<input type="text" id="bWriter" style="font-size: 14px;" readonly="readonly" name="bWriter" value="${board.bWriter}" readonly="readonly">
			</div>
		</div>
		
		<div class="write_row">
			<textarea cols="100" rows="25" id="bContent" name="bContent" readonly="readonly" >${board.bContent}</textarea>
		</div>
				
		
		<input type="hidden" name="cNum" id="cNum" value="${board.cNum}">
		<input type="hidden" name="bNum" id="bNum" value="${board.bNum}">
		
		<a href="javascript:likeAjax('${location}/club/board/clickLike.amg?cNum=${board.cNum}&bNum=${board.bNum}')" id="likeBtn">
			<span class="likeWrap"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></span>
			<span class="boardLike">${board.bLike}</span>
		</a>
		
		<div class="button_wrap">
			<input type="button" id="updateBtn" value="수정하기">
			<input type="button" onclick="boardDelete('${location}/club/board/boardDelete.amg','DELETE')" value="삭제하기">
		</div>
	</form>
	
	<!-- 댓글 불러오기 -->
	<div class="replyContainer">
	
	</div>
	<input type="hidden" id="loc" value="${location}">
</div>