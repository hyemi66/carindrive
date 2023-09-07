<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${path}/js/jquery.js"></script>
<!--  <script src="${path}/js/payment.js"></script>--> <!-- 결제 코드 js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
<link href="${path}/css/rent_Check.css" rel="stylesheet" />
<script>
function cardPay(rental_m_id, mem_m_phone, mem_m_name, car_car_name, car_car_color, car_car_year, rental_cost_total) {
    IMP.init('imp87360186'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
    
    var showName = car_car_year+'년식 ' + car_car_color + ' ' + car_car_name;
    IMP.request_pay({
      pg: "html5_inicis",
      pay_method: "card",
      merchant_uid : 'merchant_'+new Date().getTime(),
      name : showName,
      amount : rental_cost_total,
      buyer_name : rental_m_id,
      buyer_tel : mem_m_phone,
    }, function (rsp) { // callback
        if (rsp.success) {
        	alert("결제가 완료되었습니다 !");
        	// Ajax로 서버에 결제 정보 전송
            $.ajax({
                url: "/rent/savePaymentInfo", // 서버의 URL
                method: "POST",
                data: {
                    merchant_uid: rsp.merchant_uid,
                    amount: rsp.amount,
                    buyer_name: rsp.buyer_name,
                    buyer_tel: rsp.buyer_tel,
                    item_name: rsp.item_name
                },
                success: function(response) {
                    if (response.success) {
                        alert("결제 정보가 저장되었습니다.");
                        localStorage.setItem('payment_tid', rsp.imp_uid);

                    } else {
                        alert("결제 정보 저장에 실패했습니다.");
                    }
                }
            });
         	 location.href='/rent/rent_Check?m_id=${rental.m_id}';
        } else {
          alert("결제에 실패했습니다.");
        }
    });
}
function kakaoPay(rental_m_id, mem_m_phone, mem_m_name, car_car_name, car_car_color, car_car_year, rental_cost_total) {
	IMP.init('imp87360186');

	 var showName = car_car_year+'년식 ' + car_car_color + ' ' + car_car_name;
	IMP.request_pay({
	    pg : 'kakaopay',
	    pay_method : 'card', //카드결제
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : showName,
	    amount : rental_cost_total *1000, //판매가격
	    buyer_name : rental_m_id,
	    buyer_tel : mem_m_phone,
	}, function(rsp) {
	    if ( rsp.success ) {
		var msg = '결제가 완료되었습니다.';
		msg += '고유ID : ' + rsp.imp_uid;
		msg += '상점 거래ID : ' + rsp.merchant_uid;
		msg += '결제 금액 : ' + rsp.paid_amount;
		msg += '카드 승인번호 : ' + rsp.apply_num;
		   
		pay_info(rsp);
		
	    } else {
		var msg = '결제에 실패하였습니다.';
		msg += '에러내용 : ' + rsp.error_msg;
		
		location.href="goods_pay_fail.do?error_msg="+rsp.error_msg;
	    }

	});
}
	//비공개 방식으로 서버로 결제정보 전달
	function pay_info(rsp){
	      var form = document.createElement('form');
	      var objs;
	 
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_name');
	      objs.setAttribute('value', rsp.buyer_name);
	      form.appendChild(objs);
	 
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_phone');
	      objs.setAttribute('value', rsp.buyer_tel);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'member_email');
	      objs.setAttribute('value', rsp.buyer_email);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buy_addr');
	      objs.setAttribute('value', rsp.buyer_addr);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buy_product_name');
	      objs.setAttribute('value', rsp.name);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_buyid');
	      objs.setAttribute('value', rsp.imp_uid);
	      form.appendChild(objs);
	      
	      /*objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_merid');
	      objs.setAttribute('value', rsp.merchant_uid); //삭제하거나 수정예정
	      form.appendChild(objs);*/
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'amount');
	      objs.setAttribute('value', rsp.paid_amount);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_card_num');
	      objs.setAttribute('value', rsp.apply_num);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_pay_ok');
	      objs.setAttribute('value', rsp.success);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'buyer_postcode');
	      objs.setAttribute('value', rsp.buyer_postcode);
	      form.appendChild(objs);
	      
	      objs = document.createElement('input');	//삭제하거나 수정 예정
	      objs.setAttribute('type', 'hidden');
	      objs.setAttribute('name', 'merchantId');  // 폼의 필드 이름을 'merchantId'로 설정
	      objs.setAttribute('value', rsp.merchant_uid);  // 결제 응답에서 merchant_uid 값을 가져옵니다.
	      form.appendChild(objs);

	      form.setAttribute('method', 'post');
	      form.setAttribute('action', "/rent/rent_Check");	// /rent/rent_Check_List() 메서드 동작
	      document.body.appendChild(form);
	      form.submit();
	}

</script>
</head>
<body>
  <jsp:include page="../include/header.jsp"/>
  
  <div class="clear"></div>
<%-- 예약 선택 메뉴 --%>
<div class="mainmenu">
<div id="menu01">
	<input type="checkbox" name="accordian" id="car01">
	<label for="car01">2023.07.17 | 09:00</label>
	<div><p><input type="date"></p></div>
</div>
<div  id="menu02">
	<input type="checkbox" name="accordian" id="car02">
	<label for="car02">2023.07.17 | 09:00</label>
	<div><p><input type="date"></p></div>
</div>
<div  id="menu03">
	<input type="checkbox" name="accordian" id="car03">
	<label for="car03">전체</label>
	<div>
		<p><a href="#">전체</a></p><br>
		<p><a href="#">경형</a></p><br>
		<p><a href="#">소형</a></p><br>
		<p><a href="#">중형(세단)</a></p><br>
		<p><a href="#">중형(SUV)</a></p><br>
		<p><a href="#">전기차</a></p><br>
	</div>
</div>
<div  id="menu04">
	<input type="checkbox" name="accordian" id="car04">
	<label for="car04">대여시간</label>
	<div><p><input type="time">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;<input type="time"></p></div>
</div>
</div>

<div class="clear"></div>

<div class="carname">
	<div><h1>KIA 레이</h1></div>
	<table border="1">
		<tr>
			<td>
				<img src="${path}/images/car/Gcar01.png">
			</td>
			<td id="sub">
				<p>차량명 : 2023 KIA 레이</p>
				<hr>
				<p>차량정보 : 가솔린 | 경형 RV | 2023년</p>
				<hr>
				<p>비고 :<br>나<br>는<br>레<br>이<br>임<br></p>
				<p><a href="${path}/rent/rent">차량 다시 선택</a></p>
			</td>
		</tr>
	</table>
	
	<div><h3>차량 예약하기</h3></div>
	<div id="carpay">
		<div id="box">
		
				<div id="member">
					<h2>&nbsp;예약자 정보</h2>
					아이디: <span>${rental.m_id}</span><br> 연락처: <span>${mem.m_phone}</span><br>
					이름: <span>${mem.m_name}</span>
					<hr>

					<h2>&nbsp;차량 정보</h2>
					차종: <span>${car.car_name}</span><br> 차량색상: <span>${car.car_color}</span><br>
					연식: <span>${car.car_year}년식</span><br>
				</div>

				<div id="car">
					<h2>&nbsp;렌트 정보</h2>
					예약일자: <span>${rental.reservation_date}</span><br> 실제 대여일자: <span>${rental.rental_date_time}부터</span><br>
					반납일자: <span>${rental.return_date_time}까지</span><br> 렌트 비용: <span>${rental_cost_total}원</span><br>
					<button
						onclick="cardPay('${rental.m_id}', '${mem.m_phone}', '${mem.m_name}', '${car.car_name}', '${car.car_color}', '${car.car_year}', ${rental_cost_total})">카드
						결제</button>
					<button
						onclick="kakaoPay('${rental.m_id}', '${mem.m_phone}', '${mem.m_name}', '${car.car_name}',  '${car.car_color}', '${car.car_year}', ${rental_cost_total})">카카오페이
						결제</button>
					</div>
				</div>
			</div>
	<hr>
대여관련 안내사항
<br><br><br><br><br><br>
보험적용 불가사항
<br><br><br><br>
취소/환불안내
<br><br><br><br><br>
취소 및 환불규정
<br><br><br><br><br><br>
</div>



<div class="clear"></div>


<jsp:include page="../include/footer.jsp"/>
</body>
</html>