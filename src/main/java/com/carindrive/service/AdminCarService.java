package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.PageVO;

public interface AdminCarService {

	int getListCount(PageVO p);

	List<CarVO> getAdminCarList(PageVO p);

	void adminInsertCar(CarVO c);

	CarVO getAdminCarCont(int no);

	void adminUpdateCar(CarVO c);

	void AcDel(int no);

}
