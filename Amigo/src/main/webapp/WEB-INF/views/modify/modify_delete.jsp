<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/modify/modify_delete.css'/>">
<script src="<c:url value="/resources/script/modify/modify_delete.js"/>"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="container">
		<div id="content">
			<div class="title">
				<h2 class="delete_title">탈퇴 유의사항</h2>
				<span class="delete_sub">회원탈퇴전 다음사항을 꼭 확인해주세요.</span>
			</div>
			
			<div class="article row_1">
				<h2 class="article_title">* 탈퇴할경우 재사용 및 복구가 불가능합니다.</h2>
				<span class="article_sub">
					회원정보로 이용하셨던 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br/>
				</span>
			</div>
			
			<div class="article row_2">
				<h2 class="article_title">* 탈퇴 후에도 등록한 게시물은 그대로 남아 있습니다.</h2>
				<span class="article_sub">
					게시판,고객센터등에 올린 게시글 및 댓글은 탈퇴 시 자동 삭제되지 않고 그대로 남아 있습니다.<br/>
					삭제를 원하시는 게시글이나 댓글이 있다면 <span class="strong">반드시 탈퇴 전 비공개 처리하거나 삭제 하시기 바랍니다.</span><br/>
					탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, 게시글을 임의로 삭제해드릴 수 없습니다.<br/>
				</span>
			</div>
			
			<div class="article row_3">
				<h2 class="article_title">* 탈퇴 후에는 탈퇴한 아이디로 다시 가입할 수 없습니다.</h2>
				<span class="article_sub">
					탈퇴후 다시는 <span class="strong">동일한 아이디로 회원 가입하실 수 없습니다.</span><br/>
					탈퇴후 아이디와 데이터는 복수할수 없으며, 게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할수 없습니다.
				</span>
			</div>
						
			<div class="check_wrap">
				<input type="checkbox" id="agree_check">
				<label for="agree_check">안내 사항을 모두 확인하였으며, 이에 동의합니다.</label>
			</div>
			
			<input type="button" value="탈퇴" id="delete_btn" onclick="goNextPage('${location}/member/modify_delete_ok.amg');">
		</div>
	</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>