package com.carindrive.dao;


import java.util.List;

import com.carindrive.vo.MemberVO;
/*
public interface MemberDAO {

	void insertMember(MemberVO m);

	MemberVO getMemberInfo(String m_id);


}
*/

public interface MemberDAO {
	
	MemberVO getMemberInfo(String m_id);

	
	//yw 부분
	MemberVO idCheck(String id);
	
	void insertMember(MemberVO cm);

	MemberVO loginCheck(String m_id);


	MemberVO adminCk(String m_id);


	List<MemberVO> myPage(String m_id);


	MemberVO findPwd(String m_id);


	void updateMember(MemberVO m);


	void delMember(String m_id);

}
