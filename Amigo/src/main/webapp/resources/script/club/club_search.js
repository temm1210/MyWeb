var orderByCriteria='date';
$(document).ready(function(){

	/* 현재페이지 값을 저장하는 쿠키값이 아무것도 없다면 기본 1로셋팅(1페이지 값의 동호회를 불러옴) */
	if($.cookie("curPage") == null) 
		$.cookie("curPage",1);

	/* 새로고침 유무를 위한쿠키. 처음페이지 로딩과 동시에 false로셋팅 */
	if($.cookie("isRefresh") == null)
		$.cookie("isRefresh",false);
	
	/* 페이지 로드시 동호회 리스트를 불러옴  */
	getClubsAjax();
	
	/* 새로고침 눌렀을시 새로고침쿠키를 true로 설정 */
	$(document).keydown(function(e){
		if(e.which === 116)
			$.cookie("isRefresh",true);		
	})  
	
	$("#btn_search").click(function(){
		var titleSearch = $("#titleSearch").val();
		var hobbySearch = $("#hobbySearch").val();
		var addressSearch = $("#addressSearch").val();
		
		alert(titleSearch+","+hobbySearch+","+addressSearch)
	})
	
	/* 페이지에서 나갈시 쿠키값 삭제 */
	$(window).on('beforeunload', function(){
		/* 새로고침 클릭시는 해당이벤트 비활성화 */
		if($.cookie("isRefresh") == 'false') {
			var cookies = $.cookie();
			for(var cookie in cookies)
				$.removeCookie(cookie);
		}
	});
	
	/* 뒤로가기 버튼눌렀을때 Ajax요청으로 가져온 이전 부분만 출력 (SPA랑비슷) */
	$(window).on('popstate', function(event) {
		
	  var data = event.originalEvent.state;
	  
	  /* history에 이전데이터의 자료들이 남아있으면 Ajax요청다시안하고 그 데이터를 바로가져옴 속도향상 */
	  /* 뒤로가기나,앞으로가기 버튼클릭시 해당페이지 값으로 쿠키 재설정 */
	  if(data!=null){
	  	  $('.club-wrap').html(data.clubs);
	  	  $.cookie("curPage",data.curPage);
	  }
	  else
		  history.back();
	});
})

function getOrderByWord(word){
	orderByCriteria = word;
	getClubsAjax();
}

function moveForPage(movePage){
	$.cookie("curPage",movePage);
	getClubsAjax();
}

/* 제목검색,취미검색,주소검색,페이지를 넘겨서 아작스방식으로 동호회리스트를 가져옴 */
function getClubsAjax(){

	var titleSearch = $("#titleSearch").val();
	var hobbySearch = $("#hobbySearch").val();
	var addressSearch = $("#addressSearch").val();
	var curPage = $.cookie("curPage");

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
 			if($.cookie("isRefresh") == 'true'){
				$.cookie("isRefresh",false);
 			}else{
 				history.pushState({ clubs: clubs,curPage:curPage}, '', '')
 			}		
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}