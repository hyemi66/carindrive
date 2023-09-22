package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.AdminMemberDAO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.PageVO;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	private AdminMemberDAO AmDao;

	@Override
	public int getListCount(PageVO p) {
		return this.AmDao.getListCount(p);
	}

	@Override
	public List<MemberVO> getMemberList(PageVO p) {
		return this.AmDao.getMemberList(p);
	}

	@Override
	public MemberVO getMem(String m_id) {
		return this.AmDao.getMem(m_id);
	}

	@Override
	public void editM(MemberVO m) {
		this.AmDao.editM(m);
	}

	@Override
	public void delM(String m_id) {
		this.AmDao.delM(m_id);
	}
}
