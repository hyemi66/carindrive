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
    <link href="${path}/css/rent_Check.css" rel="stylesheet" />
    <script src="${path}/js/jquery.js"></script>
</head>
<body>
    <jsp:include page="../include/header.jsp"/>
    <div class="clear"></div>

    <div id="bigbox">
        <p id="bar">예약 내역</p>
        
        <%--라디오 버튼 --%>
        <div>
		    <label><input type="radio" name="filter" value="all" checked> 환불 포함 보기</label>
		    <label><input type="radio" name="filter" value="notRefunded"> 환불 제외 보기</label>
		</div>
        
        <%--주문 항목 --%>
        <c:forEach var="orderInfo" items="${orderInfos}" varStatus="status">
            <div class="box ${status.index > 0 ? 'hidden-history' : ''}">
                <div class="img">
				<img alt="${carInfos[status.index].c_name}" src="${path}/images/car/${carInfos[status.index].c_img}">   
                </div>
                <div class="member">
                    <h2>${status.index == 0 ? '최근에 예약한 차량' : '예약 내역'}</h2>
                    렌탈 대여/반납 일시 : <span>${rentalMap[orderInfo.merchantId].cr_sdate} - ${rentalMap[orderInfo.merchantId].cr_edate}</span><br>
                    예약자 성함: <span>${memberInfo.m_name}</span><br>
                    예약자 연락처: <span>${formattedPhone}</span><br>
                    예약한 차량: <span>${orderInfo.buy_product_name}</span><br>
                    결제일자: <span>${orderInfo.buy_date}</span><br>
                    렌트 비용: <span><fmt:formatNumber value="${orderInfo.amount}" type="number" pattern="#,###"/>원</span><br>
                    결제 상태: 
					    <c:choose>
					        <c:when test="${orderInfo.refund == '정상결제'}">
					            <span style="color: blue;">${orderInfo.refund}</span><br>
					        </c:when>
					        <c:when test="${orderInfo.refund == '환불완료'}">
					            <span style="color: red;">${orderInfo.refund}</span><br>
					        </c:when>
					    </c:choose>
					
                    주문 번호: <span>${orderInfo.merchantId}</span>
                    
                    <c:set var="rentalStartDateTime" value="${fn:substring(rentalMap[orderInfo.merchantId].cr_sdate, 0, 19)}"/>
				    <c:if test="${!fn:contains(orderInfo.refund, '환불완료') && rentalStartDateTime gt currentDateTime}">
				        <form action="/rent/refund" method="post">
				            <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
				            <button type="submit">환불하기</button>
				        </form>
				    </c:if>
                </div>
            </div>
        </c:forEach>

<script type="text/javascript">
		//문서의 내용이 모두 로드된 후에 함수를 실행
		document.addEventListener('DOMContentLoaded', function() {
		    // 모든 'box' 클래스를 가진 요소를 선택
		    const boxes = document.querySelectorAll('.box');
		    // 'filter'라는 이름을 가진 모든 라디오 버튼을 선택하여 반복 처리
		    document.querySelectorAll('input[name="filter"]').forEach(radio => {
		        // 라디오 버튼의 값이 변경될 때의 이벤트를 등록합니다.
		        radio.addEventListener('change', function() {
		            // 선택된 라디오 버튼의 값이 'all'인 경우
		            if (this.value === 'all') {
		                // 모든 'box' 요소를 표시
		                boxes.forEach(box => {
		                    box.style.display = 'flex';
		                });
		            } 
		            // 선택된 라디오 버튼의 값이 'notRefunded'인 경우
		            else if (this.value === 'notRefunded') {
		                // 각 'box' 요소에 대해서 반복 처리
		                boxes.forEach(box => {// 각 'box' 내부에서 'color: red;' 스타일을 가진 <span> 요소를 찾음
		                    const refundStatus = box.querySelector('span[style="color: red;"]');
		                    // 해당 상태가 '환불완료'이면 'box' 요소를 숨김
		                    if (refundStatus && refundStatus.textContent.trim() === '환불완료') {
		                        box.style.display = 'none';
		                    } // 그렇지 않으면 'box' 요소를 표시합니다.
		                    else {
		                        box.style.display = 'flex';
		                    }
		                });
		            }
		        });
		    });
		});
</script>


    </div>

    <jsp:include page="../include/footer.jsp"/>
</body>
</html>
