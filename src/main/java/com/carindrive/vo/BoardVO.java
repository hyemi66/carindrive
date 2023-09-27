package com.carindrive.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO { // c_service 테이블

	private String cs_no;	// 작성자 아이디
	private String cs_id; 		// 작성자 아이디
	private String cs_pwd; 		// 작성자 비밀번호
	private String cs_title; 	// 글제목
	private String cs_cont; 		// 글내용
	private Date cs_date; 		// 등록날짜(수정일 포함)
	private int cs_hit; 			// 조회수
	private int startrow; //시작행 번호
	private int endrow;   //끝행 번호


}