<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<script>
    alert("세션이 만료되었습니다. 다시 로그인을 해주세요.");
    location.href = "/member/memberLogin";
</script>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>
