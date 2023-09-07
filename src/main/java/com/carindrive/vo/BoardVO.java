package com.carindrive.vo;

import lombok.Data;

@Data
public class BoardVO {

	private int bno;			//게시판 번호
	private String writer;		//글쓴이
	private String title;		//글제목
	private String content;		//글내용
	private int viewcnt;		//조회수
	private String regdate;		//등록날짜
	
	private int replycnt;		//댓글 개수 카운터
	
	//페이징 => 쪽나누기
	private int startrow;		//시작행 번호
	private int endrow;			//끝행 번호
	
	public BoardVO() {}
	
	
}
