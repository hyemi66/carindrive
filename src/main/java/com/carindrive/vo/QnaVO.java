package com.carindrive.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Data
public class QnaVO {

	private int cq_no;		// 게시판 번호
	private String cq_id;	// 글쓴이
	private String cq_pwd;	// 글 비밀번호
	private String cq_title;	// 글제목
	private String cq_cont;	// 글내용
	private String cq_date;	// 등록날짜
	private String cq_file; // 첨부파일
	
	private int qna_replygroup; 	// 원볼글과 답변글을 묶어주는 그룹 번호값
	private int qna_replytype;	// 원본글(0)과 답변글(1,2 ... ) 구분 번호  
	private int qna_replyindex;	// 답변글 정렬순서
	
}
