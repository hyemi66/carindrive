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
    public List<OrderVO> getCashInfo(String m_id) {
        return orderDAO.getCashInfo(m_id);
    }//예약번호 가져오기

	@Override
	public OrderVO getOrder(long num) {
		return this.orderDAO.getOrder(num);
	}//주문내역 가져오기

	@Override
	public void refundOK(String order_number) {
		this.orderDAO.refundOK(order_number);
	}//환불 완료시 주문번호를 기준으로 refund에 '환불완료'라고 업데이트

	@Override
	public OrderVO getOrder2(String merchantId) {
		return this.orderDAO.getOrder2(merchantId);
	}//주문번호를 기준으로 결제내역을 가져옴

	@Override
	public OrderVO getPayInfo2(String order_number) {
		return this.orderDAO.getPayInfo2(order_number);
	}//주문번호를 기준으로 결제내역을 가져옴 (추가결제용)

	@Override
	public List<OrderVO> getAllChildOrders(String order_number) {
		return this.orderDAO.getAllChildOrders(order_number);
	}//주문번호를 기준으로 모든 결제내역을 가져옴 (추가결제용,환불용)

	@Override
	public void addTime(String oldOrder) {
		this.orderDAO.addTime(oldOrder);
	}//시간연장이 되면 기존결제내역 refund에 시간연장이라고 업데이트
	
	
	
}
