package com.carindrive.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.RentalVO;

@Repository
public class RentalDAOImpl implements RentalDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertRental(RentalVO r) {
		this.sqlSession.insert("rental_in",r);
	}//차량 예약 정보 저장

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return this.sqlSession.selectList("get_rlist",m_id);
	}//해당 고객의 모든차량 렌트 내역 확인
	
	@Override
	public RentalVO getRentOne(String cr_mid) {
	    return this.sqlSession.selectOne("get_rentCar", cr_mid);
	}//방금 예약한목록 가져오기

	@Override
	public void getMemberList(MemberVO m) {
		this.sqlSession.selectList("m_list",m);
	}//회원 정보 확인(가져오기)

	@Override
	public CarVO getCarInfo(String cr_cname) {
		return this.sqlSession.selectOne("getCarInfo",cr_cname);
	}//차 정보 가져오기
	
	@Override
	public void insertCost(int cr_num, double one_price) {
		RentalVO rentalVO = new RentalVO();
        rentalVO.setCr_num(cr_num);
        rentalVO.setCr_price(one_price);
        this.sqlSession.update("cost_in", rentalVO);
	}//렌트 비용을 데이터베이스에 추가

	@Override
	public void insertMerchantId(String merchantId, int cr_num) {
	    RentalVO rentalVO = new RentalVO();
	    rentalVO.setCr_order(merchantId);
	    rentalVO.setCr_num(cr_num);
	    this.sqlSession.update("insertMerchantId", rentalVO);
	}//주문번호를 렌탈정보 데이터베이스에 추가

	@Override
	public RentalVO getRentCar(String cr_order) {
		return this.sqlSession.selectOne("getRentCar",cr_order);
	}//주문번호를 기준으로 렌트내역을 가져옴

	@Override
	public List<CarVO> findAllCar() {
		return this.sqlSession.selectList("findAllCar");
	}//모든 차량 불러오기
	
	@Override
	public List<CarVO> getCarList(CarVO cv) {
		return this.sqlSession.selectList("carList", cv);
	} // 차 리스트 불러오기

	@Override
	public CarVO getCarInfo2(int c_num) {
		return this.sqlSession.selectOne("getCarInfo2",c_num);
	}//차량 코드번호로 차 정보 가져오기

	@Override
	public void delOrder(int cr_num) {
		this.sqlSession.delete("delOrder",cr_num);
	}//예약순을 기준으로 주문번호가 없으면 삭제시킴

	@Override
	public void updateCok(String c_name) {
		this.sqlSession.update("update_cok", c_name);
	} // 예약된 차 이름으로 c_car테이블 c_ok 0으로 변경

	@Override
	public int checkDate(Map<String, Object> params) {
		return this.sqlSession.selectOne("checkDate",params);
	}

	@Override
	public List<RentalVO> getDateCar(String c_name) {
		return this.sqlSession.selectList("getDateCar",c_name);
	}// 선택된 차량에 대한 예약된 날짜 목록을 가져옴

	@Override
	public void reValueDate(String order_number) {
		this.sqlSession.update("reValueDate",order_number);
	}//환불시 렌탈날짜 초기화

	@Override
	public void rentalStatus(String merchantId) {
		this.sqlSession.update("rentalStatus",merchantId);
	}//주문번호를 기준으로 렌탈완료시 c_rental 테이블 status를 wait -> clear로 설정

	@Override
	public void rentalDel() {
		this.sqlSession.delete("rentalDel");
	}//5분안에 결제를 진행안하고 취소를 하면 5분동안 해당차량 렌트 불가

	@Override
	public void rentalDel2(String m_id) {
		this.sqlSession.delete("rentalDel2",m_id);
	}//해당 아이디의 결제 중단 내역들을 전부 제거

	@Override
	public void waitTime(String merchantId) {
		this.sqlSession.update("waitTime",merchantId);
	}//렌탈 테이블의 차량정비시간을 설정

	@Override
	public void insertTime(RentalVO myKey) {
		this.sqlSession.update("insertTime",myKey);
	}//waitTime을 원래 반납시간과 똑같은 시간으로 지정


}
