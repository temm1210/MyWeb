<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_boardWrite.css"/>">
<script>
	$(document).ready(function(){
		var club = JSON.parse(sessionStorage.getItem("isMember"));
		$("#bWriter").attr("value",club.cNickname)

		/* 글작성폼에서 취소버튼 눌렀을떄 */
		$("#cancelBtn").on('click',function(){
			history.back();	
		});
		
	});
	
	/* 글 작성해주는 Ajax */
	function writeAjax(url){
		/* 폼데이터 배열로 key,value형식으로 해줌 */
		var data = $("#writeForm").serializeObject();
		
		$.ajax({
			type:"POST",
			url:url,
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data),
			success:function(msg){
				
				/* 글작성 성공시 */
				if(msg == "success")
					alert("요청을 성공적으로 수행하였습니다.")
					
				/* 글작성 실패시  */
				else
					alert("요청수행에 실패하였습니다.")
					
				/* 게시글작성완료후 게시글 전체보기로 이동 */
				$(".sub_ul > li:first-child > a").get(0).click();
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	}
	
	jQuery.fn.serializeObject = function() {
	    var obj = null;
	    try {
	        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
	            var arr = this.serializeArray();
	            if (arr) {
	                obj = {};
	                jQuery.each(arr, function() {
	                    obj[this.name] = this.value;
	                });
	            }//if ( arr ) {
	        }
	    } catch (e) {
	        alert(e.message);
	    } finally {
	    }
	 
	    return obj;
	};
</script>
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
			<textarea cols="100" rows="25" id="bContent" name="bContent"></textarea>
		</div>
		
		<input type="hidden" name="cNum" id="cNum" value="${cNum}">
		
		<div class="button_wrap">	
			<input type="button" onclick="writeAjax('${location}/club/board/boardWrite.amg')" value="작성">
			<input type="button" id="cancelBtn" value="취소">
		</div>
	</form>
</div>