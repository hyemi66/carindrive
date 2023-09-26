<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/introduce.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>

<br><br>
<div class="intro_main">
<div class="intro_ceo">
	<ul>
		<li><a href="${path}/introduce/introduce">CEO 인사말</a>
		<li><a href="${path}/introduce/intro">회사소개</a>
		<li><a href="${path}/introduce/history">회사연혁</a>
		<li><a href="${path}/introduce/come">오시는 길</a>
	</ul>
</div>

<article id="intro_ceo_cont">
	<h1>| 오시는 길 |</h1>
	<p>
		→ 서울시 종로구 돈화문로 26 단성사 빌딩 지하 1층 CARINDRIVE
		<br><br>
		<img alt="come" src="${path}/images/come.PNG">
	</p>
</article>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
</div>

<jsp:include page="../include/footer.jsp"/>
</body>
</html>