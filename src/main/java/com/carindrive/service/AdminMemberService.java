package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.MemberVO;
import com.carindrive.vo.PageVO;

public interface AdminMemberService {

	int getListCount(PageVO p);

	List<MemberVO> getMemberList(PageVO p);

	MemberVO getMem(String m_id);

	void editM(MemberVO m);

	void delM(String m_id);

}
