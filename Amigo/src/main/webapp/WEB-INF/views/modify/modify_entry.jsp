<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/modify/modify.css" />">
<title>Insert title here</title>
<style>
	#delete_info{
		background-image: url("<c:url value="/resources/images/delete.jpg"/>");
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		transition:all 0.2s;
		width:100%;
		height:700px;
		box-shadow: 1px 1px 1px rgba(0,0,0,.2);
	}
	
		
	#udpate_info{
		background-image: url("<c:url value="/resources/images/change.jpg"/>");
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		transition:all 0.2s;
		width:100%;
		height:700px;
		box-shadow: 1px 1px 1px rgba(0,0,0,.2);
	}
</style>
</head>
<body>
<div id="container">	
	<span class="my_info">내 정보</span>
	<i class="fa fa-cog" style="font-size:160px;" aria-hidden="true"></i>
	
	<div id="content">
		<div class="wrap_link">
			<span class="sub_comment">회원탈퇴</span>
			<a href="${location}/member/delete.amg" class="link_page">
				<div id="delete_info">
					<div class="modify_page second_page"></div>
				</div>
			</a>
		</div>
		
		<div class="wrap_link">
			<span class="sub_comment">회원수정</span>
			<a href="${location}/member/modify_update.amg" class="link_page">
				<div id="udpate_info">
					<div class="modify_page first_page"></div>
				</div>
			</a>
		</div>

	</div>
</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>