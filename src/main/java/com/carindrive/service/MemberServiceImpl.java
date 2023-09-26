package com.carindrive.service;

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
import com.carindrive.vo.SocialVO;


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
	public void insertKakao(SocialVO kakaoUser) {
		this.memberDao.insertKakao(kakaoUser);
		
	}

	@Override
	public SocialVO serchkakao(String userEmail) {
		
		return this.memberDao.serchkakao(userEmail);
	}

	@Override
	public MemberVO serchUserEmail(String m_email) {
		
		return this.memberDao.serchUserEmail(m_email);
	}

	@Override
	public int updatePwd(MemberVO m) {
		
		return this.memberDao.updatePwd(m);
	}



	
}
