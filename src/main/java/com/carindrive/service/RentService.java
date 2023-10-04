package com.carindrive.service;

import java.util.List;
import java.util.Map;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;

public interface RentService {

	//차량 예약 정보 저장
	void insertRental(RentalVO r);

	//해당 고객의 모든차량 렌트 내역 확인
	List<RentalVO> getRentList(String m_id);

	//방금 예약한목록 가져오기
	RentalVO getRentOne(String m_id);
	
	//회원 정보 확인(가져오기)
	void getMemberList(MemberVO m);

	//선택된 차 정보 가져오기
	CarVO getCarInfo(String cr_cname);

	//렌트 비용을 데이터베이스에 추가
	void insertCost(int cr_num, double one_price);

	//주문번호를 렌탈정보 데이터베이스에 추가
	void insertMerchantId(String merchantId, int cr_num);

	//주문번호를 기준으로 해당 예약내역을 선택
	RentalVO getRentCar(String cr_order);

	//모든 차 정보를 가져오기
	List<CarVO> findAllCar();
	
	// 차 리스트 가져오기
	List<CarVO> getCarList(CarVO cv);

	//차량코드번호(프라이머리키)로 차정보 가져오기
	CarVO getCarInfo2(int c_num);

	//주문순서를 기준으로 주문번호가 null인것을 지우기
	void delOrder(int cr_num);

	//렌트한 차량 car_ok 1 -> 0으로 업데이트
	void updateCok(String c_name);
	
	//날짜 중복 체크 쿼리문
	boolean checkDate(String carName, String startDate, String endDate);

	// 선택된 차량에 대한 예약된 날짜 목록을 가져옴
	List<RentalVO> getDateCar(String c_name);

	//환불시 렌탈 날짜를 초기화
	void reValueDate(String order_number);

	//주문번호를 기준으로 렌탈완료시 c_rental 테이블 status를 wait -> clear로 설정
	void rentalStatus(String merchantId);

	//5분안에 결제를 진행안하고 취소를 하면 5분동안 해당차량 렌트 불가
	void rentalDel();

	//해당 아이디의 결제 중단 내역들을 전부 제거
	void rentalDel2(String m_id);

	//렌탈 테이블의 차량정비시간을 설정
	void waitTime(String merchantId);

	//waitTime을 원래 반납시간과 똑같은 시간으로 지정
	void insertTime(RentalVO myKey);

}
