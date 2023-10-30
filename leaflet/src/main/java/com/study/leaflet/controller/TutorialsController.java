package com.study.leaflet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class TutorialsController{
	
	/** Quick Start Guide 페이지 */
	@GetMapping("/tutorials/quickStartGuide.do")
	public String quickStartGuide(){
		
		return "/tutorials/quickStartGuide";
	}
	
	/** Markers With Custom Icons 페이지 */
	@GetMapping("/tutorials/markersWithCustomIcons.do")
	public String markersWithCustomIcons(){
		
		return "/tutorials/markersWithCustomIcons";
	}
	
	/** Using GeoJSON with Leaflet 페이지 */
	@GetMapping("/tutorials/usingGeoJSONwithLeaflet.do")
	public String usingGeoJSONwithLeaflet(){
		
		return "/tutorials/usingGeoJSONwithLeaflet";
	}
	
	/** Interactive Choropleth Map 페이지 */
	@GetMapping("/tutorials/interactiveChoroplethMap.do")
	public String interactiveChoroplethMap(){
		
		return "/tutorials/interactiveChoroplethMap";
	}
	
}
