package com.carindrive.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carindrive.service.MemberService;
import com.carindrive.vo.MemberVO;


@Controller //스프링 MVC 게시판 컨트롤러 클래스
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	   @RequestMapping(value="/member", method=RequestMethod.GET)
	   public String service() {
	      return "member/member";
	   }
	   
	   @RequestMapping(value = "/m_login",method=RequestMethod.GET)
	   public String memberLogin() {
		   return "member/m_login";
	   }
	   
	 //로그인 기능 구현
	 		@RequestMapping(value="/m_login",method=RequestMethod.POST)
	 		public String  memberLogin(@RequestParam("m_id") String m_id, @RequestParam("m_pwd") String m_pwd,
	 				Model model, HttpSession session) {
	 			// 데이터베이스에서 해당 사용자 정보 조회
	 	        MemberVO member = memberService.getMemberInfo(m_id);

	 	        if (member != null && member.getM_pwd().equals(m_pwd)) {	//아이디 정보의 비밀번호를 비교
	 	            // 로그인 성공
	 	        	model.addAttribute("loginmsg", "success");
	 	        	session.setAttribute("loggedInUser", member);	//사용자의 정보를 세션에 저장
	 	        	System.out.println(member.getM_name());
	 	            return "redirect:/rent/rent"; // 로그인 후 차량예약 페이지 이동
	 	        } else {
	 	            // 로그인 실패
	 	            model.addAttribute("errorMessage", "error");
	 	            return "/member/m_login"; // 로그인 페이지로 돌아감
	 	        }
	 		}
	 		
	 		
	   
	   @RequestMapping(value = "/m_join",method=RequestMethod.GET)
	   public String insurance() {
		   return "member/m_join";
	   }
	   
	   //회원가입
	   @RequestMapping(value="/m_join", method=RequestMethod.POST)
	   public ModelAndView memberSign(MemberVO m, RedirectAttributes rttr) {
		   this.memberService.insertMember(m);
		   return new ModelAndView("redirect:/"); 		// 리다이렉트할 URL로 수정 (매핑주소(메서드)를 찾아감)
		}
	   
	   @RequestMapping(value = "/serch_id",method=RequestMethod.GET)
	   public String serch_id() {
		   return "member/serch_id";
	   }
	   
	   @RequestMapping(value = "/serch_pwd",method=RequestMethod.GET)
	   public String serch_pwd() {
		   return "member/serch_pwd";
	   }
	   
	   @RequestMapping(value = "/pass_change",method=RequestMethod.GET)
	   public String pass_change() {
		   return "member/pass_change";
	   }
	 
}
