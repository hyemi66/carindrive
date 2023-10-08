<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
<link href="${path}/css/rent_Check.css" rel="stylesheet" />
<script src="${path}/js/jquery.js"></script>
</head>
<body>
<div class="CARBig">
	<jsp:include page="../include/header.jsp" />
	</div>
	<div class="CARBig">
	<div class="clear"></div>
	<div id="bigbox">
		<p id="bar">예약 내역</p>
		<div id="box">
			<h1>예약하신 내역이 존재하지 않습니다.</h1>
			<a href="/rent/rent"><h2>차량 예약하러 가기</h2></a>
		</div>
	</div>

</div>
<div class="CARBig">
	<jsp:include page="../include/footer.jsp" />
	</div>
</body>
</html>