<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        
        <div>
		    <label><input type="radio" name="filter" value="all" checked> 환불 포함 보기</label>
		    <label><input type="radio" name="filter" value="notRefunded"> 환불 제외 보기</label>
		</div>
        
        <c:forEach var="orderInfo" items="${orderInfos}" varStatus="status">
            <div class="box ${status.index > 0 ? 'hidden-history' : ''}">
                <div class="img">
				<img alt="${carInfos[status.index].c_name}" src="${path}/images/car/${carInfos[status.index].c_img}">
					                

                </div>
                <div class="member">
                    <h2>${status.index == 0 ? '최근에 예약한 차량' : '예약 내역'}</h2>
                    <p>렌탈 대여일자 :<span>${rentalMap[orderInfo.merchantId].cr_sdate} - ${rentalMap[orderInfo.merchantId].cr_edate}</span></p>
                    <p>예약자 성함: <span>${orderInfo.buyer_name}</span></p>
                    <p>예약자 연락처: <span>${orderInfo.buyer_phone}</span></p>
                    <p>예약한 차량: <span>${orderInfo.buy_product_name}</span></p>
                    <p>결제일자: <span>${orderInfo.buy_date}</span></p>
                    <p>렌트 비용: <span><fmt:formatNumber value="${orderInfo.amount}" type="number" pattern="#,###"/>원</span></p>
                    <p>결제 상태: 
					    <c:choose>
					        <c:when test="${orderInfo.refund == '정상결제'}">
					            <span style="color: blue;">${orderInfo.refund}</span>
					        </c:when>
					        <c:when test="${orderInfo.refund == '환불완료'}">
					            <span style="color: red;">${orderInfo.refund}</span>
					        </c:when>
					    </c:choose>
					</p>
                    <p>주문 번호: <span>${orderInfo.merchantId}</span></p>
                    <c:if test="${!fn:contains(orderInfo.refund, '환불완료')}">
                        <form action="/rent/refund" method="post">
                            <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
                            <button type="submit">환불하기</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </c:forEach>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {  // 페이지 로딩 완료 후 실행
    const boxes = document.querySelectorAll('.box');  // 모든 주문 박스 선택

    // 라디오 버튼의 상태에 따라 주문 목록 필터링
    document.querySelectorAll('input[name="filter"]').forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'all') {
                boxes.forEach(box => {
                    box.style.display = 'flex';  // 'block' 대신 'flex' 사용
                });
            } else if (this.value === 'notRefunded') {
                boxes.forEach(box => {
                    const refundStatus = box.querySelector('span[style="color: red;"]');
                    if (refundStatus && refundStatus.textContent.trim() === '환불완료') {
                        box.style.display = 'none';
                    } else {
                        box.style.display = 'flex';  // 'block' 대신 'flex' 사용
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
