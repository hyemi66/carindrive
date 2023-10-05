package com.carindrive.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;


@Repository
public class ServiceDAOImpl implements ServiceDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<ServiceVO> getList() {
		return this.sqlSession.selectList("s_list");
	}

	@Override
	public int getListCount(PageVO p) {
		return this.sqlSession.selectOne("notice_row",p);
	}

	@Override
	public List<ServiceVO> getQuestionList(PageVO p) {
		return this.sqlSession.selectList("question_list",p);
	}

	@Override
	public ServiceVO getCont(int cs_no) {
		return this.sqlSession.selectOne("cs_cont", cs_no);
	}

	@Override
	public void insertQna(QnaVO q) {
		this.sqlSession.insert("qna_in",q);
	}

	@Override
	public List<ServiceVO> getQuestionList00() {
		return this.sqlSession.selectList("question_list00");
	}

	@Override
	public List<ServiceVO> getQuestionList01() {
		return this.sqlSession.selectList("question_list01");
	}


	@Override
	public List<ServiceVO> getQuestionList02() {
		return this.sqlSession.selectList("question_list02");
	}

	@Override
	public List<ServiceVO> getQuestionList03() {
		return this.sqlSession.selectList("question_list03");
	}

	@Override
	public List<ServiceVO> getQuestionList04() {
		return this.sqlSession.selectList("question_list04");
	}

	@Override
	public List<ServiceVO> getQuestionList05() {
		return this.sqlSession.selectList("question_list05");
	}

	@Override
	public List<ServiceVO> getQuestionList06() {
		return this.sqlSession.selectList("question_list06");
	}

	@Override
	public List<ServiceVO> getQuestionList07() {
		return this.sqlSession.selectList("question_list07");
	}

	@Override
	public int getRowCount(PageVO p) {
		return this.sqlSession.selectOne("qna_count", p);
	}

	@Override
	public List<QnaVO> getQnaList(PageVO p) {
		return this.sqlSession.selectList("qna_list",p);
	}

	@Override
	public QnaVO qpwdCheck(int cq_no) {
		return this.sqlSession.selectOne("qpwdCheck",cq_no);
	}

	@Override
	public List<QnaVO> getQnaList(int cq_no) {
		return this.sqlSession.selectOne("qpwdCheck_b",cq_no);
	}

	@Override
	public void editQna(QnaVO q) {
		this.sqlSession.update("qna_edit", q);
	}

	@Override
	public void delqna(int cq_no) {
		this.sqlSession.delete("del_qna", cq_no);
	}

	@Override
	public QnaVO getQnaCont(int cq_no) {
		return this.sqlSession.selectOne("qna_cont",cq_no);
	}

	@Override
	public void replyqna(QnaVO q) {
		this.sqlSession.insert("reply_in",q);
		
	}

	@Override
	public void updateLevel(QnaVO q) {
		this.sqlSession.update("levelUp", q);
	}

	@Override
	public ServiceVO getCs_Cont(int cs_no) {
		return this.sqlSession.selectOne("sg_cont",cs_no);
	}

	@Override
	public void updateHit(int cs_no) {
		this.sqlSession.update("cs_hit",cs_no);
	}

	@Override
	public List<QnaVO> getQnaReply(int qna_replygroup) {
		return this.sqlSession.selectList("qna_reply", qna_replygroup);
	}

}
