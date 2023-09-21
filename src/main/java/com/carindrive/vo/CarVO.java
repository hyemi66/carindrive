package com.carindrive.vo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@SequenceGenerator(//@SequenceGenerator 시퀀스 생성기 애너테이션
		  name="car_seq_gename", 
		  sequenceName = "car_seq",
		  initialValue = 1, 
		  allocationSize = 1 
		)
@Table(name="c_car")
@EqualsAndHashCode(of="c_num")
public class CarVO {

	@Id
	@GeneratedValue(
			  strategy = GenerationType.SEQUENCE,
			  generator = "car_seq_gename")
	private int c_num;
	
	private String c_name;
	private String c_brand;
	private String c_year;
	private String c_color;
	private String c_type;
	private String c_type2;
	private String c_oil;
	private int c_price;
	private int c_ok;
	private String c_img;
	
}
