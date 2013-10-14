<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou">


<xsl:template name="onecolumn">
<xsl:variable name="rssfeed" select="document/config/parameter[@name='rssfeed']" />
<xsl:variable name="rssfeeditems" select="document/config/parameter[@name='rssfeeditems']" />
<html lang="en">
<head>

<xsl:call-template name="head"/>
<xsl:call-template name="gacode"/>
</head>
<body>
	<xsl:choose>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'news')">
		<xsl:attribute name="id" select="string('home-d')" />
		<xsl:attribute name="class">v5</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		<xsl:attribute name="id" select="string('home-d')" />
		<xsl:attribute name="class">v7</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>
	<!-- TEMPLATE CHANGE 2012-02-27 -->
		<div id="skip" class="acc"><a href="#skiptocontent">Skip to Main Content</a></div>
		
		<!-- END TEMPLATE CHANGE 2012-02-27 -->
	
	<div id="bg">
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/oucampusemergency/index.html', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="alert" </xsl:comment> 
			<xsl:comment>#include virtual="/oucampusemergency/index.html" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:if>
		<div id="container">
			<a href="http://www.sjsu.edu" id="sjsuhomelink"></a>
			<!-- TEMPLATE CHANGE 2012-02-09 -->
			<a href="http://www.sjsu.edu/sjsuhome/sjsu-feature" id="doodlelink"></a>
			<!-- END TEMPLATE CHANGE 2012-02-09 -->
			<div id="top_subsite">
			        <div class="left">
			        	<!-- Subsite name and enclosing unit -->
			        	<a href="{$ou:sitepath}/"><h1 class="subsite_name"><xsl:value-of select="$ou:subsite"/></h1></a>
			        	<span class="subsitetitle">San José State University</span>
			        	<xsl:if test="$ou:encunitlink != ''">
<a href="{$ou:encunitlink}"><span class="subsite_enclosingunit"><xsl:value-of select="$ou:enclosingunit"/></span></a>
</xsl:if>
			        </div>
	        <div class="right">		        
				<xsl:call-template name="search"/>
	        </div>
		</div>		
			<!-- Subsite Primary Navigation -->
		<h1 class="acc">Main Navigation</h1> 
 		<nav id="subsitenav" role="navigation">
 		<xsl:choose>
		<xsl:when test="doc(concat($root, '/includes'))/list/file[. eq 'meganav.inc']">	

			<xsl:comment> com.omniupdate.div label="topnav" path="/includes/meganav.inc"</xsl:comment> 
			<xsl:comment>#include virtual="<xsl:value-of select="$ou:sitepath"/>/includes/meganav.inc" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text(concat($ou:httproot,'primarynav.html'), 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="primarynav" </xsl:comment> 
			<xsl:comment>#include virtual="<xsl:value-of select="$ou:sitepath"/>/primarynav.html" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
		</nav>		
		<h2 class="acc">Shortcut Icons</h2> 
		<div id="quickicons"> 
			<xsl:call-template name="quickicons"/>
		</div>	

			<div id="breadcrumb">
				<!-- Breadcrumbs -->
				<div class="left">
	    			<xsl:call-template name="bc">
						<xsl:with-param name="path" select="$ou:dirname"/>								
					</xsl:call-template>
		    	</div>
				<!-- end Breadcrumbs -->
				<!-- Social Media -->
	        	<div class="right">
		        	<xsl:call-template name="socialmedia"/>
					
	        	</div>
	        	<!-- end Social Media -->
			</div>
			<div id="content" role="main">
				<!-- Secondary Navigation -->
				<nav class="secnav">
		    		<h1 class="acc">Secondary Navigation</h1>
					<h2>Navigate</h2>
					<a class="back_up_level" href="../"><span class="navarrowback"><xsl:comment>&nbsp;</xsl:comment></span>BACK to <xsl:value-of select="$back2" /></a>
		    		<xsl:choose>
		    			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'forms')" >
		    				<xsl:call-template name="formsindexfilter" />
		    			</xsl:when>
		    			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'siteindex')" >
		    				
		    				<xsl:call-template name="siteindexfilter" />
		    				
		    			</xsl:when>		    			
		    			<xsl:otherwise>	
		    			<ul id="currnav">
						<xsl:comment> com.omniupdate.div label="sidenav" path="<xsl:value-of select="$dirname"/>sidenav.inc" </xsl:comment> 
						<xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,$dirname)"/>sidenav.inc"</xsl:comment>
						<xsl:comment> /com.omniupdate.div </xsl:comment>
						</ul>
						<ul id="prevnav">
						<xsl:if test="($dirname != '/')" >
						<xsl:comment> com.omniupdate.div label="parentnav" path="<xsl:value-of select="$parent-path"/>/sidenav.inc" </xsl:comment> 
						<xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,$parent-path)"/>/sidenav.inc"</xsl:comment>
						<xsl:comment> /com.omniupdate.div </xsl:comment>
						</xsl:if>
						</ul>
						</xsl:otherwise>
					</xsl:choose>
				</nav>
				<!-- end Secondary Navigation -->
				<h1 id="skiptocontent" class="acc">Main Content</h1>
				<div class="left">
        		<xsl:choose>
					<xsl:when test="(document/config/parameter[@name='pagetype'] = 'forms')">
						<div class="longinfo" role="article">
		    				<h2><xsl:value-of select="document/title" /></h2>
    				            <div id="scrolltotop"></div>				
							<xsl:copy-of select="document/maincontent/column_two/comment()" />
							<xsl:call-template name="forms"/>
						</div>							        			
					</xsl:when>
					<xsl:when test="(document/config/parameter[@name='pagetype'] = 'staff')">
							<h2 class="pagetitle"><xsl:value-of select="document/title" /></h2>
    				     	<div class="content_wrapper" role="directory">
    				     	<xsl:copy-of select="document/maincontent/column_two/comment()" />			
							<xsl:call-template name="staff_template"/>
						</div>							        			
					</xsl:when>					
	    			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'siteindex')" >	    				
	    				<div class="longinfo" role="article">
		    				<h2><xsl:value-of select="document/title" /></h2>
    				            <div id="scrolltotop"></div>
	    						<xsl:call-template name="siteindex" />
	    				</div>	    				
	    			</xsl:when>
		    								
					<xsl:when test="(document/config/parameter[@name='pagetype'] = 'news')">
						<div class="left" role="article">
							<h1 class="acc">Content</h1>
							<h2 class="pagetitle"><xsl:value-of select="document/title" /></h2>		
							
							<script src="http://www.google.com/jsapi?key=ABQIAAAAeqmXqXocwWEAMdOhU8DYjhSM2vXT2j2xHE_iOcqCbZQaOoosvRQNgEtu-7RQkfQtj1iaY3J7DBonyw" type="text/javascript"></script>
							
							<script type="text/javascript">
							        google.load("feeds", "1");
							        function OnLoad() {
							        var feedControl = new google.feeds.FeedControl();
							                feedControl.addFeed("<xsl:value-of select="$rssfeed" />");
							                feedControl.setNumEntries(<xsl:value-of select="$rssfeeditems" />);
							                feedControl.draw(document.getElementById("newsfeed"));
							        }
							        google.setOnLoadCallback(OnLoad);
							</script>
							
							<div id="newsfeed">Loading rss feed...</div>
							
							<a href="{$rssfeed}">View more news posts</a>
						</div>
					</xsl:when>
				</xsl:choose>
				</div>
			</div>
			<!-- Footer -->
			<div id="footer">
			<xsl:call-template name="footer" />
			</div><!-- end Footer -->
		</div>
</div>
<div id="footer_bg"></div>

<xsl:call-template name="scripts" />	

<xsl:copy-of select="document/footcode/node()" />
</body>
</html>
</xsl:template>
</xsl:stylesheet>	
