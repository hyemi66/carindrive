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
    
</head>

    	<%--이 창을 띄울때 세션이 만료되면 새로운 창을 띄우고 로그인유도 --%>
<%-- 세션이 만료되면 새 창을 열어 로그인 페이지로 이동 // 부모 창을 로그인 페이지로 이동 --%>
<c:if test="${sessionScope.noSession == true}"> <%--이 기능이 동작을 안함 --%>
    <script>
        alert('세션이 만료되었습니다 다시 로그인해주세요!');
        window.opener.location.href = '/member/m_login'; 
        window.close(); // 현재 팝업 창 닫기
    </script>
</c:if>
<body>

    
    <h2>본인 인증</h2>
    <hr>
    <form method="post">
    <div class="form-group">
        <label for="mPwd">비밀번호:</label>
        <input type="password" id="mPwd" name="mPwd" placeholder="비밀번호를 입력해주세요.">
    </div>
    <button id="submit">환불하기</button>
    </form>
    





    
</body>
</html>
