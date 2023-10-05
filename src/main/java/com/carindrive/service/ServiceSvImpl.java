package com.carindrive.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.ServiceDAO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;

@Service
public class ServiceSvImpl implements ServiceSv {
	@Autowired
	private ServiceDAO serviceDAO;

	@Override
	public List<ServiceVO> getList() {
		return this.serviceDAO.getList();
	}

	@Override
	public int getListCount(PageVO p) {
		return this.serviceDAO.getListCount(p);
	}

	@Override
	public List<ServiceVO> getQuestionList(PageVO p) {
		return this.serviceDAO.getQuestionList(p);
	}

	@Override
	public ServiceVO getCont(int cs_no) {
		return this.serviceDAO.getCont(cs_no);
	}

	@Override
	public void insertQna(QnaVO q) {
		this.serviceDAO.insertQna(q);
	}

	@Override
	public List<ServiceVO> getQuestionList00() {
		return this.serviceDAO.getQuestionList00();

	}

	@Override
	public List<ServiceVO> getQuestionList01() {
		return this.serviceDAO.getQuestionList01();
	}


	@Override
	public List<ServiceVO> getQuestionList02() {
		return this.serviceDAO.getQuestionList02();

	}

	@Override
	public List<ServiceVO> getQuestionList03() {
		return this.serviceDAO.getQuestionList03();

	}

	@Override
	public List<ServiceVO> getQuestionList04() {
		return this.serviceDAO.getQuestionList04();
	}

	@Override
	public List<ServiceVO> getQuestionList05() {
		return this.serviceDAO.getQuestionList05();

	}

	@Override
	public List<ServiceVO> getQuestionList06() {
		return this.serviceDAO.getQuestionList06();
	}


	@Override
	public List<ServiceVO> getQuestionList07() {
		return this.serviceDAO.getQuestionList07();

	}

	@Override
	public int getRowCount(PageVO p) {
		return this.serviceDAO.getRowCount(p);
	}

	@Override
	public List<QnaVO> getQnaList(PageVO p) {
		return this.serviceDAO.getQnaList(p);
	}

	@Override
	public QnaVO qpwdCheck(int cq_no) {
		return this.serviceDAO.qpwdCheck(cq_no);
	}

	@Override
	public List<QnaVO> getQnaList(int cq_no) {
		return this.serviceDAO.getQnaList(cq_no);
	}

	@Override
	public void replyqna(QnaVO q) {
		this.serviceDAO.updateLevel(q);//답변 레벨 증가
	    this.serviceDAO.replyqna(q);
	}

	@Override
	public QnaVO getQnaCont2(int cq_no) {
		return this.serviceDAO.getQnaCont(cq_no);
	}

	@Override
	public void editQna(QnaVO q) {
		this.serviceDAO.editQna(q);	
	}

	@Override
	public void delqna(int cq_no) {
		this.serviceDAO.delqna(cq_no);
	}

	@Override
	public QnaVO getQnaCont(int cq_no) {
		return null;
	}

	@Override
	public ServiceVO getCs_Cont(int cs_no) {
		this.serviceDAO.updateHit(cs_no);//조회수 증가
		return this.serviceDAO.getCs_Cont(cs_no);
	}

	@Override
	public List<QnaVO> getQnaReply(int qna_replygroup) {
		return this.serviceDAO.getQnaReply(qna_replygroup);
	}
	
}
