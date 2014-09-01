package com.aidu.mydoc.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import com.aidu.mydoc.bo.DocNode;

public interface DocNodeDao {
	public void save(DocNode dn);
	public Set<DocNode> loadAll(Class arg0, Serializable arg1);
	public DocNode load(Class arg0, Serializable arg1);
}

