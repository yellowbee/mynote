<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="com.aidu.mydoc.bo.DocNode" %>
<%@ page language="java" import="java.util.Set" %>
<%@ page isELIgnored ="false" %>
<html>
<head>
<base href="<%=basePath%>" />
	<link rel="stylesheet" type="text/css" href="resources/css/mystyle.css"/>
	<!-- <link href="css/bootstrap/docs/assets/css/bootstrap.css" rel="stylesheet"></link> -->
	<!-- <link rel="stylesheet" href="almost-flat-ui/stylesheets/normalize.css" />
	<link rel="stylesheet" href="almost-flat-ui/stylesheets/app.css" /> -->
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script> -->
	<script src="resources/jquery-1.11.1.min.js"></script>
    <script src="resources/jquery-ui-1.11.1/jquery-ui.js"></script>
    <script src="resources/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="resources/jquery-ui-1.11.1/jquery-ui.css">
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function(){
        	//global variable
        	var cur_title = "";
        	
        	//------ manipulate the display/edit area --------
			$("#edit-panel").hide();		
			$("button#butt1").click(function () {
				var text_textArea = $("textarea#myTextArea").val();
				$("div.panel-body").html(text_textArea);
			});
			
			$("button#butt2").click(function() {
				$("#display-panel").toggleClass("col-lg-5");
				//alert($("#display-panel").attr("class"));
  				$( "#edit-panel" ).toggle("slide");
  				var text_panel_body = $("div.panel-body").html();
  				//alert(text_panel_body);
  				$("textarea#myTextArea").val(text_panel_body);
			});
        	
			$("button#butt3").click(function () {
				//$.get("http://localhost:8080/mynote/" + cur_save_url, function(data) {
				//var newText = $("textarea#myTextArea").val();
				/* $.post(cur_save_url, $("textarea#myTextArea").val(), function(result) {
					alert(result);
				}); */
				$.ajax({
				    url : "app/save",
				    type : "POST",
				    contentType : "application/json",
				    data : JSON.stringify({
				    	newText : $("textarea#myTextArea").val(),
				    	title : cur_title
				    }),
				    success: function(result)
				    {
				        alert(result);
				    }
				});
			});
			
            // a tag click handler
			$('#menu').on('click', 'a', function() {
				var href = $(this).attr('href'); // app/content?docid=90&title=Web_Service
				var title_para = href.split("&")[1];
				var title = title_para.split("=")[1];
				cur_title = title;
				var panel_title = "<h2>" + title.replace(/_/g, ' ') + "</h2>";
				$.get($(this).attr('href'), function(data) {
					$("div.panel-body").html(panel_title + data);
				});
				
				// synch the edit panel with the display panel
				var text_panel_body = $("div.panel-body").html();
  				//alert(text_panel_body);
  				$("textarea#myTextArea").val(text_panel_body);
  				
				//$('#mainedit').attr('readonly', true);
                return false;
			});
			
            $('.children').hide();
		    
		    // switch class handler: toggle the '+' and '-' switch to hide and show the subtree of a node
		    $('#menu').on('click', '.switch', function() {
		    	var switch_text = $(this).html();
		    	if (switch_text.indexOf('+') !== -1) {// toggle on '+'
		    		var copy_this = $(this);
	        		var url = "app/load?docid=" + $(this).attr('docid');

	        		$.getJSON(url, function(json) {
	        			var subtree = '';
	        			$.each(json, function(key, value) {
	        				var value_with_space = value.replace(/_/g, ' '); // replace all '_' with space character
	        				//subtree += '<div><div><span class="switch" docid="' + key + '">+&#160;</span><a href="#">' + value + '</a></div><div class="children" style="padding-left:1em"></div></div>';
	        				subtree += '<div><div><span class="switch" docid="' + key + '">+&#160;</span><a href="' + 'app/content?docid=' + key + '&title=' + value + '">' + value_with_space + '</a></div><div class="children" style="padding-left:1em"></div></div>';
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
	<!-- ******************************** UI Start ******************************************** -->
    <!-- <div id="container" class="container-fluid"> -->
    <nav id="myNavbar" class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
	    <div class="container-fluid">
	    	<div class="row">
	    		<div class="col-md-3"></div>
	        	<div class="col-md-3"><button id="butt1" type="button" class="btn btn-primary">preview</button></div>
	        	<div class="col-md-3"><button id="butt2" type="button" class="btn btn-primary">edit</button></div>
	        	<div class="col-md-3"><button id="butt3" type="button" class="btn btn-primary">save</button></div>
	       	</div>
	    </div>
	</nav>

    <div id="my-panel" class="container-fluid edit-body">            
		<div class="row">
    		<div id="menu" class="col-lg-2">
				<div>
					<div> <span class="switch" docid="${root.id}">+&#160;</span><a href="app/content?docid=${root.id}&title=${root.docName}">${root.docName}</a></div>
					<div class="children" style="padding-left:1em"></div>
				</div>
			</div>

			<div  id="display-panel" class="col-lg-10 panel panel-default">
		        <div class="panel-body" id="showText">Look, I'm in a panel!</div>
		   	</div>       

			<div id="edit-panel" class="col-lg-5">
				<textarea id="myTextArea" rows="30" cols="80">hello world</textarea>
			</div>
    	</div>
	</div>

	    <!-- <div id="content"></div> -->
    <!-- </div> -->
    
    <div id="footer" role="contentinfo">Copyright 2013, aidu.com</div>  
	<!-- ******************************** UI End ******************************************** -->
</body>
</html>

