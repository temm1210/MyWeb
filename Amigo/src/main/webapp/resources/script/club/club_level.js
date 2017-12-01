//등업시키기
function levelUpAjax(path,type,cNickname){
	
	var data={
			cNum:$("#cnum").val(),
			cNickname:cNickname,
			typeLevel:type
	};
	
	$.ajax({
		type:"POST",
		url:path,
		headers:{
			"Content-Type":"application/json; charset=UTF-8"
		},
		data:JSON.stringify(data),
		success:function(grade){
			if(confirm("등급을 변경 시키겠습니까?")){
				$.each($(".nickName"),function(index,element){
					if( $(element).val() == cNickname){
						$(element).siblings(".writerGrade").text(grade);
					}//if
				});//each
				
			}//if
		}//success:function
	});
}