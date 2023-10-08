package com.carindrive.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.carindrive.service.AdminService;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.PageVO;
import com.carindrive.vo.QnaVO;
import com.carindrive.vo.ServiceVO;
import com.oreilly.servlet.MultipartRequest;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	/* 공지사항 */
	@RequestMapping("/admin_main")
	public ModelAndView admin_gongji_list(ServiceVO g, HttpServletRequest request, HttpSession session, PageVO p) 
			throws Exception{
		
		int page = 1; // 쪽번호
		int limit = 7; // 한페이지에 보여지는 목록개수
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));    
		}
		
		String find_name=request.getParameter("find_name");
		String find_field=request.getParameter("find_field");
		p.setFind_field(find_field);
		p.setFind_name("%"+find_name+"%");
		
		int listcount = this.adminService.getListCount(p);
		
		p.setStartrow((page-1)*7+1); // 시작행번호
		p.setEndrow(p.getStartrow()+limit-1); // 끝행번호
		
		List<ServiceVO> glist = this.adminService.getAdminGongjiList(p);
		
		// 총페이지수
		int maxpage = (int)((double)listcount/limit+0.95);
		int startpage = (((int)((double)page/10+0.9))-1)*10+1;
		int endpage = maxpage;
		if(endpage > startpage+10-1) endpage = startpage+10-1;

		ModelAndView listM = new ModelAndView();
		
		listM.addObject("glist",glist);
		listM.addObject("page",page);
		listM.addObject("startpage",startpage);
		listM.addObject("endpage",endpage);
		listM.addObject("maxpage",maxpage);
		listM.addObject("listcount",listcount);   
		listM.addObject("find_field",find_field);
		listM.addObject("find_name", find_name);
		
		listM.setViewName("admin/admin_main");
		
		return listM;
	} // admin_gongji_list()
	
	@GetMapping("/admin_gongji_write")
	public ModelAndView admin_gongji_write(HttpServletRequest request) {
		int page=1;
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		ModelAndView wm = new ModelAndView();
		wm.addObject("page",page); // 페이징에서 책갈피 기능때문에 추가
		wm.setViewName("admin/admin_gongji_write");
		
		return wm;
	} // admin_gongji_write()
	
	@PostMapping("/admin_gongji_write_ok")
	public ModelAndView admin_gongji_write_ok(ServiceVO g) {
			
			this.adminService.agInsert(g);

			return new ModelAndView("redirect:/admin/admin_main");
	} // admin_gongji_write_ok()
	
	@RequestMapping("/admin_gongji_cont")
	public ModelAndView admin_gongji_cont(int no, int page, String state,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		ServiceVO s = this.adminService.getAgCont(no);
		String cs_cont = s.getCs_cont().replace("\n","<br>");
		    
		ModelAndView cm=new ModelAndView();
		cm.addObject("s",s);
		cm.addObject("cs_cont",cs_cont);
		cm.addObject("page",page);
		    
		if(state.equals("cont")) { // 관리자 자료실 상세정보 보기
			cm.setViewName("./admin/admin_gongji_cont");
		} else if (state.equals("edit")) { // 관리자 자료실 수정폼
			cm.setViewName("./admin/admin_gongji_edit");
		}
		
		return cm;
	} // admin_gongji_cont()
	
	@RequestMapping("/admin_gongji_edit_ok")
	public ModelAndView admin_gongji_edit_ok(ServiceVO g, HttpServletRequest request) throws Exception{
		
		int page=1;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		this.adminService.Agupdate(g);
	
		ModelAndView em=new ModelAndView("redirect:/admin/admin_main?page="+page);

		return em;
	} // admin_gongji_edit_ok()
	
	@GetMapping("/admin_gongji_del")
	public ModelAndView admin_gongji_del(int no,int page,HttpServletResponse response,
			HttpSession session,HttpServletRequest request) throws Exception{
		
		this.adminService.AgDel(no);
		
		ModelAndView dm=new ModelAndView();
		dm.setViewName("redirect:/admin/admin_main");
		dm.addObject("page",page);
		return dm;
	}//admin_gongji_del()
	
	
	
	
	/* 차량관리 */
	@RequestMapping("/admin_car_list")
	public ModelAndView admin_car_list(CarVO c,HttpServletResponse response,
			HttpServletRequest request,HttpSession session,PageVO p) throws Exception {
		int page=1;
		int limit=7;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		String find_name=request.getParameter("find_name");
		String find_field=request.getParameter("find_field");
		p.setFind_field(find_field);
		p.setFind_name("%"+find_name+"%");
		
		int listcount = this.adminService.getCarCount(p);
		
		p.setStartrow((page-1)*7+1);//시작행번호
		p.setEndrow(p.getStartrow()+limit-1);//끝행번호

		List<CarVO> clist = this.adminService.getAdminCarList(p);
		
		// 총페이지수
		int maxpage=(int)((double)listcount/limit+0.95);
		int startpage=(((int)((double)page/10+0.9))-1)*10+1;
		int endpage=maxpage;
		if(endpage > startpage+10-1) endpage=startpage+10-1;

		ModelAndView listM=new ModelAndView();
		
		listM.addObject("clist",clist);
		listM.addObject("page",page);
		listM.addObject("startpage",startpage);
		listM.addObject("endpage",endpage);
		listM.addObject("maxpage",maxpage);
		listM.addObject("listcount",listcount);   
		listM.addObject("find_field",find_field);
		listM.addObject("find_name", find_name);
		
		listM.setViewName("admin/admin_car_list");
		return listM;
	} // admin_car_list()
	
	@GetMapping("/admin_car_write")
	public ModelAndView admin_car_write(HttpServletRequest request) throws Exception {
		int page=1;
		
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		ModelAndView wm = new ModelAndView("admin/admin_car_write");
		wm.addObject("page",page); // 페이징에서 책갈피 기능때문에 추가
		
		return wm;
	} // admin_car_write()
	
	@PostMapping("/admin_car_write_ok")
	public ModelAndView admin_car_write_ok(HttpServletRequest request, CarVO c) throws Exception {
		String saveFolder=request.getRealPath("images/car");
		//이진파일 업로드 서버경로
		int fileSize=5*1024*1024;//이진파일 업로드 최대크기
		MultipartRequest multi=null;//이진파일을 받을 참조변수

		multi=new MultipartRequest(request,saveFolder,
				fileSize,"UTF-8");
		
		String c_name=multi.getParameter("c_name");
		String c_brand=multi.getParameter("c_brand");
		String c_year=multi.getParameter("c_year");
		String c_color=multi.getParameter("c_color");
		String c_type=multi.getParameter("c_type");
		String c_type2=multi.getParameter("c_type2");
		String c_oil=multi.getParameter("c_oil");
		double c_price=Double.parseDouble(multi.getParameter("c_price")) ;
		
		File upFile=multi.getFile("c_img");//첨부한 이진파일
		//을 받아옴.
		if(upFile != null) {//첨부한 이진파일이 있다면
			String fileName=upFile.getName();//첨부한 파일명
			
			c.setC_img(fileName);
		}
		c.setC_brand(c_brand); c.setC_color(c_color);
		c.setC_name(c_name); c.setC_oil(c_oil);
		c.setC_price(c_price); c.setC_type(c_type);
		c.setC_type2(c_type2); c.setC_year(c_year);
		
		this.adminService.carInsert(c);

		return new ModelAndView("redirect:/admin/admin_car_list");
	}
	
	@RequestMapping("/admin_car_cont")
	public ModelAndView admin_car_cont(int no,int page,String state) {
		CarVO c = this.adminService.getAdminCarCont(no);
	    ModelAndView cm=new ModelAndView();
	    cm.addObject("c",c);
	    cm.addObject("page",page);
	    
	    if(state.equals("cont")) {//관리자 자료실 상세정보 보기
	    	cm.setViewName("./admin/admin_car_cont");
	    }else if(state.equals("edit")) {//관리자 자료실 수정폼
	    	cm.setViewName("./admin/admin_car_edit");
	    }
	    return cm;
	}//admin_car_cont()
	
	@RequestMapping("/admin_car_edit_ok")
	public ModelAndView admin_car_edit_ok(HttpServletRequest request, CarVO c) throws Exception{
		String saveFolder=request.getRealPath("images/car");//수정 첨부된 파일을 실제 업로드하는
		//서버 폴더 경로
		int fileSize=5*1024*1024;
		
		MultipartRequest multi=null;
		multi=new MultipartRequest(request,saveFolder,fileSize,"UTF-8");
		
		int c_num=Integer.parseInt(multi.getParameter("c_num"));
		int page=1;
		if(multi.getParameter("page") != null) {
			page=Integer.parseInt(multi.getParameter("page"));
		}
		String c_name=multi.getParameter("c_name");
		String c_brand=multi.getParameter("c_brand");
		String c_year=multi.getParameter("c_year");
		String c_color=multi.getParameter("c_color");
		String c_type=multi.getParameter("c_type");
		String c_type2=multi.getParameter("c_type2");
		String c_oil=multi.getParameter("c_oil");
		double c_price=Double.parseDouble(multi.getParameter("c_price")) ;
		
		CarVO db_File = this.adminService.getAdminCarCont(c_num);
		//DB로 부터 기존 첨부파일명을 구함
		
		File upFile=multi.getFile("c_img");//수정 첨부된 파일을 가져온다.
		
		if(upFile != null) { // 수정 첨부된 파일이 있는 경우 실행
			String fileName=upFile.getName(); // 수정 첨부된 파일명을 구함.
			
			c.setC_img(fileName);
		}else { // 수정 첨부파일이 없는 경우
			String fileDBName="";
			if(db_File.getC_img() != null) { // 기존 첨부파일이 있는 경우
				c.setC_img(db_File.getC_img());
			}else {
				c.setC_img(fileDBName);
			}
		} // if else
		
		c.setC_num(c_num);
		c.setC_brand(c_brand); c.setC_color(c_color);
		c.setC_name(c_name); c.setC_oil(c_oil);
		c.setC_price(c_price); c.setC_type(c_type);
		c.setC_type2(c_type2); c.setC_year(c_year);
		
		this.adminService.updateCar(c);
		
		ModelAndView em=new ModelAndView("redirect:/admin/admin_car_list?page="+page);
		return em;
	}//admin_car_edit_ok()
	
	@GetMapping("/admin_car_del")
	public ModelAndView admin_car_del(int no, int page, HttpServletRequest request) throws Exception{
		String delFolder = request.getRealPath("images/car");
		
		CarVO db_File = this.adminService.getAdminCarCont(no);
		
		this.adminService.carDel(no);

		if(db_File.getC_img() != null) { // 파일존재시
			File delFile = new File(delFolder + db_File.getC_img()); // 삭제할 파일 객체 생성
			delFile.delete();
		}
		
		ModelAndView dm = new ModelAndView();
		dm.setViewName("redirect:/admin/admin_car_list");
		dm.addObject("page",page);
		
		return dm;
	} // admin_car_del()
	
	/* 1대1 문의 */
	@RequestMapping("/admin_qna")
	public ModelAndView admin_qna(QnaVO q,HttpServletResponse response,
			HttpServletRequest request,HttpSession session,PageVO p) throws Exception {
		String cq_id = (String)session.getAttribute("id");
		int state = this.adminService.getAdminState(cq_id);
		int page=1;
		int limit=7;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		int listcount = this.adminService.getQnaCount(p);
		
		p.setStartrow((page-1)*7+1);//시작행번호
		p.setEndrow(p.getStartrow()+limit-1);//끝행번호

		List<QnaVO> qlist = this.adminService.getAdminQnaList(p);
		
		// 총페이지수
		int maxpage=(int)((double)listcount/limit+0.95);
		int startpage=(((int)((double)page/10+0.9))-1)*10+1;
		int endpage=maxpage;
		if(endpage > startpage+10-1) endpage=startpage+10-1;

		ModelAndView listM=new ModelAndView();
		
		listM.addObject("state", state);
		listM.addObject("qlist",qlist);
		listM.addObject("page",page);
		listM.addObject("startpage",startpage);
		listM.addObject("endpage",endpage);
		listM.addObject("maxpage",maxpage);
		listM.addObject("listcount",listcount);
		
		listM.setViewName("admin/admin_qna");
		return listM;
	} // admin_qna()
	
	@RequestMapping("/admin_qna_cont")
	public ModelAndView admin_qna_cont(int no,int page) {
		QnaVO q = this.adminService.getAdminQnaCont(no);
		String cq_cont = q.getCq_cont().replace("\n","<br>");
		
		List<QnaVO> qlist = this.adminService.getAdminQnaReply(q.getQna_replygroup());
		
	    ModelAndView cm=new ModelAndView();
	    cm.addObject("q",q);
	    cm.addObject("page",page);
	    cm.addObject("cq_cont", cq_cont);
	    cm.addObject("qlist", qlist);
	    
	    return cm;
	} // admin_qna_cont()
	
	@RequestMapping("/admin_qna_reply")
	public ModelAndView admin_qna_reply(int no, int page) {
		QnaVO q = this.adminService.getAdminQnaCont(no);
		
		ModelAndView qm = new ModelAndView();
		
		qm.addObject("q", q);
		qm.addObject("page",page);
		
		return qm;
	} // admin_qna_reply()
	
	@PostMapping("/admin_qna_reply_ok")
	public String admin_qna_reply_ok(int page, QnaVO q, HttpSession session) {
		String cq_id = (String)session.getAttribute("id");
		q.setCq_id(cq_id);
		
		this.adminService.replyQna(q);
		
		return "redirect:/admin/admin_qna?page=" + page; // 목록 보기로 이동
	} // admin_qna_reply_ok()
	
	@RequestMapping("/admin_qna_reply_edit")
	public ModelAndView admin_qna_reply_edit(int no, int page) {
		QnaVO q = this.adminService.getAdminQnaCont(no);
		
		ModelAndView qm = new ModelAndView();
		
		qm.addObject("q", q);
		qm.addObject("page",page);
		
		return qm;
	} // admin_qna_reply_edit()
	
	@PostMapping("/admin_qna_reply_edit_ok")
	public String admin_qna_reply_edit_ok(int page, QnaVO q) {
		this.adminService.updateReply(q);
		
		return "redirect:/admin/admin_qna?page=" + page;
	} // admin_qna_reply_edit_ok()
	
	@GetMapping("/admin_qna_reply_del")
	public ModelAndView admin_qna_reply_del(int no,int page) {
		
		this.adminService.delReply(no);
		
		ModelAndView dm=new ModelAndView();
		
		dm.setViewName("redirect:/admin/admin_qna");
		dm.addObject("page",page);
		
		return dm;
	}//admin_gongji_del()
	
	/* 회원관리 */
	@RequestMapping("/admin_member")
	public ModelAndView admin_member(MemberVO m,HttpServletResponse response,
			HttpServletRequest request,HttpSession session,PageVO p) throws Exception {
		int page=1;
		int limit=7;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		int listcount = this.adminService.getMemCount(); // 탈퇴회원 총 수
		
		p.setStartrow((page-1)*7+1);//시작행번호
		p.setEndrow(p.getStartrow()+limit-1);//끝행번호
		
		List<MemberVO> mlist = this.adminService.getAdminMemList(p); // 탈퇴회원 멤버 리스트
		
		// 총페이지수
		int maxpage=(int)((double)listcount/limit+0.95);
		int startpage=(((int)((double)page/10+0.9))-1)*10+1;
		int endpage=maxpage;
		if(endpage > startpage+10-1) endpage=startpage+10-1;

		ModelAndView listM=new ModelAndView();
		
		listM.addObject("mlist",mlist);
		listM.addObject("page",page);
		listM.addObject("startpage",startpage);
		listM.addObject("endpage",endpage);
		listM.addObject("maxpage",maxpage);
		listM.addObject("listcount",listcount);
		
		listM.setViewName("admin/admin_member");
		return listM;
	} // admin_member()
	
	@GetMapping("/admin_member_del")
	   public ModelAndView admin_member_del(String m_id, int page) {
	      this.adminService.del_mem(m_id);
	      this.adminService.del_rental(m_id);
	      
	      ModelAndView mm = new ModelAndView();
	      mm.addObject("page", page);
	      mm.setViewName("redirect:/admin/admin_member");
	      
	      return mm;
	   } // admin_member_del()
	
	/* 차량환불관리 */
	@RequestMapping("/admin_pay")
	public ModelAndView admin_pay(OrderVO o,HttpServletResponse response,
			HttpServletRequest request,HttpSession session,PageVO p) throws Exception {
		int page=1;
		int limit=7;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		int listcount = this.adminService.getOrderCount(); // 차량예약총수
		
		p.setStartrow((page-1)*7+1);//시작행번호
		p.setEndrow(p.getStartrow()+limit-1);//끝행번호
		
		List<OrderVO> mlist = this.adminService.getAdminOrderList(p); // 차량예약리스트
		
		// 총페이지수
		int maxpage=(int)((double)listcount/limit+0.95);
		int startpage=(((int)((double)page/10+0.9))-1)*10+1;
		int endpage=maxpage;
		if(endpage > startpage+10-1) endpage=startpage+10-1;

		ModelAndView listM = new ModelAndView();
		
		listM.addObject("mlist",mlist);
		listM.addObject("page",page);
		listM.addObject("startpage",startpage);
		listM.addObject("endpage",endpage);
		listM.addObject("maxpage",maxpage);
		listM.addObject("listcount",listcount);
		
		listM.setViewName("admin/admin_pay");
		
		return listM;
	} // admin_pay()
	
}
