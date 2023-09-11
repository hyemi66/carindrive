package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.OrderDAO;
import com.carindrive.vo.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDAO orderDAO;
	
	@Override
	public void saveOrder(OrderVO order) {
		this.orderDAO.saveOrder(order);
	}//주문내역(결제정보) 저장
	
    @Override
    public List<OrderVO> getId(String m_id) {
        return orderDAO.getId(m_id);
    }//예약번호 가져오기

	@Override
	public OrderVO getOrder(long num) {
		return this.orderDAO.getOrder(num);
	}//주문내역 가져오기


}
