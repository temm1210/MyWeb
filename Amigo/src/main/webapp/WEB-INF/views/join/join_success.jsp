<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/join/join_success.css"/>">
<style>
	#main-img{
		background-image: url("${img}/welcome.jpg");
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		width:100%;
		height:400px;
	}
</style>
</head>
<body>
	<div id="container">
		<div id="content">
			<div id="main-img"></div>
			<div class="welcome">
				<h2><span class="important">회원가입</span>을 축하드립니다.</h2>
				<span class="sub">고객님의 사이트 이용에 불편하지 않도록 노력하겠습니다.
				로그인 후 바로 서비스 이용이 가능합니다. 아래 버튼을 클릭해주세요</span>
			</div>
			<img src="${img}/success.png" id="img_success" width="50%" height="50%">
			
			<div class="link_group">
				<a href="${location}/member/login.amg" class="link" id="agree_link">로그인</a>
				<a href="/index.jsp" class="link" id="home_link">홈으로가기</a>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>