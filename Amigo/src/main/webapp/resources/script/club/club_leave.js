var isChecked = false;
$(document).ready(function(){
	
	$("#agree_leave").click(function(){
		if($("#agree_leave").is(":checked"))
			isChecked=true;
		else
			isChecked=false;
	});
})

function leaveClub(path){
	if(isChecked){
		if(confirm("탈퇴를 하시겠습니까?"))
			leaveClubAjax(path)
	}
	else
		alert("안내를 확인하고 동의하셔야 탈퇴가 가능합니다");
}

function leaveClubAjax(url){
	var obj = JSON.parse(sessionStorage.getItem("isMember"));
	var data={
			cNickname:obj.cNickname,
			cNum:$("#hdnCnum").val()
	};
	
	$.ajax({
		type:"delete",
		url:url,
		data:JSON.stringify(data),
	 	headers:{
			"Content-Type":"application/json; charset=UTF-8"
		},
		success:function(msg){	
			alert(msg)
			/*홈버튼 강제클릭  */
			location.reload();
			$("#first_link").click(); 
			
		}
	});
}