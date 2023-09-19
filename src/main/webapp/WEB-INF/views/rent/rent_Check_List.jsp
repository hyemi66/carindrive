<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="phone" value="${memberInfo.m_phone}" />
<c:set var="formattedPhone" value="${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}" />

<% java.util.Date date = new java.util.Date(); %>
<fmt:formatDate value="<%= date %>" pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate"/>
<c:set var="currentDateTime" value="${formattedDate}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 확인</title>
    <link href="${path}/css/rent_Check.css" rel="stylesheet"/>
    <script src="${path}/js/jquery.js"></script>
    <script src="${path}/js/rentList.js"></script>
</head>
<body>
    <jsp:include page="../include/header.jsp"/>
    <div class="clear"></div>

    <div id="bigbox">
        <p id="bar">예약 내역</p>
        
<c:choose>
   <c:when test="${fn:length(orderInfos) == 0}">
   <div class="noRentalbox">
   	<img alt="차로고" src="${path}/images/carlogo.jpg" width="500" height="300">
   	<span>예약된 차량이 없습니다.</span>
   </div>
   </c:when>
   
   <c:otherwise>
        <div>
		    <label><input type="radio" name="filter" value="all" checked> 환불 포함 보기</label>
		    <label><input type="radio" name="filter" value="notRefunded"> 환불 제외 보기</label>
		</div>
		<br>
        <c:forEach var="orderInfo" items="${orderInfos}" varStatus="status">
            <div class="box">
                <div class="img">
				<img alt="${carInfos[status.index].c_name}" src="${path}/images/car/${carInfos[status.index].c_img}">   
                </div>
                
                <div class="infobox">
				    <h2>${status.index == 0 ? '최근에 예약한 차량' : '예약 내역'}</h2>
				
				    <div class="info-line">
				        <label>렌탈 대여/반납 일시 :</label>
				        <span>${rentalMap[orderInfo.merchantId].cr_sdate} - ${rentalMap[orderInfo.merchantId].cr_edate}</span>
				    </div>
				    <div class="info-line">
				        <label>예약자 성함:</label> 
				        <span data-member-name>${memberInfo.m_name}</span>
				    </div>
				    <div class="info-line">
				        <label>예약자 연락처:</label> 
				        <span data-member-phone>${formattedPhone}</span>
				    </div>
				    <div class="info-line">
				        <label>예약한 차량:</label> 
				        <span>${orderInfo.buy_product_name}</span>
				    </div>
				    <div class="info-line">
				        <label>결제일자:</label> 
				        <span>${orderInfo.buy_date}</span>
				    </div>
				    <div class="info-line">
				        <label>렌트 비용:</label> 
				        <span><fmt:formatNumber value="${orderInfo.amount}" type="number" pattern="#,###"/>원</span>
				    </div>
				    <div class="info-line">
				        <label>주문 번호:</label> 
				        <span>${orderInfo.merchantId}</span>
				    </div>
				    <div class="info-line">
				        <label>결제 상태:</label> 
				        <c:choose>
				            <c:when test="${orderInfo.refund == '정상결제'}">
				                <span style="color: blue;">${orderInfo.refund}</span>
				            </c:when>
				            <c:when test="${orderInfo.refund == '환불완료'}">
				                <span style="color: red;">${orderInfo.refund}</span>
				            </c:when>
				        </c:choose>
				      </div>
				    </div>
	            </div>
	        </c:forEach>
	      </c:otherwise>
	   </c:choose>
	</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>
