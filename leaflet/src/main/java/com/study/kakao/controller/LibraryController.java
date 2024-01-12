package com.study.kakao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class LibraryController{
	
	/** 키워드로 장소 검색 페이지 */
	@GetMapping("/library/searchKeyword.do")
	public String moveAndChangeLevel(){
		
		return "/kakao/library/searchKeyword";
	}
	
	/** 카테고리로 장소 검색 페이지 */
	@GetMapping("/library/searchCategory.do")
	public String searchCategory(){
		
		return "/kakao/library/searchCategory";
	}
	
}
