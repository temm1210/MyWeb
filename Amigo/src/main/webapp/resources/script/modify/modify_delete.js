var isChecked = false;

$(document).ready(function(){	
	$("#agree_check").click(function(){
		if($("#agree_check").is(":checked"))
			isChecked=true;
		else
			isChecked=false;
	});

});

function goNextPage(path){
	if(isChecked){
		if(confirm("탈퇴를 하시겠습니까?"))
			location.href=path;
	}
	else
		alert("안내를 확인하고 동의하셔야 탈퇴가 가능합니다");
}