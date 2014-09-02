package com.aidu.mydoc.web.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ContentController {
	
	@RequestMapping(value="/content")
	public ModelAndView getTextContent(@RequestParam String docid, @RequestParam String title) {
		System.out.println("request for page content");
		StringBuffer sb = new StringBuffer();
		ModelAndView mav = new ModelAndView("article");
		String title_with_space = title.replaceAll("_", " ");
		
		try {
			String filename = "/home/ben/documentation/mydocs"+"/"+title+".jsp";
			Scanner sc = new Scanner(new File(filename));
			while (sc.hasNext()) {
				sb.append(sc.nextLine() + "\n");
			}
			
			mav.addObject("textContent", sb.toString());
			mav.addObject("docid", docid);
			mav.addObject("title_with_space", title_with_space);
			mav.addObject("title", title);
			
			/*request.put("textContent", sb.toString());
			String title_with_space = title.replaceAll("_", " ");
			request.put("docid", docid);
			request.put("title_with_space", title_with_space);*/
		} catch (FileNotFoundException e) {
			System.out.println("specified document is not on the disk");
			e.printStackTrace();
		}
		return mav;
	}
}
