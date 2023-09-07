package com.carindrive.dao;

import java.util.List;

import com.carindrive.vo.BoardVO;

public interface BoardDAO {

	void insertBoard(BoardVO b);

	int getTotalCount();

	List<BoardVO> getBoardList(BoardVO b);

	BoardVO getBoardCont(int bno);

	void editBoard(BoardVO eb);

	void delBoard(int bno);

}
