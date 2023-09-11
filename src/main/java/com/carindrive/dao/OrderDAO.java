package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.OrderVO;

public interface OrderDAO {
	
	void saveOrder(OrderVO order);
	
	List<OrderVO> getId(String m_id);

	OrderVO getOrder(long num);

	

}
