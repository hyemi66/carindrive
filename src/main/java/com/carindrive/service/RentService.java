package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

public interface RentService {
	
	//차량 예약 요청
	void insertRental(RentalVO r);

	//차량 렌트 내역 확인
	List<RentalVO> getRentList(String m_id);

	//방금 예약한목록 가져오기
	RentalVO getRentOne(String m_id);
	
	//회원 정보 확인(가져오기)
	void getMemberList(MemberVO m);

	//차 정보 가져오기
	CarVO getCarInfo(String cr_cid);

	//렌트 비용을 데이터베이스에 추가
	void insertCost(int cr_num, double one_price);

	//주문번호를 렌탈정보 데이터베이스에 추가
	void insertMerchantId(String merchantId, int rental_id);

	//주문내역 저장
	void saveOrder(OrderVO order);

	//주문내역 가져오기
	List<OrderVO> getOrder(String buyer_name);
	
	// 차 리스트 가져오기
	List<CarVO> getCarList(CarVO cv);
	
	
}
