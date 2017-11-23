var path = $("#loc").val();
$(document).ready(function(){

	$(window).scrollTop(180);
	/*닉네임 입력후 포커스 해제되었을때 작동*/
	$("#cNickname").stop().blur(function(){
		/*데이터 저장(JSON)*/
		var data={
				cNickname:$("#cNickname").val(),
				cNum:$("#cNum").val()
		};
		
		if(data.cNickname.length < 2 || data.cNickname.length > 8){
			alert("닉네임은 최소2자, 최대7자까지 입력가능합니다")
			return false;
		}else{
			/*닉네임 입력시 가입하기전에 중복체크*/
			clubJoinAjax(path+"/clubMember/checkNickname.amg",data)
		}
	})
	
	/*동호회 가입하기 눌렀을때 작동*/
	$("#joinClubBtn").on('click',function(){
		
		/*가입정보 저장(JSON)*/
		var data={
				mid:userName, /*로그인한 사람의아이디*/
				cNickname:$("#cNickname").val(), /*동호회 가입하기위해 입력한 닉네임*/
				cNum:$("#cNum").val(), /*현재동호회 고유번호*/
				cGrade:"신입회원" /*등급은  처음에 최하등급 부여*/
		};
		
		if($("#resultCheck").hasClass("red"))
			alert("이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요")
		else{
			clubJoinAjax(path+"/clubMember/joinClub.amg",data)
		}
	})
});

/*중복체크,동호회가입 AJAX*/
function clubJoinAjax(url,data){

	$.ajax({
		type:"post",
		url:url,
		data:JSON.stringify(data),
	 	headers:{
			"Content-Type":"application/json; charset=UTF-8"
		},
		success:function(msg){	
			if(msg == "fail_check"){
				$("#resultCheck").text("닉네임이 이미 있습니다.").removeClass('green').addClass("red");
				
			}else if(msg == "success_check" ){
				$("#resultCheck").text("사용가능한 닉네임 입니다").removeClass('red').addClass("green");
			
			/*닉네임 검증후 가입눌렀을때*/	
			}else{
				alert(msg)
				location.reload();
				$("#first_link").click(); 
			}
		}
	});
}