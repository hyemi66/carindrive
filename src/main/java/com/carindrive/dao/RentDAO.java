package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.CarVO;

public interface RentDAO {
	
	List<CarVO> getCarList(CarVO cv);


	
}
