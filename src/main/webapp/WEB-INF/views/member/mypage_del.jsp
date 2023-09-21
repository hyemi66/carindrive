<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
<link href="${path}/css/member/mypage.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>

<div id="mypage2">
	<h2>마이페이지</h2>
	<h3>비밀번호 재확인</h3>
	<h4>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</h4>
	<hr id="mp_hr">
	<form method="post" action="mypage_del_ok">
		<table id="mypage_t">
			<c:forEach var="m" items="${mlist}">
				<tr>
					<th>회원 아이디</th>
					<td>${m.m_id}</td>
				</tr>
				<tr>
					<th>회원 비밀번호&nbsp;<font style="color:red;">*</style></th>
					<td><input type="password" size="14" id="m_pwd" name="m_pwd"></td>
				</tr>
			</c:forEach>
		</table>
		<input id="mypage_edit2" type="submit" value="탈퇴" />
		<input id="mypage_edit3" type="button" value="취소" onclick="location.href='mypage' " />
	</form>
</div>

<div class="clear"></div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>