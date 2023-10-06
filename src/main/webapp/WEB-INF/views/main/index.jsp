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
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<!-- 페이지 내용 -->
<div class="CARBig">
<div class="mainimg">
	<img alt="메인사진" src="${path}/images/MAINIMG.jpg">
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
<div class="m_event">
	<p id="m_font1">CARINDRIVE EVENT</p>
	<div class="m_tab_content">
		<input type="radio" name="m_tabmenu" id="tab01" checked>
		<input type="radio" name="m_tabmenu" id="tab02">
		<input type="radio" name="m_tabmenu" id="tab03">
		
		<div class="m_conbox con1">
			<img alt="이벤트1" src="${path}/images/event1.jpg">
		</div>
		<div class="m_conbox con2">
			<img alt="이벤트2" src="${path}/images/event2.jpg">
		</div>
		<div class="m_conbox con3">
			<img alt="이벤트3" src="${path}/images/event3.jpg">
		</div>
		
	
		<div class="m_btn">
			<label for="tab01"></label>
			<label for="tab02"></label>
			<label for="tab03"></label>
			
		</div>
	</div>
	<p id="m_fullev">
		<a href="${path}/event/event">▶ 이벤트 전체 보기</a>
	</p>
</div>
<div class="m_ser">
	<input type="button" value="고객센터" onclick="location='${path}/service/service_center'">
	<input type="button" value="이용안내" onclick="location='${path}/guide/guide'">
	<input type="button" value="보험안내" onclick="location='${path}/insurance/insurance'">
</div>

</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>