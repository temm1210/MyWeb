<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../header/topMenu.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club.css"/>">
<script src="<c:url value="/resources/script/club/club.js"/>"></script>
<title>Insert title here</title>
<script>
	
	$(document).ready(function(){	
		// 처음 동호회들오면 로그인한 유저의 정보를 가져와서 동호회 회원인지 판별 
		getUserInfo();
		
		/* 동호회 만들고 바로들어올경우 메세지를 띄워줌 */
	 	if( ${msg == "success" } )
			alert("축하합니다! 동호회가 개설되었습니다.");
	
	});
	
	function clubDeleteAjax(path){
		if(confirm("정말 동호회를 삭제하시겠습니까? 삭제후 복구는 불가능합니다. '확인'을 누르시면 바로 삭제됩니다")){
			$.ajax({
				type:"get",
				url:path,
				success:function(msg){
					alert(msg)
					location.href="${location}/club/clubSearch.amg";
				}
				
			});
		}//if
	}
	
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
				
				$(".userNickName").text(clubMember.cNickname)
					
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
					
					/* 동호회 유저중 매니저나 부매니저라면 */
					if(clubMember.cGrade == 1 || clubMember.cGrade == 2){
						$(".leaveClub").addClass("none");
						$(".deleteClub").removeClass("none");
						$(".clubUpdate").removeClass("none");
						$(".masterOnly").css("display","inline-block");
					}
				}
				if(userName=="STW"){
					$(".deleteClub").removeClass("none");
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
		<div id="img_wrap"></div>	
	</div>
	
	<input type="hidden" id="clubTitle" value="${club.cTitle}"/>
	<input type="hidden" id="clubContent" value="${club.cContent}"/>
	<div class="clubContent">
		<div class="contentWrap">
			<div id="aside">
				<ul>
					<li class="none clubUpdate">
						<span><a id="first_link" href="javascript:void(0);" onclick="goHome('${location}/club/board/clubHome.amg?cNum=${cNum}')">동호회홈</a></span>
					</li>
					
					<li class="none clubUpdate">
						<span><a href="javascript:getContentAjax('${location}/club/getClub.amg?cNum=${cNum}')">동호회 수정</a></span>
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
							<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=2')"><i class="fa fa-server" aria-hidden="true"></i>QnA</a></li>
							<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=3')"><i class="fa fa-server" aria-hidden="true"></i>등업</a></li>
							<li><a href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=4')"><i class="fa fa-server" aria-hidden="true"></i>자유게시판</a></li>						
							<li><a class="masterOnly" href="javascript:getContentAjax('${location}/club/board/boardContent.amg?cNum=${cNum}&curPage=1&category=5')"><i class='fa fa-server' aria-hidden='true'></i>공지사항</a></li>
						</ul>
					</li>
					<li><span><a href="javascript:getContentAjax('${location}/clubMember/memberList.amg?cNum=${cNum}')">멤버리스트보기</a></span></li>
					<li class="joinClub"><span><a href="javascript:getContentAjax('${location}/club/joinClub.amg?cNum=${cNum}')">동호회 가입하기</a></span></li>
					<li class="leaveClub"><span><a href="javascript:getContentAjax('${location}/club/laeveClub.amg?cNum=${cNum}')">동호회 탈퇴하기</a></span></li>
					<li class="deleteClub none"><span><a href="javascript:clubDeleteAjax('${location}/club/getClub.amg?cNum=${cNum}')">동호회 삭제하기</a></span></li>
				</ul>
			</div>
			
			<div id="club_content">
				
			</div>
		</div>	
		
		<div id="wraper">
			<input type="text" id="clubArea" value="${club.cAddress}">
			<div id="map" style="width:90%;height:300px;margin:0 auto;"></div>
		</div>
	</div>
</div>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0566b98b4e17dad7a8f0f0aff91a2908&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  
	
	//지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	
	//동호회 주소를 불러옴
	var clubAddress = document.getElementById("clubArea").value;
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	//주소로 좌표를 검색합니다
	//동호회 주소를 대입
	geocoder.addressSearch(clubAddress, function(result, status) {
		
		// 정상적으로 검색이 완료됐으면 
		 if (status === daum.maps.services.Status.OK) {
		
		    var coords = new daum.maps.LatLng(result[0].y, result[0].x);
		
		    // 결과값으로 받은 위치를 마커로 표시합니다
		    var marker = new daum.maps.Marker({
		        map: map,
		        position: coords
		    });
		
		    // 인포윈도우로 장소에 대한 설명을 표시합니다
		    var infowindow = new daum.maps.InfoWindow({
		        content: '<div style="width:150px;text-align:center;padding:6px 0;">동호회 활동지역</div>'
		    });
		    infowindow.open(map, marker);
		
		    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		    map.setCenter(coords);
		} 
	});
	

</script>
</html>
<%@ include file="../footer/footer.jsp" %>