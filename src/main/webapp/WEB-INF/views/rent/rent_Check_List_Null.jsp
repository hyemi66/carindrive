<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
<script src="${path}/js/jquery.js"></script>
<link
	href="${path}/css/rentCheck.css"
	rel="stylesheet" />
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="clear"></div>
	<div id="bigbox">
		<p id="bar">예약 내역</p>
		<div id="box">
			<h1>예약하신 내역이 존재하지 않습니다.</h1>
		</div>
	</div>


	<jsp:include page="../include/footer.jsp" />
</body>
</html>