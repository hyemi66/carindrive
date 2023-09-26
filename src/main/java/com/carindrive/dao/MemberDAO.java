package com.carindrive.dao;


import com.carindrive.vo.MemberVO;
/*
public interface MemberDAO {

	void insertMember(MemberVO m);

	MemberVO getMemberInfo(String m_id);


}
*/
import com.carindrive.vo.SocialVO;

public interface MemberDAO {
	
	MemberVO getMemberInfo(String m_id);

	
	//yw 부분
	MemberVO idCheck(String id);
	
	void insertMember(MemberVO cm);

	MemberVO loginCheck(String m_id);

	MemberVO adminCk(String m_id);
	
	void insertKakao(SocialVO kakaoUser);

	SocialVO serchkakao(String userEmail);

	MemberVO serchUserEmail(String m_email);

	int updatePwd(MemberVO m);





}
