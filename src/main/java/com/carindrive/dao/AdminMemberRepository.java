package com.carindrive.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.carindrive.vo.MemberVO;

public interface AdminMemberRepository extends JpaRepository<MemberVO, String> {

	@Modifying 
	@Query("update MemberVO m set m.m_pwd=?1, m.m_name=?2, m.m_phone=?3,m.m_email=?4 where m.m_id=?5")
	public void adminMember_Update(String pwd,String name,String phone,String email,String id); 

}
