package com.carindrive.dao;

import com.carindrive.vo.AdminVO;

public interface AdminDAO {

	AdminVO adminLogin(String ca_id);

	void insertAdmin(AdminVO ab);

}
