package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

public interface RentalDAO {

	void insertRental(RentalVO r);

	List<RentalVO> getRentList(String m_id);
	
	RentalVO getRentOne(String m_id);

	void getMemberList(MemberVO m);

	CarVO getCarInfo(int car_id);

	int insertCost(int rental_id, double rental_cost);

	void insertMerchantId(String merchantId, int rental_id);

	void saveOrder(OrderVO order);

	List<OrderVO> getOrder(String buyer_name);


	

}
