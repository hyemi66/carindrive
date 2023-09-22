package com.carindrive.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.MemberVO;
/*
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
*/

import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
		
		@Override
		public MemberVO getMemberInfo(String m_id) {
			return this.sqlSession.selectOne("get_member",m_id);
		}

		
		//yw 부분	
		/*@Autowired
		private SocialRepository socialRepo;*/
		
		@Autowired
		private SqlSession sqlSession;

		@Override
		public MemberVO idCheck(String id) {
			
			return this.sqlSession.selectOne("m_idcheck",id);
		}//아이디 중복 검색

		@Override
		public void insertMember(MemberVO cm) {
			this.sqlSession.insert("C_mem_in",cm);
			
		}//회원 저장

		
		@Override
		public MemberVO loginCheck(String m_id) {
			
			return this.sqlSession.selectOne("C_mem_login",m_id);
		}//로그인 유무 체크

		@Override
		public MemberVO adminCk(String m_id) {
			
			return this.sqlSession.selectOne("admin_ck",m_id);
		}//관리자 로그인 체크

		@Override
		public List<MemberVO> myPage(String m_id) {
			return this.sqlSession.selectList("mypage", m_id);
		} // 멤버값 리스트로 받기

		@Override
		public MemberVO findPwd(String m_id) {
			return this.sqlSession.selectOne("findpwd", m_id);
		} // 비밀번호 찾기

		@Override
		public void updateMember(MemberVO m) {
			this.sqlSession.update("update_mem", m);
		} // 회원정보수정완료

		@Override
		public void delMember(String m_id) {
			this.sqlSession.delete("del_mem", m_id);
		} // 회원탈퇴 state = 2로 수정
		
		
		/*	
		@Transactional
		public Integer insertSocial(SocialVO social) {
			try {
				socialRepo.save(social);
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("회원가입");
			}
			return -1;
		}//소셜로그인 회원가입
		
		*/
		
		


	
}
