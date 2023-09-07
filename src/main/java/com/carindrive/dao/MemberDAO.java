package com.carindrive.dao;

import com.carindrive.vo.MemberVO;

public interface MemberDAO {

	void insertMember(MemberVO m);

	MemberVO getMemberInfo(String m_id);


}
