package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.OrderVO;

public interface OrderService {
	
	//주문내역(결제정보) 저장
	void saveOrder(OrderVO order);
	
	//아이디를 이용해서 결제정보 가져오기
	List<OrderVO> getCashInfo(String m_id);

	//주문내역 전체 가져오기
	OrderVO getOrder(long num);

	//환불 완료시 주문번호를 기준으로 refund에 '환불완료'라고 업데이트
	void refundOK(String order_number);

	//주문번호를 기준으로 결제내역을 가져옴
	OrderVO getOrder2(String merchantId);

	//주문번호를 기준으로 결제내역을 가져옴 (추가결제용)
	OrderVO getPayInfo2(String order_number);

	//주문번호를 기준으로 모든 결제내역을 가져옴 (추가결제용,환불용)
	List<OrderVO> getAllChildOrders(String order_number);

	//시간연장이 되면 기존결제내역 refund에 시간연장이라고 업데이트
	void addTime(String oldOrder);
	
}
