package com.carindrive.service;

import java.util.List;

/*
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.MemberDAO;
import com.carindrive.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDao;

	@Override
	public void insertMember(MemberVO m) {
		this.memberDao.insertMember(m);
	}

	@Override
	public MemberVO getMemberInfo(String m_id) {
		return this.memberDao.getMemberInfo(m_id);
	}

}
*/



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.MemberDAO;
import com.carindrive.vo.MemberVO;


@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDao;
	
	@Override
	public MemberVO getMemberInfo(String m_id) {
		return this.memberDao.getMemberInfo(m_id);
	}
	
	//yw 부분
	@Override
	public MemberVO idCheck(String id) {
		
		return this.memberDao.idCheck(id);
	}

	@Override
	public void insertMember(MemberVO cm) {
		this.memberDao.insertMember(cm);
		
	}

	@Override
	public MemberVO loginCheck(String m_id) {
		
		return this.memberDao.loginCheck(m_id);
	}

	@Override
	public MemberVO adminCk(String m_id) {
		
		return this.memberDao.adminCk(m_id);
	}

	@Override
	public List<MemberVO> myPage(String m_id) {
		return this.memberDao.myPage(m_id);
	}

	@Override
	public MemberVO findPwd(String m_id) {
		return this.memberDao.findPwd(m_id);
	}

	@Override
	public void updateMember(MemberVO m) {
		this.memberDao.updateMember(m);
	}

	@Override
	public void delMember(String m_id) {
		this.memberDao.delMember(m_id);
	}
	

}
