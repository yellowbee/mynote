<%@ page isELIgnored ="false" %>

<%
System.out.println("docid " + request.getAttribute("docid"));
System.out.println("title_with_space " + request.getAttribute("title_with_space"));
%>

<style type="text/css">
#buttonGroup {
	display: inline;
}
</style>

<div id="wrapper">
<p id="title"><h1>${title_with_space}</h1></p>
<div id="buttonGroup">
	<button type="button" id="editButton" title="<%=request.getAttribute("title_with_space")%>" onclick="editHandler()" style="float:right">edit</button>
	<button type="button" id="addButton" docid="<%=request.getAttribute("docid")%>" onclick="addHandler()" style="float:right">add</button>
</div>

<textarea id="mainedit">
${textContent}
</textarea>
</div>