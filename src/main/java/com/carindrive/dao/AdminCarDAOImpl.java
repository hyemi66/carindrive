package com.carindrive.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.PageVO;

@Repository
public class AdminCarDAOImpl implements AdminCarDAO {

	@Autowired
	private AdminCarRepository AcRepo;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getListCount(PageVO p) {
		return this.sqlSession.selectOne("car_count",p);
	}

	@Override
	public List<CarVO> getAdminCarList(PageVO p) {
		return this.sqlSession.selectList("car_list",p);
	}

	@Override
	public void adminInsertCar(CarVO c) {
		int c_num = this.sqlSession.selectOne("cNumSeq_Find");
		c.setC_num(c_num);
		
		this.AcRepo.save(c);
	}

	@Override
	public CarVO getAdminCarCont(int no) {
		CarVO c = this.AcRepo.getReferenceById(no);
		return c;
	}
	
	@Transactional
	@Override
	public void adminUpdateCar(CarVO c) {
		this.AcRepo.updateAdminCar(c.getC_name(),c.getC_brand(),c.getC_year(),c.getC_color(),
				c.getC_type(),c.getC_type2(),c.getC_oil(),c.getC_price(),c.getC_img(),c.getC_num());
	}

	@Override
	public void AcDel(int no) {
		this.AcRepo.deleteById(no);
	}
	
}
