package com.carindrive.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void saveOrder(OrderVO order) {
		this.sqlSession.insert("saveOrder",order);
	}//주문내역(결제정보) 저장
	
	@Override
	public List<OrderVO> getCashInfo(String m_id) {
		return this.sqlSession.selectList("getCashInfo", m_id);
	}//예약번호 가져오기

	@Override
	public OrderVO getOrder(long num) {
		return this.sqlSession.selectOne("getOrder",num);
	}//주문내역 가져오기

	@Override
	public void refundOK(String order_number) {
		this.sqlSession.update("refundOK",order_number);
	}//환불 완료시 주문번호를 기준으로 refund에 '환불완료'라고 업데이트

	@Override
	public OrderVO getOrder2(String merchantId) {
		return this.sqlSession.selectOne("getOrder2",merchantId);
	}

	@Override
	public OrderVO getPayInfo2(String order_number) {
		return this.sqlSession.selectOne("getPayInfo2",order_number);
	}//주문번호를 기준으로 결제내역을 가져옴 (추가결제용)

	@Override
	public List<OrderVO> getAllChildOrders(String order_number) {
		return this.sqlSession.selectList("getAllChildOrders",order_number);
	}//주문번호를 기준으로 모든 결제내역을 가져옴 (추가결제용,환불용)

	@Override
	public void addTime(String oldOrder) {
		this.sqlSession.update("addTime",oldOrder);
		//시간연장이 되면 기존결제내역 refund에 시간연장이라고 업데이트
	}
}
