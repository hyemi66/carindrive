package com.carindrive.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.carindrive.service.AdminCarService;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.PageVO;
import com.oreilly.servlet.MultipartRequest;

@Controller
public class AdminCarController {

	@Autowired
	private AdminCarService AcService;
	
	@RequestMapping("admin_car_list")
	public ModelAndView admin_car_list(CarVO c,HttpServletResponse response,
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
			int page=1;
			int limit=7;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));    
			}
			String find_name=request.getParameter("find_name");
			String find_field=request.getParameter("find_field");
			p.setFind_field(find_field);
			p.setFind_name("%"+find_name+"%");
			
			
			int listcount=this.AcService.getListCount(p);
			
			p.setStartrow((page-1)*7+1);//시작행번호
			p.setEndrow(p.getStartrow()+limit-1);//끝행번호

			List<CarVO> clist=this.AcService.getAdminCarList(p);
			
			//총페이지수
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
		}
		return null;
	}//admin_car_list()
	
	@GetMapping("/admin_car_write")
	public ModelAndView admin_car_write(HttpServletResponse response,
			HttpSession session,HttpServletRequest request) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
			int page=1;
			
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));
			}
			
			ModelAndView wm = new ModelAndView("admin/admin_car_write");
			wm.addObject("page",page);//페이징에서 책갈피 기능때문에 추가
			return wm;
		}
		return null;
	}//admin_car_write()
	
	@PostMapping("/admin_car_write_ok")
	public ModelAndView admin_bbs_write_ok(HttpSession session,HttpServletResponse
			response,HttpServletRequest request, CarVO c) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
	
		if(isAdminLogin(session, response)) {
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
			int c_price=Integer.parseInt(multi.getParameter("c_price")) ;
			
			File upFile=multi.getFile("c_img");//첨부한 이진파일
			//을 받아옴.
			if(upFile != null) {//첨부한 이진파일이 있다면
				String fileName=upFile.getName();//첨부한 파일명
				/*
				Calendar ca=Calendar.getInstance();//칼렌더는 추상
				
				//클래스로 new로 객체 생성을 못함. 년월일 시분초 값을 반환
				int year=ca.get(Calendar.YEAR);//년도값
				int month=ca.get(Calendar.MONTH)+1;//월값. +1을 한
				//이유가 1월이 0으로 반환 되기 때문이다.
				int date=ca.get(Calendar.DATE);//일값
				String homedir=saveFolder+"/"+year+"-"+month+"-"+date;//오늘
				//날짜 폴더 경로 저장
				File path1=new File(homedir);
				if(!(path1.exists())) {
					path1.mkdir();//오늘날짜 폴더를 생성
				}
				Random r=new Random();
				int random=r.nextInt(100000000);
				
				//첨부 파일 확장자 구함
				int index=fileName.lastIndexOf(".");//마침표 위치
				//번호를 구함
				String fileExtension=fileName.substring(index+1);//마침표
				//이후부터 마지막 문자까지 구함.첨부파일 확장자를 구함
				String refileName="car"+year+month+date+random+"."+
						fileExtension;//새로운 이진파일명 저장
				String fileDBName="/"+year+"-"+month+"-"+date+"/"+
						refileName;//DB에 저장될 레코드값
				upFile.renameTo(new File(homedir+"/"+refileName));
				*/
				//바뀌어진 이진파일로 업로드
				
				c.setC_img(fileName);
			}
			c.setC_brand(c_brand); c.setC_color(c_color);
			c.setC_name(c_name); c.setC_oil(c_oil);
			c.setC_price(c_price); c.setC_type(c_type2);
			c.setC_type2(c_type2); c.setC_year(c_year);

			this.AcService.adminInsertCar(c);

			return new ModelAndView("redirect:/admin_car_list"); 
		}		
		return null;
	}//admin_bbs_write_ok()
	
	@RequestMapping("/admin_car_cont")
	public ModelAndView admin_car_cont(int no,int page,String state,
			HttpServletResponse response, HttpSession session) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
			CarVO c = this.AcService.getAdminCarCont(no);
		    ModelAndView cm=new ModelAndView();
		    cm.addObject("c",c);
		    cm.addObject("page",page);
		    
		    if(state.equals("cont")) {//관리자 자료실 상세정보 보기
		    	cm.setViewName("./admin/admin_car_cont");
		    }else if(state.equals("edit")) {//관리자 자료실 수정폼
		    	cm.setViewName("./admin/admin_car_edit");
		    }
		    return cm;
		}//if
		return null;
	}//admin_car_cont()
	
	@RequestMapping("/admin_car_edit_ok")
	public ModelAndView admin_car_edit_ok(HttpServletRequest request,
			HttpServletResponse response,HttpSession session,CarVO c) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
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
			int c_price=Integer.parseInt(multi.getParameter("c_price")) ;
			
			CarVO db_File=this.AcService.getAdminCarCont(c_num);
			//DB로 부터 기존 첨부파일명을 구함
			
			File upFile=multi.getFile("c_img");//수정 첨부된 파일을 가져온다.
			
			if(upFile != null) {//수정 첨부된 파일이 있는 경우 실행
				String fileName=upFile.getName();//수정 첨부된 파일명을 구함.
				/*File delFile=new File(saveFolder+db_File.getC_img());
				//삭제할 파일 객체 생성
				if(delFile.exists()) { 
					delFile.delete();//기존첨부파일을 삭제				
				}
				Calendar cal=Calendar.getInstance();
				int year=cal.get(Calendar.YEAR);//년도값
				int month=cal.get(Calendar.MONTH)+1;//월값
				int date=cal.get(Calendar.DATE);//일값
				
				String homedir=saveFolder+"/"+year+"-"+month+"-"+date;
				File path01=new File(homedir);
				if(!(path01.exists())) {//오늘날짜 폴더 경로가 없어면
					path01.mkdir();//오늘날짜 폴더를 생성
				}
				Random r=new Random();
				int random=r.nextInt(100000000);
				
				int index=fileName.lastIndexOf(".");
				String fileExtendsion=fileName.substring(index+1);
				String refileName="car"+year+month+date+random+"."+fileExtendsion;
				String fileDBName="/"+year+"-"+month+"-"+date+"/"+refileName;
				upFile.renameTo(new File(homedir+"/"+refileName));
				*/
				
				
				c.setC_img(fileName);
			}else {//수정 첨부파일이 없는 경우
				String fileDBName="";
				if(db_File.getC_img() != null) {//기존 첨부파일이 있는 경우
					c.setC_img(db_File.getC_img());
				}else {
					c.setC_img(fileDBName);
				}
			}//if else
			c.setC_num(c_num);
			c.setC_brand(c_brand); c.setC_color(c_color);
			c.setC_name(c_name); c.setC_oil(c_oil);
			c.setC_price(c_price); c.setC_type(c_type2);
			c.setC_type2(c_type2); c.setC_year(c_year);
			
			this.AcService.adminUpdateCar(c);
			
			ModelAndView em=new ModelAndView("redirect:/admin_car_list?page="+page);
			return em;
		}
		return null;
	}//admin_car_edit_ok()
	
	@GetMapping("/admin_car_del")
	public ModelAndView admin_car_del(int no,int page,HttpServletResponse response,
			HttpSession session,HttpServletRequest request) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		
		if(isAdminLogin(session, response)) {
			
			this.AcService.AcDel(no);
			
			ModelAndView dm=new ModelAndView();
			dm.setViewName("redirect:/admin_car_list");
			dm.addObject("page",page);
			return dm;
		}
		return null;
	}//admin_car_del()
	
	
	
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
