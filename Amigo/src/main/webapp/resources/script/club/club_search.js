$(document).ready(function(){
	//새로고침 유무를 세션스토리지에 저장해서, 새로고침 클릭시 현재페이지는 history에 저장안함
	if(sessionStorage.getItem('isRefresh') == null)
		sessionStorage.setItem('isRefresh',false);
	
	// 새로고침 눌렀을시 isRefresh세션스토리지 true로 설정 
	$(document).keydown(function(e){
		if(e.which == 116)
			sessionStorage.setItem('isRefresh',true);	
	})  
	
	//전체검색 버튼클릭시
	$("#btn_all").click(function(){
			//검색옵션 전부초기화
			$("#titleSearch").val('');
			$("#hobbySearch").val('all');
			$("#addrSearch").val('')
			
			getClubsAjax(1,null);
			
			//동호회 주소불러와서 map에 뿌려주는 AJAX
			getAddressAjax();
	})
	
	//검색버튼 클릭시
	$("#btn_search").click(function(){
		//동호회 리스트불러오는 AJAX
		getClubsAjax(curPage,cNumJSON);
		
		//동호회 주소불러와서 map에 뿌려주는 AJAX
		getAddressAjax();
		
		//검색후 맵을 초기상태로 돌려놓음
		map.setCenter(new daum.maps.LatLng(37.20446357557853,137.13464871597167));
		map.setLevel(14)
	})
	
	/* 뒤로가기 버튼눌렀을때 Ajax요청으로 가져온 이전 부분만 출력 (SPA랑비슷) */
	$(window).on('popstate', function(event) {
		
	  var data = event.originalEvent.state;
	  
	  /* history에 이전데이터의 자료들이 남아있으면 Ajax요청다시안하고 그 데이터를 바로가져옴 속도향상 */
	  /* 뒤로가기나,앞으로가기 버튼클릭시 해당페이지 값으로 sessionStorage 재설정 */
	  if(data!=null){
	  	  $('.club-wrap').html(data.clubs);
	  	  curPage = data.curPage
	  }
	  else
		  history.back();
	});
	
	$(".club_category > a").click(function(){
		$(".club_category > a").removeClass("click");
		$(this).addClass("click");
		getClubsAjax(1)
	})
})
function goPagingPage(curPage){
	$(window).scrollTop(85);
	getClubsAjax(curPage,cNumJSON)
	 
}
