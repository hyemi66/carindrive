package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.RentalDAO;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

@Service
public class RentServiceImpl implements RentService {

	@Autowired
	private RentalDAO rentalDao;
	
	@Override
	public void insertRental(RentalVO r) {
		this.rentalDao.insertRental(r);
	}

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return rentalDao.getRentList(m_id);
	}
	
	@Override
	public RentalVO getRentOne(String m_id) {
		return this.rentalDao.getRentOne(m_id);
	}

	@Override
	public void getMemberList(MemberVO m) {
		this.rentalDao.getMemberList(m);
	}

	@Override
	public CarVO getCarInfo(int car_id) {
		return this.rentalDao.getCarInfo(car_id);
	}

	@Override
	public int insertCost(int rental_id, double rental_cost) {
	    return this.rentalDao.insertCost(rental_id, rental_cost);
	}

	@Override
	public void insertMerchantId(String merchantId, int rental_id) {
		this.rentalDao.insertMerchantId(merchantId, rental_id);
	}

	@Override
	public void saveOrder(OrderVO order) {
		this.rentalDao.saveOrder(order);
	}

	@Override
	public List<OrderVO> getOrder(String buyer_name) {
		return this.rentalDao.getOrder(buyer_name);
	}





}
