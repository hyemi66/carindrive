package com.carindrive.service;

import com.carindrive.vo.AdminVO;

public interface AdminService {

	AdminVO adminLogin(String ca_id);

	void insertAdmin(AdminVO ab);

}
