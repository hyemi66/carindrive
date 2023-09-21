package com.carindrive.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.carindrive.vo.AdminVO;

public interface AdminRepository extends JpaRepository<AdminVO, String> {

}
