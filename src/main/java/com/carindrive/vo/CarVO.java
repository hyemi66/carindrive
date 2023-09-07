package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CarVO { // c_car 테이블
   
   private int c_num;		 		// 차량코드번호
   private String c_name; 			// 차량 이름
   private String c_brand;			// 차량 브랜드
   private String c_year;			// 차량 년식 
   private String c_color; 			// 차량 색상
   private double c_price; 			// 차량 렌트 비용
   private int c_ok; 				// 차량 대여 가능 여부
   private String c_img; 			// 차량 이미지 이름
   
}