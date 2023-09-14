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

        <c:forEach var="orderInfo" items="${orderInfos}" varStatus="status">
            <div class="box ${status.index > 1 ? 'hidden-history' : ''}">
                <div class="img">
				<img alt="${orderCarList[status.index].buyProductName}" src="${path}/images/car/${orderCarList[status.index].c_img}">
					                

                </div>
                <div class="member">
                    <h2>${status.index == 0 ? '최근에 예약한 차량' : '예약 내역'}</h2>
                    <p>렌탈 대여일자 :<span>${rentalMap[orderInfo.merchantId].cr_sdate} - ${rentalMap[orderInfo.merchantId].cr_edate}</span></p>
                    <p>예약자 성함: <span>${orderInfo.buyer_name}</span></p>
                    <p>예약자 연락처: <span>${orderInfo.buyer_phone}</span></p>
                    <p>예약한 차량: <span>${orderInfo.buy_product_name}</span></p>
                    <p>결제일자: <span>${orderInfo.buy_date}</span></p>
                    <p>렌트 비용: <span>${orderInfo.amount}원</span></p>
                    <p>주문 번호: <span>${orderInfo.merchantId}</span></p>
                    <p>주문한 차량 모델: <span>${orderCarDTO.buyProductName}</span></p>
    <p>차량 			<p>차량년식: <span>${orderCarDTO.carYear}</span></p>
    <p>차량 			<p>차량 색상: <span>${orderCarDTO.carColor}</span></p>
                    <c:if test="${!fn:contains(orderInfo.merchantId, '환불')}">
                        <form action="/rent/refund" method="post">
                            <input type="hidden" name="order_number" value="${orderInfo.merchantId}">
                            <button type="submit">환불하기</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </c:forEach>

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
    </div>

    <jsp:include page="../include/footer.jsp"/>
</body>
</html>
