﻿<cfoutput>
#html.doctype()#
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>#server.keyExists( "lucee" ) ? "lucee" : "adobe"# #server.coldfusion.productVersion# - Welcome to Coldbox!</title>
	<meta name="description" content="ColdBox Application Template">
    <meta name="author" content="Ortus Solutions, Corp">
	<!---Base URL --->
	<base href="#getSetting( "HTMLBaseURL" )#" />
	<!---css --->
	<link href="includes/css/bootstrap.min.css" rel="stylesheet">
	<style>
	 /* Utility */
	.centered { text-align: center !important; }
	.inline{ display: inline !important; }
	.margin10{ margin: 10px; }
	.padding10{ padding: 10px; }
	.margin0{ margin: 0px; }
	.padding0{ padding: 0px; }
	.footer {
	  margin-top: 45px;
	  padding: 35px 35px;
	  border-top: 1px solid ##e5e5e5;
	}
	.footer p {
	  margin-bottom: 0;
	  color: ##555;
	}
	body{ padding-top: 50px; }
	</style>
</head>
<body data-spy="scroll">
	<!---Top NavBar --->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<!---Brand --->
			<div class="navbar-header">
				<!---Responsive Design --->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
				    <span class="icon-bar"></span>
				    <span class="icon-bar"></span>
				    <span class="icon-bar"></span>
				</button>
				<!---Branding --->
				<a class="navbar-brand" href="#event.buildLink('')#"><strong>Home</strong></a>
			</div>

			<div class="collapse navbar-collapse" id="navbar-collapse">
				<!---About --->
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="##" class="dropdown-toggle" data-toggle="dropdown">
							<i class="glyphicon glyphicon-info-sign"></i> About <b class="caret"></b>
						</a>
						<ul id="actions-submenu" class="dropdown-menu">
							 <li><a href="">#getColdBoxSetting("codename")# (#getColdBoxSetting("suffix")#)</a></li>
							 <li><a href="mailto:bugs@coldbox.org?subject=DataBoss Bug Report"><i class="icon-fire"></i> Report a Bug</a></li>
							 <li><a href="mailto:info@coldbox.org?subject=DataBoss Feedback"><i class="icon-bullhorn"></i> Send Us Feedback</a></li>
							 <li><a href="http://www.ortussolutions.com/products/coldbox"><i class="icon-home"></i> Professional Support</a></li>
							 <li class="centered">
							 	<img src="includes/images/ColdBoxLogoSquare_125.png" alt="logo"/>
							 </li>
						</ul>
					</li>
				</ul>
			</div>
		</div> <!---end container --->
	</nav> <!---end navbar --->

	<!---Container And Views --->
	<div class="container">#renderView()#</div>

	<footer class="footer">
		<p class="pull-right">
			<a href="##"><i class="glyphicon glyphicon-arrow-up"></i> Back to top</a>
		</p>
		<p>
			<a href="http://www.coldbox.org">ColdBox Platform</a> is a copyright-trademark software by
			<a href="http://www.ortussolutions.com">Ortus Solutions, Corp</a>
		</p>
		<p>
			Design thanks to
			<a href="http://twitter.github.com/bootstrap">Twitter Boostrap</a>
		</p>
	</footer>

	<!---js --->
	<script src="#html.elixirPath( "js/jquery.js" )#"></script>
	<script src="#html.elixirPath( "js/bootstrap.min.js" )#"></script>

	<script>
	$(function() {
		// activate all drop downs
		$('.dropdown-toggle').dropdown();
		// Tooltips
		$("[rel=tooltip]").tooltip();
		// Load Exception via AJAX
		//$.get(
		//	"index.cfm/testerror"
		//);

	})
	</script>
</body>
</html>
</cfoutput>
