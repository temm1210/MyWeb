<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url var="memberImg" value="/resources/images/member_images" />
<c:set var="location" value="${pageContext.request.contextPath}"/>

<style>
	.member{
		border-bottom: 1px solid rgba(0,0,0,.2);
    	padding: 20px;
	}
	.mpic > img{
		border-radius: 50%;
		vertical-align: middle;
		padding-right: 10px;
	}
	.memberPic{
		font-size: 60px;
		vertical-align: middle;
		padding-right: 10px;
	}
	.cmregdate{
		padding-right: 30px;
	}
</style>
<div id="clubMemberContainer">
	<div id="memberWrap">
		<ul>
			<c:forEach var="member" items="${member}" >
				<li class="member">
					<div class="membersInfo">
						<c:choose>
							<c:when test="${member.mPic != null}">
								<span class="memberinfo mpic"><img height="60px" width="60px" src="${memberImg}/${member.mPic}"></span>
							</c:when>
							
							<c:otherwise>
								<span><i class="fa fa-user-circle memberPic" aria-hidden="true"></i></span>
							</c:otherwise>
						</c:choose>
						<span class="memberinfo nickName">${member.cNickname}</span>
						<span class="memberinfo cmregdate"><fmt:formatDate value="${member.cmRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						<span class="memberinfo cgrade">${member.cGrade}</span>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>