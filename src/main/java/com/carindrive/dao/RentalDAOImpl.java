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
	public RentalVO getRentOne(String cr_mid) {
	    return this.sqlSession.selectOne("get_rentCar", cr_mid);
	}

	@Override
	public void getMemberList(MemberVO m) {
		this.sqlSession.selectList("m_list",m);
	}

	@Override
	public CarVO getCarInfo(String cr_cid) {
		return this.sqlSession.selectOne("c_list",cr_cid);
	}

	@Override
	public void insertCost(int cr_num, double one_price) {
		RentalVO rentalVO = new RentalVO();
        rentalVO.setCr_num(cr_num);
        rentalVO.setCr_price(one_price);
        this.sqlSession.update("cost_in", rentalVO);
	}

	@Override
	public void insertMerchantId(String merchantId, int cr_num) {
	    RentalVO rentalVO = new RentalVO();
	    rentalVO.setCr_order(merchantId);  // RentalVO에 해당하는 메서드명으로 변경해야 합니다.
	    rentalVO.setCr_num(cr_num);       // RentalVO에 해당하는 메서드명으로 변경해야 합니다.
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
