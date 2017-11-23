$(document).ready(function(){
	
	/* 처음 동호회들오면 로그인한 유저의 정보를 가져와서 동호회 회원인지 판별 */
	getUserInfo();
	
	/*동호회 페이지에 들어오면, 홈으로가기 버튼을 강제로 클릭해서, 홈화면을 띄워줌*/
	$("#first_link").click();
	
	/*사이드 메뉴에바에서 특정 메뉴 클릭할때*/
	$("#aside > ul > li a").click(function(){
		$(".sub_ul > li > a").removeClass("click");
		$(this).addClass("click");
	})
	
	/* 뒤로,앞으로 버튼 클릭시 */
	$(window).on('popstate', function(event) {
		var data = event.originalEvent.state;
	  
		if(data!=null){
			/* 사이드메뉴 선택이아닌,게시판보는중 뒤로가기하면 게시판에서 SPA처리 */
			if(data.page == "board"){
				if(data.orderWord == '최신순'){
					$("#order > a").removeClass("orderClick");
					$("#order > a:nth-child(1)").addClass("orderClick");
				}else if(data.orderWord == '조회수'){
					$("#order > a").removeClass("orderClick");
					$("#order > a:nth-child(2)").addClass("orderClick");
				}else if(data.orderWord == '좋아요수'){
					$("#order > a").removeClass("orderClick");
					$("#order > a:nth-child(3)").addClass("orderClick");
				}

				$("#boardList").html(data.content);
			
			/* 게시판이아닌 옆에 사이드메뉴가 이전history에 저장되면 club.jsp에서 SPA처리 */
			}else{
				if(data.orderWord == 0){
					$(".sub_ul > li > a").removeClass("click");
					$(".sub_ul > li:nth-child(1) > a").addClass("click");
			 	}else if(data.orderWord == 1){
			 		$(".sub_ul > li > a").removeClass("click");
			 		$(".sub_ul > li:nth-child(2) > a").addClass("click");
			 	}else if(data.orderWord == 2){
			 		$(".sub_ul > li > a").removeClass("click");
			 		$(".sub_ul > li:nth-child(3) > a").addClass("click");
			 	}else if(data.orderWord == 3){
			 		$(".sub_ul > li > a").removeClass("click");
				  $(".sub_ul > li:nth-child(4) > a").addClass("click");
			 	}else if(data.orderWord == 4){
			 		$(".sub_ul > li > a").removeClass("click");
			 		$(".sub_ul > li:nth-child(5) > a").addClass("click");
			 	}else if(data.orderWord == 5){
			 		$(".sub_ul > li > a").removeClass("click");
			 		$(".sub_ul > li:nth-child(6) > a").addClass("click");
			 	}
			  
				$('#club_content').html(data.content);
			}
		}
		else
			history.back();
	}); 	
})

/*동호회 홈으로 가기*/
function goHome(url){
	url+="&ctgLength="+$(".sub_ul > li").length
	getContentAjax(url)
	$(window).scrollTop(180);
}

/* 사이드 메뉴바의 메뉴를 클릭시 거기에 맞는 컨텐츠를 보여줌 */
function getContentAjax(url){
	
	var path = url.substring(url.lastIndexOf('?')+1 , url.length);
	var start = path.indexOf('category');
	/* 사이드메뉴 선택한 메뉴추출 */
	var orderWord = path.substring(path.indexOf('=',start)+1);

	$.ajax({
		type:"GET",
		url:url,
		success:function(content){
			$("#club_content").html(content);
			
			/* 컨트롤러의 기본페이지(club.amg,cnum값...)에서 받는 파라미터 값을 여기에 그대로 적어줘야 뒤로가기 눌렀을때 원하는 결과가나옴 */
			history.pushState({ content:content,page:"content",orderWord:orderWord},'','?'+path)
		}
	});
}
