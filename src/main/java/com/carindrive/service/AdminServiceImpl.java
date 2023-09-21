package com.carindrive.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.AdminDAO;
import com.carindrive.vo.AdminVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDao;

	@Override
	public AdminVO adminLogin(String ca_id) {
		return this.adminDao.adminLogin(ca_id);
	}

	@Override
	public void insertAdmin(AdminVO ab) {
		this.adminDao.insertAdmin(ab);
	}
}
