<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<%@ include file="../header/topMenu.jsp" %>
<script src="<c:url value="/resources/script/checkEffect.js"/>"></script>
<script src="<c:url value="/resources/script/club/club_make.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_make.css"/>">
<title>Insert title here</title>
<style>
	#section{
		padding-top: 200px;
		padding-bottom: 120px;
		text-align: center;
		background-image: url("<c:url value="/resources/images/club_form.jpg"/>");
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat; 
	}
</style>
</head>
<body>
	<div id="container">
		<div id="section">		
			<h3>동호회 만들기</h3>
			<div id="article">
				<form method="post" action="" id="club_form" enctype="multipart/form-data">
					<span>*모두 빠짐없이 입력하셔야 합니다.</span>
					<div id="title_field" class="club_row">
						<label for="title">동호회 제목 </label>
						<input type="text" id="title" name="cTitle" placeholder="동호회제목 입력(5자이상)">
						<span class="input_check"></span>
						<i class="fa fa-check ch" aria-hidden="true"></i>						
					</div>
					
					<div id="content_field" class="club_row">
						<label for="content">동호회 소개글 </label>
						<input type="text" id="content" name="cContent" placeholder="소개글 입력(10자이상)">
						<span class="input_check"></span>	
						<i class="fa fa-check ch" aria-hidden="true"></i>					
					</div>
					
					<div id="name_field" class="club_row">
						<label for="nickname">닉네임<span class="detail">(*동호회에서 사용할 닉네임)</span> </label>
						<input type="text" id="cNickname" name="cNickname" placeholder="닉네임을 입력하세요(2자이상)">
						<span class="input_check"></span>	
						<i class="fa fa-check ch" aria-hidden="true"></i>					
					</div>
					
					<div id="cpic_field" class="club_row">
						<label for="cpic">동호회 대표사진 </label>
						<input type="file" id="cpic" name="cpic" value="사진" >
						<span class="input_check"></span>						
					</div>
				
					<div id="area_field" class="club_row">
						<label for="area">활동 지역</label>
						<select name="cArea1" id="area1">
							<option value="서울">서울</option>
							<option value="경기">경기</option>
							<option value="인천">인천</option>
							<option value="대전">대전</option>
							<option value="부산">부산</option>
							<option value="대구">대구</option>
							<option value="광주">광주</option>
							<option value="울산">울산</option>
						</select>
								
						<select name="cArea2" id="area2">
							<option value="관악구">관악구</option>
							<option value="강남구">강남구</option>
							<option value="용산구">용산구</option>
							<option value="강서구">강서구</option>
							<option value="금천구">금천구</option>
							<option value="송파구">송파구</option>
						</select>		
						<span class="input_check"></span>				
					</div>
					
					<div id="hobby_field" class="club_row">
						<label for="hobby">관심사</label>
						<select name="cHobby" id="hobby">
							<option value="자연" selected>자연</option>
							<option value="여행/캠핑">여행/캠핑</option>
							<option value="자동차">자동차</option>
							<option value="운동/스포츠">운동/스포츠</option>
							<option value="동물/반려견">동물/반려견</option>
							<option value="공부/스터디">공부/스터디</option>
							<option value="스키/보드">스키/보드</option>
							<option value="자전거">자전거</option>
							<option value="등산">등산</option>
							<option value="술/칵테일">술/칵테일</option>
							<option value="공연/전시">공연/전시</option>
							<option value="문화">문화</option>
							<option value="패션">패션</option>
							<option value="게임">게임</option>
							<option value="전공/직장">전공/직장</option>
							<option value="영화">영화</option>
							<option value="음악">음악</option>
							<option value="사진">사진</option>
							<option value="독서">독서</option>
							<option value="기타">기타/이색</option>
						</select>
						<span class="input_check"></span>
					</div>
					<div class="submit_group">
						<input type="button" id="joinBtn" value="만들기" onclick="makeClub('${location}/club/insertClub.amg?${_csrf.parameterName}=${_csrf.token}')">
						<input type="button" id="cancelBtn" value="취소" onclick="exitPage('${location}/main.amg')">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>