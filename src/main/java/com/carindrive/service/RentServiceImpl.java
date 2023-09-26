package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.RentDAO;
import com.carindrive.dao.RentalDAO;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

@Service
public class RentServiceImpl implements RentService {

	@Autowired
	private RentalDAO rentalDao;
	
	@Autowired
	private RentDAO rentDao;
	
	@Override
	public void insertRental(RentalVO r) {
		this.rentalDao.insertRental(r);
	}

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return rentalDao.getRentList(m_id);
	}
	
	@Override
	public RentalVO getRentOne(String cr_mid) {
		return this.rentalDao.getRentOne(cr_mid);
	}

	@Override
	public void getMemberList(MemberVO m) {
		this.rentalDao.getMemberList(m);
	}

	@Override
	public CarVO getCarInfo(String cr_cid) {
		return this.rentalDao.getCarInfo(cr_cid);
	}

	@Override
	public void insertCost(int cr_num, double one_price) {
	    this.rentalDao.insertCost(cr_num, one_price);
	}

	@Override
	public void insertMerchantId(String merchantId, int cr_num) {
		this.rentalDao.insertMerchantId(merchantId, cr_num);
	}

	@Override
	public void saveOrder(OrderVO order) {
		this.rentalDao.saveOrder(order);
	}

	@Override
	public List<OrderVO> getOrder(String buyer_name) {
		return this.rentalDao.getOrder(buyer_name);
	}

	@Override
	public List<CarVO> getCarList(CarVO cv) {
		return this.rentDao.getCarList(cv);
	}


}
