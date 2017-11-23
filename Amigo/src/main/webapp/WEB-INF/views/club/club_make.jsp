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
		background-image: url("${img}/club_form.jpg");
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
						<input type="text" id="title" name="cTitle" placeholder="동호회제목 입력(3자이상)">
						<span class="input_check"></span>
						<i class="fa fa-check ch" aria-hidden="true"></i>						
					</div>
					
					<div id="content_field" class="club_row">
						<label for="content">동호회 소개글 </label>
						<input type="text" id="content" name="cContent" placeholder="소개글 입력(8자이상)">
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
						<i class="fa fa-check ch" aria-hidden="true"></i>		
					</div>
				
					<div id="area_field" class="club_row">
						<label for="area">활동 지역</label>
						<input type="text" name="cAddress" id="cAddress" placeholder="주소입력:여기를 클릭해주세요" readonly="readonly" onfocus="linkToBtn()" onclick="linkToBtn()">
						<!-- <input type="button" id="addr_btn" onclick="sample5_execDaumPostcode()" value="주소 검색"> --> 
						<i class="fa fa-check ch" aria-hidden="true"></i><br>
						<div id="map" style="width:100%;height:300px;margin:10px 0;display:none"></div>	
					</div>
					
					<div id="hobby_field" class="club_row">
						<label for="hobby">관심사</label>
						<select name="cHobby" id="hobby">
							<option value="자연" selected>자연</option>
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
						<input type="button" id="joinBtn" value="만들기" onclick="makeClub('${location}/club/insertClub.amg?${_csrf.parameterName}=${_csrf.token}')">
						<input type="button" id="cancelBtn" value="취소" onclick="exitPage('${location}/main.amg')">
					</div>
					
					<input type="hidden" name="cGrade" value="매니저">
				</form>
			</div>
		</div>
	</div>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0566b98b4e17dad7a8f0f0aff91a2908&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
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
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
</html>

<%@ include file="../footer/footer.jsp" %>