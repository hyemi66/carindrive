package com.carindrive.service;

import com.carindrive.vo.MemberVO;

public interface MemberService {

	//회원가입 메서드
	void insertMember(MemberVO m);

	//회원정보를 가져오는 메서드(로그인)
	MemberVO getMemberInfo(String m_id);

}
