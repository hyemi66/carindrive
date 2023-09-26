package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.ServiceVO;

public interface AdminDAO {

	int getListCount(PageVO p);

	List<ServiceVO> getAdminGongjiList(PageVO p);

	void agInsert(ServiceVO g);

	ServiceVO getAgCont(int no);

	void Agupdate(ServiceVO g);

	void AgDel(int no);

	int getCarCount(PageVO p);

	List<CarVO> getAdminCarList(PageVO p);

	void carInsert(CarVO c);

	CarVO getAdminCarCont(int no);

	void updateCar(CarVO c);

	void carDel(int no);

}
