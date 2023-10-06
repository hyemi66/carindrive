package com.carindrive.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
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
	
	/* 1대1 문의 */
	@Override
	public int getQnaCount(PageVO p) {
		return this.sqlSession.selectOne("admin_qna_count", p);
	} // qna 목록 총 개수

	@Override
	public List<QnaVO> getAdminQnaList(PageVO p) {
		return this.sqlSession.selectList("admin_qna_list", p);
	} // qna 목록 리스트
	
	@Override
	public int getAdminState(String cq_id) {
		return this.sqlSession.selectOne("admin_state", cq_id);
	} // admin state번호 알기

	@Override
	public QnaVO getAdminQnaCont(int no) {
		return this.sqlSession.selectOne("admin_qna_cont", no);
	} // qna 내용보기
	
	@Override
	public List<QnaVO> getAdminQnaReply(int qna_replygroup) {
		return this.sqlSession.selectList("replyList", qna_replygroup);
	} // 번호에 해당하는 답변 저장
	
	@Override
	public void updateQnaIndex(QnaVO q) {
		this.sqlSession.update("update_index", q);
	} // qna index 증가

	@Override
	public void replyQna(QnaVO q) {
		this.sqlSession.insert("reply_insert", q);
	} // qna 답변저장

	@Override
	public void updateReply(QnaVO q) {
		this.sqlSession.update("reply_update", q);
	} // 답변수정

	@Override
	public void delReply(int no) {
		this.sqlSession.delete("reply_del", no);
	} // 답변삭제
	
	
	/* 탈퇴회원관리 */
	@Override
	public int getMemCount() {
		return this.sqlSession.selectOne("count_mem");
	} // 탈퇴회원 총 수

	@Override
	public List<MemberVO> getAdminMemList(PageVO p) {
		return this.sqlSession.selectList("admin_mem_list", p);
	} // 탈퇴회원 멤버 리스트

	@Override
	public void del_mem(String m_id) {
		this.sqlSession.delete("admin_del_mem", m_id);
	} // 탈퇴회원 완전히 삭제하기
	
	/* 차량예약환불관리 */
	@Override
	public int getOrderCount() {
		return this.sqlSession.selectOne("count_order");
	} // 차량예약총개수

	@Override
	public List<OrderVO> getAdminOrderList(PageVO p) {
		return this.sqlSession.selectList("admin_order_list", p);
	} // 차량예약리스트

	@Override
	public void del_rental(String m_id) {
		this.sqlSession.delete("del_rental", m_id);
	}

}
