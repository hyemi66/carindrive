package com.carindrive.controller;

import java.io.PrintWriter;
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

import com.carindrive.service.AdminGongjiService;
import com.carindrive.vo.GongjiVO;
import com.carindrive.vo.PageVO;

@Controller
public class AdminGongjiController {

	@Autowired
	private AdminGongjiService AgService;
	
	@RequestMapping("admin_gongji_list")
	public ModelAndView admin_gongji_list(GongjiVO g,HttpServletResponse response,
			HttpServletRequest request,HttpSession session,PageVO p) 
	throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		String admin_id = (String)session.getAttribute("admin_id");
		if(admin_id == null) {
			out.println("<script>");
			out.println("alert('관리자로 로그인 하세요!');");
			out.println("location='admin_login';");
			out.println("</script>");
		}else {
			int page=1;//쪽번호
			int limit=7;//한페이지에 보여지는 목록개수
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));    
			}
			String find_name=request.getParameter("find_name");
			String find_field=request.getParameter("find_field");
			p.setFind_field(find_field);
			p.setFind_name("%"+find_name+"%");
			
			
			int listcount=this.AgService.getListCount(p);
			
			p.setStartrow((page-1)*7+1);//시작행번호
			p.setEndrow(p.getStartrow()+limit-1);//끝행번호

			List<GongjiVO> glist=this.AgService.getAdminGongjiList(p);
			
			//총페이지수
			int maxpage=(int)((double)listcount/limit+0.95);
			int startpage=(((int)((double)page/10+0.9))-1)*10+1;
			int endpage=maxpage;
			if(endpage > startpage+10-1) endpage=startpage+10-1;

			ModelAndView listM=new ModelAndView();
			
			listM.addObject("glist",glist);
			listM.addObject("page",page);
			listM.addObject("startpage",startpage);
			listM.addObject("endpage",endpage);
			listM.addObject("maxpage",maxpage);
			listM.addObject("listcount",listcount);   
			listM.addObject("find_field",find_field);
			listM.addObject("find_name", find_name);
			
			listM.setViewName("admin/admin_gongji_list");
			return listM;
		}
		return null;
	}//admin_gongji_list()
	
	@GetMapping("/admin_gongji_write")
	public ModelAndView admin_gongji_write(HttpServletResponse response,
			HttpSession session,HttpServletRequest request) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {//true인 경우 실행, ==true가 생략됨.
			int page=1;
			
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));
			}
			
			ModelAndView wm = new ModelAndView("admin/admin_gongji_write");
			wm.addObject("page",page);//페이징에서 책갈피 기능때문에 추가
			return wm;
		}
		return null;
	}//admin_gongji_write()
	
	 
	@PostMapping("/admin_gongji_write_ok")
	public ModelAndView admin_gongji_write_ok(HttpSession session,HttpServletResponse
			response,HttpServletRequest request,GongjiVO g) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
	
		if(isAdminLogin(session, response)) {

			g.setCs_name("관리자");
			
			this.AgService.AgInsert(g);

			return new ModelAndView("redirect:/admin_gongji_list"); 
		}		
		return null;
	}//admin_gongji_write_ok()
	
	@RequestMapping("/admin_gongji_cont")
	public ModelAndView admin_gongji_cont(int no,int page,String state,
			HttpServletResponse response, HttpSession session) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
			GongjiVO g = this.AgService.getAgCont(no);
		    String cs_cont = g.getCs_cont().replace("\n","<br>");/* textarea에서
		    엔터키를 친 부분을 줄바꿈 처리해서 내용보기 한다. */
		    
		    ModelAndView cm=new ModelAndView();
		    cm.addObject("g",g);
		    cm.addObject("cs_cont",cs_cont);
		    cm.addObject("page",page);
		    
		    if(state.equals("cont")) {//관리자 자료실 상세정보 보기
		    	cm.setViewName("./admin/admin_gongji_cont");
		    }else if(state.equals("edit")) {//관리자 자료실 수정폼
		    	cm.setViewName("./admin/admin_gongji_edit");
		    }
		    return cm;
		}//if
		return null;
	}//admin_gongji_cont()
	
	@RequestMapping("/admin_gongji_edit_ok")
	public ModelAndView admin_bbs_edit_ok(HttpServletRequest request,
			HttpServletResponse response,HttpSession session,GongjiVO g) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
			
			int page=1;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));
			}
			
			this.AgService.AgUpdate(g);
		
			ModelAndView em=new ModelAndView("redirect:/admin_gongji_list?page="+page);

			return em;
		}
		return null;
	}//admin_gongji_edit_ok()
	
	@GetMapping("/admin_gongji_del")
	public ModelAndView admin_gongji_del(int no,int page,HttpServletResponse response,
			HttpSession session,HttpServletRequest request) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
			
			this.AgService.AgDel(no);//번호를 기준으로 삭제
			
			ModelAndView dm=new ModelAndView();
			dm.setViewName("redirect:/admin_gongji_list");
			dm.addObject("page",page);
			return dm;
		}
		return null;
	}//admin_gongji_del()
	

	public static boolean isAdminLogin(HttpSession session, HttpServletResponse 
			response) throws Exception{
		
		PrintWriter out=response.getWriter();
		String admin_id=(String)session.getAttribute("admin_id");
		if(admin_id == null) {
			out.println("<script>");
			out.println("alert('관리자로 로그인 하세요!');");
		    out.println("location='admin_login';");
		    out.println("</script>");
		
		    return false;
		}
		return true;
	}//isAdminLogin()
}
