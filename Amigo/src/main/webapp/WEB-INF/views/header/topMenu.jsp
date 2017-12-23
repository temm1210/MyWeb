<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	/* 현재로그인한 유저 아이디 */
	var userName = "${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}";
	
	$(document).ready(function(){
		/* 스프링 시큐리티의 CSRF라는 기능으로 인해 POST방식으로 보낼때 CSRF처리를 해줘야함. AJAX에서 POST요청을함으로 로딩과 동시에 CSRF처리 */
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

	    $(document).ajaxSend(function(e, xhr, options) {
	        xhr.setRequestHeader(header, token);
	    });
	    /* --------------------------------------------------- */

		/* 로그인된 상태라면  */
		if( userName!=''){
 			clubsGet(userName); 
 		}
	});

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
				/* 가입한 동호회가 있다면 */
				var str="";
				$.each(clubs,function(index){
					str+='<li><a href=${location}/club/club.amg?cNum='+clubs[index].CNUM+' >'
					str+='<img src=${clubImg}/'+clubs[index].CPIC+'>'
					str+='<span id="deco_text">'
					str+=clubs[index].CTITLE
					str+='</span>'
					str+='</a></li>' 
					
					$("#join_clubs").append(str)
					str="";
				})
			}
		}); 
	} 
</script>
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
		<h2>AmiGo</h2>
	</a>
    <div class="sub-logo">
	    <sec:authorize access="isAnonymous()">
	  		<a href="${location}/member/login.amg" class="btn" id="log"><i class="fa fa-user-o" aria-hidden="true"></i></a>
	   		<a href="${location}/member/joinFirst.amg" class="btn" id="join"><i class="fa fa-user-plus" aria-hidden="true"></i></a>
	 	</sec:authorize>
	
	  	<sec:authorize access="isAuthenticated()"> 
	  		<sec:authentication property="principal" var="user"/> 	
	  		<div id="aside_club">
	  			<i class="fa fa-align-justify caret" aria-hidden="true"></i>
	  			<div class="wrap_fa">
		  			<i class="fa fa-times caret opacityZero" id="close" aria-hidden="true">
		  				<span class="clubs_list">가입동호회리스트</span>
		  			</i>	  
	  			</div>
		  		<input id="subBtn" type="button"> 		
		  		<!-- 가입한 동호회 리스트를 보여줌 -->
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
						<i class="fa fa-user-circle user_font" style="font-size:40px;" aria-hidden="true"></i>				
					</c:when>							
					<c:otherwise>
						<div id="profile_pic">
							<img id="pr_pic" height="60px" width="60px" src="${memberImg}/${user.mPic}">
						</div>
					</c:otherwise>
				</c:choose>
	  		</a>
	  																		
	  		<form id="logOutForm" action="<c:url value='/member/logOut.amg?logoutMethod=basic'/>" method="post">
	  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  		</form> 
	  	</sec:authorize>
  	</div>	
   
  	<nav id="menu" class="menu">
    	<ul class="dropdown">
      		<li ><a href="#Link">동호회</a>
      			<ul>
      				<li><a href="${location}/club/clubMake.amg">동호회 만들기</a>
      				<li><a href="${location}/club/clubSearch.amg?page=1">동호회 찾기</a>
      			</ul>
      		</li>

			<li><a href="#Link">고객센터</a>
				<ul>
					<li><a href="${location}/qna/faq.amg">F&Q</a></li>
					<li><a href="${location}/qna/qna.amg">1:1질문</a></li>
				</ul>
			</li>
	    </ul>
  	</nav>
</div>
<script src="<c:url value="/resources/script/header/topMenu.js"/>"></script> 



