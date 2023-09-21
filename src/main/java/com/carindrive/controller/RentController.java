package com.carindrive.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carindrive.service.MemberService;
import com.carindrive.service.RentService;
import com.carindrive.vo.CarVO;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.RentalVO;

@Controller //스프링 MVC 게시판 컨트롤러 클래스
@RequestMapping("/rent/*")
public class RentController {

	@Autowired
	private RentService rentService;

	@Autowired
	private MemberService memberService;

	// 렌트 페이지 전체 차량 보여주기
	@RequestMapping("/rent")
	public ModelAndView rent(HttpServletRequest request,CarVO cv) {
		
		List<CarVO> clist = this.rentService.getCarList(cv); // 차량 리스트 불러오기
		
		ModelAndView cm = new ModelAndView("./rent/rent");
		
		cm.addObject("clist", clist);
		
		return cm;
	}

	//전체차량에서 선택한 차량만 보여주기
	@RequestMapping(value="/rent", method=RequestMethod.POST)
	public ModelAndView rent(@RequestParam String cr_cname, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
		// rentalVO 객체는 form에서 전송된 데이터를 자동으로 바인딩 받게 됩니다.
		System.out.println("rent메서드 동작");
		ModelAndView model = new ModelAndView();
		//로그인정보 가져오기
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		
		//선택된 차량이름으로 해당차량 정보 검색
		CarVO car = this.rentService.getCarInfo(cr_cname);
		
		//모델에 차량 정보 추가 (jsp에서 출력)
		model.addObject("car", car);
		
		return new ModelAndView("/rent/rentInfo");
	}
	
		@GetMapping("/rentInfo")
		public ModelAndView rentInfo(@RequestParam String cr_cname, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
			
			System.out.println("rentInfo(GET)메서드 동작");
			
			ModelAndView model = new ModelAndView();
			//if문을 사용하기위한 로그인 정보
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			
			//선택된 차량의 정보를 출력하기 위함
			CarVO car = this.rentService.getCarInfo(cr_cname);

			// 현재 날짜 설정 (렌트 신청일)
			model.addObject("car",car);
			model.addObject("cr_cname",cr_cname);
			model.setViewName("rent/rentInfo");
			return model;	// 리다이렉트할 URL로 수정 (매핑주소(메서드)를 찾아감)
		}
		
		@PostMapping("/rentInfo")
		public ModelAndView rentInfo(RentalVO r, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
			ModelAndView model = new ModelAndView();
			
			System.out.println("rentInfo(POST)메서드 동작");
			//로그인 정보 가져오기
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			System.out.println("멤버정보: "+memberInfo);
			r.setCr_mid(memberInfo.getM_id());
			
			CarVO car = this.rentService.getCarInfo(r.getCr_cname()); //정상작동
			System.out.println("차량정보: "+ car);
			model.addObject("car",car);
			
			System.out.println("렌트정보: " +r);
			
			/*렌트빌리는 날짜, 반납하는 날짜 기능*/
			String cr_sdate = r.getCr_sdate();		//VO에 들어있는 날짜,시간 값들을 가져옴
			String cr_edate = r.getCr_edate();

			cr_sdate = cr_sdate.replace("T", " ");	//중간에 껴있는 T문자를 공백처리함
			cr_edate = cr_edate.replace("T", " ");

			r.setCr_sdate(cr_sdate);	//공백처리한 날짜,시간 값을 다시 저장
			r.setCr_edate(cr_edate);

			// 렌트 신청일 구하기
			// 현재 날짜 가져오기
			Date d = new Date();
			SimpleDateFormat s = new SimpleDateFormat("yyyy년 MM월 dd일 aa hh시 mm분");
			String cr_rdate = s.format(d);

			// 현재 날짜 설정 (렌트 신청일)
			r.setCr_rdate(cr_rdate);	//클라이언트에게 입력받는것이 아닌 코드가 동작하는 순간 시간 저장
			System.out.println("데이터베이스에 저장");
			this.rentService.insertRental(r);			//모든 값들이 준비되었으면 데이터베이스에 저장

			rttr.addFlashAttribute("msg", "success"); //성공시 메세지띄우기
			//model.setViewName("rent/rentOK");
			return new ModelAndView("redirect:/rent/rentOK");
		}

		//차 예약 완료전 결제창
		@RequestMapping(value = "/rentOK")
		public String rentOK(Model model, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
			System.out.println("rentOK 메서드 시작");

			try {
				//로그인된 아이디를 기준으로 해당 고객의 정보를 불러옴
				MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

				//해당 고객의 아이디를 기준으로 렌트정보를 가져옴
				RentalVO rental = this.rentService.getRentOne(memberInfo.getM_id());
				
				System.out.println("멤버아이디: "+ memberInfo.getM_id());
				
				//차 이름으로 해당 차량 정보 가져옴 (렌트 내역에 필요)
				CarVO car = this.rentService.getCarInfo(rental.getCr_cname()); //정상작동

				//고객 정보 가져오기 (렌트 내역에 필요)
				MemberVO mem = this.memberService.getMemberInfo(memberInfo.getM_id());

				// 렌트 기간 계산
				//DateTimeFormatter를 이용하여 날짜와 시간 문자열을 파싱하여 LocalDateTime 객체로 변환
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
				LocalDateTime stard_date = LocalDateTime.parse(rental.getCr_sdate(), formatter);
				LocalDateTime end_date = LocalDateTime.parse(rental.getCr_edate(), formatter);

				/*Duration.between(rentalDateTime, returnDateTime)를 통해 렌트 기간의 시간 간격을 계산*/
				Duration duration = Duration.between(stard_date, end_date);
				long minutes = duration.toMinutes();	//몇분동안 렌트했는지 파악

				// 렌트 가격 계산
				double one_price = minutes * car.getC_price();

				//DecimalFormat 는 숫자의 출력형태를 변환한다.
				DecimalFormat decimalFormat = new DecimalFormat("#"); //소수점 제외
				String total_price = decimalFormat.format(one_price);

				//렌트 비용을 c_rental 테이블에 추가
				this.rentService.insertCost(rental.getCr_num(),one_price);

				model.addAttribute("rental", rental);						//렌탈정보
				model.addAttribute("car",car);								//차정보
				model.addAttribute("mem",mem);								//회원정보
				model.addAttribute("total_price", total_price);				//렌트비용
				rttr.addFlashAttribute("msg", "success");					//예약성공시 출력

				return "/rent/rentOK";
			}catch (Exception e){
				e.printStackTrace();
				return "/";	//에러페이지로 이동
			}
		}

	}
