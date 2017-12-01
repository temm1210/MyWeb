$(document).ready(function(){
	
	//동호회 페이지에 들어오면, 홈으로가기 버튼을 강제로 클릭해서, 홈화면을 띄워줌
	$("#first_link").click();
	
	/*사이드 메뉴에바에서 특정 메뉴 클릭할때*/
	$("#aside > ul > li a").click(function(){
		$("#aside > ul > li a").removeClass("click");
		$(this).addClass("click");
	})
	
	/* 뒤로,앞으로 버튼 클릭시 */
	$(window).on('popstate', function(event) {
		var data = event.originalEvent.state;
	    var orderWordArray=['최신순','조회수','좋아요수']
	    
	    var $anchorLink;
		if(data!=null){
			//사이드메뉴 선택이아닌,게시판보는중 뒤로가기하면 게시판에서 SPA처리 
			if(data.page == "board"){
				$anchorLink = $("#order > a")
				$.each($anchorLink,function(index,element){
					if(data.orderWord == orderWordArray[index]){
						$anchorLink.removeClass("orderClick")
						$(element).addClass("orderClick")
					}
				});
				
				//뒤로가기 눌렀을때 보여줄 페이지 설정
				$("#boardList").html(data.content);	
			//게시판이아닌 옆에 사이드메뉴가 이전history에 저장되면 club.jsp에서 SPA처리 */
			}else if(data.page == "content"){
				$anchorLink = $(".sub_ul > li ")
				$.each($anchorLink,function(index,element){
					if(data.orderWord == index){
						$anchorLink.children("a").removeClass("click");
						$(element).children("a").addClass("click")
					}
				})			
				//뒤로가기 눌렀을때 보여줄 페이지 설정
				$('#club_content').html(data.content);
			}else if(data.page == "reply"){
				//뒤로가기 눌렀을때 보여줄 페이지 설정
				$("#replyList").html(data.content)
			}
			
		}
		else
			history.back();
	}); //	$(window).on('popstate')
})

/*동호회 홈으로 가기*/
function goHome(url){
	url+="&ctgLength="+$(".sub_ul > li").length
	getContentAjax(url)
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
			$(window).scrollTop(450);
			
			if(sessionStorage.getItem('isClubRefresh') == "true"){
 				sessionStorage.setItem('isClubRefresh',false);
 			}else{
 			// 컨트롤러의 기본페이지(club.amg,cnum값...)에서 받는 파라미터 값을 여기에 그대로 적어줘야 뒤로가기 눌렀을때 원하는 결과가나옴 
 				history.pushState({ content:content,page:"content",orderWord:orderWord},'','?'+path)
 			}	
			
		}
	});
}
