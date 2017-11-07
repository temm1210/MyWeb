$(document).ready(function(){
	 
	/* 동호회 제목 체크 */
	$("#title").stop().blur(function(){
		 checkValue(this,"이름을 입력하세요",5)
	})
	/* 소개글체크 */
	$("#content").stop().blur(function(){
		 checkValue(this,"소개글을 입력하세요",10)
	})
	/*닉네임 체크*/
	$("#cNickname").stop().blur(function(){
		 checkValue(this,"닉네임을 입력하세요",2)
	})
})

/* 만들기 버튼 클릭시 */
function makeClub(path){
	var i = 0;
	var icons = $(".ch");
	
	$.each(icons,function(index,value){
		if( $(value).hasClass("view") )
			i++;
	})
	
	if(i == icons.length )
		$("#club_form").attr("action",path).submit();
	else
		alert("모두 올바르게 입력 하셔야 합니다.");
}

/* 취소버튼 클릭시  */
function exitPage(path){
	if(confirm("이 페이지에서 나가시겠습니까?"))
		$("#club_form").attr("method","get").attr("action",path).submit(); 
}
function checkValue(sel,errorStr,condition){
	 var value =$(sel).val();
	 var $sel_parent = $(sel).parent();
	 
	 if(value == '' || value.length < condition)
		 errorCheckEffect(errorStr,$sel_parent);
	 else
		 successCheckEffect($sel_parent);
}