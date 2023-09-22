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
    <input type="hidden" name="c_num" id="c_num" value="${car.c_num}">
    <input type="hidden" name="order_number" id="order_number" value="${rental.cr_order}">
    
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
    <input type="hidden" name="price" value="${orderInfo.amount}">
    <input type="submit" value="결제요청">
</form>


<%--9월22일 여기까지 작업완료 현재 비동기식으로 결제창 구현하다가 실패했고 비동기식으로 가격을 받고 그것에 맞춰서
새로운 결제창을 띄워서 그곳에 결제에 필요한 값들을 넘기고 view는 버튼두개만 보이게 설정하려고 했음
가능하다면 비동기식창 timeUp창에서 바로 결제버튼을 누르면 결제가 되도록 해야함
현재문제는 렌트비용이 자바스크립트로 넘어가지않음 --%>



<button onclick="payMent('card', '${rental.cr_mid}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${orderInfo.amount}')">카드 결제</button>
<button onclick="payMent('kakao', '${rental.cr_mid}', '${car.c_name}', '${car.c_color}', '${car.c_year}', ${orderInfo.amount})">카카오페이 결제</button>

<script>
var globalBuyDate; 	// 전역 변수로 buy_date 선언 결제일자 새로갱신
function payMent(paymentType, rental_cr_mid, car_c_name, car_c_color, car_c_year, orderInfo_amount) {
	console.log("Payment amount:", orderInfo_amount); // 이 부분을 추가합니다.
	

	if (typeof orderInfo_amount === 'undefined' || !orderInfo_amount) {
	    alert('결제 금액을 확인할 수 없습니다.');
	    return;
	}

	IMP.init('imp87360186');

	 var showName = car_c_year+'년식 ' + car_c_color + ' ' + car_c_name;
	 var pgValue;
	 globalBuyDate = new Date().getTime();	// 날짜 값을 전역 변수에 저장

	    if (paymentType === "card") {
	        pgValue = "html5_inicis";
	    } else if (paymentType === "kakao") {
	        pgValue = "kakaopay";
	    }
	 //IMP.request_pay() 함수는 내부적으로 정의된 파라미터만 처리하므로, buy_date와 같은 '사용자 정의 파라미터는 무시'된다.
	 //그렇기 때문에 결제 후 콜백 함수 내부에서 rsp.buy_date를 참조하려고 하면 값이 없어서 null이 된다.
	 //buy_date를 '전역 변수로 설정'하여 payMent 함수에서 값을 할당하고, 콜백 함수 내에서 이 값을 사용하는 방식으로 수정
	 
	IMP.request_pay({
	    pg : pgValue,
	    pay_method : 'card', //카드결제
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : showName,
	    amount : orderInfo_amount, //판매가격
	    buyer_name : rental_cr_mid,
	}, function(rsp) {
	    if ( rsp.success ) {
		var msg = '결제가 완료되었습니다.';
		msg += '고유ID : ' + rsp.imp_uid;
		msg += '상점 거래ID : ' + rsp.merchant_uid;
		msg += '결제 금액 : ' + rsp.paid_amount;
		msg += '카드 승인번호 : ' + rsp.apply_num;
		   
		pay_info(rsp);
		
	    } else {
	        var errorMsg = '결제가 취소되었습니다.';
	        alert(errorMsg);
	        history.back();	//이전 페이지로 돌아가기
	    }
	});
}
//데이터 담아서 비동기식으로 JSON타입으로 데이터 전송
	function pay_info(rsp) {
    var orderData = {
        buyer_name: rsp.buyer_name,
        buyer_phone: rsp.buyer_tel,
        member_email: rsp.buyer_email,
        buy_addr: rsp.buyer_addr,
        buy_product_name: rsp.name,
        buyer_buyid: rsp.imp_uid,
        amount: rsp.paid_amount,
        buyer_card_num: rsp.apply_num,
        buyer_pay_ok: rsp.success,
        buyer_postcode: rsp.buyer_postcode,
        merchantId: rsp.merchant_uid,
        paid_at: globalBuyDate,		//결제일자를 paid_at 변수로 받음 paid_at를 컨트롤러로 가공해서 buy_date로 만들것임
    };

 // AJAX 요청
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "/rent/rent_Check",
        data: JSON.stringify(orderData),
        dataType: "json",
        success: function(map) {
            console.log(map); 
            console.log("Success value:", map.success);
            
            if(map.success) {
            	const orderInfo = map.orderInfo;
                const rental = map.rental;
                location.href = map.redirectUrl	 // 서버에서 지정한 URL로 리디렉트

        }else {
                alert("결제 정보 처리 중 오류 발생 다시 시도해주세요");
                history.back(); //이전 페이지로 이동
        }
    },
        error: function(error) {
        console.error("Error:", error); //콘솔에 에러 로그 출력
            alert("오류로 인해서 결제가 취소되었습니다. 다시 시도해주세요");
            location.href = "/rent/rent";
        }
	});
}
</script>

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
    const order_numberValue = document.getElementById("order_number").value; // 주문번호 추가

    // cr_edate 값이 없는 경우 가격을 0원으로 설정
    if (!cr_edateValue) {
        document.getElementById("priceDisplay").innerText = "0원";
        return;
    }

    $.ajax({
        url: "/rent/calculatePrice", // 요청 URL 수정
        type: "GET",
        data: {
            c_num: c_numValue,
            order_number: order_numberValue,
            cr_edate: cr_edateValue
        },
        success: function (price) {
            document.getElementById("priceDisplay").innerText = formatNumber(price) + "원";
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
