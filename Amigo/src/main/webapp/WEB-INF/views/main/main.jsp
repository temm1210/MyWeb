<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/main/main.css" />">
<script>
	$(function(){
		/* $(".parallax-container").parallax({imageSrc:"door.jpg"})  */
 		 if($('.parallax-window').length){
			 $('.parallax-window').parallax();
		 }  
		
		if(${msg == "delete_success"})
			alert("성공적으로 탈퇴되었습니다\n.그동안 이용해주셔서 감사합니다.")
	});
	
</script> 
</head>
<body>
	<div class="wrapper">
		<div id="visualMain">
			<video muted=" muted" autoplay loop id="vid"> 
				<source src="<c:url value="/resources/video/freevideo.mp4"/>" type="video/mp4">
			</video>
		</div>
		
		<!-- 첫번째 본문(시작을알림) -->
		<div class="section">
			<div id="videoArticle">
				<div class="caption">
					<h1>Welcome to AmiGo</h1>
					<p>
						AmiGo 홈페이지에 오신걸 환영합니다.
						<br>
						AmiGo에서 취미가 비슷한 사람들을 찾아 같이 즐겨보세요
						<br> 
					</p>
				</div>
			</div>
			
			<!-- 2번째 본문 (서비스및,소개)-->
			<div id="article_2" class="article-parallax">
				<div class="parallax-window" id="parallax-image" data-parallax="scroll">	
					<div class="img-text">
						<a href="#">
							<img id="first-sub" src="<c:url value="/resources/images/camp.jpg"/>" width="100%" height="700px">
							<div class="border-line"></div>
							<div class="img_caption ">
								<span class="sub-comment">소개보기</span>
							</div>
						</a>
					</div>
					<div class="img-text_2">
						<a href="${location}/amigoService.amg">
							<img id="second-sub" src="<c:url value="/resources/images/society.jpg"/>" width="100%" height="700px">
							<div class="border-line"></div>
							<div class="img_caption ">
								<span class="sub-comment">서비스보기</span>
							</div>
						</a>
					</div>
				</div>	
			</div>
			
			<!-- 3번째 본문(현재 존재하는 동호회 보기 및 검색) -->
			<div id="article_3" class="article-parallax">
				<div class="parallax-window" id="parallax-image" data-parallax="scroll" data-image-src="<c:url value="/resources/images/door.jpg" />">
					<div class="content_text">
						<a href="${location}/club/clubSearch.amg">
							<div class="border-line"></div>
							<div class="img_caption">
								<h1 class="main-comment font-change">AmiGo Societies</h1>
								<span class="sub-comment">#동호회 보기/검색</span>
							</div>
						</a>
					</div>
				</div>
			</div> 
			
			
			<!-- 4번째 본문 (동호회 분류 보기)  -->
			<div id="article_4" class="article-clubs">
				<h2>동호회 테마별</h2>
				<div class="first-article">
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=자연">
							<img src="<c:url value="/resources/images/nature.jpg"/>">
							<div class="border-line"></div>
							<span class="supply-comment">#자연</span>
						</a>
					</div>
							
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=여행캠핑">
							<img src="<c:url value="/resources/images/tour.jpg"/>">
							<div class="border-line"></div>
							<span class="supply-comment">#여행/캠핑</span>
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=자동차">
							<img src="<c:url value="/resources/images/supercar.jpg"/>">
							<div class="border-line"></div>
							<span class="supply-comment">#자동차</span>
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=운동스포츠">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/workout.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#운동/스포츠</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=동물반려견">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/animals.png"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#동물/반려견</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=공부스터디">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/study.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#공부/스터디</span>
							<!-- </div> -->
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=스키 보드">	
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/ski.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#스키/보드</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=자전거">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/bycicle.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#자전거</span>
							<!-- </div> -->
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=등산">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/climb.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#등산</span>
							<!-- </div> -->
						</a>
					</div>
							
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=술칵테일">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/cocktail.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#술/칵테일</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=공연전시">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/concert.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#공연/전시</span>
							<!-- </div> -->
						</a>
					</div>
							
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=문화">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/culture.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#문화</span>
							<!-- </div> -->
						</a>
					</div>
							
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=패션">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/fashion.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#패션</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=게임">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/game.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#게임</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=전공직장">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/work.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#전공/직장</span>
						<!-- 	</div> -->
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=영화">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/movie.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#영화</span>
							<!-- </div> -->
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=음악">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/music.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#음악</span>
							<!-- </div> -->
						</a>
					</div>
						
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=사진">
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/picture.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#사진</span>
							<!-- </div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=독서">				
							<!-- <div class="item-box"> -->
								<img src="<c:url value="/resources/images/read.jpg"/>">
								<div class="border-line"></div>
								<span class="supply-comment">#독서</span>
						<!-- 	</div> -->
						</a>
					</div>
					
					<div class="img_box item-box">
						<a href="${location}/club/clubSearch.amg?keyword=기타이색">
							<img src="<c:url value="/resources/images/etc.jpg"/>">
							<div class="border-line"></div>
							<span class="supply-comment">#기타/이색</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value="/resources/script/parallax.js"/>"></script>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>
