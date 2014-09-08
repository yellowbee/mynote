package com.aidu.mydoc.web.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

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
			File file = new File(filename);
			BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF8"));
			
			String str;
			while ((str = in.readLine()) != null) {
				sb.append(str + "\n");
			}
			/*Scanner sc = new Scanner(new File(filename));
			while (sc.hasNext()) {
				sb.append(sc.nextLine() + "\n");
			}*/
			
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
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return mav;
	}
}
