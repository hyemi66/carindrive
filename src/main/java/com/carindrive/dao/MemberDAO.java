package com.carindrive.dao;


import java.util.List;

import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;
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

	List<MemberVO> myPage(String m_id);


	MemberVO findPwd(String m_id);


	void updateMember(MemberVO m);


	void delMember(String m_id);


	List<OrderVO> checkPay(String m_id);



}
