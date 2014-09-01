package com.aidu.mydoc.struts;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;

import com.opensymphony.xwork2.ActionSupport;

public class DocPageAction extends ActionSupport implements RequestAware {
	private String docid;
	
	public String getDocid() {
		return docid;
	}
	public void setDocid(String docid) {
		this.docid = docid;
	}
	private Map<String, Object> request;	
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}

	public String add() {
		
		request.put("docid", docid);
		
		return "pagetoadd";
	}
	
	public String edit() {
		
		return "pagetoedit";
	}
}
