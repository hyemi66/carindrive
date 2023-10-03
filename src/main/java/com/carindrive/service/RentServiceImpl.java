package com.carindrive.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public RentalVO getRentCar(String cr_order) {
		return this.rentalDao.getRentCar(cr_order);
	}//주문번호를 기준으로 렌트내역을 가져옴

	@Override
	public List<CarVO> findAllCar() {
		return this.rentalDao.findAllCar();
	}//모든 차 정보를 가져오기
	
	@Override
	public List<CarVO> getCarList(CarVO cv) {
		return this.rentalDao.getCarList(cv);
	}//모든 차 정보를 가져오기

	@Override
	public CarVO getCarInfo2(int c_num) {
		return this.rentalDao.getCarInfo2(c_num);
	}

	@Override
	public void delOrder(int cr_num) {
		this.rentalDao.delOrder(cr_num);
	}

	@Override
	public void updateCok(String c_name) {
		this.rentalDao.updateCok(c_name);
	} // 예약된 차 이름으로 c_car테이블 c_ok 0으로 변경

    @Override
    public boolean checkDate(String cr_cname, String cr_sdate, String cr_edate) {
        Map<String, Object> params = new HashMap<>();
        params.put("cr_cname", cr_cname);
        params.put("cr_sdate", cr_sdate);
        params.put("cr_edate", cr_edate);

        int count = rentalDao.checkDate(params);

        return count > 0; 
    }//날짜 중복 체크

	@Override
	public List<RentalVO> getDateCar(String c_name) {
		return this.rentalDao.getDateCar(c_name);
	}// 선택된 차량에 대한 예약된 날짜 목록을 가져옴

	@Override
	public void reValueDate(String order_number) {
		this.rentalDao.reValueDate(order_number);
	}//환불시 렌탈날짜 초기화

	@Override
	public void rentalStatus(String merchantId) {
		this.rentalDao.rentalStatus(merchantId);
	}//주문번호를 기준으로 렌탈완료시 c_rental 테이블 status를 wait -> clear로 설정

	@Override
	public void rentalDel() {
		this.rentalDao.rentalDel();
	}//5분안에 결제를 진행안하고 취소를 하면 5분동안 해당차량 렌트 불가

	@Override
	public void rentalDel2(String m_id) {
		this.rentalDao.rentalDel2(m_id);
	}//해당 아이디의 결제 중단 내역들을 전부 제거

	@Override
	public void waitTime(String merchantId) {
		this.rentalDao.waitTime(merchantId);
	}//렌탈 테이블의 차량정비시간을 설정

	@Override
	public void insertTime(RentalVO myKey) {
		this.rentalDao.insertTime(myKey);
	}//waitTime을 원래 반납시간과 똑같은 시간으로 지정
	

}
