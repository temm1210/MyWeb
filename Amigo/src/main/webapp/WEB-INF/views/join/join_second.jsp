<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="join_header.jsp" %>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/script/checkEffect.js"/>"></script>
<script src="<c:url value="/resources/script/information_check.js"/>"></script>
<script src="<c:url value="/resources/script/join/join_second.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/join/join_second.css"/>">
<script>
	/* 스프링 시큐리티의 CSRF라는 기능으로 인해 POST방식으로 보낼때 CSRF처리를 해줘야함. AJAX에서 POST요청을함으로 로딩과 동시에 CSRF처리 */
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$(document).ajaxSend(function(e, xhr, options) {
	    xhr.setRequestHeader(header, token);
	});
	/* --------------------------------------------------- */
	function idCheckAjax(){
		var mId = $("#username").val()
		
		var data={
			mId:mId
		}
		
		$.ajax({
			type:"POST",
			url:"${location}/member/isIdExist.amg",
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data),
			success:function(msg){
				if(msg == "possible"){
					$("#id_field > .input_check").css("color","green").text("사용가능한 아이디입니다")
					 successCheckEffect($("#id_field"));
				}
				else
					$("#id_field > .input_check").css("color","red").text("이미 있는 아이디입니다")
			}
		})
	}
</script>
</head>
<body>
	<div id="container">
		<h3>기본정보입력</h3>
		<form enctype="multipart/form-data" method="post" action="" id="join_second_form">
			<div id="id_field" class="join_row">
				<label for="id">아이디 </label>
				<input type="text" id="username" name="username" placeholder="ID를 입력">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<div id="pwd_field" class="join_row">
				<label for="pwd">비밀번호 </label>
				<input type="password" id="password" name="password" placeholder="영문,숫자,특수문자혼합하여 8~20자리입력">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<div id="pwd_check_field" class="join_row">
				<label for="pwd_check">비밀번호재확인 </label>
				<input type="password" id="password_check" name="password_check" placeholder="패스워드 재확인">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<div id="name_field" class="join_row">
				<label for="name">이름 </label>
				<input type="text" id="name" name="mName" placeholder="이름 입력">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<div id="pic_field" class="join_row">
				<label for="mpic">프로필사진 </label>
				<span class="wraper_img">
					<img id="pro_pic" src="" >
					<i class="fa fa-user-circle" aria-hidden="true"></i>
				</span>
				<span class="wraper_pic">
					<span class="sel_pic">파일선택</span>
					<input type="file" style="border:none;" id="pic" name="pic">
				</span>
				<input type="button" value="취소" id="cancelPic" name="cancelPic">
				
			</div>
			
			<div id="age_field" class="join_row">
				<label for="age">나이</label>
				<input type="text" id="age" name="mAge" placeholder="나이 입력" onkeydown="javascript:onlyNumber(this)">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<div id="gender_field" class="join_row">
				<label for="gender_box">성별 </label>
				<select name="mGender" id="gender_box">
					<option value="M">남자</option>
					<option value="W">여자</option>
				</select>
			</div>
			
			<div id="email_field" class="join_row">
				<label for="email">이메일</label>
				<input type="text" id="first_email" name="first_email" placeholder="이메일 ID">@
				<input type="text" id="last_email" name="last_email" placeholder="직접입력">
				<select name="email_box" id="email_box">
					<option value="empty" selected>직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="gmail.com">gmail.com</option>
					<option value="nate.com">nate.com</option>
					<option value="hanmir.com">hanmir.com</option>
					<option value="yahoo.com">yahoo.com</option>
				</select>
				<input type="hidden" name="mEmail" id="mEmail">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<div id="tel_field" class="join_row">
				<label for="tel">전화번호</label>
				<input type="text" id="tel" name="mTel" placeholder="'-'를 제외하고 입력하세요">
				<span class="input_check"></span>
				<i class="fa fa-check" aria-hidden="true"></i>
			</div>
			
			<input type="hidden" name="authority" value="ROLE_USER">
			
			<div class="submit_group">
				<input type="button" id="joinBtn" value="가입" onclick="goNextPage('${location}/member/joinSuccess.amg?${_csrf.parameterName}=${_csrf.token}')">
				<input type="button" id="cancelBtn" value="취소" onclick="exitPage('${location}/main.amg')">
			</div>
		</form>
	</div>
</body>
</html>