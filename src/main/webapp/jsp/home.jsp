<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="com.aidu.mydoc.bo.DocNode" %>
<%@ page language="java" import="java.util.Set" %>
<html>
<head>
<base href="<%=basePath%>" />
	<link rel="stylesheet" type="text/css" href="css/mystyle.css"/>
	<!-- <link href="css/bootstrap/docs/assets/css/bootstrap.css" rel="stylesheet"></link> -->
	<!-- <link rel="stylesheet" href="almost-flat-ui/stylesheets/normalize.css" />
	<link rel="stylesheet" href="almost-flat-ui/stylesheets/app.css" /> -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function(){
			
            // a tag click handler
			$('#menu').on('click', 'a', function() {
				$.get($(this).attr('href'), function(data) {
					$('#content').html(data);
				});

				$('#mainedit').attr('readonly', true);
                return false;
			});
			
            $('.children').hide();
		    
		    // switch class handler: toggle the '+' and '-' switch to hide and show the subtree of a node
		    $('#menu').on('click', '.switch', function() {
		    	var switch_text = $(this).html();
		    	if (switch_text.indexOf('+') !== -1) {// toggle on '+'
		    		var copy_this = $(this);
	        		var url = "doc!loadChildren?docid=" + $(this).attr('docid');

	        		$.getJSON(url, function(json) {
	        			var subtree = '';
	        			$.each(json.childrenMap, function(key, value) {
	        				var value_with_space = value.replace(/_/g, ' '); // replace all '_' with space character
	        				//subtree += '<div><div><span class="switch" docid="' + key + '">+&#160;</span><a href="#">' + value + '</a></div><div class="children" style="padding-left:1em"></div></div>';
	        				subtree += '<div><div><span class="switch" docid="' + key + '">+&#160;</span><a href="' + 'content!getTextContent?docid=' + key + '&title=' + value + '">' + value_with_space + '</a></div><div class="children" style="padding-left:1em"></div></div>';
	        			});
	        			copy_this.parent().next('.children').html(subtree);
	        		});
	        		
	        		$(this).parent().next('.children').show();
	            	$(this).html('-&#160;&#160;');
		    	}
		    	else { // toggle on '-'
		    		$(this).parent().next('.children').hide();
		            $(this).html('+&#160;');
		    	}
		    });
        });
    </script>
	<script>
		function editHandler() {
			var text = $('#mainedit').html();
			var title = $('#editButton').attr('title');
			title = title.replace('/ /g', '_');

			$('#content').html(
					'<form name="new_form" id="new_form" action="doc!save?title=' + title + '"' + ' method="post">' +
					'<textarea id="mainedit" name="new_text">' +
					'</textarea>' +	
					'<input type="submit" value="Submit">' +
					'</form>');
			$('#content #mainedit').html(text);
		}
		
		function addHandler() {
			var url = "docpage!add?docid=" + $('#addButton').attr('docid');
			$('#content').load(url);
		}
		
		function testLoad() {
			$('#menu').load("testload");
		}
	</script>
</head>

<body>
    <!-- <div id="container" class="container-fluid"> -->
    	<div id="banner">
    		<p><h1>MyDoc</h1></p>
    	</div>
		
		<div id="menu">
		    <% 
				DocNode root = (DocNode)request.getAttribute("root");
				/* Set<DocNode> children = (Set<DocNode>)request.getAttribute("children"); */
			%>
			<div style="line-height:20px">
				<div> <span class="switch" docid="<%=root.getId()%>">+&#160;</span><a href="content!getTextContent?docid=<%=root.getId()%>&title=<%=root.getDocName()%>"><%=root.getDocName()%></a></div>
				<div class="children" style="padding-left:1em"></div>
			</div>
	    </div>
	        
	    <div id="content"></div>
    <!-- </div> -->
    
    <div id="footer" role="contentinfo">Copyright 2013, aidu.com</div>
</body>
</html>

