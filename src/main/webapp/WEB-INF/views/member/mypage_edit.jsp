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
			<h1>회 원 정 보 수 정</h1>
			<form method="post" action="mypage_edit_ok">
				<table id="mypage_st">
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
							<td>
								<div>
									<select id="m_tel" name="m_tel" class="select">
									<option value="${m.m_tel}">${m.m_tel}</option>
									<option value="SK">SK</option>
									<option value="KT">KT</option>
									<option value="LG">LGU+</option>
									<option value="알뜰">알뜰폰</option>
									</select>
									<input id="m_phone" name="m_phone" placeholder="휴대전화번호"
									onfocus="this.placeholder=''" onblur="this.placeholder='휴대전화번호'" value="${m.m_phone}">
								</div>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<div>
									<input id="m_email" name="m_email" placeholder="이메일"
									onfocus="this.placeholder=''" onblur="this.placeholder='이메일'" value="${m.m_email}">
								</div>
							</td>
						</tr>
						<tr>
							<th>면허등록여부</th>
							<td>
								<input type="button" value="면허등록" onclick="${path}/">
							</td>
						</tr>
					</c:forEach>
				</table>
				<input id="mypage_bt2" type="submit" value="수정완료" />
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