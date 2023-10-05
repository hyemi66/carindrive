<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    String calculatedPrice = request.getParameter("calculatedPrice");
    if (calculatedPrice == null || calculatedPrice.isEmpty()) {
        calculatedPrice = "0";
    }
    request.setAttribute("calculatedPrice", calculatedPrice);
%>
<html>
<head>
<script src="${path}/js/jquery.js"></script>
<script src="${path}/js/timeUpPay.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link href="${path}/css/timeUp.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>시간 연장</title>
</head>

<body>
<div class="plusPay">
	<h2>추가 금액</h2>
	<hr>
	<p>추가시간 : <fmt:formatNumber type="number" pattern="#0" value="${calculatedPrice / car.c_price}" />분</p>
	
	<p>1분 금액 : <fmt:formatNumber type="number" pattern="#0" value="${car.c_price}"/>원</p>
	<hr>
	<p>총 추가 금액(1분 금액 x 추가시간) : ${calculatedPrice}원</p>
	<div id="plusMent">
		<button onclick="payMent('card', '${rental.cr_mid}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${calculatedPrice}, '${rental.cr_order}')">카드 결제</button>
		<button onclick="payMent('kakao', '${rental.cr_mid}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${calculatedPrice}, '${rental.cr_order}')">카카오페이 결제</button>
	</div>
</div>
</body>
</html>