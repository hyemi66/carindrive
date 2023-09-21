package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.RentalVO;

public interface RentDAO {
	
	List<CarVO> getCarList(CarVO cv);

	void insertLoad(RentalVO r);


}
