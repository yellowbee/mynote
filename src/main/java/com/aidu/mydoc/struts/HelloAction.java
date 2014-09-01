package com.aidu.mydoc.struts;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.RequestAware;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.aidu.mydoc.bo.DocNode;
import com.aidu.mydoc.dao.DocNodeDao;
import com.aidu.mydoc.dao.hibernate.DocNodeDaoHib;
import com.aidu.mydoc.dao.hibernate.HibernateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class HelloAction extends ActionSupport implements RequestAware {
	private static final int ROOT_DOC_ID = 16;
	private static Logger logger = Logger.getLogger(HelloAction.class.getName());
	
	private DocNodeDao docNodeDao;
	
	private Map<String, Object> request;
	
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}

	public DocNodeDao getDocNodeDao() {
		return docNodeDao;
	}

	public void setDocNodeDao(DocNodeDao docNodeDao) {
		this.docNodeDao = docNodeDao;
	}

	@Override
	public String execute() {
		/*Set<DocNode> children = new HashSet<DocNode>();*/
				
		// start a transaction
		DocNode dn = docNodeDao.load(DocNode.class, ROOT_DOC_ID);
		// System.out.println(dn.getDocName());
		
		request.put("root", dn);
		logger.warn("root loaded");

		return "success";
	}
}
