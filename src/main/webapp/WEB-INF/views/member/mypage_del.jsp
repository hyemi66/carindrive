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
			<h1>회 원 정 보 탈 퇴</h1>
			<h3>비밀번호 재확인</h3>
			<h4>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</h4>
			<form method="post" action="mypage_del_ok">
				<table id="mypage_st">
					<c:forEach var="m" items="${mlist}">
						<tr>
							<th>회원 아이디</th>
							<td>${m.m_id}</td>
						</tr>
						<tr>
							<th>회원 비밀번호&nbsp;<font style="color:red;">*</style></th>
							<td><input type="password" size="14" id="m_pwd" name="m_pwd"></td>
						</tr>
						<tr></tr>
						<tr>
							<td colspan="2" id="delfont">※ 단, 탈퇴시 예약내역도 같이 취소됩니다. ※</td>
						</tr>
					</c:forEach>
				</table>
				<div id="mypage_del">
					<input id="mypage_bt3" type="submit" value="탈퇴" />
					<input id="mypage_bt3" type="button" value="취소" onclick="location.href='mypage' " />
				</div>
			   </form>
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