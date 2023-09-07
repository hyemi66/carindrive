package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CarVO {

    private int car_id;         // 차량 고유번호
    private String car_name;    // 차량 이름
    private String car_brand;   // 차량 브랜드
    private int car_year;       // 차량 연식
    private String car_color;   // 차량 색상
    private double car_price;   // 차량 가격 (1분당 가격)
    private int car_availability; // 차량 이용 가능 여부
    
    // Getter와 Setter는 Lombok으로 생성할 수도 있습니다.
}
