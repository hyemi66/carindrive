<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="phone" value="${memberInfo.m_phone}" /> <%--전화번호를 010-1111-2222 형식으로 바꿈 --%>
<c:set var="formattedPhone" value="${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}" />

<% java.util.Date date = new java.util.Date(); %>
<fmt:formatDate value="<%= date %>" pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate"/>
<c:set var="currentDateTime" value="${formattedDate}"/> <%--현재날짜 --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상세정보</title>
    <link href="${path}/css/rent_details.css" rel="stylesheet"/>
    <script src="${path}/js/jquery.js"></script>
</head>
<body>

<div id="bigbox"> <%--전체 틀--%>
	<p id="bar">렌트 내역서</p>
	
  	<div class=box>
    <div class="img">
				<img alt="${carInfo.c_name}" src="${path}/images/car/${carInfo.c_img}">   
	</div>
	</div>
	
	<div class=box>
		<div class="infobox">
		<h2>고객정보</h2>
			<p>예약자 성함: ${memberInfo.m_name}</p>
			<p>예약자 연락처: ${formattedPhone}</p>
			<p>운전자 성함: 추후 수정</p>
			<p>운전자 연락처: 추후 수정</p>
		</div>
		
		<div class="infobox">
		<h2>차량정보</h2>
			<p>브랜드: ${carInfo.c_brand}</p>
			차량이름: <span style="color: red;">${carInfo.c_name}</span>
			<p>연식: ${carInfo.c_year}년식</p>
			<p>색상: ${carInfo.c_color}</p>
			<p>연료: ${carInfo.c_oil}</p>
			<p>차종: ${carInfo.c_type}</p>
		</div>
	</div>
	<div class=box>
		<div class="infobox">
		<h2>결제정보</h2>
			<p>주문번호: ${orderInfo.merchantId}</p>
			<p>결제일자: ${orderInfo.buy_date}</p>
			<p>렌트비용: <fmt:formatNumber value="${orderInfo.amount}" type="number" pattern="#,###"/>원</p>
			<c:choose>
				<c:when test="${orderInfo.refund == '정상결제'}">
					결제상태: <span style="color: blue;">${orderInfo.refund}</span>
				</c:when>
				<c:when test="${orderInfo.refund == '환불완료'}">
					결제상태: <span style="color: red;">${orderInfo.refund}</span>
				</c:when>
			</c:choose>
			<p>대여일자: ${rentalInfo.cr_sdate}</p>
			<p>반납일자: ${rentalInfo.cr_edate}</p>
		</div>
	</div>	
	
			
		<div class=box>
		<div class="infobox">
		    <c:choose>
		       	<c:when test="${orderInfo.refund == '정상결제' || currentDateTime < rentalInfo.cr_edate}">
		            <form action="/rent/timeUp" method="post">
		                <input type="hidden" name="c_num" value="${carInfo.c_num}">
		                <input type="hidden" name="cr_edate" value="${rentalInfo.cr_edate}">
		                <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
		                <button type="submit">시간연장</button>
		            </form>		
		        </c:when>
		        <c:otherwise>
		            <h2>시간연장불가</h2>
		        </c:otherwise>
		    </c:choose>
		</div>

		
		<div class="infobox">
			<c:choose>
				<c:when test="${orderInfo.refund == '정상결제'}">
                   <form action="/rent/refund" method="post" id="refundForm">
                      <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
                      <button type="submit">환불하기</button>
                  </form>
				</c:when>
				<c:when test="${orderInfo.refund == '환불완료' || currentDateTime > rentalInfo.cr_sdate}">
					<h2>환불불가</h2>
				</c:when>
			</c:choose>
		</div>
	</div>
</div><%--bigbox --%>

<script>
function openPopup(url) {
    var width = 1200; // 팝업 창 가로 크기
    var height = 1000; // 팝업 창 세로 크기
    var left = (screen.width - width) / 2; // 화면 가운데 정렬을 위한 좌표
    var top = (screen.height - height) / 2; // 화면 가운데 정렬을 위한 좌표

 // 팝업 창 열기 resizable=no'는 창의 크기 고정
    window.open(url, 'popup', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top + ', resizable=no');
}
</script>
        
</body>
</html>