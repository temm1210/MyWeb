<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/modify/modify_entry.css" />">
<title>Insert title here</title>
</head>
<body>
<div id="container">	
	<span class="my_info">내 정보</span>
	<i class="fa fa-cog" style="font-size:70px;" aria-hidden="true"></i>
	
	<div id="content">
		<div class="wrap_link">
			<span class="sub_comment">회원탈퇴</span>
			<a href="${location}/member/modify_delete.amg" class="link_page">
				<div class="modify_info" id="delete_info">
					<img src="<c:url value='/resources/images/delete3.jpg'/>" class="modify_page">
				</div>
			</a>
		</div>
		
		<div class="wrap_link">
			<span class="sub_comment">회원수정</span>
			<a href="${location}/member/modify_update.amg" class="link_page">
				<div class="modify_info" id="udpate_info">
					<img src="<c:url value='/resources/images/change2.jpg'/>" class="modify_page">
				</div>
			</a>
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>