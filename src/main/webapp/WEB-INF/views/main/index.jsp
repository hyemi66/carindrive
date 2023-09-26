<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<!-- 페이지 내용 -->

<div class="mainimg">
	<h1>메인 사진</h1>
</div>

<div class="main_car">
	<p id="m_font1">스마트한 카 라이프의 시작</p>
	<p id="m_font2">
		신차를 구매하지 않고 렌트로 차량을 운용하는 방법으로<br>
		차량 상담, 출고, 렌트, 보험과 세금 정비 등에 대한 업무를 기아가 전담하는 렌터카 서비스입니다.
	</p>
	<br>
	<p id="m_rent"><a href="${path}/rent/rent">예약바로가기</a></p>
	<div id="m_intro">
		<img id="mainLogo" alt="logo" src="${path}/images/Mainlogo.PNG">
	</div>
</div>
<hr id="m_hr">
<div id="m_event">
	<p id="me_font">CARINDRIVE MAIN EVENT</p>
	<p id="me_font2">
		<a href="${path}/event/event">▷ 이벤트 전체보기</a>
	</p>
	<div id="me_ev">
		<p>메인 이벤트1</p>
		<p>메인 이벤트2</p>
		<br>
		<p>메인 이벤트3</p>
		<p>메인 이벤트4</p>
	</div>
</div>
<div class="m_ser">
	<input type="button" value="고객센터" onclick="location='${path}/service/service_center'">
	<input type="button" value="이용안내" onclick="location='${path}/guide/guide'">
	<input type="button" value="보험안내" onclick="location='${path}/insurance/insurance'">
</div>


<jsp:include page="../include/footer.jsp"/>
</body>
</html>