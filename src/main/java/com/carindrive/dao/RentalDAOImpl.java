package com.carindrive.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

@Repository
public class RentalDAOImpl implements RentalDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertRental(RentalVO r) {
		this.sqlSession.insert("rental_in",r);
	}

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return this.sqlSession.selectList("get_rlist",m_id);
	}
	
	@Override
	public RentalVO getRentOne(String m_id) {
	    return this.sqlSession.selectOne("get_rentCar", m_id);
	}

	@Override
	public void getMemberList(MemberVO m) {
		this.sqlSession.selectList("m_list",m);
	}

	@Override
	public CarVO getCarInfo(int car_id) {
		return this.sqlSession.selectOne("c_list",car_id);
	}

	@Override
	public int insertCost(int rental_id, double rental_cost) {
		RentalVO rentalVO = new RentalVO();
        rentalVO.setRental_id(rental_id);
        rentalVO.setRental_cost(rental_cost);
        return sqlSession.update("cost_in", rentalVO);
	}

	@Override
	public void insertMerchantId(String merchantId, int rental_id) {
	    RentalVO rentalVO = new RentalVO();
	    rentalVO.setMerchantId(merchantId);  // RentalVO에 해당하는 메서드명으로 변경해야 합니다.
	    rentalVO.setRental_id(rental_id);       // RentalVO에 해당하는 메서드명으로 변경해야 합니다.
	    this.sqlSession.update("insertMerchantId", rentalVO);
	}

	@Override
	public void saveOrder(OrderVO order) {
		this.sqlSession.insert("saveOrder",order);
	}

	@Override
	public List<OrderVO> getOrder(String buyer_name) {
		return this.sqlSession.selectList("getOrder",buyer_name);
	}




}
