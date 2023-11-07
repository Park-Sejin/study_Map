package com.study.kakao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class MapController{
	
	/** 지도 이동과 레벨 변경 및 방지 페이지 */
	@GetMapping("/map/moveAndChangeLevel.do")
	public String moveAndChangeLevel(){
		
		return "/kakao/map/moveAndChangeLevel";
	}
	
	/** 컨트롤 생성 및 지도 정보 페이지 */
	@GetMapping("/map/controlAndMapInfo.do")
	public String controlAndMapInfo(){
		
		return "/kakao/map/controlAndMapInfo";
	}
	
	/** 지도타입 변경 페이지 */
	@GetMapping("/map/MapTypeChange.do")
	public String MapTypeChange(){
		
		return "/kakao/map/MapTypeChange";
	}
	
}
