<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou">


<xsl:template name="redirect">
<html lang="en">
<head>
<xsl:call-template name="head"/>
<xsl:call-template name="gacode"/>
</head>
<body>
	<div id="bg">
		<div id="container">
			<a href="http://www.sjsu.edu" id="sjsuhomelink"></a>
			<div id="top_subsite">
			        <div class="left">
			        	<!-- Subsite name and enclosing unit -->
			        	<a href="{$ou:sitepath}/"><h1 class="subsite_name"><xsl:value-of select="$ou:subsite"/></h1></a>
			        	<span class="subsitetitle">San José State University</span>
			        	<a href="http://www.sjsu.edu/adminfinance/"><span class="subsite_enclosingunit"><xsl:value-of select="$ou:enclosingunit"/></span></a>
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
               <div class="left"><a href="http://www.sjsu.edu/">SJSU Home&nbsp;&gt;&nbsp;</a></div>
               
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
					<a class="back_up_level" href="../"><span class="navarrowback"><xsl:comment>&nbsp;</xsl:comment></span>BACK one Level</a>
				</nav>
				<!-- end Secondary Navigation -->
				<h1 class="acc">Main Content</h1>
				<div class="left">
        		<xsl:copy-of select="document/maincontent/column_two/node()" />
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
