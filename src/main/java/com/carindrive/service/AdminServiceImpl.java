package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.carindrive.dao.AdminDAO;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO adminDao;

	@Override
	public int getListCount(PageVO p) {
		return this.adminDao.getListCount(p);
	}

	@Override
	public List<ServiceVO> getAdminGongjiList(PageVO p) {
		return this.adminDao.getAdminGongjiList(p);
	}

	@Override
	public void agInsert(ServiceVO g) {
		this.adminDao.agInsert(g);
	}

	@Override
	public ServiceVO getAgCont(int no) {
		return this.adminDao.getAgCont(no);
	}

	@Override
	public void Agupdate(ServiceVO g) {
		this.adminDao.Agupdate(g);
	}

	@Override
	public void AgDel(int no) {
		this.adminDao.AgDel(no);
	}

	@Override
	public int getCarCount(PageVO p) {
		return this.adminDao.getCarCount(p);
	}

	@Override
	public List<CarVO> getAdminCarList(PageVO p) {
		return this.adminDao.getAdminCarList(p);
	}

	@Override
	public void carInsert(CarVO c) {
		this.adminDao.carInsert(c);
	}

	@Override
	public CarVO getAdminCarCont(int no) {
		return this.adminDao.getAdminCarCont(no);
	}

	@Override
	public void updateCar(CarVO c) {
		this.adminDao.updateCar(c);
	}

	@Override
	public void carDel(int no) {
		this.adminDao.carDel(no);
	}

	@Override
	public int getQnaCount(PageVO p) {
		return this.adminDao.getQnaCount(p);
	}

	@Override
	public List<QnaVO> getAdminQnaList(PageVO p) {
		return this.adminDao.getAdminQnaList(p);
	}
	
	@Override
	public int getAdminState(String cq_id) {
		return this.adminDao.getAdminState(cq_id);
	}

	@Override
	public QnaVO getAdminQnaCont(int no) {
		return this.adminDao.getAdminQnaCont(no);
	}
	
	@Override
	public List<QnaVO> getAdminQnaReply(int qna_replygroup) {
		return this.adminDao.getAdminQnaReply(qna_replygroup);
	}
	
	@Transactional
	@Override
	public void replyQna(QnaVO q) {
		this.adminDao.updateQnaIndex(q); // 답변 레벨 증가
		this.adminDao.replyQna(q); // 답변 저장
	}

	@Override
	public void updateReply(QnaVO q) {
		this.adminDao.updateReply(q);
	}

	@Override
	public void delReply(int no) {
		this.adminDao.delReply(no);
	}

	@Override
	public int getMemCount() {
		return this.adminDao.getMemCount();
	}

	@Override
	public List<MemberVO> getAdminMemList(PageVO p) {
		return this.adminDao.getAdminMemList(p);
	}

	@Override
	public void del_mem(String m_id) {
		this.adminDao.del_mem(m_id);
	}

	@Override
	public int getOrderCount() {
		return this.adminDao.getOrderCount();
	}

	@Override
	public List<OrderVO> getAdminOrderList(PageVO p) {
		return this.adminDao.getAdminOrderList(p);
	}

	@Override
	public void del_rental(String m_id) {
		this.adminDao.del_rental(m_id);
	}

}
