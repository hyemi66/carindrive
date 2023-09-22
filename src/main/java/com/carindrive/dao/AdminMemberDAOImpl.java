package com.carindrive.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.MemberVO;
import com.carindrive.vo.PageVO;

@Repository
public class AdminMemberDAOImpl implements AdminMemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private AdminMemberRepository AmRepo;

	@Override
	public int getListCount(PageVO p) {
		return this.sqlSession.selectOne("am_count",p);
	}

	@Override
	public List<MemberVO> getMemberList(PageVO p) {
		return this.sqlSession.selectList("am_list",p);
	}

	@Override
	public MemberVO getMem(String m_id) {
		MemberVO am=this.AmRepo.getReferenceById(m_id);
		return am;
	}
	
	@Transactional
	@Override
	public void editM(MemberVO m) {
		this.AmRepo.adminMember_Update(m.getM_pwd(),m.getM_name(),m.getM_phone(),m.getM_email(),m.getM_id());

	}

	@Override
	public void delM(String m_id) {
		this.AmRepo.deleteById(m_id);
	}
	
	
}
