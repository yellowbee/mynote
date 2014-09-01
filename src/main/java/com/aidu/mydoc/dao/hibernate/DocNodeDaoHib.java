package com.aidu.mydoc.dao.hibernate;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.aidu.mydoc.bo.DocNode;
import com.aidu.mydoc.dao.DocNodeDao;
import com.aidu.mydoc.struts.DocAction;

public class DocNodeDaoHib implements DocNodeDao {
	private static Logger logger = Logger.getLogger(DocNodeDaoHib.class.getName());
	
	private SessionFactory sessionFactory;
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public void save(DocNode dn) {
		/*SessionFactory sf = HibernateUtil.getSessionFactory();*/
		
		Session session = sessionFactory.openSession();
		// start a transaction
		session.beginTransaction();
		session.save(dn);
		session.getTransaction().commit();
		session.close();
		//sf.close();
	}
	
	// Load the children of a node
	// Input: node class type, node id
	public Set<DocNode> loadAll(Class arg0, Serializable arg1) {
		Set<DocNode> children = new HashSet<DocNode>();
		
		Session session = sessionFactory.openSession();
		
		DocNode dn = (DocNode)session.load(arg0, arg1);

		System.out.println(dn.getDocName());
		for (DocNode dnx : dn.getChildren()) {
			// System.out.println(dnx.getDocName());
			// hm.put(dnx.getId(), dnx.getDocName());
			/*System.out.println("In loadAll");
			System.out.println(dnx.getId() + ":" + dnx.getDocName() + ":" + dnx.getParent().getId());*/
			logger.info("loading: " + dnx.getId() + " " + dnx.getDocName() + " " + dnx.getParent().getId());
			children.add(dnx);
		}	
		/*session.getTransaction().commit();*/
		session.close();
		
		return children;
	}
	
	public DocNode load(Class arg0, Serializable arg1) {
		/*SessionFactory sf = HibernateUtil.getSessionFactory();*/
		
		Session session = sessionFactory.openSession();
		// start a transaction
		session.beginTransaction();
		DocNode dn = (DocNode)session.load(arg0, arg1);
		dn.getDocName();
		session.getTransaction().commit();
		session.close();
		
		return dn;
	}
}
