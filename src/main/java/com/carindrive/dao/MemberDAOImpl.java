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
import com.carindrive.vo.SocialVO;

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
		
		@Transactional
		@Override
		public void insertKakao(SocialVO kakaoUser) {
			this.sqlSession.insert("insertKakao",kakaoUser );
			
			//JPA
			//this.socialRepo.save(kakaoUser);
			
		}//카카오 회원가입

		@Override
		public SocialVO serchkakao(String userEmail) {
			
			return this.sqlSession.selectOne("serchKakao",userEmail);
		}//카카오 로그인 확인

		@Override
		public MemberVO serchUserEmail(String m_email) {
			
			return this.sqlSession.selectOne("Serch_email",m_email);
		}//유저 이메일 체크

		@Override
		public int updatePwd(MemberVO m) {
			
			return this.sqlSession.update("update_pwd",m);
		}//비밀번호 변경

		
		


	
}
