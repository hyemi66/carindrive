<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정보 확인</title>
    <link href="${path}/css/refund.css" rel="stylesheet" />
    <script src="${path}/js/jquery.js"></script>
    <script src="${path}/js/refund.js"></script>
    
</head>
<body>
    <h2>본인 인증</h2>
    <hr>
    <div class="form-group">
        <label for="name">이름:</label>
        <input type="text" id="name" placeholder="이름을 입력해주세요.">
    </div>
    <div class="form-group">
        <label for="phone">전화번호:</label>
        <input type="text" id="phone" placeholder="전화번호(숫자)를 입력해주세요.">
    </div>
    <button id="submit">환불하기</button>
</body>
</html>
