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
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		/* pdateFileName = this.files[0].name;파일명 가져오기  */
		var prev_profile = "${member.mPic}";
		var isChange = false;
		
		var email = "${member.mEmail}";
		var position = email.indexOf('@');
		
		/* @를기준으로 앞에아이디, 뒤에 주소를 가져오기 */
		var emailId = email.substring(0,position);
		var emailLoc = email.substring(position+1,email.length);

		/* 프로필 사진이 한번이라도 변경됐을시 */
		$("#pic").change(function(){
			isChange=true;
		})
		/* select박스에 변경이 생길시 뒤에 주소에 자동입력 */
		$("#email_box").stop().change(function(){		
			selectEmailCheck(this);
		})
		
		/* 현재유저의 이메일을 화면에 보여줌 */
		$("#first_email").attr("value",emailId)
		$("#last_email").attr("value",emailLoc)
	

		/* 이미지 업로드 클릭시 */
		$(".sel_pic").click(function(){
			/* 파일업르도 버튼 강제로 클릭이벤트발생 */
			$("#pic").trigger("click");
		})
		
		/* 이미지업로드시 */
		$("#pic").change(function(){
			readURL(this);
		})
		
		/* 업로드 삭제버튼 클릭시 */
		$("#cancelPic").click(function(){
			
			isChange=true;
			/* 미리보기 삭제 */
			$("#pro_pic").attr('src','').css("display","none");
			
			/* 기본 프로필사진 보여주기 */
			$("#profile").css("display","inline-block");
			/* 파일삭제 */
			$("#pic").val("");
		})
		
		/* 수정버튼 눌렀을때 */
		$("#modifyBtn").click(function(){
			var icons = $(".fa-check");
			var i = 0;
			
			$("#mEmail").val($("#first_email").val()+"@"+$("#last_email").val())
			
			/* 모두 올바르게 입력했는지 체크 */
			$.each(icons,function(index,value){
				if( $(value).hasClass("view") )
					i++;
			})
			
			if(i == icons.length ){
				if(confirm("수정하시겠습니까?")){
					if(isChange){
						$("#prev_pic").attr("value",prev_profile);
					}
					$("#modify_form").attr("action","${location}/member/modify_ok.amg?${_csrf.parameterName}=${_csrf.token}").submit(); 
				}
			}
			else
				alert("모두 올바르게 입력 하셔야 합니다.");
		})
		
		/* 취소버튼을 눌렀을때 */
		$("#cancelBtn").click(function(){
			if(confirm("이 페이지에서 나가시겠습니까?"))
				$("#modify_form").attr("method","get").attr("action","/index.jsp").submit();  
		})
	})
			
	/* 이미지미리보기  */
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			
			reader.onload = function(e){
				$("#pro_pic").attr('src',e.target.result).css("display","inline-block");
				$("#profile").css("display","none")
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
</head>
<body>
<div id="wrapper">
		<div id="img_main">	
			<div id="content">
				<form enctype="multipart/form-data" method="post" id="modify_form">				
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
							<input type="hidden" id="prev_pic" name="prev_pic" value="">
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
						<input type="hidden" name="mEmail" id="mEmail">
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