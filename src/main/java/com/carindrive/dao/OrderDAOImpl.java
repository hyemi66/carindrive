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
	public List<OrderVO> getId(String m_id) {
		return this.sqlSession.selectList("getId", m_id);
	}//예약번호 가져오기

	@Override
	public OrderVO getOrder(long num) {
		return this.sqlSession.selectOne("getOrder",num);
	}//주문내역 가져오기

	@Override
	public void refundOK(String order_number) {
		this.sqlSession.update("refundOK",order_number);
	}
}
