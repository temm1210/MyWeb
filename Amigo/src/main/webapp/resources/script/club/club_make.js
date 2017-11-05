$(document).ready(function(){
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	 
	 $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
	 
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
	/*select 값 변경할때 작동*/
	$("#area1").change(function(){
		addSelectBox();
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

/* 아작스로 다음주소 selectBox만들기 */
function addSelectBox(){
	var area =  $("#area1 option:selected").val(); 
	
	$.ajax({
		type:"post",
		url:"/club/selectBox.amg?area="+area,
		success:function(data){
			var i=0;
			var selectTag='';
			
			for(i in data){
				console.log(data[i]);
				selectTag += "<option value=";
				selectTag += data[i]+">";
				selectTag += data[i]+"</option>";
			}
			
			$("#area2").html(selectTag); 	
		},
 	  	error:function(request,status,error){
 	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
 	    }	
	});
}
function checkValue(sel,errorStr,condition){
	 var value =$(sel).val();
	 var $sel_parent = $(sel).parent();
	 
	 if(value == '' || value.length < condition)
		 errorCheckEffect(errorStr,$sel_parent);
	 else
		 successCheckEffect($sel_parent);
}