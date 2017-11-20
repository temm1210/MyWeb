<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club.css"/>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function(){	
		
		getUser();
		$(".sub_ul > li:first-child > a").get(0).click();
		
	 	if( ${msg == "success" } )
			alert("축하합니다! 동호회가 개설되었습니다."); 
		
		$(window).on('popstate', function(event) {
			  var data = event.originalEvent.state;
			  
			  if(data!=null)
			  	  $('#club_content').html(data.content);
			  else
				  history.back();
		});
			
   		 $(".sub_ul > li > a").click(function(){
			$(".sub_ul > li > a").removeClass("click");
			$(this).addClass("click");
		})   
	});
	
	 
	
	function getUser(){
		var data={
				userName:"${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}",
				cNum:${cNum}
		};

		$.ajax({
			type:"POST",
			url:"${location}/clubMember/getNickname.amg",
		 	headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data), 
			success:function(clubMember){
		
				/* 동호회 유저가 아니라면 */
				if(clubMember == '')
					sessionStorage.setItem('isMember',"none");
				
				/* 동호회 유저라면  */
				else
					sessionStorage.setItem('isMember',JSON.stringify(clubMember));		
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	}
	
	function getContentAjax(url){
		var path = url.substring(url.lastIndexOf('?')+1 , url.length);
			
		$.ajax({
			type:"GET",
			url:url,
			success:function(content){
		
				$("#club_content").html(content);
				/* $(window).scrollTop(200); */ 
				/* 컨트롤러의 기본페이지(club.amg)에서 받는 파라미터 값을 여기에 그대로 적어줘야 뒤로가기 눌렀을때 원하는 결과가나옴 */
				history.pushState({ content:content },'','?'+path)
			}
		});
		
	}
</script>
<style>
   	#img_wrap{
		background-image: url("<c:url value='/resources/images/club_images/${club.cPic}'/>");
		background-position: center;
		background-size: contain;
		opacity: 0.9;
		width: 100%;
		height: 400px; 
	}
</style>
</head>
<body>
<div id="container">
	<div id="club_pic">
		<div id="img_wrap">
			<h2>${club.cTitle}</h2>
		</div>	
	</div>
	<div id="aside">
		<ul>
			<li><span>자유게시판</span>
				<ul class="sub_ul">
					<li><a class="click" href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${cNum}&curPage=1')"><i class="fa fa-server" aria-hidden="true"></i>전체글보기</a></li>
					<li><a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${cNum}&curPage=1&category=1')"><i class="fa fa-server" aria-hidden="true"></i>자기소개</a></li>
					<li><a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${cNum}&curPage=1&category=4')"><i class="fa fa-server" aria-hidden="true"></i>자유게시판</a></li>
					<li><a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${cNum}&curPage=1&category=2')"><i class="fa fa-server" aria-hidden="true"></i>QnA</a></li>
					<li><a href="javascript:getContentAjax('${location}/club/board/boardListAll.amg?cNum=${cNum}&curPage=1&category=3')"><i class="fa fa-server" aria-hidden="true"></i>등업</a></li>
				</ul>
			</li>
			<li><span><a href="#">멤버리스트보기</a></span></li>
			<li><span><a href="javascript:getContentAjax('${location}/club/joinClub.amg?cNum=${cNum}')">동호회 가입하기</a></span></li>
		</ul>
	</div>
	
	<div id="club_content">

	</div>
</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>