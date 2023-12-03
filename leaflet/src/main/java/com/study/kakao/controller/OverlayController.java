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
	
	/** 여러개 마커 생성 페이지 */
	@GetMapping("/overlay/createMultipleMarker.do")
	public String createMultipleMarker(){
		
		return "/kakao/overlay/createMultipleMarker";
	}
	
	/** 다양한 이미지 마커 표시 페이지 */
	@GetMapping("/overlay/createImageMarker.do")
	public String createImageMarker(){
		
		return "/kakao/overlay/createImageMarker";
	}
	
	/** 원, 선, 사각형, 다각형 표시 페이지 */
	@GetMapping("/overlay/createShape.do")
	public String createShape(){
		
		return "/kakao/overlay/createShape";
	}
	
	/** 마우스로 선 그리기 및 거리 계산 페이지 */
	@GetMapping("/overlay/createLineAndDistance.do")
	public String createShapeAndAreaCalcul(){
		
		return "/kakao/overlay/createLineAndDistance";
	}
	
	/** 마우스로 다각형 그리기 및 면적 계산 페이지 */
	@GetMapping("/overlay/createPolygonAndArea.do")
	public String createPolygonAndArea(){
		
		return "/kakao/overlay/createPolygonAndArea";
	}
	
}
