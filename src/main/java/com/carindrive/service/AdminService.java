package com.carindrive.service;

import java.util.List;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;

public interface AdminService {
	
	/* 공지사항 */
	int getListCount(PageVO p);

	List<ServiceVO> getAdminGongjiList(PageVO p);

	void agInsert(ServiceVO g);

	ServiceVO getAgCont(int no);

	void Agupdate(ServiceVO g);

	void AgDel(int no);
	
	/* 차량관리 */
	int getCarCount(PageVO p);

	List<CarVO> getAdminCarList(PageVO p);

	void carInsert(CarVO c);

	CarVO getAdminCarCont(int no);

	void updateCar(CarVO c);

	void carDel(int no);
	
	/* 1대1 문의 */
	int getQnaCount(PageVO p);

	List<QnaVO> getAdminQnaList(PageVO p);

	int getAdminState(String cq_id);

	QnaVO getAdminQnaCont(int no);

	List<QnaVO> getAdminQnaReply(int qna_replygroup);
	
	void replyQna(QnaVO q);

	void updateReply(QnaVO q);

	void delReply(int no);
	
	/* 탈퇴회원관리 */
	int getMemCount();

	List<MemberVO> getAdminMemList(PageVO p);

	void del_mem(String m_id);
	
	void del_rental(String m_id);
	
	/* 차량환불관리 */
	int getOrderCount();

	List<OrderVO> getAdminOrderList(PageVO p);


}
