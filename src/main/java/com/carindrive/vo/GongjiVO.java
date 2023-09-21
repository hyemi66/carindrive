package com.carindrive.vo;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@SequenceGenerator(//@SequenceGenerator 시퀀스 생성기 애너테이션
		  name="cs_no_seq_gename", 
		  sequenceName = "cs_no_seq",
		  initialValue = 1, 
		  allocationSize = 1 
		)
@Table(name="c_service")
@EqualsAndHashCode(of="cs_no")
public class GongjiVO {

	@Id
	@GeneratedValue(
			  strategy = GenerationType.SEQUENCE,
			  generator = "cs_no_seq_gename")
	private int cs_no;
	
	private String cs_name;
	private String cs_title;
	private String cs_cont;
	private int cs_hit;
	
	@CreationTimestamp
	private Timestamp cs_date;
	
	
	
}
