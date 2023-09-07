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
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<form method="post">
<h2>회원 가입 페이지 입니다.</h2>
    <label for="m_id">아이디:</label>
    <input type="text" name="m_id" id="m_id"> <br>
    
    <label for="m_pwd">비밀번호:</label>
    <input type="password" name="m_pwd" id="m_pwd"> <br>
    
    <label for="m_name">이름:</label>
    <input type="text" name="m_name" id="m_name"> <br>
    
    <label for="m_phone">전화번호:</label>
    <input type="text" name="m_phone" id="m_phone"> <br>
    
    <input type="submit" value="가입하기"> <br>
</form>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>