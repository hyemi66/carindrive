package com.carindrive.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;
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
		
		@Autowired
		private SqlSession sqlSession;

		@Override
		public MemberVO idCheck(String id) {
			
			return this.sqlSession.selectOne("m_idcheck",id);
		}

		@Override
		public void insertMember(MemberVO cm) {
			this.sqlSession.insert("C_mem_in",cm);
			
		}

		
		@Override
		public MemberVO loginCheck(String m_id) {
			
			return this.sqlSession.selectOne("C_mem_login",m_id);
		}

		@Override
		public MemberVO adminCk(String m_id) {
			
			return this.sqlSession.selectOne("admin_ck",m_id);
		}

		
		@Transactional
		@Override
		public void insertKakao(SocialVO kakaoUser) {
			this.sqlSession.insert("insertKakao",kakaoUser );
			
		}

		@Override
		public SocialVO serchkakao(String userEmail) {
			
			return this.sqlSession.selectOne("serchKakao",userEmail);
		}

		@Override
		public MemberVO serchUserEmail(String m_email) {
			
			return this.sqlSession.selectOne("Serch_email",m_email);
		}

		@Override
		public int updatePwd(MemberVO m) {
			
			return this.sqlSession.update("update_pwd",m);
		}
		
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
			this.sqlSession.update("del_mem", m_id);
		} // 회원탈퇴 state = 2로 수정

		@Override
		public List<OrderVO> checkPay(String m_id) {
			return this.sqlSession.selectList("checkPay", m_id);
		} // 예약내역 확인 후 탈퇴

	

	
}
