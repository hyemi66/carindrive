package com.carindrive.controller;
//package com.car.controller;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.car.service.MemberService;
//import com.car.vo.MemberVO;
//
//@Controller //스프링 MVC 게시판 컨트롤러 클래스
//@RequestMapping("/member/*")
//public class MemberController {
//	
//	@Autowired
//	private MemberService memberService;
//	
//	   @RequestMapping(value="/member", method=RequestMethod.GET)
//	   public String service() {
//	      return "member/member";
//	   }
//	   
//	   @RequestMapping(value = "/m_login",method=RequestMethod.GET)
//	   public String memberLogin() {
//		   return "member/m_login";
//	   }
//	   
//	 //로그인 기능 구현
//	 		@RequestMapping(value="/m_login",method=RequestMethod.POST)
//	 		public String  memberLogin(@RequestParam("m_id") String m_id, @RequestParam("m_pwd") String m_pwd,
//	 				Model model, HttpSession session) {
//	 			// 데이터베이스에서 해당 사용자 정보 조회
//	 	        MemberVO member = memberService.getMemberInfo(m_id);
//
//	 	        if (member != null && member.getM_pwd().equals(m_pwd)) {	//아이디 정보의 비밀번호를 비교
//	 	            // 로그인 성공
//	 	        	model.addAttribute("loginmsg", "success");
//	 	        	session.setAttribute("loggedInUser", member);	//사용자의 정보를 세션에 저장
//	 	        	System.out.println(member.getM_name());
//	 	            return "redirect:/rent/rent"; // 로그인 후 차량예약 페이지 이동
//	 	        } else {
//	 	            // 로그인 실패
//	 	            model.addAttribute("errorMessage", "error");
//	 	            return "/member/m_login"; // 로그인 페이지로 돌아감
//	 	        }
//	 		}
//	 		
//	 		
//	   
//	   @RequestMapping(value = "/m_join",method=RequestMethod.GET)
//	   public String insurance() {
//		   return "member/m_join";
//	   }
//	   
//	   //회원가입
//	   @RequestMapping(value="/m_join", method=RequestMethod.POST)
//	   public ModelAndView memberSign(MemberVO m, RedirectAttributes rttr) {
//		   this.memberService.insertMember(m);
//		   return new ModelAndView("redirect:/"); 		// 리다이렉트할 URL로 수정 (매핑주소(메서드)를 찾아감)
//		}
//	   
//	   @RequestMapping(value = "/serch_id",method=RequestMethod.GET)
//	   public String serch_id() {
//		   return "member/serch_id";
//	   }
//	   
//	   @RequestMapping(value = "/serch_pwd",method=RequestMethod.GET)
//	   public String serch_pwd() {
//		   return "member/serch_pwd";
//	   }
//	   
//	   @RequestMapping(value = "/pass_change",method=RequestMethod.GET)
//	   public String pass_change() {
//		   return "member/pass_change";
//	   }
//	 
//}
import java.io.PrintWriter;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.apache.bcel.generic.MULTIANEWARRAY;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import com.carindrive.service.MemberService;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.MemberVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import pwdchange.CarPwdCh;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/member", method=RequestMethod.GET)
	   public String service() {
	      return "member/member";
	   }
	
	
	   //회원가입  
	   @GetMapping("m_join")
	   public String m_join( HttpServletResponse response) {
		   response.setContentType("text/html;charset=UTF-8");
		   
		   return "member/m_join";
	   }
	   
	   @PostMapping("/m_join_ok")
	   public ModelAndView m_join_ok() {
		   
		   return null;
	   }
	   
	   
	   //아이디 중복 검색
	    @PostMapping("/member_idcheck")
	    public ModelAndView member_idcheck(String id,HttpServletResponse response)
	    throws Exception{
	    	response.setContentType("text/html;charset=UTF-8");
	    	
	    	PrintWriter out=response.getWriter();
	    	
	    	MemberVO db_id = this.memberService.idCheck(id);
	    	
	    	int re=-1;//중복 아이디가 없을 때 반환값
	    	if(db_id != null) {//중복아이디가 있는 경우
	    		re=1;
	    	}
	    	out.println(re);//값 반환기능
	    	
	    	return null;
	    }//member_idcheck()
	  
	   
	    //회원 가입 저장
	    @RequestMapping("member_join_ok")
	    public ModelAndView member_join_ok(MemberVO cm) {
	    	
	    	cm.setM_pwd(CarPwdCh.getPassWordToXEMD5String(cm.getM_pwd()));//비번 암호화
	    	this.memberService.insertMember(cm);//회원 저장
	    	
	    	return new ModelAndView("redirect:/member/m_login");
	    }
	    
	    //회원 로그인
	    @GetMapping("m_login")
		   public String memberLogin() {
			   return "member/m_login";
		   }
	    
	
	    
	    // 로그인 인증 처리
	    //가입회원인 경우는 mem_state=1 일때 로그인 인증 처리(탈퇴 회원은 mem_state=2라서 로그인 인증 불가)
	    @PostMapping("/m_login_ok")
	    public String m_login_ok(String m_id,String m_pwd,
	    		HttpServletResponse response,HttpSession session) throws Exception{
	        response.setContentType("text/html;charset=UTF-8");
	        PrintWriter out=response.getWriter();
	        
	        MemberVO cm=null;
	        
	        if(m_id.equals("admin01")) {
	         
	        	cm=this.memberService.adminCk(m_id);
	        
	        }else {
	        	 cm=this.memberService.loginCheck(m_id);
	 	        //아이디와 가입회원 1(일반회원) & 9(관리자)인 경우만 로그인 인증 처리
	 	        //login_id =m_id //login_pwd =m_pwd
	 	       	
	        }
	        if(cm == null) {
 	        	out.println("<script>");
 	        	out.println("alert('가입 안된 회원입니다.!');");
 	        	out.println("history.back();");
 	        	out.println("</script>");
 	        }else {
 	        	if(!cm.getM_pwd().equals(CarPwdCh.getPassWordToXEMD5String(m_pwd))) {
 	        		out.println("<script>");
 	        		out.println("alert('비번이 다릅니다!');");
 	        		out.println("history.go(-1);");
 	        		out.println("</script>");        		
 	        	}else {
 	        		
 	        		session.setAttribute("memberInfo",cm);//세션 id키이름에 아이디를 저장
 	        		session.setAttribute("id",m_id);//세션 id키이름에 아이디를 저장
 	        		return "main/index";
 	        		
 	        	}
 	        }
	        return null;
        	
	      
	    }//member_login_ok()
	    
	    //로그아웃
	    @RequestMapping("/m_logout")
	    public String m_logout(HttpServletResponse response,
	    		HttpSession session) throws Exception{
	    	response.setContentType("text/html;charset=UTF-8");
	    	PrintWriter out=response.getWriter();
	    	
	    	session.invalidate();//세션 만료 => 로그아웃
	    	
	    	out.println("<script>");
	    	out.println("alert('로그아웃 되었습니다!');");
	    	out.println("</script>");
	    	
	    	return "main/index";
	    }//m_logout()
	    
	   
	    //로그인 상태 확인
	    public static boolean isLogin(HttpSession session,HttpServletResponse response)
	    throws Exception{
	    	PrintWriter out=response.getWriter();
	    	String id=(String)session.getAttribute("id");
	    	
	    	if(id == null) {
	    		out.println("<script>");
	    		out.println("alert('다시 로그인 하세요!');");
	    		out.println("location='member_login';");
	    		out.println("</script>");
	    		
	    		return false;
	    	}
	    	return true;
	    }//isLogin()
	    
	    //아이디 찾기 뷰페이지
	    @RequestMapping("/serch_id")
	    public String serch_id() {
	    	
	    	return "member/serch_id";
	    }
	    
	    //비밀번호 찾기 뷰페이지
	    @RequestMapping("/serch_pwd")
	    public String serch_pwd() {
	    	
	    	return "member/serch_pwd";
	    }
	    
	/* 마이페이지 관련 부분 */
	@RequestMapping("/mypage")
	public ModelAndView mypage(String m_id, HttpSession session) {
		m_id = (String)session.getAttribute("id");
	
		ModelAndView mm = new ModelAndView();
	
		List<MemberVO> mlist = this.memberService.myPage(m_id);
	
		mm.addObject("mlist", mlist);
		mm.setViewName("/member/mypage");
	
		return mm;
	}
	       
	// 회원정보수정(비밀번호 확인)
	@RequestMapping("/mypage_ok")
	public ModelAndView mypage_ok(String m_id, HttpSession session) {
		ModelAndView mom = new ModelAndView();
	
		m_id = (String)session.getAttribute("id");
		List<MemberVO> mlist = this.memberService.myPage(m_id);
	          
		mom.addObject("mlist", mlist);
		mom.setViewName("/member/mypage_ok");
	          
		return mom;
	}
	       
	// 회원정보수정(비번 입력시)
	@RequestMapping("/mypage_edit")
	public ModelAndView mypage_edit(String m_id, String m_pwd, MemberVO m,
		HttpSession session, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		m_id = (String)session.getAttribute("id");
		
		List<MemberVO> mlist = this.memberService.myPage(m_id);
		m = this.memberService.findPwd(m_id);
		
		if(!m.getM_pwd().equals(CarPwdCh.getPassWordToXEMD5String(m_pwd))) {
			out.println("<script>");
			out.println("alert('비번이 다릅니다!');");
			out.println("location='mypage_ok';");
			out.println("</script>"); 
		} else {
			ModelAndView fm = new ModelAndView();
			fm.addObject("mlist", mlist);
			fm.setViewName("/member/mypage_edit");
		
			return fm;
		}
		return null;
	}

	// 회원정보수정완료
	@PostMapping("/mypage_edit_ok")
	public ModelAndView mypage_edit_ok(String m_id, MemberVO m, 
			HttpServletRequest request, HttpSession session) throws Exception {
		m_id = (String)session.getAttribute("id");
		
		m.setM_id(m_id);
		m.setM_tel(request.getParameter("m_tel"));
		m.setM_phone(request.getParameter("m_phone"));
		m.setM_email(request.getParameter("m_email"));
		
		this.memberService.updateMember(m);
		
		ModelAndView mm = new ModelAndView();
		mm.setViewName("redirect:/member/mypage");
		
		return mm;
	}
}
	    


