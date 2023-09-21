package com.carindrive.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.carindrive.service.AdminMemberService;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.PageVO;

import pwdchange.CarPwdCh;


@Controller
public class AdminMemberController {

	@Autowired
	private AdminMemberService AmService;
	
	
	@RequestMapping("/admin_member_list")
	public String admin_member_list(Model listM,
			HttpServletResponse response,
			HttpServletRequest request,
			PageVO p)
					throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String admin_id=(String)session.getAttribute("admin_id");

		if(admin_id == null) {
			out.println("<script>");
			out.println("alert('관리자로 로그인 하세요!');");
			out.println("location='admin_login';");
			out.println("</script>");
		}else {
			int page=1;
			int limit=7;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));			
			}
			String find_name=request.getParameter("find_name");
			String find_field=request.getParameter("find_field");
			p.setFind_field(find_field);
			p.setFind_name("%"+find_name+"%");
			

			int listcount=this.AmService.getListCount(p);
		

			p.setStartrow((page-1)*7+1);
			p.setEndrow(p.getStartrow()+limit-1);

			List<MemberVO> blist=
					this.AmService.getMemberList(p);

			int maxpage=(int)((double)listcount/limit+0.95);
			int startpage=(((int)((double)page/10+0.9))-1)*10+1;
			int endpage=maxpage;
			if(endpage > startpage+10-1) endpage=startpage+10-1;

			listM.addAttribute("blist",blist);
			listM.addAttribute("page",page);
			listM.addAttribute("startpage",startpage);
			listM.addAttribute("endpage",endpage);
			listM.addAttribute("maxpage",maxpage);
			listM.addAttribute("listcount",listcount);	
			listM.addAttribute("find_field",find_field);
			listM.addAttribute("find_name", find_name);

			return "admin/admin_member_list";
		}
		return null;
	}//admin_member_list()
	
	@RequestMapping("/admin_member_info")
	public String admin_member_info(
			@RequestParam("m_id") String m_id,
			@RequestParam("state") String state,
			HttpServletRequest request,
			HttpServletResponse response,
			Model am) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String admin_id=(String)session.getAttribute("admin_id");

		if(admin_id == null) {
			out.println("<script>");
			out.println("alert('다시 로그인 하세요!');");
			out.println("location='admin_login';");
			out.println("</script>");
		}else {
			int page=1;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));    		
			}
			MemberVO m=this.AmService.getMem(m_id);
			
			
			am.addAttribute("m",m); 
			am.addAttribute("page",page);

			if(state.equals("info")) {//상세정보 보기
				return "admin/admin_member_info";
			}else if(state.equals("edit")) {//수정폼
				return "admin/admin_member_edit";
			}
		}
		return null;
	}//admin_member_info()
	
	@RequestMapping("/admin_member_edit")
	public String admin_member_edit(
			MemberVO m,HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String admin_id=(String)session.getAttribute("admin_id");
		if(admin_id == null) {
			out.println("<script>");
			out.println("alert('다시 로그인 하세요!');");
			out.println("location='admin_login';");
			out.println("</script>");
		}else {
			m.setM_pwd(CarPwdCh.getPassWordToXEMD5String(
					m.getM_pwd()));
			this.AmService.editM(m);
			out.println("<script>");
			out.println("alert('정보 수정했습니다!');");
			out.println("location='admin_member_info?state=edit"
					+"&m_id="+m.getM_id()+"';");
			out.println("</script>");
		}
		return null;
	}//admin_member_edit()
	
	@RequestMapping("/admin_member_del")
	public ModelAndView admin_member_del(
			@RequestParam("m_id") String m_id,
			HttpServletResponse response,
			HttpServletRequest request)
					throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String admin_id=(String)session.getAttribute("admin_id");
		if(admin_id == null) {
			out.println("<script>");
			out.println("alert('다시 로그인 하세요!');");
			out.println("location='admin_login';");
			out.println("</script>");
		}else {
			int page=1;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));    		
			}
			this.AmService.delM(m_id);//회원삭제
			/* 문제풀이) 아이디를 기준으로 회원을 delete한다.     	
			 */
			return     	
					new ModelAndView(
							"redirect:/admin_member_list").addObject("page",page); 
			//admin_member_list?page=쪽번호 get방식으로 회원목록으로 이동
		}
		return null;
	}//admin_member_del()
}
