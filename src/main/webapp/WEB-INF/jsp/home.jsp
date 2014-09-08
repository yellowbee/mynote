<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="com.aidu.mydoc.bo.DocNode" %>
<%@ page language="java" import="java.util.Set" %>
<%@ page isELIgnored ="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
    <link rel="stylesheet" href="resources/jquery-ui-1.11.1/jquery-ui.css">
    
    <script src="resources/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-theme.min.css">
    
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function(){
        	//global variable
        	var cur_title = "";
        	var cur_docid = "";
        	// variables for the modal form
        	
        	
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
				    contentType : "application/json;charset=UTF-8",
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
				// -------- update the current title and docid every time a node anchor is clicked -------
				var href = $(this).attr('href'); // app/content?docid=90&title=Web_Service
				var title_para = href.split("&")[1];
				var title = title_para.split("=")[1];
				cur_title = title;
				var panel_title = "<h2>" + title.replace(/_/g, ' ') + "</h2>";
				
				cur_docid = href.split("?")[1].split("&")[0].split("=")[1];
				// ---------------------------------------------------------------------------------------
				
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
	        			$.each(json, function(key, value) { // key is the docid in string, value is the title in string
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
		    
		 	// ---------------- scripts for the modal form Start ------------------------
		 	var dialog, form;
        	var child_title = $("form #title");
        	//allFields = $([]).add(name);
		 	       	
        	// event handler for the button in the dialog
			function addPage() {
				if (cur_title == "") {
					alert("Please select a parent page first");
					dialog.dialog("close");
				}
				else {
					//alert("title to create: " + title.val());
					// send a request for creating and storing a new node, pid is parent id
					var url = "app/add?title=" + child_title.val().replace(/ /g, '_') + "&pid=" + cur_docid;

					$.getJSON(url, function() {
	        			/* var subtree = '';
	        			$.each(json, function(key, value) { // key is 'docid', value is the actual docid
	        				//var value_with_space = value.replace(/_/g, ' '); // replace all '_' with space character
	        				//subtree += '<div><div><span class="switch" docid="' + key + '">+&#160;</span><a href="#">' + value + '</a></div><div class="children" style="padding-left:1em"></div></div>';
	        				subtree += '<div><div><span class="switch" docid="' + value + '">+&#160;</span><a href="' + 'app/content?docid=' + value + '&title=' + cur_title.replace(' ', /_/g) + '">' + cur_title.replace(/_/g, ' ') + '</a></div><div class="children" style="padding-left:1em"></div></div>';
	        			});
	        			copy_this.parent().next('.children').html(subtree); */
	        		});
					dialog.dialog("close");
				}
				
				return true;
			}
			
			// config for the dialog window
			dialog = $( "#dialog-form" ).dialog({
		      autoOpen: false,
		      height: 300,
		      width: 350,
		      modal: true,
		      buttons: {
		        "Add a new page": addPage,
		        Cancel: function() {
		          dialog.dialog( "close" );
		        }
		      },
		      close: function() {
		        /* form[ 0 ].reset();
		        allFields.removeClass( "ui-state-error" ); */
		      }
		    });
			
			//register event handler for
        	form = dialog.find( "form" ).on( "submit", function( event ) {
      			event.preventDefault();
      			addPage();
    		});
			
			// register event handler for the button to open dialog
			$( "#add-page" ).button().on( "click", function() {
				dialog.dialog( "open" );
			});
			// ---------------- scripts for the modal form End --------------------------
		    
		    
        });
			
		
    </script>
	<!-- <script>
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
	</script> -->
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
	        	<div class="col-md-3">
	        		<button id="butt3" type="button" class="btn btn-primary">save current page</button>
	        		<button id="add-page" type="button" class="btn btn-primary">add new page</button>
	        	</div>
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
	<!-- ***************** Dialog Component Start ************************ -->
	<div id="dialog-form" title="Add New Node">
		<p class="validateTips">All form fields are required.</p>
		 
		<form>
			<fieldset>
				<label for="title">Title</label>
				<input type="text" name="title" id="title" value="Input title here" class="text ui-widget-content ui-corner-all"> 
				<!-- Allow form submission with keyboard without duplicating the dialog button -->
				<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
			</fieldset>
		</form>
	</div>
	<!-- ********************** Dialog Component End ************************* -->
</body>
</html>

