package com.study.map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.study.map")
public class StudyMapApplication {

	public static void main(String[] args) {
		SpringApplication.run(StudyMapApplication.class, args);
	}

}
