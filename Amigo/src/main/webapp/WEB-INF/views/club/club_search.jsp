<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../header/topMenu.jsp"%>
<script src="<c:url value="/resources/script/club/club_search.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_search.css"/>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function(){				
		//맵에 클러스트 표시를 해주기위해 처음에 주소를 가져와서 맵에뿌려주는 AJAX시행 
		getAddressAjax()
	});
	
	/* 제목검색,취미검색,주소검색,페이지를 넘겨서 아작스방식으로 동호회리스트를 가져옴 */
	function getClubsAjax(curPage,cNumJSONArray){
		
		var data
		
		var titleSearch = $("#titleSearch").val();
		var hobbySearch = $("#hobbySearch").val();
		var addrSearch = $("#addrSearch").val();
		var orderByCriteria =$(".click").text();
		var curPage = curPage;
		var clubNumList;
		/* 넘어온 파라미터들을 JSON형식으로 파싱 */
		if(cNumJSONArray != null){
			data={
				titleSearch:titleSearch,
				hobbySearch:hobbySearch,
				addrSearch:addrSearch,
				orderByCriteria:orderByCriteria,
				curPage:curPage,
				clubNumList:cNumJSONArray.clubNumber
			};
		}
		else{
			data={
				titleSearch:titleSearch,
				hobbySearch:hobbySearch,
				addrSearch:addrSearch,
				orderByCriteria:orderByCriteria,
				curPage:curPage
			};
		}
		
		$.ajax({
			type:"POST",
			url:"${location}/club/clubsList.amg",
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			data:JSON.stringify(data),	
			success:function(clubs){
	 			$(".club-wrap").html(clubs);
	 		
	 			/* 새로고침을 눌렀을시에는 현재페이지를 history에 저장하지 않음 */
	 			if(sessionStorage.getItem('isRefresh') == "true"){
	 				sessionStorage.setItem('isRefresh',false);
	 			}else{
	 				history.pushState({ clubs: clubs,curPage:curPage}, '', '?page='+curPage)
	 			}	
			}
		})
	}
	
	
	// DB상에서 조건에 맞는 주소를 가져옴
	function getAddressAjax(){
		
		var data= {
			hobbySearch:$("#hobbySearch").val(),
			titleSearch:$("#titleSearch").val(),
			addrSearch:$("#addrSearch").val()
		}

		
		$.ajax({
			type:"POST",
			url:"${location}/club/getClubAddress.amg",
			headers:{
				"Content-Type":"application/json; charset=UTF-8"
			},
			dataType:"JSON",
			data:JSON.stringify(data),
			success:function(address){				
				//주소를 저장하는 리터럴 객체를 만듬
 				var locationJSON = {
						"address":address
				}
				//가져온 모든주소가 저장된 리터럴 객체를 좌표로 바꾸기위해 함수실행
				changeToLatLng(locationJSON)  
			}
		})
	}
</script>
<body>
	<div id="container">
		<div id="content">
			<div id="article1">
				<h2>동호회 검색</h2>
				<div class="input_box row_1">
					<label for="titleSearch">제목 검색</label>
					<input type="text" id="titleSearch" name="titleSearch">
				</div>
				
				<div class="input_box row_2">
					<label for="hobbySearch">카테고리</label>
					<select name="hobbySearch" id="hobbySearch">
						<option value="all" <c:out value="${keyword == null?'selected':''}"/>>전체</option>
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
					<input type="text" name="addrSearch" id="addrSearch">
				</div>
				
				<input type="button" id="btn_search" value="검색">
				<input type="button" style="margin-left:10px;" id="btn_all" value="전체검색">
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
		
		<div id="mpaContainer">
			<div id="map" style="width:100%;height:800px;position: fixed;"></div>
			
			<p id="mapTransInfo">
				<input type="checkbox" id="chkTraffic" onclick="setOverlayMapTypeId()" /> 교통정보 보기
				<input type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" /> 자전거도로 정보 보기   
			</p>
		</div>
	</div>	<!-- container -->
	<input type="hidden" id="page" value="${page}">
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0566b98b4e17dad7a8f0f0aff91a2908&libraries=services,clusterer"></script>
<script>
	//다음맵 생성
	var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	    center : new daum.maps.LatLng(37.20446357557853,137.13464871597167), // 지도의 중심좌표
	    level : 14 // 지도의 확대 레벨
	});
	var mapTypeControl = new daum.maps.MapTypeControl();
	
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPLEFT);
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.LEFT);
	
	//지도 타입 정보를 가지고 있을 객체입니다 
	//map.addOverlayMapTypeId 함수로 추가된 지도 타입은
	//가장 나중에 추가된 지도 타입이 가장 앞에 표시됩니다
	//이 예제에서는 지도 타입을 추가할 때 지적편집도, 지형정보, 교통정보, 자전거도로 정보 순으로 추가하므로
	//자전거 도로 정보가 가장 앞에 표시됩니다
	var mapTypes = { 
		traffic :  daum.maps.MapTypeId.TRAFFIC,
		bicycle : daum.maps.MapTypeId.BICYCLE,
	};
	//-----------------------------다음맵생성 끝-------------------------------
	
	//-----------------------------클러스터 만들기------------------------------
	var clusterer = new daum.maps.MarkerClusterer({
	      map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
	      averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
	      minLevel: 6, // 클러스터 할 최소 지도 레벨
	      disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
	});
	
	
	//-----------------------------geocoder객체 만들기--------------------------
	var geocoder = new daum.maps.services.Geocoder();
	
	//기본 마커의 이미지 정보를 가지고있는변수.
	var markerImage= new daum.maps.MarkerImage(
		   '${location}/resources/images/marker.png',
		   new daum.maps.Size(31, 40),
		   new daum.maps.Point(16, 40)
	);
	
   // 마커에 마우스오버시의 이미지 정보를 가지고있는 변수
   var overMarkerImage= new daum.maps.MarkerImage(
		   '${location}/resources/images/marker2.png',
		   new daum.maps.Size(36, 40),
		   new daum.maps.Point(18, 40)
	);
	//지도에 존재하는 마커를 저장하는 변수
	var markers;
	
	//맵에있는 모든 인포윈도우를 저장하는 변수
	var infowindowArray;
	
	//인포윈도우가 활성화된 상태인지 체크
	var viewInfowindow = false;
	
 	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
 		removeAllInfowindow()
	}); 
	//중심 좌표나 확대 수준이 변경되면 발생한다.단, 애니메이션 도중에는 발생하지 않는다.
 	daum.maps.event.addListener(map, 'idle', function(){           
	    // 지도 영역정보를 얻어옵니다 
	    var bounds = map.getBounds();
	    
	    // 영역정보의 남서쪽 정보를 얻어옵니다 
	    var swLatlng = bounds.getSouthWest();
	    
	    // 영역정보의 북동쪽 정보를 얻어옵니다 
	    var neLatlng = bounds.getNorthEast();
	  
	    // 맵의 현재 bounds를 가져옴
	  	var cBounds = map.getBounds();

	    if(!viewInfowindow)
	    	afterZoomInOut(cBounds)
	  
	}); 
	
	
	// 체크 박스를 선택하면 호출되는 함수입니다
	function setOverlayMapTypeId() {  
		
	    var chkTraffic = document.getElementById('chkTraffic'),
	        chkBicycle = document.getElementById('chkBicycle');

	    // 지도 타입을 제거합니다
	    for (var type in mapTypes) {
	        map.removeOverlayMapTypeId(mapTypes[type]);    
	    }

	    // 교통정보 체크박스가 체크되어있으면 지도에 교통정보 지도타입을 추가합니다
	    if (chkTraffic.checked) {
	        map.addOverlayMapTypeId(mapTypes.traffic);    
	    }
	    
	    // 자전거도로정보 체크박스가 체크되어있으면 지도에 자전거도로정보 지도타입을 추가합니다
	    if (chkBicycle.checked) {
	        map.addOverlayMapTypeId(mapTypes.bicycle);    
	    }
	    
	}  
	
	//특정동호회 마우스 오버시 보여줄 마커
	var clubMarker;
	var isView = true
	
	//특정동호회에서 마우스 벗어나면 마커지움
	function hideMarkers(){
		if(!isView){
			clubMarker.setMap(null);
			isView = true;
		}

	}
	
	//맵위에 존재하는 모든 infowindow 닫음
	function removeAllInfowindow(){
		$.each(markers,function(index,marker){
			infowindowArray[index].Infowindow.close();
		});
	}
	//동호회에 마우스 오버했을때 마커를 표시해주기위한 함수
	function showMarker(address){
		if(isView){
			geocoder.addressSearch(address, function(result,status){
				if (status === daum.maps.services.Status.OK) {
					
					var coords = new daum.maps.LatLng(result[0].y, result[0].x);
					
					//띄워줄 마커를 새로생성
		         	clubMarker = new daum.maps.Marker({
			            map: map,
			            position: coords,
			            image:overMarkerImage
			        });
					isView=false;
				}//첫번째 if
			});
		}
	}
	
	// 클러스터에 뿌려주기위해  주소를 좌표로 반환해주는 함수
	function changeToLatLng(locationJSON){	
		
		//위치정보를 저장하는 배열
		var latLngArray = new Array();
		
		//가져온 주소의 갯수
		var lastIndex = locationJSON.address.length;
		
		//검색된 동호회가 하나도없으면 맵에서 클러스터 모두제거
		if(lastIndex == 0){
			clusterer.clear();
		}
		
		//가져온 주소를의 개수만큼 실행
		$.each(locationJSON.address,function(key,value){

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(value.cAddress, function(result,status){
				
				 // 정상적으로 검색이 완료됐으면 
			   	if (status === daum.maps.services.Status.OK) {	
			   		
			   		//좌표값을 배열에 대입
		 	    	latLngArray.push({
			    		"lat":result[0].y,
			    		"lng":result[0].x,
			    		"club":value
			    	})

			   		//주소 -> 좌표 작업이 다 끝났는지 확인
			   	 	if( lastIndex == latLngArray.length){
			   	 		
			   	 		//주소값 저장한 배열을 리터럴 객체의 value값으로 대입.
				    	var latLngJSON = {
				 	    		"positions":latLngArray
					   	};	
				    	//주소 -> 좌표 완료후 클러스터표시
				    	addressCluster(latLngJSON);
			   	 	}
			   	 }			
			});
		});//$.each문
	}
	  
	//주소를 저장할 JSON
	var cNumJSON;
	
	//맵의 중심 좌표나 확대 수준이 변경될때
 	function afterZoomInOut(cBounds){
		var cNumArray = new Array();
		//마커가 있다면		
		if(markers != null){
			$.each(markers,function(index,marker){
		    	if( cBounds.contain(marker.getPosition()) ){
		    		cNumArray.push({
		    			"cNum":marker.getTitle()
		    		});	
		    	}
			});
			
			var newcNumJSON={
				"clubNumber":cNumArray
			}

			//JSON을 서로비교해서 이전데이터랑 같으면 동호회 리스트 가져오는 아작스 실행안함
			if(JSON.stringify(newcNumJSON) != JSON.stringify(cNumJSON) ){	
				cNumJSON = newcNumJSON;	 
				getClubsAjax(1,cNumJSON)
		
			}
		}//if(markers != null)
	} 

	function addressCluster(data){
		
		infowindowArray = new Array();
		//기존에 추가된 모든마커 제거
		clusterer.clear();
		
        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        markers = $(data.positions).map(function(i, position) {
            return new daum.maps.Marker({
                 position: new daum.maps.LatLng(position.lat, position.lng),
            	 title: position.club.cNum,
            	 image:markerImage
            });
        }); 
        
        
        $.each(markers,function(index,marker){
        	//infowindow에 띄워줄 HTML
         	var str='<div class="mapClub item-box" style="height:200px; width:300px; margin-left:-12px; padding:0 10px; margin-top:20px;">';
        		str+='<div class="item-box">';
        		str+='<div class="club_row">';
        		str+='<a href="${location}/club/club.amg?cNum='+data.positions[index].club.cNum+'">';
        		str+='<div class="club-box">';
        		str+='<div id="img_club" style="background-image:url(${clubImg}/'+data.positions[index].club.cPic+')" ></div>';
        		str+='</div>';
        		
        		str+='<div class="item_comment">';
        		str+='<p class="club_title">'+data.positions[index].club.cTitle+'</p><br/><br/><br/>';
        		str+='<p class="club_master">'; 
      
        		if(data.positions[index].club.cMasterPic == null){
        			str+='<i class="fa fa-user-circle master_pic" style="font-size:70px;" aria-hidden="true"></i>';	
        		}
        		else{
        			str+='<img src="${memberImg}/'+data.positions[index].club.cMasterPic+'" class="master_pic">';
        		}
   
        		str+='<span class="club_masterPic">'+data.positions[index].club.cMaster+'</span>';
        		str+='<p class="club_intro">'+data.positions[index].club.cContent+'</p>';
        		str+='<p>'+data.positions[index].club.cAddress+'</p>';
        		str+='<p><fmt:formatDate value='+data.positions[index].club.cRegdate+' pattern="yyyy-MM-dd HH:mm:ss"/>';
        		str+='<input type="hidden" class="cAddress" value='+data.positions[index].club.cAddress+'>';
        		str+='</div></a></div>';
        		str+='<i class="fa fa-user clubs_detail" aria-hidden="true">'+data.positions[index].club.memberCount+'</i>';
        		str+='<i class="fa fa-folder clubs_detail" aria-hidden="true">'+data.positions[index].club.boardCount+'</i>';
        		str+='</div></div>';
        	//인포윈도우설정. 눌렀을때 보여줄 Content와 눌렀을떄 x버튼을 나타내기위해 removeable를 설정
            var iwContent = str, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    			iwRemoveable = true; 
                    
            //설정한 내용을 기준으로 인포윈도우 설정.
	        var infowindow = new daum.maps.InfoWindow({
		         content: iwContent,
		         removable : iwRemoveable
	        });
	        infowindowArray.push({
	        	"Infowindow":infowindow
	        })
            //각마커에 클릭이벤트 등록
	        daum.maps.event.addListener(marker, 'click', function() {
	        	// 열려있는 인포윈도우 제거
	        	removeAllInfowindow();
	            // 마커 위에 인포윈도우를 표시합니다
	            viewInfowindow=true;
	            infowindow.open(map, marker);
	           
	      	});
	        
	        //각마커에 마우스오버 이벤트를 등록합니다
	        daum.maps.event.addListener(marker, 'mouseover', function() {    		
        	    marker.setImage(overMarkerImage);
        	}); 
	        
	     	// 각마커에 마우스아웃 이벤트를 등록합니다
	        daum.maps.event.addListener(marker, 'mouseout', function() {
	            // 마커에 마우스아웃 이벤트가 발생하면 기본마커이미지 가져옴
	        	marker.setImage(markerImage);
	        });
        
        })
        
	    // 클러스터러에 마커들을 추가합니다
        clusterer.addMarkers(markers);
	    
	    //맵에 마커를 새로그림
		clusterer.redraw();
		
	    // 마커 클러스터러에 클릭이벤트를 등록합니다
	    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
	    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
	    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

	        // 현재 지도 레벨에서 1레벨 확대한 레벨
	        var level = map.getLevel()-1;

	        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
	        map.setLevel(level, {anchor: cluster.getCenter()});
		});
	}
</script>
</html>