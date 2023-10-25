package com.study.leaflet;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.study.leaflet")
public class LeafletApplication {

	public static void main(String[] args) {
		SpringApplication.run(LeafletApplication.class, args);
	}

}
