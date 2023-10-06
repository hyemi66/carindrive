<%@ page contentType="text/html; charset=UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<div id="eventImg" >
	<img alt="이벤트" src="${path}/images/event.jpg">
</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>