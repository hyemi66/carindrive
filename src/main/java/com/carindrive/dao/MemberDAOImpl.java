package com.carindrive.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertMember(MemberVO m) {
		this.sqlSession.insert("member_in",m);
	}

	@Override
	public MemberVO getMemberInfo(String m_id) {
		return this.sqlSession.selectOne("get_member",m_id);
	}

}
