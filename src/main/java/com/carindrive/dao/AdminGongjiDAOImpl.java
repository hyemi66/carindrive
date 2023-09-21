package com.carindrive.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.GongjiVO;
import com.carindrive.vo.PageVO;

@Repository
public class AdminGongjiDAOImpl implements AdminGongjiDAO {

	@Autowired
	private AdminGongjiRepository AgRepo;
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getListCount(PageVO p) {
		return this.sqlSession.selectOne("gongji_count", p);
	}

	@Override
	public List<GongjiVO> getAdminGongjiList(PageVO p) {
		return this.sqlSession.selectList("gongji_list",p);
	}

	@Override
	public void AgInsert(GongjiVO g) {
		int cs_no = this.sqlSession.selectOne("csNoSeq_Find");
		g.setCs_no(cs_no);
		
		this.AgRepo.save(g);
	}

	@Override
	public GongjiVO getAgCont(int no) {
		GongjiVO g = this.AgRepo.getReferenceById(no);
		return g;
	}
	
	@Transactional
	@Override
	public void AgUpdate(GongjiVO g) {
		this.AgRepo.AgUpdate(g.getCs_title(),g.getCs_cont(),g.getCs_no());
	}

	@Override
	public void AgDel(int no) {
		this.AgRepo.deleteById(no);
	}
}
