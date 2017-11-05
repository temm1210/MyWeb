<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="location" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/util/reset.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/header/top-menu.css" />">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	$(document).ready(function(){
		var prevHtml;
		
 		$("#user_id").mouseover(function(){
			prevHtml = $("#user_id").html();
			$("#user_id").html(' Mypage');
		})
		
		$("#user_id").mouseout(function(){
			$("#user_id").html(prevHtml);
		}) 
	})
	
	function logOutCheck(){
		if(confirm("로그아웃 하시겠씁니까?")){
			$("#logOutForm").submit()
		}
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

  		<a href="${location}/index.jsp" title="logo" id="logo">
  			<h2>amiGo</h2>
  		</a>
 	    <div class="sub-logo">
		    <sec:authorize access="isAnonymous()">
		   		<a href="${location}/member/login.amg" class="btn" id="log"><i class="fa fa-user-o" aria-hidden="true"></i></a>
		    	<a href="${location}/member/joinFirst.amg" class="btn" id="join"><i class="fa fa-user-plus" aria-hidden="true"></i></a>
		  	</sec:authorize>

		   	<sec:authorize access="isAuthenticated()">
		   		<sec:authentication property="principal" var="user"/>  	 	
		   		<a href="javascript:logOutCheck()" class="btn" id="logOut"><span id="log_Out">Logout</span></a>			   			
				
				<a href="${location}/member/modify_check.amg" id="mypage">
					<span id="user_id">
						<sec:authentication property="principal.username"/>님
					</span>
					
					<c:choose>
						<c:when test="${user.mPic == null}">
							<i class="fa fa-user-circle" style="font-size:40px;" aria-hidden="true"></i>				
						</c:when>							
						<c:otherwise>
							<div id="profile_pic">
								<img id="pr_pic" height="60px" width="60px" src="<c:url value='/resources/images/member_images/${user.mPic}'/>">
							</div>
						</c:otherwise>
					</c:choose>
		   		</a>
		   		
		   		<form id="logOutForm" action="<c:url value='${location}/member/logOut.amg'/>"method="post">
		   			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		   		</form> 
			</sec:authorize>	    
 	    </div>
 	    
  	<nav id="menu" class="menu">
    	<ul class="dropdown">
      		<li ><a href="#Link" title="Link">동호회</a>
      			<ul>
      				<li><a href="${location}/club/clubMake.amg" title="Link">동호회 창설</a>
      				<li><a href="#Link" title="Link">동호회 보기</a>
      			</ul>
      		</li>

			<li><a href="#Link" title="Link">고객센터</a>
				<ul>
					<li><a href="${location}/qna/faq.amg" title="Link">F&Q</a></li>
					<li><a href="${location}/qna/qna.amg" title="Link">1:1질문</a></li>
				</ul>
			</li>
			
			<sec:authorize access="isAuthenticated()">
				<li><a href="#Link" title="Link">가입한동호회</a>
					<ul>
						<li><a href="${location}/#" title="Link">동호회1</a></li>
						<li><a href="${location}/#" title="Link">동호회2</a></li>
					</ul>
				</li>
			</sec:authorize>
	    </ul>
  	</nav>
	  
</div>
<script src="<c:url value="/resources/script/script.js"/>"></script> 



