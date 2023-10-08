package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;

public interface AdminDAO {

	int getListCount(PageVO p);

	List<ServiceVO> getAdminGongjiList(PageVO p);

	void agInsert(ServiceVO g);

	ServiceVO getAgCont(int no);

	void Agupdate(ServiceVO g);

	void AgDel(int no);

	int getCarCount(PageVO p);

	List<CarVO> getAdminCarList(PageVO p);

	void carInsert(CarVO c);

	CarVO getAdminCarCont(int no);

	void updateCar(CarVO c);

	void carDel(int no);

	int getQnaCount(PageVO p);

	List<QnaVO> getAdminQnaList(PageVO p);

	int getAdminState(String cq_id);
	
	QnaVO getAdminQnaCont(int no);

	List<QnaVO> getAdminQnaReply(int qna_replygroup);

	void updateQnaIndex(QnaVO q);

	void replyQna(QnaVO q);

	void updateReply(QnaVO q);

	void delReply(int no);

	int getMemCount();

	List<MemberVO> getAdminMemList(PageVO p);

	void del_mem(String m_id);

	int getOrderCount();

	List<OrderVO> getAdminOrderList(PageVO p);

	void del_rental(String m_id);

}
