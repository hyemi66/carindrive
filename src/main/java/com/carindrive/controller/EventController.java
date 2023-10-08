package com.carindrive.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller //스프링 MVC 게시판 컨트롤러 클래스
@RequestMapping("/event/*")
public class EventController {
	
	@RequestMapping("/event")
	public ModelAndView event() {
		return new ModelAndView("/event/event");
	}
	
}
