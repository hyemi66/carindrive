package com.carindrive.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.RentalVO;

@Repository
public class RentDAOImpl implements RentDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CarVO> getCarList(CarVO cv) {
		return this.sqlSession.selectList("carList", cv);
	} // 차 리스트 불러오기

	@Override
	public void insertLoad(RentalVO r) {
		this.sqlSession.insert("insert_load", r);
	} // 차 중간 저장



}
