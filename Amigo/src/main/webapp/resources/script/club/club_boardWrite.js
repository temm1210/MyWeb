$(document).ready(function(){
	
	var obj = JSON.parse(sessionStorage.getItem("isMember"));
	
	/*동호회 회장*/
	var clubMaster = $("#clubMaster").text()
	$("#bWriter").attr("value",obj.cNickname)
	
	
	/*동호회 회장은 카테고리에 공지사항 추가*/
	if(clubMaster != obj.cNickname){
		$("#masterCategory").css('display','none')
	}
	
	/* 글작성폼에서 취소버튼 눌렀을떄 */
	$("#cancelBtn").on('click',function(){
		history.back();	
	});
	
});

/* 글 작성해주는 Ajax */
function writeAjax(url){
	/* 폼데이터 배열로 key,value형식으로 해줌 */
	var data = $("#writeForm").serializeObject();
	
	$.ajax({
		type:"POST",
		url:url,
		headers:{
			"Content-Type":"application/json; charset=UTF-8"
		},
		data:JSON.stringify(data),
		success:function(msg){
			
			/* 글작성 성공시 */
			if(msg == "success")
				alert("요청을 성공적으로 수행하였습니다.")
				
			/* 글작성 실패시  */
			else
				alert("요청수행에 실패하였습니다.")
				
			/* 게시글작성완료후 게시글 전체보기로 이동 */
			$(".sub_ul > li:first-child > a").get(0).click();
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}

jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        }
    } catch (e) {
        alert(e.message);
    } finally {
    }
 
    return obj;
};