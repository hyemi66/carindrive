package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

public interface RentalDAO {

	void insertRental(RentalVO r);

	List<RentalVO> getRentList(String m_id);
	
	RentalVO getRentOne(String cr_mid);

	void getMemberList(MemberVO m);

	CarVO getCarInfo(String cr_cid);

	void insertCost(int cr_num, double one_price);

	void insertMerchantId(String merchantId, int cr_num);

	void saveOrder(OrderVO order);

	List<OrderVO> getOrder(String buyer_name);


	

}
