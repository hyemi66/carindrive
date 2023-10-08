<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<div class="Bmypage">
	<div class="Mypage">
		<div class="Mypage_menu">
			<h2>마이페이지</h2>
			<img id="mypage_img" alt="사람" src="${path}/images/people.jpg">
			<ul>
				<li><a href="${path}/member/mypage">회원정보확인</a>
				<li><a href="${path}/member/mypage_ok">회원정보수정</a>
				<li><a href="${path}/member/mypage_del">회원탈퇴</a>
			</ul>
		</div>
		<article id="mypage_show">
			<h1>회 원 정 보 확 인</h1>
			<table id="mypage_st">
				<c:forEach var="m" items="${mlist}">
					<tr>
						<th>아이디</th>
						<td>${m.m_id}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${m.m_name}</td>
					</tr>
					<tr>
						<th>생일</th>
						<td>${m.m_birth}</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${m.m_phone}(${m.m_tel})</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${m.m_email}</td>
					</tr>
					<tr>
						<th>가입날짜</th>
						<td>${fn:substring(m.m_regdate,0,10)}</td>
					</tr>
					<tr>
						<th>면허 등록 여부</th>
						<td>미등록</td>
					</tr>
				</c:forEach>
			</table>
			<div class="clear"></div>
		</article>
	</div>
</div>
<div class="clear"></div>
</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>