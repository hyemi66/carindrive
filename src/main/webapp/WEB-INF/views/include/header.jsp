<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CarInDrive</title>
<link rel="stylesheet" type="text/css" href="${path}/css/main.css">
</head>
<body>
<header>
	<div class="logo">
		<a href="/">
			<img src="${path}/images/LOGO2.PNG" alt="carindrive">
		</a>
	</div>
		
	<nav>
		<ul>
			<li><a href="${path}/rent/rent">차량예약</a></li>
			<li><a href="${path}/rent/rent_Check_List">예약확인</a></li>
			<li><a href="${path}/guide/guide">이용안내</a></li>
			<li><a href="${path}/insurance/insurance">보험안내</a></li>
			<li><a href="${path}/event/event">이벤트</a></li>
			<li><a href="${path}/service/service_center">고객센터</a></li>
		</ul>
	</nav>
		
	<div class="login">
		<%-- 일반, 관리자 로그인 분리 임시 --%>    	
		<c:choose>  
			<c:when test="${id eq 'admin01'}"> 
				 <b><span style="color: #1c2b37;">${id}님</span><a href="${path}/admin/admin_main"> 관리자페이지</a></b> | <b><a href="${path}/member/m_logout">로그아웃</a></b> 
			</c:when> 
			
			<c:when test="${!empty id}">
				<b><span style="color: #1c2b37;">${id}님</span><a href="${path}/member/mypage"> 마이페이지</a></b> | <b><a href="${path}/member/m_logout">로그아웃</a></b> 
			</c:when>
			
			<c:otherwise>
				<b><a href="${path}/member/m_login">로그인</a></b> | <b><a href="${path}/member/m_join">회원가입</a></b>
			</c:otherwise>
		</c:choose>
    </div>
</header>

<hr id="m_hr">
  
 <div class="clear"></div>