<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header/topMenu.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		$("#sendBtn").click(function(){
			sendMessage();
		})
	});
	
	var sock= new SockJS("<c:url value="/echo"/>");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;
	
    function sendMessage(){
        sock.send($("#message").val());     
    }
            
    //evt 파라미터는 websocket이 보내준 데이터다.
    function onMessage(evt){  //변수 안에 function자체를 넣음.
        var data = evt.data; 
    	var sessionid = null;
    	var message = null;
    	
    	var strArray = data.split(":")
    	
   		var sessionId = $(".userID").text()
   		sessionid = strArray[0];
    	message = strArray[1];
    	
        $("#data").prepend("<h2>"+sessionid+" :"+message+"</h2><br/>");
    }
    
    function onClose(evt){
        $("#data").append("연결 끊김");
    }
</script>
<style>
	.testWrap{
		margin-top: 150px;
	}
</style>
<div class="testWrap">
	<input type="text" id="message"/>
	<input type="button" id="sendBtn" value="전송"/>
	<p class="userID">${userid}
	<div id="data"></div>
</div>
