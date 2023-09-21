package com.carindrive.vo;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Entity
@Table(name = "c_member")
@EqualsAndHashCode(of="m_id")
public class MemberVO {
	
	@Id
	private String m_id;
	private String m_pwd;
	private String m_name;
	private String m_email;
	private String m_phone;
	private String m_tel;
	private String m_birth;
	private int m_state=0;
	
	@CreationTimestamp
	private Timestamp regdate;
	

}
