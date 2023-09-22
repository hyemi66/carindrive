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
			<input type="submit" value="다 &nbsp;&nbsp;시 &nbsp;&nbsp;선 &nbsp;&nbsp;택">
		</div>
	<hr>
	<br><br>
	<div id="carpay">
		<div id="box">
		
			<div id="bar"><h3>결제 정보 확인</h3></div>
			    <div class="box">
			        <div class="member">
			            <h2 class ="title">&nbsp;예약자 정보</h2>
			            <span class = "mtitle">아이디 :</span> <span>${rental.cr_mid}</span><br>
			            <span class = "mtitle">연락처 :</span> <span>${formattedPhone}</span><br>
			            <span class = "mtitle">이름 :</span> <span>${mem.m_name}</span>
			            <hr>
			        <div class="car">
			            <h2>&nbsp;차량 정보</h2>
			            <span class = "mtitle">차종 :</span> <span>${car.c_brand}&nbsp;${car.c_name}</span><br>
			            <span class = "mtitle">차량색상 :</span> <span>${car.c_color}</span><br>
			            <span class = "mtitle">연식 :</span> <span>${car.c_year}년식</span><br>
			        </div>
			        <div class="rent">
			            <h2>&nbsp;렌트 정보</h2>
			            <span class = "mtitle">예약일자 :</span> <span>${rental.cr_rdate}</span><br>
			            <span class = "mtitle">실제 대여일자 :</span> <span>${rental.cr_sdate}부터</span><br>
			            <span class = "mtitle">반납일자 :</span> <span>${rental.cr_edate}까지</span><br>
			            <span class = "mtitle">렌트 비용 :</span> <span><fmt:formatNumber value="${total_price}" type="number" pattern="#,###"/>원</span><hr>
					
					
<button onclick="payMent('card', '${rental.cr_mid}', '${mem.m_phone}', '${mem.m_name}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${total_price})">카드 결제</button>
<button onclick="payMent('kakao', '${rental.cr_mid}', '${mem.m_phone}', '${mem.m_name}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${total_price})">카카오페이 결제</button>

					</div>
				</div>
			</div>
		</div>
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
				<td>&nbsp;인수일기준 2 ~ 3일전</td> <td>&nbsp;총 대여금의 20% 수수료부과</td>
			</tr>
			<tr>
				<td>&nbsp;인수일기준 1 ~ 당일</td> <td>&nbsp;총 대여금의 24시간 수수료부과</td>
			</tr>
		</table>
	</div>
</div>

<br><br>

<div class="clear"></div>


<jsp:include page="../include/footer.jsp"/>
</body>
</html>