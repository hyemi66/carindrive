package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderCarDTO {
    private String buyerName;        // 구매자 이름
    private String buyProductName;   // 주문한 차량 모델 이름
    private String carYear;          // 차량 년식
    private String carColor;         // 차량 색상
    
    public OrderCarDTO() {}

    // 생성자, 게터, 세터 등 필요한 메서드 추가
}

