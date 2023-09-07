package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class RentalVO {

    private int rental_id;         // 렌트 아이디
    private int car_id;            // 차량 고유번호
    private String m_id;           // 회원 아이디
    private String reservation_date;  // 렌트 신청일 (날짜만 포함)
    private String rental_date_time;    // 실제 대여일 (날짜만 포함)
    private String return_date_time;    // 반납 날짜 (날짜만 포함)
    private double rental_cost;       // 렌트 비용
    private String merchantId;			//주문번호
	
}