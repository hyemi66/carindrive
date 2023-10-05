package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ServiceVO {
	private int cs_no;			// 게시판 번호
	private String cs_pwd;		// 글 비밀번호
	private String cs_title;	// 글제목
	private String cs_cont;		// 글내용
	private String cs_date;		// 등록날짜
	private String cs_type;		// 질문 종류 
	private int cs_hit; 			// 조회수
}
