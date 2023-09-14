<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>carindrive : 로그인페이지</title>

<link rel="stylesheet" type="text/css" href="${path}/css/member/m_log.css">
<script type="text/javascript" src="${path}/js/member/m_login.js"></script>

<script src="${path}/js/jquery.js"></script>
<!-- 네이버 인증 로그인 -->

</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<form action="m_login_ok" method="post">
	<div id="wrap">
		<div id="all_form">
			<div id="logo">
				<hr>
				CARINDRIVE
				<hr>
			</div>
			<div id="log_form">
				<div id="id_form">
					<input id="m_id" name="m_id" placeholder="아이디" 
					onfocus="this.placeholder=''" onblur="this.placeholder='아이디'">
					<span class="idck"></span>
				</div><%--id_form --%>
				<div id="pwd_form">
					<input type="password" id="m_pwd" name="m_pwd" placeholder="비밀번호"
					onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호'">
					<span class="pwdck"></span>
				</div><%--pwd_form --%>
				 
				<div id="maintain">
					<input type="checkbox" id="checkbox" name="checkbox"checked="checked"><label for="checkbox"><span>로그인 상태 유지</span></label>
				</div><%--maitain_form --%>
				<div id="button_form">
					<input type="submit" value="로그인" id="btn1" onclick="return logCk()">
				</div>
			</div><%--logform end --%>
			<%--아이디, 비밀번호찾기 & 회원가입 --%>
			<div id="another_form">
				<a href="${path}/member/serch_pwd">비밀번호 찾기</a>&nbsp;&nbsp;&#124;
				<a href="${path}/member/serch_id">아이디 찾기</a>&nbsp;&nbsp;&#124;
				<a href="${path}/member/m_join">회원가입</a>&nbsp;&nbsp;
			</div>
			<%-- SNS 로그인 --%>
			<div id="social">
				<a href="#"><img src="${path}/images/member/naver_icon.png"  id="naver"></a>
				<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=4094fcc6d950836e2f6c9f216ab46fef&redirect_uri=http://localhost:7990/member/kakaotest">
				<img src="${path}/images/member/kakao_icon.png"id="kakao"></a>
				<a href="#"><img src="${path}/images/member/google_icon.png"  id="google">
				</a>
			</div>
			<%-- 기타--%>
			<div id="ano">
				<span>CARINDRIVE&nbsp;&nbsp;&#124;</span>
				<span> Copyright&nbsp;</span>
				<span>All Rights Reserved.</span>
			</div>
		</div><%--allform end --%>
	</div><%-- wrap end --%>
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

<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>



</body>
</html>