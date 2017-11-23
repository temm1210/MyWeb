<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../header/topMenu.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club.css"/>">
<script src="<c:url value="/resources/script/club/club.js"/>"></script>
<title>Insert title here</title>
<script>
	
	$(document).ready(function(){	
		
		/* 동호회 만들고 바로들어올경우 메세지를 띄워줌 */
	 	if( ${msg == "success" } )
			alert("축하합니다! 동호회가 개설되었습니다."); 
		
	});

	function getUserInfo(){
		var clubMaster = $("#clubMaster").text()
		
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
				if(clubMember == ''){
					sessionStorage.setItem('isMember',"none");
					/* 회원가입을 보여주고,회원탈퇴는 숨김 */
					
					$(".leaveClub").addClass("none");
					$(".joinClub").removeClass("none");
				}
				
				/* 동호회 유저라면  isMemeber라는 이름으로 유저정보를 저장(clubMemberVO)*/
				else{
					sessionStorage.setItem('isMember',JSON.stringify(clubMember));
					
					/* 동호회가입 없애고, 탈퇴를 보여줌 */
					$(".leaveClub").removeClass("none");
					$(".joinClub").addClass("none");
					
					/* 동호회 유저중 회장이라면 */
					if(clubMaster == clubMember.cNickname ){
						$(".masterOnly").css("display","inline-block")
					}
				}
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
	.masterOnly{
		display: none;
	}
</style>
<style>
	.none{
		display: none;
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
	
	<div class="contentWrap">
		<div id="aside">
			<ul>
				<li>
					<span><a id="first_link" href="javascript:void(0);" onclick="goHome('${location}/club/board/clubHome.amg?cNum=${cNum}')">동호회홈으로가기</a></span>
				</li>
				<li>
					<span id="clubMasterPic">동호회장</span> 
					<div class="clubMasterInfo">
						<c:choose>
							<c:when test="${club.cMasterPic == null}">
								<div><i class="fa fa-user-circle" style="font-size:80px; color: black; width: 100%; padding: 0;margin-bottom: 5px;" aria-hidden="true"></i></div>				
							</c:when>		
												
							<c:otherwise>
								<img src="${memberImg}/${club.cMasterPic}" style="border-radius:50%;" height="100px" width="100px">
							</c:otherwise>
						</c:choose>
						<span id="clubMaster">${club.cMaster}</span>
					</div>
					<span id="clubDate">생성일:<fmt:formatDate value="${club.cRegdate}" pattern="yyyy-MM-dd"/></span>
				</li>
				<li><span>자유게시판</span>
					<ul class="sub_ul">
						<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=0')"><i class="fa fa-server" aria-hidden="true"></i>전체글보기</a></li>
						<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=1')"><i class="fa fa-server" aria-hidden="true"></i>자기소개</a></li>
						<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=4')"><i class="fa fa-server" aria-hidden="true"></i>자유게시판</a></li>
						<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=2')"><i class="fa fa-server" aria-hidden="true"></i>QnA</a></li>
						<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=3')"><i class="fa fa-server" aria-hidden="true"></i>등업</a></li>
						<li><a class="masterOnly" href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=5')"><i class='fa fa-server' aria-hidden='true'></i>공지사항</a></li>
					</ul>
				</li>
				<li><span><a href="#">멤버리스트보기</a></span></li>
				<li class="joinClub"><span><a href="javascript:getContentAjax('${location}/club/joinClub.amg?cNum=${cNum}')">동호회 가입하기</a></span></li>
				<li class="leaveClub"><span><a href="javascript:getContentAjax('${location}/club/laeveClub.amg?cNum=${cNum}')">동호회 탈퇴하기</a></span></li>
			</ul>
		</div>
		
		<div id="club_content">
			
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="../footer/footer.jsp" %>