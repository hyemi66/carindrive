<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
<link href="${path}/css/rent_Check.css" rel="stylesheet" />
<script src="${path}/js/jquery.js"></script>


</head>
<body>
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<div class="clear"></div>

<div id="bigbox">
  <p id="bar">예약 내역</p>
  <div id="box">
      <div id="img">
        <img alt="레이" src="${path}/images/ray.jpg">
      </div>
            
      <div id="member">
        <h2>&nbsp;방금 결제하신 정보</h2>
        예약자 성함: <span>${orderInfo.buyer_name}</span><br>
        예약자 연락처: <span>${orderInfo.buyer_phone}</span><hr>
        예약한 차량: <span>${orderInfo.buy_product_name}</span><br>
        결제일자: <span>${orderInfo.buy_date}</span><br>
        실제 대여일자: <span>${rental.cr_sdate}부터</span><br>
        반납일자: <span>${rental.cr_edate}까지</span><br>
        렌트 비용: <span>${orderInfo.amount}원</span><br>
        주문 번호: <span>${orderInfo.merchantId}</span><br>
	     <form action="/rent/refund" method="post">
	    <!-- 주문 번호를 함께 전송합니다. 이 값이 환불 로직에서 사용됩니다. -->
	    <input type="hidden" name="order_index" value="${orderInfo.id}">
	    <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
	    <input type="hidden" name="order_name" value="${orderInfo.buyer_name}">
	    <button type="submit">환불하기</button>
		</form>
      </div>
  </div>
</div>

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
