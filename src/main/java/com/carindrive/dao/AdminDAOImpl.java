package com.carindrive.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.ServiceVO;

@Repository
public class AdminDAOImpl implements AdminDAO {
	
	@Autowired
	private SqlSession sqlSession;

	/* 공지사항 */
	@Override
	public int getListCount(PageVO p) {
		return this.sqlSession.selectOne("list_count", p);
	} // 공지사항 목록 총 개수
	
	@Override
	public List<ServiceVO> getAdminGongjiList(PageVO p) {
		return this.sqlSession.selectList("gongji_list", p);
	} // 공지사항 목록

	@Override
	public void agInsert(ServiceVO g) {
		this.sqlSession.insert("gongji_add", g);
	} // 공지사항 글추가

	@Override
	public ServiceVO getAgCont(int no) {
		return this.sqlSession.selectOne("gongji_cont", no);
	} // 글번호로 내용보기

	@Override
	public void Agupdate(ServiceVO g) {
		this.sqlSession.update("gongji_update", g);
	} // 글 수정

	@Override
	public void AgDel(int no) {
		this.sqlSession.delete("gongji_del", no);
	} // 글 삭제

	
	/* 차량관리 */
	@Override
	public int getCarCount(PageVO p) {
		return this.sqlSession.selectOne("car_count", p);
	} // 차 총 개수

	@Override
	public List<CarVO> getAdminCarList(PageVO p) {
		return this.sqlSession.selectList("car_list", p);
	} // 차 리스트

	@Override
	public void carInsert(CarVO c) {
		this.sqlSession.insert("car_insert", c);
	} // 차량추가

	@Override
	public CarVO getAdminCarCont(int no) {
		return this.sqlSession.selectOne("car_cont", no);
	} // 차량 내용보기

	@Override
	public void updateCar(CarVO c) {
		this.sqlSession.update("car_update", c);
	} // 차량 정보 수정

	@Override
	public void carDel(int no) {
		this.sqlSession.delete("car_del", no);
	}

}
