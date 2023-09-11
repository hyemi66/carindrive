<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <button id="toggleHistory">접기</button>

    <c:forEach var="orderItem" items="${orderInfos}" varStatus="status">
        <div class="box ${status.index > 0 ? 'hidden-history' : ''}">
            <div class="img">
                <img alt="레이" src="${path}/images/${car.c_img}">
            </div>

            <div class="member">
                <c:choose>
                    <c:when test="${status.index == 0}">
                        <h2>최근에 예약한 차량</h2>
                    </c:when>
                    <c:otherwise>
                        <h2>예약 내역</h2>
                    </c:otherwise>
                </c:choose>
                <p>예약자 성함: <span>${orderItem.buyer_name}</span></p>
                <p>예약자 연락처: <span>${orderItem.buyer_phone}</span></p>
                <hr>
                <p>예약한 차량: <span>${orderItem.buy_product_name}</span></p>
                <p>결제일자: <span>${orderItem.buy_date}</span></p>
                <p>실제 대여일자: <span>${rental[status.index].cr_sdate} 부터</span></p>
                <p>반납일자: <span>${rental[status.index].cr_edate} 까지</span></p>
                <p>렌트 비용: <span>${orderItem.amount}원</span></p>
                <p>주문 번호: <span>${orderItem.merchantId}</span></p>
                <c:if test="${!fn:contains(orderItem.merchantId, '환불')}">
                    <form action="/rent/refund" method="post">
                        <input type="hidden" name="order_index" value="${orderItem.id}">
                        <input type="hidden" name="order_number" value="${orderItem.merchantId}">
                        <button type="submit">환불하기</button>
                    </form>
                </c:if>
            </div>
        </div>
    </c:forEach>

</div>

<script type="text/javascript"> 
    const toggleBtn = document.getElementById('toggleHistory');
    toggleBtn.addEventListener('click', function() {
        const histories = document.querySelectorAll('.hidden-history');
        histories.forEach(history => {
            history.style.display = history.style.display === 'none' ? 'flex' : 'none';
        });
        if(toggleBtn.innerText === '접기') {
            toggleBtn.innerText = '전체 목록 보기';
        } else {
            toggleBtn.innerText = '접기';
        }
    });
</script>

<jsp:include page="../include/footer.jsp"/>
</body>
</html>
