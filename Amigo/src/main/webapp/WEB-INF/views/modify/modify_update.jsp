<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<%@ include file="../header/topMenu.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="<c:url value="/resources/script/information_check.js"/>"></script>
<script src="<c:url value="/resources/script/checkEffect.js"/>"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/modify/modify_update.css'/>">
<script src="<c:url value="/resources/script/modify/modify_update.js"/>"></script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
		<div id="img_main">	
			<div id="content">
				<form enctype="multipart/form-data" method="post" id="modify_form" action="${location}/member/modify_ok.amg?${_csrf.parameterName}=${_csrf.token}">				
					<h2>회원정보</h2>	
					<p>&nbsp;&nbsp;*는 수정불가능한 항목입니다.</p>
					<div id="id_field" class="inform_row">
						<label for="mid">*아이디 </label>
						<input type="text" id="username" name="username" value="${member.username}" readonly="readonly">
					</div>
					
					<div id="pwd_field" class="inform_row">
						<label for="pwd">패스워드 </label>
						<input type="password" id="password" name="password">
						<span class="input_check"></span>
						<i class="fa fa-check" aria-hidden="true"></i>
					</div>
					
					<div id="pwd_check_field" class="inform_row">
						<label for="pwd_check">비밀번호재확인 </label>
						<input type="password" id="password_check" name="password_check">
						<span class="input_check"></span>
						<i class="fa fa-check" aria-hidden="true"></i>
					</div>
					
					<div id="name_field" class="inform_row">
						<label for="name">이름 </label>
						<input type="text" id="name" name="mName" value="${member.mName}">
						<span class="input_check"></span>
						<i class="fa fa-check view" aria-hidden="true"></i>
					</div>
					
					<div id="pic_field" class="inform_row">
						<label for="mpic">프로필사진 </label>			
							<span class="wraper_img">
								<c:choose>
									<c:when test="${member.mPic != null}">
										<img id="pro_pic" src="<c:url value='/resources/images/member_images/${member.mPic}'/>" >
										<i class="fa fa-user-circle" id="profile" aria-hidden="true"></i>
									</c:when>
									<c:otherwise>
										<i class="fa fa-user-circle" id="profile" aria-hidden="true"></i>
										<img id="pro_pic" src="" >
									</c:otherwise>
								</c:choose>
							</span>								   
						<span class="wraper_pic">
							<span class="sel_pic">파일선택</span>
							<input type="button" value="삭제" id="cancelPic" name="cancelPic">
							<input type="file" style="border:none;" id="pic" name="pic">
							<input type="hidden" id="prev_pic" name="prev_pic" value="${member.mPic}">
							<input type="hidden" id="isChange" name="isChange">
						</span>
						
					</div>
					
					<div id="tel_field" class="inform_row">
						<label for="tel">전화번호 </label>
						<input type="text" id="tel" name="mTel" value="${member.mTel}">
						<span class="input_check"></span>
						<i class="fa fa-check view" aria-hidden="true"></i>
					</div>
					
					<div id="email_field" class="inform_row">
						<label for="email">이메일</label>
						<div id="email_select">
							<input type="text" id="first_email" name="first_email" ><span id="esp">@</span>
							<input type="text" id="last_email" name="last_email" >
							<select name="email_box" id="email_box">
								<option value="empty" selected>직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="gmail.com">gmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="hanmir.com">hanmir.com</option>
								<option value="yahoo.com">yahoo.com</option>
							</select>
						</div>
						<input type="hidden" name="mEmail" id="mEmail" value="${member.mEmail}">
						<span class="input_check"></span>
						<i class="fa fa-check view" aria-hidden="true"></i>
					</div>
					
					<div id="gender_field" class="inform_row">
						<label for="gender">*성별 </label>
						<input type="text" id="gender" value="${member.mGender}" readonly="readonly">
					</div>
					
					<div id="date_field" class="inform_row">
						<label for="regdate">*가입일자 </label>
						<input type="text" id="regdate" value="<fmt:formatDate value="${member.mRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly">
					</div>
					
					<div id="update_field" class="inform_row">
						<label for="update_date">*최근수정일자 </label>
						<input type="text" id="update_date" value="<fmt:formatDate value="${member.mUpdatedate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly">
					</div>
					
					<div id="age_field" class="inform_row">
						<label for="age">*나이 </label>
						<input type="text" id="age" value="${member.mAge}"readonly="readonly">
					</div>
					
					<div class="submit_group">
						<input type="button" id="modifyBtn" value="수정">
						<input type="button" id="cancelBtn" value="취소">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>