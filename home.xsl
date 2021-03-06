<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou">


<xsl:template name="home">
<html lang="en">
<head>
<xsl:call-template name="head"/>
<xsl:call-template name="gacode"/>
</head>
<body class="v1">

<!-- TEMPLATE CHANGE 2012-02-21 -->
		<div id="skip" class="acc"><a href="#skiptocontent">Skip to Main Content</a></div>
		
		<!-- END TEMPLATE CHANGE 2012-02-21 -->
	 
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
	        <div class="right">		        
				<xsl:call-template name="search"/>
	        </div>
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
		</nav>	<!-- end Subsite Primary Navigation -->
			<div id="breadcrumb">
				<!-- Breadcrumbs -->
				
				<div class="left">
<!--	    			<xsl:call-template name="bc">-->
<!--						<xsl:with-param name="path" select="$ou:dirname"/>								-->
<!--					</xsl:call-template>-->
		    	</div>
				<!-- end Breadcrumbs -->
				<!-- Social Media -->
	        	<div class="right">
		        	<xsl:call-template name="socialmedia"/>
					
	        	</div>
	        	<!-- end Social Media -->
			</div>
			
			<div id="content" role="main">
				<div class="left">
		    		<h1 id="skiptocontent" class="acc">Content</h1>
		        	<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
					<xsl:choose>
					<xsl:when test="(document/config/parameter[@name='slideshow']/option[@value='yes']/@selected = 'true')">
						<xsl:choose>
							<xsl:when test="not(document/maincontent/banner/slideshow/table)">
							<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
							<p>There is no slideshow added in this area. <br /> Please select the edit button and add a default slideshow using the insert snippet option on the toolbar.</p>
							</xsl:when>						
							<xsl:when test="not($ou:action = 'edt')">
								<xsl:if test="document/config/parameter[@name='subsite']/option[@value='yes']/@selected = 'true'">
									<xsl:call-template name="nivoslider" />
								</xsl:if>
								<xsl:if test="document/config/parameter[@name='subsite']/option[@value='yes']/@selected = 'false'">
									<xsl:call-template name="nivosliderhome" />
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="not(document/maincontent/banner/slideshow/table)">
								<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
								<p>There is no slideshow added in this area. <br /> Please select the edit button and add a default slideshow using the insert snippet option on the toolbar.</p>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
									<img>
										<xsl:attribute name="src" ><xsl:value-of select="document/maincontent/banner/slideshow/table/tbody/tr[2]/td[1]/img/@src" /></xsl:attribute>
										<xsl:attribute name="alt" ><xsl:value-of select="document/maincontent/banner/slideshow/table/tbody/tr[2]/td[1]/img/@alt" /></xsl:attribute>
										<xsl:attribute name="title" ><xsl:value-of select="concat('#htmlcaption',position())" /></xsl:attribute>
									</img>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>									
					</xsl:when>
					<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="not($ou:action = 'edt')">
			            <div class="banner_text">
			                <h2 class="pagetitle acc"><xsl:copy-of select="document/title/node()" /></h2>
			                <div class="banner_caption homepage" role="complementary">
			                   <xsl:copy-of select="document/maincontent/banner/banner_caption/node()" />
			                </div>
			            </div>

			            <div class="banner_image_homepage" role="banner">
			            	<xsl:copy-of select="document/maincontent/banner/image/node()" />
			            </div>
			            </xsl:when>
			            <xsl:otherwise>
			            <div>
			                <h2 class="pagetitle acc"><xsl:copy-of select="document/title/node()" /></h2>
			                <div class="banner_caption homepage" role="complementary" style="background-color: grey; width: 660px;">
			                   <xsl:copy-of select="document/maincontent/banner/banner_caption/node()" />
			                </div>
			            </div>
			            <!-- end Banner Text -->
			            <!-- Banner Image -->
			            <div>
			            	<xsl:copy-of select="document/maincontent/banner/image/node()" />
			            </div>
			            </xsl:otherwise>
		            </xsl:choose>
					</xsl:otherwise>
					</xsl:choose>		        	
		        </div>
		        <nav class="secnav">
				    <h1 class="acc">Tour</h1>
		    		<h2>Explore</h2>
		    		<xsl:choose>
			    		<xsl:when test="not($ou:action = 'edt')">
			    		<xsl:call-template name="gallery" />
			    		</xsl:when>
		    		<xsl:otherwise>
		    		<xsl:copy-of select="document/maincontent/banner/gallery/comment()" />
		    		<div id="gallery">
						<ul>
							<xsl:for-each select="document/maincontent/banner/gallery/img">
								<xsl:if test="position() = 1">
									<li>
									<a><xsl:attribute name="class">btn_imgthumb</xsl:attribute>
										<xsl:attribute name="href" ><xsl:value-of select="./@src" /></xsl:attribute>
										<xsl:attribute name="title" ><xsl:value-of select="./@alt" /></xsl:attribute>
									</a></li>
								</xsl:if>
							</xsl:for-each>
						</ul>
					</div>	
		    		</xsl:otherwise>
		    		</xsl:choose>
		    	</nav>
		        
				<div class="content_wrapper">
					<xsl:choose>
					<xsl:when test="(document/config/parameter[@name='columns']/option[@value='1col']/@selected = 'true')">
						<xsl:copy-of select="document/maincontent/column_two/node()" />
					</xsl:when>
					<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true') or (document/config/parameter[@name='columns']/option[@value='3col']/@selected = 'true')">

                		<div class="left" role="region">

	                		<xsl:copy-of select="document/maincontent/column_one/node()" />

                		</div>
                		<xsl:choose>
	                		<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true')">

		                		<div class="right">
		                			<xsl:copy-of select="document/maincontent/column_two/node()" />
		                        </div>

	            			</xsl:when>
	            			<xsl:otherwise>
		            			<div class="right">
									<div class="l" role="article">

										<xsl:copy-of select="document/maincontent/column_two/node()" />

									</div>
									<div class="r" role="article">

                						<xsl:copy-of select="document/maincontent/column_three/node()" />

                					</div>
                				</div>
	            			</xsl:otherwise>
            			</xsl:choose>
					</xsl:when>
					</xsl:choose>
        		</div>
			<!-- Footer -->
			<div id="footer">
			<xsl:call-template name="footer" />
			</div><!-- end Footer -->
		</div>
	</div>
</div>
	<div id="footer_bg"></div>
	<xsl:call-template name="scripts" />	
<xsl:copy-of select="document/footcode/node()" />
</body>
</html>
</xsl:template>
</xsl:stylesheet>	
