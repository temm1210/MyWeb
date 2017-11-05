<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../header/topMenu.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/modify/modify_check.css"/>">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		if(${msg == 'fail'}){
			$(".fail_msg").html("비밀번호가 틀립니다.다시입력하세요");
		}else{
			$(".fail_msg").html("");
		}
			
	});
</script>
</head>
<body>
	<div id="container">
		<div id="content">
			<form id="password_form" method="post" action="${location}/member/modify_entry.amg">
				<div class="wrap_pwd">
					<h2>비밀번호를 한번 더 입력해주세요</h2>
					<div class="pwd_field">
						<label for="password">패스워드 </label>
						<input type="password" id="password" name="password">
						<input type="submit" value="확인">
					</div>
					<span class="fail_msg" style="color:red;"></span>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>