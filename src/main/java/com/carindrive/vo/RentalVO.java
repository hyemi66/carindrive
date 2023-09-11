package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RentalVO {

    private int cr_num; // 예약번호
    private String cr_mid; // 유저아이디
    private String cr_cname; // 차량이름
    private String cr_rdate; // 예약일자
    private String cr_sdate; // 실제 대여일
    private String cr_edate; // 반납일자
    private double cr_price; // 렌트비용
    private String cr_order; // 주문번호
   
}