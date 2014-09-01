<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.Set" %>
<%@ page language="java" import="com.aidu.mydoc.bo.DocNode" %>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function(){
		    $('#menu .switch').toggle(
		        function() {
		        	// alert($(this).parent().next('.children').children().size());
		        	/* if ( $(this).parent().next('.children').children().size() > 0 ) {
		        		//alert("children");
		            	$(this).parent().next('.children').show();
		        	} else { */
		        		var url = "doc!loadChildren?docid=" + $(this).attr('docid');
		        		$(this).parent().next('.children').load(url);
		        		$(this).parent().next('.children').show();
		        	/* } */
		            $(this).html('-&#160;&#160;');
		        },
		        function() {
		            $(this).parent().next('.children').hide();
		            $(this).html('+&#160;');
		        }
		    );
        });
    </script>

<% 
DocNode parent = (DocNode)request.getAttribute("parent");
Set<DocNode> children = (Set<DocNode>)request.getAttribute("children");

for (DocNode dn : children) {
%>
	<div>
		<div><div class="switch" docid="<%=dn.getId()%>" style="float:left">+&#160;</div><div><a href="#"><%=dn.getDocName()%></a></div></div>
		<div class="children" style="padding-left:1em">
		</div>
	</div>
<%
}
%>