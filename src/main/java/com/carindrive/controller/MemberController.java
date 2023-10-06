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
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.management.loading.PrivateClassLoader;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.carindrive.service.MemberService;
import com.carindrive.service.RegisterMail;
import com.carindrive.vo.KakaoProfile;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OAuthToken;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;
import com.carindrive.vo.SocialVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
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
	
	
	   //join
	   @GetMapping("m_join")
	   public String m_join( HttpServletResponse response) {
		   response.setContentType("text/html;charset=UTF-8");
		   
		   return "member/m_join";
	   }
	   
	   //join_ok
	    @RequestMapping("member_join_ok")
	    public ModelAndView member_join_ok(MemberVO cm, @RequestParam("m_email") String m_email, 
	    		HttpServletResponse response)throws Exception {
	    	
	    	response.setContentType("text/html;charset=UTF-8");
	    	PrintWriter out = response.getWriter();
	    	
	    	//이메일 중복 체크후 아이디 값 가져오기
	    	MemberVO pm = this.memberService.serchUserEmail(m_email);
	    	
	    	if(pm != null) {
	    		out.println("<script>");
 	        	out.println("alert('이미 존재하는 이메일 입니다!');");
 	        	out.println("location='m_join';");
 	        	out.println("</script>");

	    		
	    	}else {
	    		cm.setM_pwd(CarPwdCh.getPassWordToXEMD5String(cm.getM_pwd()));//비번 암호화
	    		this.memberService.insertMember(cm);//회원 저장
	    		out.println("<script>");
 	        	out.println("alert('회원가입이 완료되었습니다!');");
 	        	out.println("location='m_login';");
 	        	out.println("</script>");
	    	}
	    	return null;
	    }
	   
	   
	   //id_serch
	    @PostMapping("/member_idcheck")
	    public ModelAndView member_idcheck(String id,HttpServletResponse response)
	    throws Exception{
	    	response.setContentType("text/html;charset=UTF-8");
	    	PrintWriter out=response.getWriter();
	    	
	    	MemberVO db_id = this.memberService.idCheck(id);
	    	
	    	int re=-1;
	    	if(db_id != null) {
	    		re=1;
	    	}
	    	out.println(re);
	    	
	    	return null;
	    }//member_idcheck()
	  
	      
	    //login
	    @GetMapping("m_login")
		   public String memberLogin() {
			   return "member/m_login";
		   }
	   
	    //login_authentication
	    //가입회원인 경우는 mem_state=1 일때 로그인 인증 처리(탈퇴 회원은 mem_state=2라서 로그인 인증 불가)
	    //시큐리티 적용 전 -> 관리자를 m_ state = 9로 저장해서 간단하게 분리 정도만 구현
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
	 	       	
	        }
	        if(cm == null) {
 	        	out.println("<script>");
 	        	out.println("alert('비회원입니다!');");
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
	    
	    //logout
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
	    
	   
	    //is_login
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
	    

	    //id_serch
	    @GetMapping("/serch_id")
	    public String serch_id() {   
	    	return "member/serch_id";
	    }//serch_id()
	   
	    @GetMapping("/serch_id_email_ok")
	    public String serch_id_email_ok() {
	    	return "member/serch_id_email_ok";
	    }//serch_id_email_ok()
	    
	    
	   //id_email_ok
	   @Autowired
	   private RegisterMail registerMail;
	   
	    @PostMapping("serch_id_email_ck")
	    @ResponseBody
	    public ModelAndView mailConfirm_id(@RequestParam("m_email") String m_email,
	         String ck_email, HttpSession session, HttpServletResponse response) throws Exception {
	    	response.setContentType("text/html;charset=UTF-8");
	    	PrintWriter out = response.getWriter();
	    	//이메일 존재하는 지 인증
	    	MemberVO cm = this.memberService.serchUserEmail(m_email);
	    	
	    	if(cm ==null) { 
	    		out.println("<script>");
	    		out.println("alert('사용자 정보가 존재하지 않습니다!');");
	    		out.println("location='serch_id';");
	    		out.println("</script>");
	    		
	    	}else {
	    		//이메일 인증
		    	String code = registerMail.sendSimpleMessage(m_email);
			    System.out.println("인증코드 : " + code);
			    
			    session.setAttribute("code", code);		    
		    	session.setAttribute("userid", cm.getM_id());
			    
			    return new ModelAndView("redirect:/member/serch_id_email_ok");
	    	}

			   return null;
		}//mailConfirm_id()
	 
	    
	    //pwd_serch
	    @GetMapping("/serch_pwd")
	    public String serch_pwd() {
	    	return "member/serch_pwd";
	    }//serch_pwd()
	    
	    @GetMapping("/serch_pwd_ok")
	    public String serch_pwd_ok() {    	
	    	return "member/serch_pwd_ok";
	    }//serch_pwd()
	    
	    //pwd_email_ok
	    @PostMapping("serch_pwd_email_ck")
	    @ResponseBody
	    public ModelAndView mailConfirm_pwd(@RequestParam("m_email") String m_email, 
	         String m_id, HttpSession session, HttpServletResponse response) throws Exception {
	    	response.setContentType("text/html;charset=UTF-8");
	    	PrintWriter out = response.getWriter();
	    	//이메일이 존재하는 지 인증
	    	MemberVO cm = this.memberService.serchUserEmail(m_email);
	    	
	    	//존재하면 이메일 인증 실행
	    	if(cm ==null) { //이메일 존재하지 않는다면 
	    		out.println("<script>");
	    		out.println("alert('사용자 정보가 존재하지 않습니다!');");
	    		out.println("location='serch_pwd';");
	    		out.println("</script>");
	    		
	    	}else {
	    		//이메일 인증
		    	String code = registerMail.sendSimpleMessage(m_email);
			    System.out.println("인증코드 : " + code);
			    
			    session.setAttribute("code", code);		    
		    	session.setAttribute("userid", cm.getM_id());
		    	session.setAttribute("m_email", cm.getM_email());
			    
			    return new ModelAndView("redirect:/member/serch_pwd_ok");
	    	}

			   return null;
		}//mailConfirm_pwd()
	    
	   
	   //pwd_change
	   @PostMapping("/pwd_change_ok")
	   public ModelAndView pwd_change_ok( HttpServletResponse response, 
			   @RequestParam("ch_pwd") String ch_pwd,
			   @RequestParam("id") String id,
			   MemberVO m)throws Exception {
		   response.setContentType("text/html;charset=UTF-8");
		   PrintWriter out = response.getWriter();
		   
		   //해당 회원 아이디가 있는지 확인
		   MemberVO db_id = this.memberService.idCheck(id);
		   if(db_id == null) {
			   out.println("<script>");
			   out.println("alert('없는 아이디 입니다.');");
			   out.println("history.back()");
			   out.println("</script>");
			   
		   }else { 
			   
			   //받아온 비밀번호 암호화 
			   m.setM_id(id);
			   m.setM_pwd(CarPwdCh.getPassWordToXEMD5String(ch_pwd));
			   //아이디에 해당하는 비밀번호 업데이트
			   this.memberService.updatePwd(m);
			   out.println("<script>");
			   out.println("alert('비밀번호가 변경되었습니다.');");
			   out.println("location.href='m_login'");
			   out.println("</script>");
			    
		   }
    	   return null;
		   
	   }
	    
	    //kakao login
	    @GetMapping("/kakaotest")
	    public @ResponseBody ModelAndView kakaotest(String code , HttpSession session, HttpServletResponse response) 
	    throws Exception{
	    	//Data를 리턴해주는 함수
	    	response.setContentType("text/html; charset=UTF-8");
	    	PrintWriter out = response.getWriter();
	    	
	    	//POST 방식으로 key=value 데이터 요청(카카오 쪽으로)
	    	RestTemplate rt = new RestTemplate();
	    	
	    	//HttpHeader 오브젝트 생성
	    	HttpHeaders headers = new HttpHeaders();
	    	headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	    	//key-value 형태임을 알림
	    	
	    	//HttpBody 오브젝트 생성
	    	MultiValueMap<String ,String> params = new LinkedMultiValueMap<>();
	    	params.add("grant_type", "authorization_code");
	    	params.add("client_id", "4094fcc6d950836e2f6c9f216ab46fef");
	    	params.add("redirect_uri", "http://localhost:7991/member/kakaotest");
	    	params.add("code", code);
	    	
	    	//HttpHeader와 httpbody를 하나의 오브젝트에 담기
	    	HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = 
	    			new HttpEntity<>(params,headers);
	    	
	    	//Http 요청 - post 방식으로 - 그리고 response변수의 응답을 받음
	    	ResponseEntity<String> response01 = rt.exchange(
	    			
	    			"https://kauth.kakao.com/oauth/token",
	    			HttpMethod.POST,
	    			kakaoTokenRequest,
	    			String.class
	    			//응답받을 타입
	    			);
	    	
	    	
	    	ObjectMapper obmapper = new ObjectMapper();
	    	OAuthToken oauthToken =null;
	    	
	    	try {
				oauthToken = obmapper.readValue(response01.getBody(), OAuthToken.class);
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
	    	e.printStackTrace();
			}
	    
	    	//POST 방식으로 key=value 데이터 요청(카카오 쪽으로)
	    	RestTemplate rt2 = new RestTemplate();
	    	
	    	//HttpHeader 오브젝트 생성
	    	HttpHeaders headers2 = new HttpHeaders();
	    	headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
	    	headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	    	//key-value 형태임을 알림
	    	 
	    	//HttpHeader와 httpbody를 하나의 오브젝트에 담기
	    	HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = 
	    			new HttpEntity<>(headers2);
	    	
	    	//Http 요청 - post 방식으로 - 그리고 response변수의 응답을 받음
	    	ResponseEntity<String> response2 = rt2.exchange(
	    			
	    			"https://kapi.kakao.com/v2/user/me",
	    			HttpMethod.POST,
	    			kakaoProfileRequest2,
	    			String.class
	    			//응답받을 타입
	    			);
	    	
	       	
	    	//카카오 프로필 정보 받아오기
	    	ObjectMapper obmapper2 = new ObjectMapper();
	    	KakaoProfile kakaoProfile =null;
	    	
	    	try {
	    		kakaoProfile = obmapper2.readValue(response2.getBody(), KakaoProfile.class);
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
	    	e.printStackTrace();
			}
	    	
	    	System.out.println("카카오 아이디:" +kakaoProfile.getId());
	    	System.out.println("카카오 이메일:" +kakaoProfile.getKakao_account().getEmail());
	    	System.out.println("카카오 닉네임:" +kakaoProfile.getKakao_account().getProfile().getNickname());
	   
	    	//임시 패스워드
	    	UUID garbagePassword = UUID.randomUUID();	    	
	    	
	    	//SocialVO에 카카오 유저 정보 저장
	    	Long userId= kakaoProfile.getId(); 
	    	//실제 카카오 아이디 정보라 DB에 넣어도 될지, DB에는 임시로 시퀀스 번호 저장 
	    	String userPwd= garbagePassword.toString();
	    	String userEmail=kakaoProfile.getKakao_account().getEmail();	
	    	String userName=kakaoProfile.getKakao_account().getEmail()+"_"+kakaoProfile.getId();
	    	String userNickName=kakaoProfile.getKakao_account().getProfile().getNickname();
	    	
	    	//이메일 &닉네임 정보 없는 회원일 때
	    	if(kakaoProfile.getKakao_account().getEmail() == null) {
	    		userEmail = "nullEmailUser";
	    		userNickName="카카오 로그인 회원";
	    	}
	    	
	    	SocialVO kakaoUser = new SocialVO();
	    	
	    	kakaoUser.setPassword(userPwd);
	    	kakaoUser.setEmail(userEmail);
	    	kakaoUser.setUsername(userName);
	    	  	
	    	//회원 비회원 유무 파악
	    	SocialVO originUser = this.memberService.serchkakao(userEmail);
	 	    		    	
	    	if(originUser == null) { // 미가입 회원
	    		//회원가입 -> social table 
		    	this.memberService.insertKakao(kakaoUser);

	    		session.setAttribute("id",userNickName);//세션 id키이름에 유저 이메일을 저장
	    		return  new ModelAndView("redirect:/rent/rent"); 
	        }else {// 가입 회원
	        	session.setAttribute("id",userNickName);
	        	return  new ModelAndView("redirect:/rent/rent");
	    	
	    	
	        }//else()
	  	
	    }//kakao end
	    
	    /* 마이페이지 관련 부분(회원정보확인페이지) */
		@RequestMapping("/mypage")
		public ModelAndView mypage(HttpSession session) {
			String m_id = (String)session.getAttribute("id");
		
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
		
		// 회원정보삭제(비번 입력창)
		@GetMapping("/mypage_del")
		public ModelAndView mypage_del(String m_id, String m_pwd, MemberVO m,
				HttpSession session, HttpServletResponse response) throws Exception {
			ModelAndView mom = new ModelAndView();
			
			m_id = (String)session.getAttribute("id");
			List<MemberVO> mlist = this.memberService.myPage(m_id);
		          
			mom.addObject("mlist", mlist);
			mom.setViewName("/member/mypage_del");
		          
			return mom;
		}
		
		// 회원삭제정보(비번 입력시)
		@PostMapping("/mypage_del_ok")
		public ModelAndView mypage_del_ok(String m_id, String m_pwd, MemberVO m,
				HttpSession session, HttpServletResponse response) throws Exception {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			m_id = (String)session.getAttribute("id");
			
			List<MemberVO> mlist = this.memberService.myPage(m_id);
			m = this.memberService.findPwd(m_id);
			
			if(!m.getM_pwd().equals(CarPwdCh.getPassWordToXEMD5String(m_pwd))) {
				out.println("<script>");
				out.println("alert('비번이 다릅니다!');");
				out.println("location='mypage_del';");
				out.println("</script>"); 
			} else {
				ModelAndView fm = new ModelAndView();
				this.memberService.delMember(m_id);
				out.println("<script>");
				out.println("alert('회원탈퇴요청되셨습니다.');");
				out.println("location='/';");
				out.println("</script>");
				
				session.invalidate();
			
			}
			return null;
		}
	    
}
	    


