package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.OrderVO;

public interface OrderService {
	
	//주문내역(결제정보) 저장
	void saveOrder(OrderVO order);
	
	//예약번호 가져오기
	List<OrderVO> getId(String m_id);

	//주문내역 전체 가져오기
	OrderVO getOrder(long num);

	//환불 완료시 주문번호에 환불이라고 업데이트
	void refundOK(String order_number);
	
}
