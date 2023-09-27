package com.carindrive.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaVO { // c_qna 테이블
   
   private int cq_no; // 글번호
   private String cq_id; // 작성자 아이디
   private String cq_pwd; // 작성자 비밀번호
   private String cq_title; // 글제목
   private String cq_cont; // 글내용
   private Date cq_date; // 등록일자
   private String cq_ment; // (관리자 댓글)
   private int startrow; //시작행 번호
   private int endrow;   //끝행 번호
}