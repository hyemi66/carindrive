package com.carindrive.dao;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.AdminVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private AdminRepository adminRepo;

	@Override
	public AdminVO adminLogin(String ca_id) {
		
		Optional<AdminVO> result = this.adminRepo.findById(ca_id);
		AdminVO admin;
		
		if(result.isPresent()) {
			admin = result.get();
		}else {
			admin = null;
		}
		return admin;
	}//관리자 로그인 인증

	@Override
	public void insertAdmin(AdminVO ab) {
		this.adminRepo.save(ab);
	}
}
