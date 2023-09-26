<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${path}/js/jquery.js"></script>
<script src="${path}/js/payment.js"></script> <!-- 결제 코드 js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
<link href="${path}/css/rent_Wait.css" rel="stylesheet" />

</head>
<body>
  <jsp:include page="../include/header.jsp"/>
  
  <div class="clear"></div>
<%-- 예약 선택 메뉴 --%>
<form method="post" action="/rent/rentInfo">

<input type="hidden" name="cr_cname" id="cr_cname" value="${car.c_name}">

<div class="mainmenu">

<div id="menu01">
	<p>
		빌 리 는 날 짜&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="datetime-local" name="cr_sdate" id="cr_sdate" value="${cr_sdate}" required readOnly>

	</p>
</div>
<div id="menu02">
	<p>
		반 납 하 는 날 짜&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="datetime-local" name="cr_edate" id="cr_edate" value="${cr_edate}" required readOnly>
	</p>
</div>
</div>

<div class="clear"></div>

<div class="carname">

	<div><h1>${car.c_brand} ${car.c_name}</h1></div>
	<table border="1">
		<tr>
			<td>
				<img src="${path}/images/car/${car.c_img}">
			</td>
			<td id="sub">
				<h2><p style="color: blue";>차량정보</p></h2>
				<p>차량명 : ${car.c_brand} ${car.c_name} ${car.c_year}년식</p>
				<hr>
				<p>차량색상 : ${car.c_color}</p>
				<p>타입 : ${car.c_type}</p>
				<p>연료 : ${car.c_oil}</p>
				<span><a href="${path}/rent/rent">차량/날짜 다시 선택</a></span>
				<input type="submit" value="예 약 하 기">
			</td>
		</tr>
	</table>

	<hr>
대여관련 안내사항
<br><br><br><br><br><br>
보험적용 불가사항
<br><br><br><br>
취소/환불안내
<br><br><br><br><br>
취소 및 환불규정
<br><br><br><br><br><br>
</div>

</form>



<div class="clear"></div>


<jsp:include page="../include/footer.jsp"/>
</body>
</html>