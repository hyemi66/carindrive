package com.carindrive.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class MemberVO { 

   private String m_id; //회원 아이디
   private String m_pwd; //회원 비밀번호
   private String m_name; //회원 이름
   private String m_email; //회원 이메일
   private String m_phone; //회원 번화번호
   private String m_tel; //통신사
   private String m_birth; //회원 생년월일
   private int m_state; //가입회원이면 1, 탈퇴회원이면 2
   
   private String regdate;//등록날짜
   

   
   
}