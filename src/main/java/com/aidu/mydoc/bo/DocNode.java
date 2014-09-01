package com.aidu.mydoc.bo;

import java.util.HashSet;
import java.util.Set;

public class DocNode {
	private int id;
	private String docName;
	private DocNode parent; // needed for many-2-one
	private Set<DocNode> children; // needed for one-2-many
	
	public DocNode() {
		children = new HashSet<DocNode>();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDocName() {
		return docName;
	}
	public void setDocName(String docName) {
		this.docName = docName;
	}
	public DocNode getParent() {
		return parent;
	}
	public void setParent(DocNode parent) {
		this.parent = parent;
	}
	public Set<DocNode> getChildren() {
		return children;
	}
	public void setChildren(Set<DocNode> children) {
		this.children = children;
	}
	
	
}