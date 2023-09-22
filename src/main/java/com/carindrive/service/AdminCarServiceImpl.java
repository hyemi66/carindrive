package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.AdminCarDAO;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.PageVO;

@Service
public class AdminCarServiceImpl implements AdminCarService {

	@Autowired
	private AdminCarDAO AcDao;

	@Override
	public int getListCount(PageVO p) {
		return this.AcDao.getListCount(p);
	}

	@Override
	public List<CarVO> getAdminCarList(PageVO p) {
		return this.AcDao.getAdminCarList(p);
	}

	@Override
	public void adminInsertCar(CarVO c) {
		this.AcDao.adminInsertCar(c);
	}

	@Override
	public CarVO getAdminCarCont(int no) {
		return this.AcDao.getAdminCarCont(no);
	}

	@Override
	public void adminUpdateCar(CarVO c) {
		this.AcDao.adminUpdateCar(c);
	}

	@Override
	public void AcDel(int no) {
		this.AcDao.AcDel(no);
	}
}
