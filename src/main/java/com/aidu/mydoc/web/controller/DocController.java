package com.aidu.mydoc.web.controller;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aidu.mydoc.bo.DocNode;
import com.aidu.mydoc.dao.DocNodeDao;

@Controller
public class DocController {
	private DocNodeDao docNodeDao;
	private static Logger logger = Logger.getLogger(DocController.class.getName());
	
	public DocNodeDao getDocNodeDao() {
		return docNodeDao;
	}

	@Autowired
	@Qualifier("docNodeDao")
	public void setDocNodeDao(DocNodeDao docNodeDao) {
		this.docNodeDao = docNodeDao;
	}

	@RequestMapping(value="/load", produces="application/json")
	public @ResponseBody Map<String, String> loadChildren(@RequestParam String docid) {
		Map<String, String> childrenMap = new HashMap<String, String>();
		
		Set<DocNode> children = docNodeDao.loadAll(DocNode.class, Integer.parseInt(docid));

		for (DocNode dnx : children) {
			childrenMap.put(String.valueOf(dnx.getId()), dnx.getDocName());
			//System.out.println("Returning json data: " + dnx.getId() + ":" + dnx.getDocName());
			logger.info("Returning json data: " + dnx.getId() + ":" + dnx.getDocName());
		}
		/*request.put("parent", dn);
		request.put("children", children);*/

		return childrenMap;
	}

	@RequestMapping(value="/add", produces="application/json")
	public @ResponseBody Map<String, String> add(@RequestParam String title, @RequestParam String pid) {
		Map<String, String> docid_map = new HashMap<String, String>();
		// create a document node and save it to
		// the database
		DocNode parent_dn = new DocNode();
		parent_dn.setId(Integer.parseInt(pid));
		
		DocNode dn = new DocNode();
		dn.setDocName(title);
		dn.setParent(parent_dn);
		
		docNodeDao.save(dn);
		docid_map.put("docid", String.valueOf(dn.getId()));
		/*System.out.println("title: " + title_no_space);
		System.out.println("file does not exist yet");*/
		logger.info("save doned for doc node with title " + title + " and docid " + dn.getId() );
		
		return docid_map;
	}
	
	//public ModelAndView save(@RequestParam("value1") String new_text, @RequestParam String title) {
	//@RequestMapping(value="/save", method=RequestMethod.POST, headers="Accept=application/json")
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public ModelAndView save(@RequestBody String data) {
		//System.out.println("save request for " + title + " received");
		JSONObject jsonObj = new JSONObject(data);
		//System.out.println("current title: " + jsonObj.getString("title"));
		//System.out.println("new text to save: " + jsonObj.getString("newText"));
		
		String title = jsonObj.getString("title");	
		String title_no_space = title.replaceAll(" ", "_");
		String newText = jsonObj.getString("newText");
		//File f = new File("/home/ben/documentation/mydocs/" + title_no_space + ".jsp");
		// if file does not exist, create a node for it in the database
		/*if(!f.exists()) {
			// create a document node and save it to
			// the database
			DocNode parent_dn = new DocNode();
			parent_dn.setId(Integer.parseInt(docid));
			
			DocNode dn = new DocNode();
			dn.setDocName(title_no_space);
			dn.setParent(parent_dn);
			
			docNodeDao.save(dn);
			
			System.out.println("title: " + title_no_space);
			System.out.println("file does not exist yet");
			logger.info("saved: " + title_no_space);
			
			//docNodeDao.loadAll();
		}*/

		// save the new document to disk
		StringBuffer sb = new StringBuffer();
		try {
			PrintWriter out = new PrintWriter("/home/ben/documentation/mydocs/" + title_no_space + ".jsp");
			sb.append(newText);
			out.write(sb.toString());
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView("saved");
		return mav;
	}
}
