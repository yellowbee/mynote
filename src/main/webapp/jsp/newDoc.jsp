<form name="new_form" id="new_form" action="doc!save?docid=<%=request.getAttribute("docid")%>" method="post">
	<input style="text" name="title" size = 150 value="input title here" />
	<textarea id="mainedit" name="new_text">
	</textarea>	

	<input type="submit" value="Submit">
</form>

<%
System.out.println("submit button has docid: " + request.getAttribute("docid"));
%>