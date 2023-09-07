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
public class MemberController2 {
	
	@Autowired
	private MemberService memberService;
	
		//로그인 페이지 열기
		@RequestMapping(value="/memberLogin",method=RequestMethod.GET)
		public void memberLogin() {
		}
		
		@RequestMapping(value="/memberLogin",method=RequestMethod.POST)
		public String memberLogin(@RequestParam("m_id") String m_id, @RequestParam("m_pwd") String m_pwd, Model model,
		        HttpSession session) {
		    // 데이터베이스에서 해당 사용자 정보 조회
		    MemberVO member = memberService.getMemberInfo(m_id);

		    if (member != null && member.getM_pwd().equals(m_pwd)) {
		        // 로그인 성공
		        model.addAttribute("loginmsg", "success");
		        session.setAttribute("loggedInUser", member);

		        String prevPage = (String) session.getAttribute("prevPage");
		        if (prevPage != null && !prevPage.isEmpty()) {
		            session.removeAttribute("prevPage");  // 더 이상 필요하지 않으므로 세션에서 제거
		            return "redirect:" + prevPage; // 로그인 후 이전 페이지로 리다이렉트
		        } else {
		            return "redirect:/"; // 이전 페이지 정보가 없으면 메인 페이지로 리다이렉트
		        }
		    } else {
		        // 로그인 실패
		        model.addAttribute("errorMessage", "error");
		        return "/member/memberLogin"; // 로그인 페이지로 돌아감
		    }
		}
	
		//회원가입 페이지 열기
		@RequestMapping(value="/memberSign",method=RequestMethod.GET)
		public void memberSign() {
		}
		
		//회원정보 저장
		@RequestMapping(value="/memberSign", method=RequestMethod.POST)
		public ModelAndView memberSign(MemberVO m, RedirectAttributes rttr) {
			this.memberService.insertMember(m);
			return new ModelAndView("redirect:/"); 		// 리다이렉트할 URL로 수정 (매핑주소(메서드)를 찾아감)
		}

}
