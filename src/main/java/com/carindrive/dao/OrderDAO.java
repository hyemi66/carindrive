package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.OrderVO;

public interface OrderDAO {
	
	void saveOrder(OrderVO order);
	
	List<OrderVO> getCashInfo(String m_id);

	OrderVO getOrder(long num);

	void refundOK(String order_number);

	OrderVO getOrder2(String merchantId);

	OrderVO getPayInfo2(String order_number);

	List<OrderVO> getAllChildOrders(String order_number);

	void addTime(String oldOrder);
}
