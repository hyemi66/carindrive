package com.carindrive.controller;

import java.io.PrintWriter;

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
import com.carindrive.vo.AdminVO;

import pwdconv.PwdChange;

@Controller
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@RequestMapping("admin_login")
	public ModelAndView admin_login() {
		return new ModelAndView("admin/admin_login");
	}//admin_login()
	
	@PostMapping("admin_login_ok")
	public String admin_login_ok(AdminVO ab,HttpServletResponse response,
			HttpServletRequest request,HttpSession session) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		ab.setCa_pwd(PwdChange.getPassWordToXEMD5String(ab.getCa_pwd()));
		
		//ab.setAdmin_no(1);
		//this.adminService.insertAdmin(ab);
		
		AdminVO admin_info = this.adminService.adminLogin(ab.getCa_id());
		
		if(admin_info == null) {
			out.println("<script>");
			out.println("alert('관리자 정보가 없습니다!');");
			out.println("history.back();");
			out.println("</script>");
		}else {
			if(!admin_info.getCa_pwd().equals(ab.getCa_pwd())) {
				out.println("<script>");
				out.println("alert('관리자 비번이 다릅니다!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}else {
				session.setAttribute("admin_id",ab.getCa_id());
				return "redirect:/admin_index";
			}
		}
		return null;
	}//admin_login_ok()
	
	@GetMapping("/admin_index")
	public ModelAndView admin_index(HttpServletResponse response, HttpSession session)
	throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		String admin_id=(String)session.getAttribute("admin_id");
		
		if(admin_id == null){
			out.println("<script>");
			out.println("alert('관리자 아이디로 로그인 하세요!');");
			out.println("location='admin_login';");
			out.println("</script>");
		}else {
			ModelAndView am=new ModelAndView();
			am.setViewName("admin/admin_main");
			return am;
		}
		return null;
	}//admin_index()
	
	@RequestMapping("/admin_logout")
	public String admin_logout(HttpServletResponse response,HttpSession session)
	throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		session.invalidate();
		
		out.println("<script>");
		out.println("alert('관리자 로그아웃 되었습니다!');");
		out.println("location='/';");
		out.println("</script>");
		
		return null;
	}//admin_logout()
	
}
