<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/login/login.css"/>">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		var state = "${state}";
		
		
		//로그인 버튼클릭시

		$("#loginBtn").on({
			click:function(){ 
				$("#login_form").attr("method","post").attr('action','<c:url value="login_proccess.amg"/>');
			},
			keydown:function(key){
				if(key.keyCode == 13){
					$("#login_form").attr("method","post").attr('action','<c:url value="login_proccess.amg"/>');
				}
			}
		});
		
		//회원가입 버튼클릭시
		$("#joinBtn").click(function(){
			$("#login_form").attr("method","get").attr("action","${location}/member/joinFirst.amg");
		})
		
		if(state == 'login_fail')
			$("#stateCh").html("로그인정보가 틀립니다.다시입력해주세요");
		else
			$("#stateCh").html("");
		
	})
</script>
<style>
	#img_main{
		background-image: url("<c:url value="/resources/images/loginMain.jpg"/>");
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		width:100%;
		height:100%;
	}
</style>
</head>
<body>	
	<div id="container">
		<div id="img_main">	
			<div id="content">
				<form id="login_form">
					<h2>LOGIN</h2>
					<span id="stateCh"></span>
					<div id="id_div" class="login_row">
						<label for="mid">아이디 </label>
						<input type="text" id="mId" name="username">
					</div>
					
					<div id="pwd_div" class="login_row">
						<label for="pwd">패스워드 </label>
						<input type="password" id="mPwd" name="password">
					</div>
					
					<div class="submit_group">
						<input type="submit" id="loginBtn" value="로그인">
						<input type="submit" id="joinBtn" value="회원가입">
					</div>
					
					<div class="link_group">
						<a href="#" id="search_id">아이디 찾기</a>
						<a href="#" id="search_pwd">비밀번호 찾기</a>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>