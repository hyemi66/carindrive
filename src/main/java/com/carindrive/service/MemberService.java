package com.carindrive.service;

import java.util.List;

/*
import com.carindrive.vo.MemberVO;

public interface MemberService {

	//회원가입 메서드
	//void insertMember(MemberVO m);

	//회원정보를 가져오는 메서드(로그인)
	//MemberVO getMemberInfo(String m_id);


}*/



import com.carindrive.vo.MemberVO;


public interface MemberService {
	
	
	//회원가입 메서드
	//void insertMember(MemberVO m);

	//회원정보를 가져오는 메서드(로그인)
	MemberVO getMemberInfo(String m_id);

	MemberVO idCheck(String id);

	void insertMember(MemberVO cm);

	MemberVO loginCheck(String m_id);

	MemberVO adminCk(String m_id);

	List<MemberVO> myPage(String m_id);

	MemberVO findPwd(String m_id);

	void updateMember(MemberVO m);



	

}

	
