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

</head>
<body>
<div class="CARBig">
  <jsp:include page="../include/header.jsp"/>
  </div>
  <div class="CARBig">
  
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
<br><br>
<div class="mainmenu">
<div class="carname">
	<h1>${car.c_brand} ${car.c_name}</h1>
	<div class="carInfo">
		<div id="carImg">
			<img src="${path}/images/car/${car.c_img}">
		</div>
		<div id="carInfo">
			<h2>차량정보</h2>
				<hr>
				<ul>
					<li>
						차량명 : ${car.c_brand} ${car.c_name}
					</li>
					<li>
						차량연식 : ${car.c_year}년식
					</li>
					<li>
						차량색상 : ${car.c_color}
					</li>
					<li>
						타입 : ${car.c_type}
					</li>
					<li>
						연료 : ${car.c_oil}
					</li>
				</ul>
				
		</div>
	</div>
	
	
	<hr>
	
	<div id="carRent">
		<input type="button" value="차 량 / 날 짜   다  시 선  택" onclick="location='${path}/rent/rent';">
		<input type="submit" value="예 &nbsp;&nbsp;약 &nbsp;&nbsp;하 &nbsp;&nbsp;기">
	</div>
	
	<hr>
	
	<div id="cp_intro">
		<h3>대여관련 안내사항</h3>
		<p>
			차량 인수 시간 08시~ 22시<br>
			(<font style="color:red">22시까지 도착 고객 한해</font> 22시까지 직원이 대기 하고 있으며 그 이후 도착시 다음날 인수 하셔야 합니다.)<br>
			<br>
			<font style="color:red">20시이후 배차료가 부과됩니다</font><br>
			20시 인수 <font style="color:red">10,000</font><br>
			20:30 ~ 21시 인수 <font style="color:red">15,000</font><br>
			22시 인수 <font style="color:red">20,000</font><br>
			<br>
			차량 반납 시간 07시~20시<br>
			첫 셔틀버스가 06시50분~7시사이에 출발하기에 50분 이전에 오셔서 반납 안내 받으시면 됩니다.<br>
			동시 예약이 된 경우 신청 시간 기준으로 확인하여 예약이 진행되기에 마감시 배차가 불가할 수 있습니다.<br>
			전 차량 금연차량으로 운영되고 있으며 애완견 동반 탑승이 불가합니다.<br>
			현역 군인(직업군인 제외)은 대여 불가합니다.<br>
			운전자가 외국인인 경우국내면허증을 소지하는경우 대여 가능합니다.<br>
			(한국어가 전혀 안되는경우 국제면허증/ 여권지참시 추가 운전자로만 등록 후 운전가능)<br>
			만21세/운전경력 만1년 이상 조건에 충족하더라도 운전 미숙이라고 판단되면 배차가 거부될 수 있습니다.<br>
			<font style="color:red">완전자차는 만 22세부터 가입이 가능합니다.</font><br>
			상담문의 : 000-000-0000 (주중/주말 09:00~18:30)
		</p>
		<h3>보험적용 불가사항</h3>
		<p>
			완전자차는 키,타이어,휠은 소모품으로 보험처리가 불가 합니다.<br>
			고객 과실로 인한 출동서비스는 출동비를 별도로 부담하셔야 합니다. (배터리 방전, 타이어교체 및 펑크수리, 견인및구난, 폭설로 인한 출동, 차량체인탈부착 등)
		</p>
		<h3>취소/환불안내</h3>
		<p>
			환불/변경/취소 신청은 유선상(000-000-0000)으로만 가능합니다.<br>
			환불규정은 기간에 따라 환불 요금이 변동될 수 있으며, 당사 업무시간 내(주중/주말 09:00~18:30 ) 에 취소 및 변경을 하셔야 적용됩니다.<br>
			개인 사정으로 인해 취소 할 경우 취소 수수료가 부과됩니다.<br>
			천재지변에 의해 취소가 될 경우에는 취소 확인할 수 있는 확인서(결항증명서)를 보내 주셔야 취소 수수료 없이 환불이 가능합니다.
		</p>
		<h3>취소 및 환불규정</h3>
		<table border="1">
			<tr>
				<td>&nbsp;예약 취소일</td> <td>&nbsp;취소 수수료</td>
			</tr>
			<tr>
				<td>&nbsp;인수일 기준  3 일전</td> <td>&nbsp;모든 금액 환불</td>
			</tr>
			<tr>
				<td>&nbsp;인수일 기준  2 일전</td> <td>&nbsp;총 대여금의 50% 수수료부과</td>
			</tr>
			<tr>
				<td>&nbsp;인수일 기준 1 일전 ~ 당일</td> <td>&nbsp;환불 불가</td>
			</tr>
		</table>
	</div>
</div>
</div>

</form>
<br><br>
<div class="clear"></div>

<%--URL 안보이게 하기 --%>
<script type="text/javascript"> 
  history.replaceState({}, null, location.pathname); 
</script> 

</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>