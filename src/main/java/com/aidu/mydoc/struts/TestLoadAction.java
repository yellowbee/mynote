package com.aidu.mydoc.struts;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.interceptor.RequestAware;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.aidu.mydoc.bo.DocNode;
import com.aidu.mydoc.dao.hibernate.HibernateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class TestLoadAction extends ActionSupport implements RequestAware {
	private Map<String, Object> request;
	
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}
	
	@Override
	public String execute() {
		Set<DocNode> children = new HashSet<DocNode>();
		
		/*SessionFactory sf = HibernateUtil.getSessionFactory();		
		Session session = sf.openSession();
		// start a transaction
		session.beginTransaction();
		DocNode dn = (DocNode)session.load(DocNode.class, 3);
//		Set<DocNode> s = dn.getChildren();
		// System.out.println(dn.getDocName());
		
		for (DocNode dnx : dn.getChildren()) {
			// System.out.println(dnx.getDocName());
			// hm.put(dnx.getId(), dnx.getDocName());
			//System.out.println(dnx.getId() + ":" + dnx.getDocName() + ":" + dnx.getParent().getId());
			children.add(dnx);
		}		
		session.getTransaction().commit();
		session.close();
		
		for (DocNode dnx : children) {
			System.out.println(dnx.getId() + ":" + dnx.getDocName()); 
		}
		request.put("parent", dn);
		request.put("children", children);*/
		return "success";
	}
}
