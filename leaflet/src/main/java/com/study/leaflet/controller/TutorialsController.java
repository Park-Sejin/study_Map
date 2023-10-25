package com.study.leaflet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class TutorialsController{
	
	/** quick Start Guide 페이지 */
	@GetMapping("/tutorials/quickStartGuide.do")
	public String quickStartGuide(){
		
		return "/tutorials/quickStartGuide";
	}
	
}
