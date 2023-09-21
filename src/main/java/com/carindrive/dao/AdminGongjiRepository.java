package com.carindrive.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.carindrive.vo.GongjiVO;

public interface AdminGongjiRepository extends JpaRepository<GongjiVO, Integer> {

	@Modifying 
	@Query("update GongjiVO g set g.cs_title=?1,g.cs_cont=?2"
			+" where g.cs_no=?3")
	public void AgUpdate(String cs_title,String cs_cont,int cs_no);
}
