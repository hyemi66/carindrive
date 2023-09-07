package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MemberVO {
	
	private String m_id;
	private String m_pwd;
	private String m_birth;
	private String m_name;
	private String m_email;
	private String user_hp_type;
	private String m_phone;

}
