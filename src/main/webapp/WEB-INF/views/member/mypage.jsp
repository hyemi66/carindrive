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
<div id="mypage">
	<h2>마이페이지</h2>
	<hr id="mp_hr">
	<form method="post" action="mypage_ok">
		<table id="mypage_t">
			<c:forEach var="m" items="${mlist}">
				<tr>
					<th>회원 아이디</th>
					<td>${m.m_id}</td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td>${m.m_name}</td>
				</tr>
				<tr>
					<th>회원생일</th>
					<td>${m.m_birth}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${m.m_tel} | ${m.m_phone}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${m.m_email}</td>
				</tr>
				<tr>
					<th>면허등록여부</th>
					<td>
						<input type="button" value="면허등록" onclick="${path}/">
					</td>
				</tr>
				<tr>
					<th>회원탈퇴</th>
					<td>
						<input type="button" value="회원탈퇴" onclick="location.href='mypage_del' ">
					</td>
				</tr>
			</c:forEach>
		</table>
		<input id="mypage_edit" type="button" value="회원정보수정" onclick="location='${path}/member/mypage_ok';">
	</form>
</div>

<div class="clear"></div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>