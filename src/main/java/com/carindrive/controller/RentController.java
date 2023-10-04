package com.carindrive.controller;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

	@RequestMapping("/rent") //처음에는 모든차량을 불러옴
	public ModelAndView rent(HttpServletRequest request,CarVO cv, HttpSession session, RedirectAttributes rttr) {
		System.out.println("rent메서드 GET 동작");

		ModelAndView model = new ModelAndView();

		// 로그인 정보 가져오기
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		if(memberInfo != null) {

			//해당 아이디의 결제 중단 내역들을 전부 제거	
			this.rentService.rentalDel2(memberInfo.getM_id());
			System.out.println("결제중단 내역들 삭제후 차량 출력");

			List<CarVO> clist = this.rentService.getCarList(cv); // 차량 리스트 불러오기

			model.setViewName("/rent/rent");
			model.addObject("clist", clist);

			return model;
		}else {
			rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
			model.setViewName("redirect:/member/m_login");
			return model;
		}
	};

	//날짜를 선택하면 그거에 맞춰서 예약할수있는 차량만 등장
	@RequestMapping(value="/rent", method=RequestMethod.POST)
	public ModelAndView rent(@RequestParam String cr_sdate, 
			@RequestParam String cr_edate, 
			HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
		
		System.out.println("rent메서드 POST 동작");
		ModelAndView model = new ModelAndView("/rent/rent");

		// 모든 차량 목록을 가져옴, 조건없이 다 가져옴
		List<CarVO> allCars = this.rentService.getCarList(null);

		List<CarVO> clist = new ArrayList<>(); //나중에 출력되는 값이 여러개가 아니므로 리스트 생성

		//모든 차량을 한대씩 검사 
		for(CarVO car : allCars) {

			//해당차량의 렌탈 대여 일자와 , 차량 정비 완료 시간을 가져오는 쿼리문
			List<RentalVO> allRentalDate = this.rentService.getDateCar(car.getC_name());

			//해당 차량의 예약 내역을 확인하고 예약된 차량이 아니라면 다음 차량 예약내역 검사 
			if(allRentalDate == null) {
				continue;
			}

			boolean rentOk = true;
			//rentOk가 true라면 해당 차량은 clist에 추가됨
			//clist는 jsp에서 출력됨 (예약가능한 차량은 출력)

			//String으로 날짜를 비교하기 위해 날짜형식을 전부 다 동일하게 맞춤
			cr_sdate = cr_sdate.replace("T", " "); // 중간에 껴있는 T문자를 공백처리함
			cr_edate = cr_edate.replace("T", " ");
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

			//
			for(RentalVO rentalDate : allRentalDate) {
				//예약이 되어있는 날짜
				LocalDateTime usedSdate = LocalDateTime.parse(rentalDate.getCr_sdate(), formatter);
				LocalDateTime usedEdate = LocalDateTime.parse(rentalDate.getCr_waitTime(), formatter);

				//사용자가 선택한 날짜
				LocalDateTime selectSdate = LocalDateTime.parse(cr_sdate, formatter);
				LocalDateTime selectEdate = LocalDateTime.parse(cr_edate, formatter);

				//날짜 충돌 확인
				if (																			//하나라도 만족하면 false
						(selectSdate.isAfter(usedSdate) && selectSdate.isBefore(usedEdate)) ||  // 사용자가 선택한 시작 날짜가 예약된 기간 내에 있는 경우. 
						(selectEdate.isAfter(usedSdate) && selectEdate.isBefore(usedEdate)) ||  // 사용자가 선택한 종료 날짜가 예약된 기간 내에 있는 경우.
						(selectSdate.isBefore(usedSdate) && selectEdate.isAfter(usedEdate))  	// 사용자가 선택한 기간이 예약된 기간을 포함하는 경우.
						) 
				{
					rentOk = false; //조건에 만족되지 못한 값들은 false로 걸러짐 그리고 다시 반복문 진행
					break;
				}
			}
			//예약가능한 날짜의 차량들은 리스트에 추가 후 jsp에 출력
			if(rentOk) {
				clist.add(car);
			}
		}
		model.addObject("cr_sdate", cr_sdate);
		model.addObject("cr_edate", cr_edate);
		model.addObject("clist", clist);

		return model;
	}

	@GetMapping("/rentInfo")
	public ModelAndView rentInfo(@RequestParam String cr_cname, 
			@RequestParam String cr_sdate,
			@RequestParam String cr_edate,
			HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {

		System.out.println("rentInfo(GET)메서드 동작");
		ModelAndView model = new ModelAndView();
		try {
			
			//if문을 사용하기위한 로그인 정보
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

			//선택된 차량의 정보를 출력하기 위함
			CarVO car = this.rentService.getCarInfo(cr_cname);

			model.addObject("car",car);
			model.addObject("cr_cname",cr_cname);
			model.addObject("cr_sdate", cr_sdate);
			model.addObject("cr_edate", cr_edate);
			model.setViewName("rent/rentInfo");
			return model;
		}catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/rent/rent");
		}
	}

	@PostMapping("/rentInfo") //선택된 날짜를 처리
	public ModelAndView rentInfo(RentalVO r, HttpSession session, RedirectAttributes rttr, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView model = new ModelAndView();
		System.out.println("rentInfo(POST)메서드 동작");

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		//예약이 가능한지를 비교 하기 위해 렌트빌리는 날짜, 반납하는 날짜를 사용함
		String cr_sdate = r.getCr_sdate();
		String cr_edate = r.getCr_edate();

		cr_sdate = cr_sdate.replace("T", " ");	//중간에 껴있는 T문자를 공백처리함 (전부다 이렇게 되있으므로 비교를위해 똑같이 T 제거)
		cr_edate = cr_edate.replace("T", " ");


		//로그인 정보 가져오기
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		if (memberInfo != null) {//로그인이 되었을 때

			System.out.println("멤버정보: "+memberInfo);
			r.setCr_mid(memberInfo.getM_id());

			//차량의 정보
			CarVO car = this.rentService.getCarInfo(r.getCr_cname()); //정상작동
			System.out.println("차량정보: "+ car);
			model.addObject("car",car);

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
			System.out.println("저장전 값 RentalVO값: "+r);
			this.rentService.insertRental(r);			//모든 값들이 준비되었으면 데이터베이스에 저장

			rttr.addFlashAttribute("msg", "success"); //성공시 메세지띄우기
			return new ModelAndView("redirect:/rent/rentOK");
		}else {
			session.setAttribute("prevPage", request.getHeader("Referer"));	//로그인후 다시 원래 페이지로 돌아가게 해주는 코드 
			rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
			return new ModelAndView("redirect:/member/m_login");
		}

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

			//DateTimeFormatter를 이용하여 날짜와 시간 문자열을 파싱하여 LocalDateTime 객체로 변환
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			System.out.println("렌트시작시간: "+rental.getCr_sdate());
			System.out.println("렌트반납시간: "+rental.getCr_edate());
			LocalDateTime stard_date = LocalDateTime.parse(rental.getCr_sdate(), formatter);
			LocalDateTime end_date = LocalDateTime.parse(rental.getCr_edate(), formatter);

			//Duration.between(rentalDateTime, returnDateTime)를 통해 렌트 기간의 시간 간격을 계산
			Duration duration = Duration.between(stard_date, end_date);
			long minutes = duration.toMinutes();	//몇분동안 렌트했는지 파악

			// 렌트 가격 계산
			double one_price = minutes * car.getC_price();

			//DecimalFormat 는 숫자의 출력형태를 변환한다.
			DecimalFormat decimalFormat = new DecimalFormat("#"); //소수점 제외
			String total_price = decimalFormat.format(one_price);
			System.out.println("렌탈가격: "+total_price);

			//렌트 비용을 c_rental 테이블에 추가
			this.rentService.insertCost(rental.getCr_num(),one_price);

			//5분안에 결제를 진행안하고 취소를 하면 해당 렌트내역은 5분뒤에 사라지고, 5분동안 해당차량 렌트 불가
			this.rentService.rentalDel();

			System.out.println("rentOK의 모든 메서드 동작완료");

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
