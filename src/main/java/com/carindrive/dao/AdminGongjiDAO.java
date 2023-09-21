package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.GongjiVO;
import com.carindrive.vo.PageVO;

public interface AdminGongjiDAO {

	int getListCount(PageVO p);

	List<GongjiVO> getAdminGongjiList(PageVO p);

	void AgInsert(GongjiVO g);

	GongjiVO getAgCont(int no);

	void AgUpdate(GongjiVO g);

	void AgDel(int no);

}
