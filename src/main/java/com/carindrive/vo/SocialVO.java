package com.carindrive.vo;

import lombok.Data;

@Data
public class SocialVO { //SocialLogin 유저 정보 테이블

	private Long Id;//시퀀스
	
	private String username; // 아이디
	
	private String password; 
	
	private String email; 
	
	private int k_state; 
	
	private String role; //권한
	
	private String create_date;//가입날짜
	
	
	
	
	
	
}
