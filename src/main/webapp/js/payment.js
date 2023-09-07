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
                url: "/controller/rent/savePaymentInfo", // 서버의 URL
                method: "POST",
                data: {
                	imp_uid : rsp.imp_uid,
                    merchant_uid: rsp.merchant_uid,
                    amount: rsp.paid_amount,
                    buyer_name: rsp.buyer_name,
                    buyer_tel: rsp.buyer_tel,
                    item_name: rsp.name
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
         	 location.href='/controller/rent/rent_Check?m_id=${rental.m_id}';
        } else {
          alert("결제에 실패했습니다.");
        }
    });
}

function kakaoPay(rental_m_id, mem_m_phone, mem_m_name, car_car_name, car_car_color, car_car_year, rental_cost_total) {
    IMP.init('imp87360186'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
    
    var showName = car_car_year+'년식 ' + car_car_color + ' ' + car_car_name;
    
    IMP.request_pay({
      pg: "kakaopay",
      pay_method: "card",
      merchant_uid : 'merchant_'+new Date().getTime(),
      name : showName,
      amount : rental_cost_total,  //원 단위로 변경하여 전달 (기본값이 1달러)
      buyer_name : rental_m_id,
      buyer_tel : mem_m_phone,
    }, function (rsp) { // callback
        if (rsp.success) {
          alert("결제가 완료되었습니다.");
       // Ajax로 서버에 결제 정보 전송
          $.ajax({
			    url: "/controller/rent/savePaymentInfo",
			    method: "POST",
			    contentType: "application/json",  // JSON 데이터 전송을 위해 설정
			    data: JSON.stringify({
			        imp_uid: rsp.imp_uid,
			        merchant_uid: rsp.merchant_uid,
			        amount: rsp.paid_amount,
			        buyer_name: rsp.buyer_name,
			        buyer_tel: rsp.buyer_tel,
			        item_name: rsp.name
			    }),
			    success: function(response) {
			        if (response.success) {
			            alert("결제 정보가 저장되었습니다.");
			        } else {
			            alert("결제 정보 저장에 실패했습니다.");
			        }
			    }
});
          location.href='/controller/rent/rent_Check?m_id=${rental.m_id}';
        } else {
          alert("결제가 취소되었습니다.");
        }
    });
}