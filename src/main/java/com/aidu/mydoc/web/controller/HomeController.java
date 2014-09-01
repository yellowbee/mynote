package com.aidu.mydoc.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.aidu.mydoc.bo.DocNode;
import com.aidu.mydoc.dao.DocNodeDao;
import com.aidu.mydoc.struts.HelloAction;

@Controller
public class HomeController extends AbstractController {
	private static final int ROOT_DOC_ID = 16;
	private static Logger logger = Logger.getLogger(HelloAction.class.getName());
	
	private DocNodeDao docNodeDao;
	
	public DocNodeDao getDocNodeDao() {
		return docNodeDao;
	}

	@Autowired
	@Qualifier("docNodeDao")
	public void setDocNodeDao(DocNodeDao docNodeDao) {
		this.docNodeDao = docNodeDao;
	}

	@Override
	@RequestMapping("/home")
	protected ModelAndView handleRequestInternal(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		/*DocNode dn = docNodeDao.load(DocNode.class, ROOT_DOC_ID);
		// System.out.println(dn.getDocName());
		
		request.put("root", dn);
		logger.warn("root loaded");

		return "success";*/
		
		DocNode dn = docNodeDao.load(DocNode.class, ROOT_DOC_ID);
		
		ModelAndView mav = new ModelAndView("home");
		mav.addObject("root", dn);
		return mav;
	}

}
