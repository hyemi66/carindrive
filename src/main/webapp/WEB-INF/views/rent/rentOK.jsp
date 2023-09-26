<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="phone" value="${mem.m_phone}" />
<c:set var="formattedPhone" value="${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}" />
<%-- mem.m_phone의 전화번호를 01011112222 형식을 010-1111-2222 형식으로 수정 --%>
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
				<p><a href="${path}/rent/rent">차량 다시 선택</a></p>
			</td>
		</tr>
	</table>
	
	<div id="carpay">
		<div id="box">
		
			<div id="bar"><h3>결제 정보 확인</h3></div>
			    <div class="box">
			        <div class="member">
			            <h2 class ="title">&nbsp;예약자 정보</h2>
			            <span class = "mtitle">아이디:</span> <span>${rental.cr_mid}</span><br>
			            <span class = "mtitle">연락처:</span> <span>${formattedPhone}</span><br>
			            <span class = "mtitle">이름:</span> <span>${mem.m_name}</span>
			            <hr>
			        <div class="car">
			            <h2>&nbsp;차량 정보</h2>
			            <span class = "mtitle">차종:</span> <span>${car.c_name}</span><br>
			            <span class = "mtitle">차량색상:</span> <span>${car.c_color}</span><br>
			            <span class = "mtitle">연식:</span> <span>${car.c_year}년식</span><br>
			        </div>
			        <div class="rent">
			            <h2>&nbsp;렌트 정보</h2>
			            <span class = "mtitle">예약일자:</span> <span>${rental.cr_rdate}</span><br>
			            <span class = "mtitle">실제 대여일자:</span> <span>${rental.cr_sdate}부터</span><br>
			            <span class = "mtitle">반납일자:</span> <span>${rental.cr_edate}까지</span><br>
			            <span class = "mtitle">렌트 비용:</span> <span><fmt:formatNumber value="${total_price}" type="number" pattern="#,###"/>원</span><hr>
					
					
<button onclick="payMent('card', '${rental.cr_mid}', '${mem.m_phone}', '${mem.m_name}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${total_price})">카드 결제</button>
<button onclick="payMent('kakao', '${rental.cr_mid}', '${mem.m_phone}', '${mem.m_name}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${total_price})">카카오페이 결제</button>

					</div>
				</div>
			</div>
		</div>
	</div>
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


<div class="clear"></div>


<jsp:include page="../include/footer.jsp"/>
</body>
</html>