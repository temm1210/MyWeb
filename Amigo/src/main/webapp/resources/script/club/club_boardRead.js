var path = $("#loc").val();
$(document).ready(function(){

	/* 수정버튼 클릭시 */
	$("#updateBtn").on('click',function(){
		
		var updateVal = $("#updateBtn").attr("value");
		
		/* 수정후 수정완료 버튼 클릭시 */
		if(updateVal == "수정완료"){
			if(confirm("정말로 수정을 하시겠습니까?")){
				boardAjax(path+"/club/board/boardUpdate.amg","PUT");
			}
		}
		/* 수정버튼을 클릭시 */
		else{
			/* 변경불가능 속성 제거 */
			$(".write_row > select").removeAttr("disabled")
			$(".write_row > input:not('#bWriter'), .write_row > textarea").removeAttr("readonly");
			
			/* 수정버튼 수정완료로 변경 */
			$("#updateBtn").attr("value","수정완료");
			$("#updateForm > h2").after("<span style='color:red'>수정중</span>")
			
			/* 제목에 자동 포커스 */
			$("#bTitle").focus();
		}
	});
})

function likeAjax(url){
	$.ajax({
		type:"get",
		url:url,
		success:function(like){
			$(".boardLike").text(like);
		}
	})
}

function boardDelete(url,type){
	if(confirm("정말 삭제를 하시겠습니까? 삭제후 복구는 불가능합니다")){
		boardAjax(url,type)
	}
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
