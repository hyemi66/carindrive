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
<link href="${path}/css/rent_Wait.css" rel="stylesheet" />

</head>
<body>
<div class="CARBig">
  <jsp:include page="../include/header.jsp"/>
  </div>
  <div class="CARBig">
  

<div class="clear"></div>

<div id="bigbox"> <%--전체 틀--%>
	<p id="bar">결제 정보 확인</p>
	
  	<div class=box>
  	
    <div class="img">
				<img alt="${car.c_name}" src="${path}/images/car/${car.c_img}">   
	</div>
	</div>
	
	<div class=box>
		<div class="infobox">
		<h2>고객정보</h2>
			<p>예약자 성함: ${memberInfo.m_name}</p>
			<p>예약자 연락처: ${formattedPhone}</p>
		</div>
		
		<div class="infobox">
		<h2>차량정보</h2>
			<p>브랜드: ${car.c_brand}</p>
			차량이름: <span style="color: red;">${car.c_name}</span>
			<p>연식: ${car.c_year}년식</p>
			<p>색상: ${car.c_color}</p>
			<p>연료: ${car.c_oil}</p>
			<p>차종: ${car.c_type}</p>
		</div>
	</div>
	<div class=box>
		<div class="infobox">
		<h2>결제정보</h2>
			<p>렌트비용: <fmt:formatNumber value="${total_price}" type="number" pattern="#,###"/>원</p>
			<p>결제일자: ${rental.cr_rdate}
			<p>대여일자: 
			    <c:choose> <%--2023-10-07 23:30 이 형식을 jsp에서 출력할때 0000년 00월 00일 오후 00시 00분 으로 출력시도하기 --%>
			        <c:when test="${rental.cr_sdate eq '0001-01-01 01:01'}">-</c:when>
			        <c:otherwise>${rental.cr_sdate}</c:otherwise>
			    </c:choose>
			</p>
			<p>반납일자: 
			    <c:choose>
			        <c:when test="${rental.cr_edate eq '9999-01-01 01:01'}">-</c:when>
			        <c:otherwise>${rental.cr_edate}</c:otherwise>
			    </c:choose>
			</p>
		</div>
	</div>
<div class = "box">
		<div class = "rent">
	<a href="/rent/rent" class="cancle">예약취소</a>
		</div>
	
		<div class = "rent2">
	<button class="cardpay" onclick="payMent('card', '${rental.cr_mid}', '${mem.m_phone}', '${mem.m_name}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${total_price})">카드 결제</button>
	<button class="kakaopay" onclick="payMent('kakao', '${rental.cr_mid}', '${mem.m_phone}', '${mem.m_name}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${total_price})">카카오페이 결제</button>
		</div>
	</div>
</div>

</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>