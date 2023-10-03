package com.carindrive.dao;

import java.util.List;
import java.util.Map;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.RentalVO;

public interface RentalDAO {

	void insertRental(RentalVO r);

	List<RentalVO> getRentList(String m_id);
	
	RentalVO getRentOne(String cr_mid);

	void getMemberList(MemberVO m);

	CarVO getCarInfo(String cr_cname);

	void insertCost(int cr_num, double one_price);

	void insertMerchantId(String merchantId, int cr_num);

	RentalVO getRentCar(String cr_order);

	List<CarVO> findAllCar();
	
	List<CarVO> getCarList(CarVO cv);

	CarVO getCarInfo2(int c_num);

	void delOrder(int cr_num);

	void updateCok(String c_name);
	
	int checkDate(Map<String, Object> params);

	List<RentalVO> getDateCar(String c_name);

	void reValueDate(String order_number);

	void rentalStatus(String merchantId);

	void rentalDel();

	void rentalDel2(String m_id);

	void waitTime(String merchantId);

	void insertTime(RentalVO myKey);


}
