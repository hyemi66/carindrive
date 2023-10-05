package com.carindrive.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO { 

	private String m_id; 
	private String m_pwd; 
	private String m_name; 
	private String m_email; 
	private String m_phone; 
	private String m_tel; 
	private String m_birth; 
	
	
	private String m_regdate;
   
}