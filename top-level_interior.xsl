<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou">


<xsl:template name="top-level_interior">
<html lang="en">
<head>
<xsl:call-template name="head"/>
<xsl:call-template name="gacode"/>
</head>
<body id="home-d" class="v5">
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
			<div id="top_home">
	        <div class="left">
	        	<a href="http://www.sjsu.edu" class="btn_logo" title="San Jos&eacute; State University"><h1>San Jos&eacute; State University</h1></a>
	        </div>
					<xsl:choose>
						<xsl:when test="(document/config/parameter[@name='exception'] = '404')" >
							<xsl:comment>disabled search box</xsl:comment>
						</xsl:when>
						<xsl:otherwise>
	        <div class="right">		        
				<xsl:call-template name="search"/>
	        </div>
						</xsl:otherwise></xsl:choose>
		</div>
			<!-- Subsite Primary Navigation -->
		<h1 class="acc">Main Navigation</h1> 
 		<nav id="home" role="navigation">
 		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/homenav.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="topnav"</xsl:comment> 
			<xsl:comment>#include virtual="/sjsuhome/includes/homenav.inc" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:if>
		<h2 class="acc">Shortcut Icons</h2> 
		<div id="quickicons"> 
			<xsl:call-template name="quickicons"/> 
		</div>
		</nav>
			<!-- end Subsite Primary Navigation -->
				
				<div id="breadcrumb">
									
					<!-- Breadcrumbs -->
					<div class="left">
					<xsl:choose>
						<xsl:when test="(document/config/parameter[@name='breadcrumbToggle']/option[@value='no']/@selected = 'true')">
							<xsl:comment>disabled breadcrumb</xsl:comment>
						</xsl:when>
						<xsl:otherwise>
						<xsl:call-template name="bc">
						<xsl:with-param name="path" select="$ou:dirname"/>								
						</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
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
				<xsl:choose>
					<xsl:when test="(document/config/parameter[@name='sidenavToggle']/option[@value='no']/@selected = 'true')">
							<xsl:comment>disabled sidenav</xsl:comment>
					</xsl:when>
				<xsl:otherwise>	
				<nav class="secnav">
		    		<h1 class="acc">Secondary Navigation</h1>
					<h2>Navigate</h2>
					<a class="back_up_level" href="../"><span class="navarrowback"><xsl:comment>&nbsp;</xsl:comment></span>BACK to <xsl:value-of select="$back2" /></a>
		    		<xsl:choose>
		    			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'forms') or (document/config/parameter[@name='pagetype'] = 'siteindex')" >
		    				<xsl:call-template name="indexfilter" />
		    			</xsl:when>
		    			<xsl:otherwise>	
		    			<xsl:choose>
	  				 		<xsl:when test="doc(concat($root,$ou:dirname))/list/directory != ''">
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
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise> 
						</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</nav>
				</xsl:otherwise>
				</xsl:choose>
				
				<!-- end Secondary Navigation -->
				
        		<xsl:choose>
			<xsl:when test="(document/config/parameter[@name='columns']/option[@value='1col']/@selected = 'true')">
				<h1 id="skiptocontent" class="acc">Main Content</h1>
				<div class="left" role="article">
					
					<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
					<xsl:copy-of select="document/maincontent/column_two/node()" />
					
        			</div>
			</xsl:when>
			
			<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true') or (document/config/parameter[@name='columns']/option[@value='3col']/@selected = 'true')">
				<h1 id="skiptocontent" class="acc">Main Content</h1>
    			<div class="left">
            		<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
            		<div class="content_wrapper">
                		<div class="left" role="region">
	                		
							<xsl:copy-of select="document/maincontent/column_one/node()" />
							
						</div>
						<div class="right">
							<xsl:choose>
								<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true')">
									<xsl:copy-of select="document/maincontent/column_two/node()" />
								</xsl:when>
								<xsl:otherwise>
									<div class="l" role="article">			                    		
			                    		<xsl:copy-of select="document/maincontent/column_two/node()" />
			                    		
		                    		</div>
		                    		<div class="r" role="article">
			                    		
			                    		<xsl:copy-of select="document/maincontent/column_three/node()" />
			                        	
		                    		</div>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</div>
				</div>
			</xsl:when>
			</xsl:choose>
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
