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
<jsp:include page="../include/header.jsp"/>
<div class="clear"></div>

<div id="bigbox">
  <p id="bar">예약 내역</p>
  <div id="box">
      <div id="img">
        <img alt="레이" src="${path}/images/ray.jpg">
      </div>
       
      <!-- 로그인 정보가 있는 경우 -->
    <c:if test="${not empty rental}">
        <h1>렌탈 정보</h1>
        <!-- 렌탈 정보 표시 -->
        <p>렌탈비용: ${rental_cost_total}</p>
        <!-- 추가적인 렌탈 정보를 여기에 표시할 수 있습니다. -->
        
        <h2>주문 내역</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>BUYER_NAME</th>
                    <th>BUYER_PHONE</th>
                    <!-- 다른 필드들도 여기에 추가 -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="orderItem" items="${order}">
                    <tr>
                        <td>${orderItem.id}</td>
                        <td>${orderItem.buyer_name}</td>
                        <td>${orderItem.buyer_phone}</td>
                        <!-- 다른 필드들의 값도 여기에 추가 -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
    </c:if>
    
    <!-- 로그인 정보가 없는 경우 -->
    <c:if test="${empty rental}">
        <h1>예약 내역이 없습니다.</h1>
        <!-- 다른 메시지 또는 이미지를 추가할 수 있습니다. -->
    </c:if>
     <form action="/rent/refund" method="post">
    <!-- 주문 번호를 함께 전송합니다. 이 값이 환불 로직에서 사용됩니다. -->
    <input type="hidden" name="order_index" value="${orderInfo.id}">
    <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
    <button type="submit">환불하기</button>
	</form>
	</div>
</div>

<%--URL 안보이게 하기 --%>
<script type="text/javascript"> 
  history.replaceState({}, null, location.pathname); 
</script> 
 
<jsp:include page="../include/footer.jsp"/>
</body>
</html>
