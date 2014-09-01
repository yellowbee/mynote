package com.aidu.mydoc.struts;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.RequestAware;

import com.aidu.mydoc.bo.DocNode;
import com.aidu.mydoc.dao.DocNodeDao;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class DocAction extends ActionSupport implements RequestAware {
	private String title;
	private String new_text;
	private String docid;
	
	private static Logger logger = Logger.getLogger(DocAction.class.getName());
	
	// The returned json data is stored here
	private Map<String, String> childrenMap;
	
	private Map<String, Object> request;
	
	private DocNodeDao docNodeDao;
	
	/*public DocNodeDao getDocNodeDao() {
		return docNodeDao;
	}*/

	public void setDocNodeDao(DocNodeDao docNodeDao) {
		this.docNodeDao = docNodeDao;
	}

	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}
	
	/*public String getTitle() {
		return title;
	}*/

	public void setTitle(String title) {
		this.title = title;
	}

	/*public String getNew_text() {
		return new_text;
	}*/

	public void setNew_text(String new_text) {
		this.new_text = new_text;
	}

	/*public String getDocid() {
		return docid;
	}*/

	public void setDocid(String docid) {
		this.docid = docid;
	}

	
	public Map<String, String> getChildrenMap() {
		return childrenMap;
	}

	public void setChildrenMap(Map<String, String> childrenMap) {
		this.childrenMap = childrenMap;
	}

	public String save() {
		StringBuffer sb = new StringBuffer();
		ActionContext.getContext().get("request");
		String title_no_space = title.replaceAll(" ", "_");
		
		File f = new File("/home/ben/documentation/mydocs/" + title_no_space + ".jsp");
		// if file does not exist, create a node for it in the database
		if(!f.exists()) {
			// create a document node and save it to
			// the database
			DocNode parent_dn = new DocNode();
			parent_dn.setId(Integer.parseInt(docid));
			
			DocNode dn = new DocNode();
			dn.setDocName(title_no_space);
			dn.setParent(parent_dn);
			
			docNodeDao.save(dn);
			
			/*System.out.println("title: " + title_no_space);
			System.out.println("file does not exist yet");*/
			logger.info("saved: " + title_no_space);
			
			//docNodeDao.loadAll();
		}

		// save the new document to disk
		try {
			PrintWriter out = new PrintWriter("/home/ben/documentation/mydocs/" + title_no_space + ".jsp");
			sb.append(new_text);
			out.write(sb.toString());
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		

		
		
		return "saved";
	}
	
	public String loadChildren() {
		childrenMap = new HashMap<String, String>();
		
		Set<DocNode> children = docNodeDao.loadAll(DocNode.class, Integer.parseInt(docid));

		for (DocNode dnx : children) {
			childrenMap.put(String.valueOf(dnx.getId()), dnx.getDocName());
			//System.out.println("Returning json data: " + dnx.getId() + ":" + dnx.getDocName());
			logger.info("Returning json data: " + dnx.getId() + ":" + dnx.getDocName());
		}
		/*request.put("parent", dn);
		request.put("children", children);*/

		return "childrenloaded";
	}
}
