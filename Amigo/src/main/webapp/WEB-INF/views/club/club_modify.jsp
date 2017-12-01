<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<c:url var="clubImg" value="/resources/images/club_images" />
<style>
	#update_form{
		/* margin:0 auto; */
		padding:40px;
		width:750px;
		text-align:left;
		border:1px solid rgba(0,0,0,.2);
		background-color: rgba(250,250,250,.9);
	}
	
	#update_form > .club_row{
		margin-bottom: 30px;
		padding:40px;
		border-bottom: 1px solid rgba(0,0,0,.2);
	}
	
	#update_form > .club_row > label{
		display: inline-block;
		width: 190px;
		font-size: 16px;
		
	}
	input[type="file"]{
		height:30px;
		font-family: 'Jeju Gothic', serif;
	}
	#update_form > .club_row > input[type="text"]{
		width:300px;
		height:30px;
		font-family: 'Jeju Gothic', serif;
	}
	#update_form > .club_row > input[type="button"],
	#update_form > .club_row > input[type="submit"]{
		font-family: 'Jeju Gothic', serif;
		height:35px;
	}
	.submit_group{
		margin-top:20px;
		margin-bottom:40px;
		text-align: center;
	}
	#hobby{
		height: 30px;
		font-family: inherit;
	}
	.submit_group > input[type="button"],
	.submit_group > input[type="submit"]{
		margin:10px auto;
		width: 20%;
		height: 70px;
		font-size: 16px;
		font-weight: bold;
		color: white;
		border: none;
		background-color: rgba(0,0,0,.8);
	}
	
	input[type='button']:hover,
	input[type='submit']:hover{
		cursor: pointer;
	}
	
	.view{
		display: inline-block;
		color: green;
	}
	.notUpdate{
		border: none;
		background: rgba(250,250,250,.3);
	}
</style>

<script>
	$(document).ready(function(){
		$("#hobby > option:nth-child(${map.club.cHobby})").attr("selected","selected")
		var isChange;
		
		// 동호회 사진이 한번이라도 변경됐을시 
	 	$("#cpic").change(function(){
			$("#isChange").attr("value","change");
		})
	})
	
	function exitPage(path){
		if(confirm("정말로 이 페이지에서 나가시겠습니까?")){
			history.back();
		}
	}
	
</script>
<div id="article">
	<form method="post" action="${location}/club/clubUpdate.amg?${_csrf.parameterName}=${_csrf.token}" id="update_form" enctype="multipart/form-data">
		<span>*은 수정불가능 항목입니다</span>
		<div id="title_field" class="club_row">
			<label for="title">*동호회 제목 </label>
			<input type="text" class="notUpdate" id="title" value="${map.club.cTitle}" name="cTitle" readonly="readonly">
			<span class="input_check"></span>
			<i class="fa fa-check ch" aria-hidden="true"></i>						
		</div>
		
		<div id="content_field" class="club_row">
			<label for="content">동호회 소개글 </label>
			<input type="text" id="content" value="${map.club.cContent}" name="cContent" placeholder="소개글 입력(8자이상)">
			<span class="input_check"></span>	
			<i class="fa fa-check ch" aria-hidden="true"></i>					
		</div>
		
		<div id="name_field" class="club_row">
			<label for="nickname">*회장</label>
			<input type="text" class="notUpdate" id="cNickname" readonly="readonly" value="${map.club.cMaster}" name="cNickname" placeholder="닉네임을 입력하세요(2자이상)">
			<span class="input_check"></span>	
			<i class="fa fa-check ch" aria-hidden="true"></i>					
		</div>
		
		<div id="cpic_field" class="club_row">
			<label for="cpic">동호회 대표사진 </label>
			<input type="file" id="cpic" name="cpic">
			<span class="input_check"></span>				
			<i class="fa fa-check ch" aria-hidden="true"></i>
			<input type="hidden" id="prev_cPic" name="prev_cPic" value="${map.club.cPic}">
			<input type="hidden" id="isChange" name="isChange">		
		</div>
	
		<div id="area_field" class="club_row">
			<label for="area">활동 지역</label>
			<input type="text" name="cAddress" id="cAddress" value="${map.club.cAddress}" readonly="readonly" onfocus="linkToBtn()" onclick="linkToBtn()">
			<i class="fa fa-check ch" aria-hidden="true"></i><br>
			<div id="map" style="width:100%;height:300px;margin:10px 0;"></div>	
		</div>
		
		<div id="hobby_field" class="club_row">
			<label for="hobby">*관심사</label>
			<select name="cHobby" id="hobby" class="notUpdate" disabled="disabled">
				<option value="자연">자연</option>
				<option value="여행캠핑">여행/캠핑</option>
				<option value="자동차">자동차</option>
				<option value="운동스포츠">운동/스포츠</option>
				<option value="동물반려견">동물/반려견</option>
				<option value="공부스터디">공부/스터디</option>
				<option value="스키보드">스키/보드</option>
				<option value="자전거">자전거</option>
				<option value="등산">등산</option>
				<option value="술칵테일">술/칵테일</option>
				<option value="공연전시">공연/전시</option>
				<option value="문화">문화</option>
				<option value="패션">패션</option>
				<option value="게임">게임</option>
				<option value="전공직장">전공/직장</option>
				<option value="영화">영화</option>
				<option value="음악">음악</option>
				<option value="사진">사진</option>
				<option value="독서">독서</option>
				<option value="기타이색">기타/이색</option>
			</select>
			<span class="input_check"></span>
		</div>
		<div class="submit_group">
			<input type="submit" id="updateBtn" value="수정" >
			<input type="button" id="cancelBtn" value="취소" onclick="exitPage('${location}/main.amg')">
		</div>
		
		<input type="hidden" name="cNum" value="${map.club.cNum}">
	</form>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0566b98b4e17dad7a8f0f0aff91a2908&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });
    
    getClubAddress("${map.club.cAddress}")
    
    function getClubAddress(data){
        // 주소로 상세 정보를 검색
        geocoder.addressSearch(data, function(result, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === daum.maps.services.Status.OK) {
                // 해당 주소에 대한 좌표를 받아서
                var coords = new daum.maps.LatLng(result[0].y, result[0].x);
                
    		    // 결과값으로 받은 위치를 마커로 표시합니다
    		    var marker = new daum.maps.Marker({
    		        map: map,
    		        position: coords
    		    });
    		    
    		    // 인포윈도우로 장소에 대한 설명을 표시합니다
    		    var infowindow = new daum.maps.InfoWindow({
    		        content: '<div style="width:150px;text-align:center;padding:6px 0;">'+data+'</div>'
    		    });
    		    infowindow.open(map, marker);
    		    
                // 지도 중심을 변경한다.
                map.setCenter(coords);
                // 마커를 결과값으로 받은 위치로 옮긴다.
                marker.setPosition(coords)
            }
        });
    }

	function linkToBtn(){
		/* $("#addr_btn").trigger("click") */
		getPostcode()
	}
    function getPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("cAddress").value = fullAddr;
                
                //주소를 맵에 뿌려줌
                getClubAddress(fullAddr);
            }
        }).open();
    }
</script>