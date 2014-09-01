package com.aidu.mydoc.struts;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.Scanner;

import org.apache.struts2.interceptor.RequestAware;

import com.opensymphony.xwork2.ActionSupport;

// Implement RequestAware and request will be initialized
// by Struts via IoC
public class ContentAction extends ActionSupport implements RequestAware {
	private String docid;
	private String title;
	private Map<String, Object> request;
	
	public String getDocid() {
		return docid;
	}

	public void setDocid(String docid) {
		this.docid = docid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}

	public String getTextContent() {
		StringBuffer sb = new StringBuffer();
		try {
			String filename = "/home/ben/documentation/mydocs"+"/"+title+".jsp";
			Scanner sc = new Scanner(new File(filename));
			while (sc.hasNext()) {
				sb.append(sc.nextLine() + "\n");
			}
			
			request.put("textContent", sb.toString());
			String title_with_space = title.replaceAll("_", " ");
			request.put("docid", docid);
			request.put("title_with_space", title_with_space);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
