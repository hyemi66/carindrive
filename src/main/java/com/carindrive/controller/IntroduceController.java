package com.carindrive.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/introduce/*")
public class IntroduceController {
	
	@RequestMapping(value="/introduce", method=RequestMethod.GET)
	public String introduce() {
		return "introduce/introduce";
	}
	
	@RequestMapping("/intro")
	public ModelAndView intro() {
		return new ModelAndView("introduce/intro");
	}
	
	@RequestMapping("/history")
	public ModelAndView history() {
		return new ModelAndView("introduce/history");
	}
	
	@RequestMapping("/come")
	public ModelAndView come() {
		return new ModelAndView("introduce/come");
	}
}
