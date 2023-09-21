package com.carindrive.vo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Entity
@Table(name="c_admin") //admin테이블 생성
@EqualsAndHashCode(of="ca_id")

public class AdminVO {
	
	private int admin_no;
	
	@Id
	private String ca_id;
	private String ca_pwd;
	private String ca_name;
	
}
