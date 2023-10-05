<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시간 연장</title>
<link href="${path}/css/timeUp.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
<script src="${path}/js/jquery.js"></script>
</head>
<body>

<div class="timeBox">
	<div id="bigBox">
		<h2>-- 현재 렌트중인 차량 --</h2>
		<img src="../images/car/${car.c_img}">
		<table border="1">
			<tr>
				<th width="70">브랜드</th>
				<th width="100">이름</th>
				<th width="100">차종</th>
				<th width="100">기름</th>
				<th width="100">년도</th>
			</tr>
			<tr>
				<td align="center">${car.c_brand}</td>
				<td align="center">${car.c_name}</td>
				<td align="center">${car.c_type}</td>
				<td align="center">${car.c_oil}</td>
				<td align="center">${car.c_year}</td>
			</tr>
		</table>
	</div>
	<hr id="t_hr">
	<div id="plusBox">
		<form method="POST" action="/rent/timeUpPay">
			<table border="1">
				<tr>
					<th width="200">기존 반납시간</th>
					<td align="center" width="400">
						${rental.cr_edate}
					</td>
				</tr>
				<tr>
					<th width="200">연장 후 반납시간</th>
					<td align="center" width="400">
						<input type="hidden" name="c_num" id="c_num" value="${car.c_num}">
						<input type="hidden" name="cr_sdate" id="cr_sdate" value="${rental.cr_edate}">
						<input type="hidden" name="order_number" id="order_number" value="${rental.cr_order}">
						<input type="hidden" name="calculatedPrice" id="calculatedPrice">
						<input type="datetime-local" name="cr_edate" id="cr_edate" onchange="setMinValue()" value="${rental.cr_edate}" required>
					</td>
				</tr>
				<tr>
					<th>추가 가격</th>
					<td>
						<span id="priceDisplay">
							<c:choose>
								<c:when test="${not empty orderInfo.amount && orderInfo.amount > 0}">
									<fmt:formatNumber value="${orderInfo.amount}" type="number" pattern="#,###"/>원
								</c:when>
								<c:otherwise>0원</c:otherwise>
							</c:choose>
						</span>
					</td>
				</tr>
			</table>
			<input type="submit" value="결제요청">
		</form>
		<input type="hidden" value="선택완료" onclick="fetchPrice()">
	</div>
</div>




<script type="text/javascript">
	//기존반납일과 새로운 반납시간을 받아서 변수에 저장 
    let startDate = document.getElementById("cr_sdate");
    let endDate = document.getElementById("cr_edate");
    let order_numberValue = document.getElementById("order_number").value;

    // 기존의 반납시간을 endDate의 min 속성으로 설정
    endDate.setAttribute("min", startDate.value);

    function setMinValue() {
        // 기존의 반납시간과 새로운 반납시간 비교
        if (new Date(endDate.value) < new Date(startDate.value)) {
            alert("기존의 반납시간보다 작은 시간은 설정할 수 없습니다.");
            endDate.value = startDate.value;
        } else {
            let diffTime = new Date(endDate.value) - new Date(startDate.value);
            let diffHours = diffTime / (1000 * 60 * 60);

            if (diffHours > 2) {
                alert("시간 연장은 최대 2시간까지만 가능합니다.");
                endDate.value = new Date(new Date(startDate.value).getTime() + 2 * 60 * 60 * 1000).toISOString().slice(0, 16);
            } 

            document.getElementById("cr_edate").value = endDate.value;
            fetchPrice();
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
            alert("오류가 발생했습니다: " + error.responseText);
        }
    });
}


// 페이지 로드 시 초기 가격 계산
fetchPrice();
document.querySelector("form").addEventListener("submit", function(e) {
    console.log("c_num:", document.getElementById("c_num").value);
    console.log("cr_sdate:", document.getElementById("cr_sdate").value);
    console.log("cr_edate:", document.getElementById("cr_edate").value);
    console.log("order_number:", document.getElementById("order_number").value);
    console.log("calculatedPrice:", document.getElementById("calculatedPrice").value);
});


</script>
</body>
</html>
