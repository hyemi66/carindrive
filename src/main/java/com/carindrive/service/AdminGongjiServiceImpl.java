package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.AdminGongjiDAO;
import com.carindrive.vo.GongjiVO;
import com.carindrive.vo.PageVO;

@Service
public class AdminGongjiServiceImpl implements AdminGongjiService {

	@Autowired
	private AdminGongjiDAO AgDao;

	@Override
	public int getListCount(PageVO p) {
		return this.AgDao.getListCount(p);
	}

	@Override
	public List<GongjiVO> getAdminGongjiList(PageVO p) {
		return this.AgDao.getAdminGongjiList(p);
	}

	@Override
	public void AgInsert(GongjiVO g) {
		this.AgDao.AgInsert(g);
	}

	@Override
	public GongjiVO getAgCont(int no) {
		return this.AgDao.getAgCont(no);
	}

	@Override
	public void AgUpdate(GongjiVO g) {
		this.AgDao.AgUpdate(g);
	}

	@Override
	public void AgDel(int no) {
		this.AgDao.AgDel(no);
	}
}
