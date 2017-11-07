<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<c:url var="clubImg" value="/resources/images/club_images" />
<c:url var="memberImg" value="/resources/images/member_images" />
<c:url var="img" value="/resources/images" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/util/reset.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/header/top-menu.css" />">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	$(document).ready(function(){
		/* 스프링 시큐리티의 CSRF라는 기능으로 인해 POST방식으로 보낼때 CSRF처리를 해줘야함. AJAX에서 POST요청을함으로 로딩과 동시에 CSRF처리 */
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

	    $(document).ajaxSend(function(e, xhr, options) {
	        xhr.setRequestHeader(header, token);
	    });
	    /* --------------------------------------------------- */
	    
		var prevHtml;
		var userName;
		var userName = "${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}";
		
		/* 로그인된 상태라면  */
		if( userName!=''){
 			clubsGet(userName); 
 		}
		
 		$("#user_id").mouseover(function(){
			prevHtml = $("#user_id").html();
			$("#user_id").html(' Mypage');
		})
		
		$("#user_id").mouseout(function(){
			$("#user_id").html(prevHtml);
		}) 
		
		$(".caret").click(function(){
			$("#subBtn").trigger("click")
		})
		
		$("#subBtn").click(function(){
			$("#aside").toggleClass("marginLeft")
			$(".caret").toggleClass("top")
			$(".caret").toggleClass("none") 
		})

	});
	
	function logOutCheck(){
		if(confirm("로그아웃 하시겠습니까?")){
			$("#logOutForm").submit()
		}
	}
	
  	function clubsGet(username){
  		
  		var id = {
  			username:username
  		};
					
		$.ajax({
			type:"post",
			url:"${location}/club/clubsGet.amg",
			data:JSON.stringify(id),
			dataType:'json',
			headers:{
				"Content-Type" : "application/json; charset=UTF-8"
			},
			success:function(clubs){
				/* 가입한 동호회가 없다면 */
				var str="";
				
				if(clubs.lengt == 0)
					$("#join_clubs").siblings("a").text("가입동호회없음")
					
	 			else{
					$.each(clubs,function(index){
						str+='<li><a href="${location}/#" >'
						str+='<img src="${clubImg}/'+clubs[index].CPIC+'">'
						str+='<span id="deco_text">'
						str+=clubs[index].CTITLE
						str+='</span>'
						str+='</a></li>' 
						
						$("#join_clubs").append(str)
						str="";
					})
				} 

			},
			error:function(request,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		}); 
	} 
</script>
<style>

	#aside{
		position: absolute;
		width: 200px;
		background: rgba(0,0,0,.7);
		left: 100%;
		top: 100px;
		-webkit-transition: margin 0.7s; /* Safari 3.1 to 6.0 */
   		transition: margin 0.7s;
	}
	#aside > .caret{
		position: relative;
		font-size: 30px;
		color: white;
		cursor: pointer;
		-webkit-transition: all 0.6s; /* Safari 3.1 to 6.0 */
   		transition: all 0.6s;
	}
	
	#aside .clubs_list{
		display: block;
		font-size: 15px;
		font-family: 'Jeju Gothic', serif;
		padding: 20px 0 20px 20px;
		vertical-align: 5px;
		display: inline-block;
	}
	
	#aside > .clubsWrap{
		margin-top: -25px;
	}
	
	#aside > #subBtn{
		display: none;
	}
	
	#join_clubs{
		min-width:100%;
		text-align: left;
	}
	
	#join_clubs img{
		margin-left: 20px;
		width: 50px;
		height: 50px;
		border-radius: 50%;
		
	}
	#join_clubs > li{
		text-align: left;
		border-bottom: 1px solid rgba(255,255,255,.5);
		padding:15px 0;
	}
	
	#join_clubs > li > a > span{
		position: absolute;
		margin-top: 19px;
		left: 80px;
		display: inline-block;
		font-size: 13px;
	}

	
	.marginLeft{
		margin-left: -200px;
	}
	.inlineBlock{
		display: inline-block;
	}
	.none{
		opacity:0;
	}
	.top{
		top:0;
	}
	
	#deco_text{
		color:white;
		font-size: 14px;
	}

	.fa-times{
		display: block;
		border-bottom: 1px solid;
		left: 0;
		top: -25px;
		text-align: center;
	}
	.fa-align-justify{
		left: -36px;
		top: -55px;
	}
</style>
<div class="nav_wrapper"> 
    <div class="spinner-master">
	    <input type="checkbox" id="spinner-form" />
	    <label for="spinner-form" class="spinner-spin">
	    <div class="spinner diagonal part-1"></div>
	    <div class="spinner horizontal"></div>
	    <div class="spinner diagonal part-2"></div>
	    </label>
 	</div>

	<a href="${location}/main.amg" title="logo" id="logo">
		<h2>amiGo</h2>
	</a>
    <div class="sub-logo">
	    <sec:authorize access="isAnonymous()">
	  		<a href="${location}/member/login.amg" class="btn" id="log"><i class="fa fa-user-o" aria-hidden="true"></i></a>
	   		<a href="${location}/member/joinFirst.amg" class="btn" id="join"><i class="fa fa-user-plus" aria-hidden="true"></i></a>
	 	</sec:authorize>
	
	  	<sec:authorize access="isAuthenticated()"> 
	  		<sec:authentication property="principal" var="user"/> 	
	  		<div id="aside">
	  			<i class="fa fa-align-justify caret" aria-hidden="true"></i>
	  			<i class="fa fa-times caret none" id="close" aria-hidden="true"><span class="clubs_list">가입동호회리스트</span></i>	  
		  		<input id="subBtn" type="button">
				<div class="clubsWrap">
					<ul id="join_clubs">
					
					</ul>
		  		</div>
	  		</div> 	
	  		<a href="javascript:logOutCheck()" class="btn" id="logOut"><span id="log_Out">Logout</span></a>			   			
			
			<a href="${location}/member/modify_check.amg" id="mypage">
				<span id="user_id">
					${user.username}님 <!-- <sec:authentication property="principal.username"/> -->
				</span>
				
				<c:choose>
					<c:when test="${user.mPic == null}">
						<i class="fa fa-user-circle" style="font-size:40px;" aria-hidden="true"></i>				
					</c:when>							
					<c:otherwise>
						<div id="profile_pic">
							<img id="pr_pic" height="60px" width="60px" src="${memberImg}/${user.mPic}">
						</div>
					</c:otherwise>
				</c:choose>
	  		</a>
	  																		
	  		<form id="logOutForm" action="<c:url value='${location}/member/logOut.amg?logoutMethod=basic'/>" method="post">
	  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  		</form> 
	  	</sec:authorize>
  	</div>	
   
  	<nav id="menu" class="menu">
    	<ul class="dropdown">
      		<li ><a href="#Link" title="Link">동호회</a>
      			<ul>
      				<li><a href="${location}/club/clubMake.amg">동호회 만들기</a>
      				<li><a href="#Link">동호회 보기</a>
      			</ul>
      		</li>

			<li><a href="#Link" title="Link">고객센터</a>
				<ul>
					<li><a href="${location}/qna/faq.amg">F&Q</a></li>
					<li><a href="${location}/qna/qna.amg">1:1질문</a></li>
				</ul>
			</li>
	    </ul>
  	</nav>
</div>
<script src="<c:url value="/resources/script/header/topMenu.js"/>"></script> 



