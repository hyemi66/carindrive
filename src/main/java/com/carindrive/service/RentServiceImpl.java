package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.RentalDAO;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.RentalVO;

@Service
public class RentServiceImpl implements RentService {

	@Autowired
	private RentalDAO rentalDao;
	
	@Override
	public void insertRental(RentalVO r) {
		this.rentalDao.insertRental(r);
	}//차량 예약 정보 저장

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return rentalDao.getRentList(m_id);
	}//해당 고객의 모든차량 렌트 내역 확인
	
	@Override
	public RentalVO getRentOne(String m_id) {
		return this.rentalDao.getRentOne(m_id);
	}//방금 예약한목록 가져오기

	@Override
	public void getMemberList(MemberVO m) {
		this.rentalDao.getMemberList(m);
	}//회원 정보 확인(가져오기)

	@Override
	public CarVO getCarInfo(String cr_cname) {
		return this.rentalDao.getCarInfo(cr_cname);
	}//차 정보 가져오기

	@Override
	public void insertCost(int cr_num, double one_price) {
	    this.rentalDao.insertCost(cr_num, one_price);
	}//렌트 비용을 데이터베이스에 추가

	@Override
	public void insertMerchantId(String merchantId, int cr_num) {
		this.rentalDao.insertMerchantId(merchantId, cr_num);
	}//주문번호를 렌탈정보 데이터베이스에 추가

	@Override
	public RentalVO getRentRefund(String cr_order) {
		return this.rentalDao.getRentRefund(cr_order);
	}//주문번호를 기준으로 렌트내역을 가져옴

	@Override
	public List<CarVO> findAllCar() {
		return this.rentalDao.findAllCar();
	}//모든 차 정보를 가져오기
	
	@Override
	public List<CarVO> getCarList(CarVO cv) {
		return this.rentalDao.getCarList(cv);
	}//모든 차 정보를 가져오기



}
