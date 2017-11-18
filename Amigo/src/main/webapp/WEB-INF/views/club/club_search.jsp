<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../header/topMenu.jsp"%>
<script src="<c:url value="/resources/script/jquery.cookie.js"/>"></script>
<script src="<c:url value="/resources/script/club/club_search.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_search.css"/>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function(){
		if(${keyword == '자연'})
			alert(${keyword})
	})
</script>
<body>
	<div id="container">
		<div id="content">
			<div id="article1">
				<h2>동호회 검색</h2>
				<div class="input_box row_1">
					<label for="titleSearch">제목 검색</label>
					<input type="text" id="titleSearch" name="titleSearch">
					<input type="button" id="btn_search" value="검색">
				</div>
				
				<div class="input_box row_2">
					<label for="hobbySearch">카테고리</label>
					<select name="hobbySearch" id="hobbySearch">
						<option value="all">전체</option>
						<option value="자연" <c:out value="${keyword == '자연'?'selected':''}"/> >자연</option>
						<option value="여행캠핑" <c:out value="${keyword == '여행캠핑'?'selected':''}"/> >여행/캠핑</option>
						<option value="자동차" <c:out value="${keyword == '자동차'?'selected':''}"/> >자동차</option>
						<option value="운동스포츠" <c:out value="${keyword == '운동스포츠'?'selected':''}"/> >운동/스포츠</option>
						<option value="동물반려견" <c:out value="${keyword == '동물반려견'?'selected':''}"/> >동물/반려견</option>
						<option value="공부스터디" <c:out value="${keyword == '공부스터디'?'selected':''}"/> >공부/스터디</option>
						<option value="스키보드" <c:out value="${keyword == '스키보드'?'selected':''}"/> >스키/보드</option>
						<option value="자전거" <c:out value="${keyword == '자전거'?'selected':''}"/> >자전거</option>
						<option value="등산" <c:out value="${keyword == '등산'?'selected':''}"/> >등산</option>
						<option value="술칵테일" <c:out value="${keyword == '술칵테일'?'selected':''}"/> >술/칵테일</option>
						<option value="공연전시" <c:out value="${keyword == '공연전시'?'selected':''}"/> >공연/전시</option>
						<option value="문화" <c:out value="${keyword == '문화'?'selected':''}"/> >문화</option>
						<option value="패션" <c:out value="${keyword == '패션'?'selected':''}"/> >패션</option>
						<option value="게임" <c:out value="${keyword == '게임'?'selected':''}"/> >게임</option>
						<option value="전공직장" <c:out value="${keyword == '전공직장'?'selected':''}"/> >전공/직장</option>
						<option value="영화" <c:out value="${keyword == '영화'?'selected':''}"/> >영화</option>
						<option value="음악" <c:out value="${keyword == '음악'?'selected':''}"/> >음악</option>
						<option value="사진" <c:out value="${keyword == '사진'?'selected':''}"/> >사진</option>
						<option value="독서" <c:out value="${keyword == '독서'?'selected':''}"/> >독서</option>
						<option value="기타이색" <c:out value="${keyword == '기타이색'?'selected':''}"/> >기타/이색</option>
					</select>
				</div>
				
				<div class="input_box row_3">
					<label for="cAddress">지역</label>
					<input type="text" name="addressSearch" id="addressSearch">
				</div>
			</div>
	
			<div id="article2" class="article-clubs">
				<h2>검색결과</h2>
				<div class="club_category">
					<a href="javascript:void(0);" class="click category_row">최신순</a>
					<a href="javascript:void(0);" class="category_row">게시글수</a>
					<a href="javascript:void(0);" class="category_row">회원수</a>
				</div>
				
				<div class="club-wrap">
				
				</div>
			</div> <!-- articl2 -->
		</div>	<!-- content -->
	</div>	<!-- container -->
	<input type="hidden" id="page" value="${page}">
</body>
</html>
