$(document).ready(function(){
	/*요청페이지를 가져옴*/
	var curPage = $("#page").val();
	
	/*새로고침 유무를 세션스토리지에 저장해서, 새로고침 클릭시 현재페이지는 history에 저장안함*/
	if(sessionStorage.getItem('isRefresh') == null)
		sessionStorage.setItem('isRefresh',false);
	
	/* 페이지 로드시 동호회 리스트를 불러옴  */
	getClubsAjax(curPage);
	
	/* 새로고침 눌렀을시 isRefresh세션스토리지 true로 설정 */
	$(document).keydown(function(e){
		if(e.which == 116)
			sessionStorage.setItem('isRefresh',true);	
	})  
	
	$("#btn_search").click(function(){
		getClubsAjax(curPage);
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

/* 제목검색,취미검색,주소검색,페이지를 넘겨서 아작스방식으로 동호회리스트를 가져옴 */
function getClubsAjax(curPage){

	var titleSearch = $("#titleSearch").val();
	var hobbySearch = $("#hobbySearch").val();
	var addressSearch = $("#addressSearch").val();
	var orderByCriteria =$(".click").text();
	var curPage = curPage;

	/* 넘어온 파라미터들을 JSON형식으로 파싱 */
	var data={
			titleSearch:titleSearch,
			hobbySearch:hobbySearch,
			addressSearch:addressSearch,
			orderByCriteria:orderByCriteria,
			curPage:curPage
	};
	
	$.ajax({
		type:"POST",
		url:"clubsList.amg",
		headers:{
			"Content-Type":"application/json; charset=UTF-8"
		},
		data:JSON.stringify(data),	
		success:function(clubs){
		
 			$(".club-wrap").html(clubs);
 			$(window).scrollTop(0); 
 			
 			/* 새로고침을 눌렀을시에는 현재페이지를 history에 저장하지 않음 */
 			if(sessionStorage.getItem('isRefresh') == "true"){
 				sessionStorage.setItem('isRefresh',false);
 			}else{
 				history.pushState({ clubs: clubs,curPage:curPage}, '', '?page='+curPage)
 			}	
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}