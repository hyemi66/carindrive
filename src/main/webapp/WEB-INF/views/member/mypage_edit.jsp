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
	<form method="post" action="mypage_edit_ok">
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
					<td>
						<div>
							<select id="m_tel" name="m_tel" class="select">
					    		<option value="">통신사 선택</option>
					    		<option value="SK">SK</option>
					    		<option value="KT">KT</option>
					    		<option value="LG">LGU+</option>
					    		<option value="알뜰">알뜰폰</option>
							</select>
							<input id="m_phone" name="m_phone" placeholder="휴대전화번호"
							onfocus="this.placeholder=''" onblur="this.placeholder='휴대전화번호'">
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div>
							<input id="m_email" name="m_email" placeholder="이메일"
							onfocus="this.placeholder=''" onblur="this.placeholder='이메일'">
							<select name="m_email_se" class="select">
					    		<option value="">이메일 선택</option>
					    		<option value="naver">naver.com</option>
					    		<option value="gmail">gmail.com</option>
					    		<option value="daum">daum.net</option>
							</select>
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
		<input id="mypage_edit" type="submit" value="수정완료" />
	</form>
</div>

<div class="clear"></div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>