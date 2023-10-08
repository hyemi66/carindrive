<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="${path}/js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
</head>
<body>
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<form method="post">
<h2>로그인 페이지 입니다.</h2>
    <table border="1">
        <tr>
            <td>아이디:</td>
            <td><input type="text" name="m_id" id="m_id"></td>
        </tr>
        <tr>
            <td>비밀번호:</td>
            <td><input type="password" name="m_pwd" id="m_pwd"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="로그인">
                <input type="button" value="회원가입" onclick="location.href='/member/memberSign'">
            </td>
        </tr>
    </table>
</form>

<!-- 로그인을 안하고 에러로인해 여기로 돌아왔을 시 -->
<!-- JSP 파일 내에서 경고 메시지 표시하기 -->
<c:if test="${not empty LoginNull}">
    <script>
        ${LoginNull}
    </script>
    <%-- 스크립트가 실행되었으므로 alertScript를 삭제 --%>
    <c:remove var="alertScript" scope="page" />
</c:if>

<script type="text/javascript">
	var loginmsg = "${loginmsg}";
	
	if (loginmsg === 'success') {
	    alert('로그인에 성공 했습니다!');   
	}

   var errorMessage  = "${errorMessage}";
   
   if (errorMessage  === 'error') {
       alert('잘못 입력 하셨습니다. 다시 로그인 해주세요 !');   
   }
 </script>
</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>