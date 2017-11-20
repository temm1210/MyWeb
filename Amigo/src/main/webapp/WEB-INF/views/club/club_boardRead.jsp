<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_boardWrite.css"/>">
<script>
	$(document).ready(function(){
		/* 수정버튼 클릭시 */
		$("#updateBtn").on('click',function(){
			
			var updateVal = $("#updateBtn").attr("value");
			
			/* 수정후 수정완료 버튼 클릭시 */
			if(updateVal == "수정완료"){	
				updateAjax("${location}/club/board/boardUpdate.amg","PUT");
			}
			/* 수정버튼을 클릭시 */
			else{
				/* 변경불가능 속성 제거 */
				$(".write_row > select").removeAttr("disabled")
				$(".write_row > input:not('#bWriter'), .write_row > textarea").removeAttr("readonly");
				
				/* 수정버튼 수정완료로 변경 */
				$("#updateBtn").attr("value","수정완료");
				$("#updateForm > h2").after("<span style='color:red'>수정중</span>")
				
				/* 제목에 자동 포커스 */
				$("#bTitle").focus();
			}
			
		});
		function updateAjax(url){
			var data = $("#updateForm").serializeObject();
			
			$.ajax({
				type:"PUT",
				url:url,
				headers:{
					"Content-Type":"application/json; charset=UTF-8"
				},
				data:JSON.stringify(data),
				success:function(msg){
					
					/* 글작성 성공시 */
					if(msg == "success")
						alert("게시글이 수정되었습니다.")
					/* 글작성 실패시  */
					else
						alert("게시글수정에 실패하였습니다.")
						
					getContentAjax('${location}/club/board/boardListAll.amg?cNum=${board.cNum}&curPage=${curPage}&category=${category}')
					/* 게시글작성완료후 게시글 전체보기로 이동 */
					/* $(".sub_ul > li:first-child > a").get(0).click(); */
					/* history.back(); */
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
	})
</script>
<div id="boardContent">
	<form id="updateForm">
		<h2>게시글쓰기</h2>
		<div class="write_row">
			<label for="bCategory">카테고리  </label>
			<select id="bCategory" name="bCategory" disabled="disabled">
				<option value="1" <c:out value="${board.bCategory == '1'?'selected':''}"/>>자기소개</option>
				<option value="2" <c:out value="${board.bCategory == '2'?'selected':''}"/>>QnA</option>
				<option value="3" <c:out value="${board.bCategory == '3'?'selected':''}"/>>등업게시판</option>
				<option value="4" <c:out value="${board.bCategory == '4'?'selected':''}"/>>자유게시판</option>
			</select>
			
			<label for="uptDate" id="uptLabel">수정일</label>
			<span id="uptDate"><fmt:formatDate value="${board.bUpdate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
		</div>
		
		<div class="write_row">
			<label for="bTitle">제목  </label>
			<input type="text" id="bTitle" size="60" name="bTitle" value="${board.bTitle}" readonly="readonly">
		</div>
		
		<div class="write_row">
			<label for="bWriter">작성자  </label>
			<input type="text" id="bWriter" readonly="readonly" name="bWriter" value="${board.bWriter}" readonly="readonly">
		</div>
		
		<div class="write_row">
			<textarea cols="100" rows="25" id="bContent" name="bContent" readonly="readonly" >${board.bContent}</textarea>
		</div>
		
		<input type="hidden" name="cNum" id="cNum" value="${board.cNum}">
		<input type="hidden" name="bNum" id="bNum" value="${board.bNum}">
		
		<div class="button_wrap">
			<input type="button" id="updateBtn" value="수정하기">
			<input type="button" id="deleteBtn" value="삭제">
		</div>
	</form>
</div>