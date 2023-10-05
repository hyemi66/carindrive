package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;

public interface ServiceSv {


	int getListCount(PageVO p);

	List<ServiceVO> getQuestionList(PageVO p);

	ServiceVO getCont(int cs_no);

	void insertQna(QnaVO q);

	List<ServiceVO> getQuestionList01();

	List<ServiceVO> getQuestionList00();

	List<ServiceVO> getQuestionList02();

	List<ServiceVO> getQuestionList03();

	List<ServiceVO> getQuestionList04();

	List<ServiceVO> getQuestionList05();

	List<ServiceVO> getQuestionList06();

	List<ServiceVO> getQuestionList07();

	int getRowCount(PageVO p);

	List<QnaVO> getQnaList(PageVO p);

	QnaVO qpwdCheck(int cq_no);

	List<QnaVO> getQnaList(int cq_no);

	void replyqna(QnaVO q);

	QnaVO getQnaCont2(int cq_no);

	void editQna(QnaVO q);

	void delqna(int cq_no);

	QnaVO getQnaCont(int cq_no);

	ServiceVO getCs_Cont(int cs_no);

	List<ServiceVO> getList();

	List<QnaVO> getQnaReply(int qna_replygroup);







}
