package com.study.kakao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class OverlayController{
	
	/** 마커 생성 페이지 */
	@GetMapping("/overlay/createMarker.do")
	public String moveAndChangeLevel(){
		
		return "/kakao/overlay/createMarker";
	}
	
	/** 인포윈도우 생성 페이지 */
	@GetMapping("/overlay/createInfoWindow.do")
	public String createInfoWindow(){
		
		return "/kakao/overlay/createInfoWindow";
	}
	
}
