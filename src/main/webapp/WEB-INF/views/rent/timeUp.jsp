<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시간 연장</title>
    <script src="${path}/js/jquery.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
    
    
    
    현재 렌트중인 차량<br>
    ${car.c_name}
    <div id="menu01">
        <p>
            기존 반납시간<br>
            <input type="datetime-local" name="cr_sdate" id="cr_sdate" value="${rental.cr_edate}" required readonly>
        </p>
    </div>
    <div id="menu02">
        <p>
            반 납 하 는 시 간 <br>
            <input type="datetime-local" name="cr_edate" id="cr_edate" onchange="setMinValue()" required>
        </p>
    </div>
	<input type="hidden" value="선택완료" onclick="fetchPrice()">

<p>계산된 가격: <span id="priceDisplay">
    <c:choose>
        <c:when test="${not empty orderInfo.amount && orderInfo.amount > 0}">
            <fmt:formatNumber value="${orderInfo.amount}" type="number" pattern="#,###"/>원
        </c:when>
        <c:otherwise>
            0원
        </c:otherwise>
    </c:choose>
</span></p>

<form method="POST" action="/rent/timeUpPay">
	<input type="hidden" name="c_num" id="c_num" value="${car.c_num}">
	<input type="hidden" name="order_number" id="order_number" value="${rental.cr_order}">
    <input type="hidden" name="calculatedPrice" id="calculatedPrice">
    <input type="submit" value="결제요청">
</form>

<script type="text/javascript">
	//기존반납일과 새로운 반납시간을 받아서 변수에 저장 
    let startDate = document.getElementById("cr_sdate");
    let endDate = document.getElementById("cr_edate");
    let order_numberValue = document.getElementById("order_number").value;

    // 기존의 반납시간을 endDate의 min 속성으로 설정
    endDate.setAttribute("min", startDate.value);

    function setMinValue() {
        // 두 날짜 값을 비교
        if (new Date(endDate.value) < new Date(startDate.value)) {
            alert("기존의 반납시간보다 작은 시간은 설정할 수 없습니다.");
            endDate.value = startDate.value;
        } else {//날짜를 잘 선택하면
            fetchPrice();	//fetchPrice()함수 시작
        }
    }

    //가격을 천단위로 , 을 출력
    function formatNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    //렌탈비용 계산
    // 렌탈비용 계산 및 업데이트
function fetchPrice() {
    const c_numValue = document.getElementById("c_num").value;
    const cr_edateValue = endDate.value;
    const order_numberValue = document.getElementById("order_number").value;

    // cr_edate 값이 없는 경우 가격을 0원으로 설정
    if (!cr_edateValue) {
        document.getElementById("priceDisplay").innerText = "0원";
        return;
    }

    $.ajax({
        url: "/rent/calculatePrice", 
        type: "GET",
        data: {
            c_num: c_numValue,
            order_number: order_numberValue,
            cr_edate: cr_edateValue
        },
        success: function (price) {
            // 가격을 화면에 표시
            document.getElementById("priceDisplay").innerText = formatNumber(price) + "원";
            
            // 나온 가격을 calculatedPrice라는 변수에 저장 그리고 이 변수를  input hidden 에 사용해서 값을 넘김
            document.getElementById("calculatedPrice").value = price;
        },
        error: function (error) {
            console.error("Error fetching price:", error);
        }
    });
}


// 페이지 로드 시 초기 가격 계산
fetchPrice();


</script>
</body>
</html>
