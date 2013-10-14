<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou">


<xsl:template name="subhomephp">
<html lang="en">
<head>
<xsl:call-template name="head"/>
<xsl:call-template name="gacode_php"/>
</head>
<body>
	<xsl:choose>
		<xsl:when test="(document/config/parameter[@name='columns']/option[@value='1col']/@selected = 'true')">
		<xsl:attribute name="id" select="string('home-d')" />
		<xsl:attribute name="class">v3</xsl:attribute>
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true')">
		<xsl:attribute name="id" select="string('home-c')" />
		<xsl:attribute name="class">v4</xsl:attribute>
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='columns']/option[@value='3col']/@selected = 'true')">
		<xsl:attribute name="id" select="string('home-c')" />
		<xsl:attribute name="class">v2</xsl:attribute>
		</xsl:when>
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
			<xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/oucampusemergency/index.html"); ?</xsl:processing-instruction>
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
			<xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/includes/meganav.inc"); ?</xsl:processing-instruction>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:when>
		<xsl:otherwise>
 			<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
				<xsl:value-of select="unparsed-text(concat($ou:httproot,'primarynav.html'), 'utf-8')" disable-output-escaping="yes"/>
			</xsl:if>
			<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
				<!-- <xsl:comment> com.omniupdate.div label="topnav" path="/includes/meganav.inc"</xsl:comment>  -->
				<xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/primarynav.html"); ?</xsl:processing-instruction>
				<!-- <xsl:comment> /com.omniupdate.div </xsl:comment> -->
			</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
		</nav>	
		<h2 class="acc">Shortcut Icons</h2> 
		<div id="quickicons"> 
			<xsl:call-template name="quickicons"/>
		</div>	
			<!-- end Subsite Primary Navigation -->
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
				<nav class="secnav_subsite">
					<xsl:if test="(document/config/parameter[@name='quicklinks']/option[@value='show']/@selected = 'true')">
		    		<div id="quicklinks">
		    		<h1 class="acc">Quick Links</h1>
		    		<h2>Quick Links</h2>
						<xsl:copy-of select="document/maincontent/quicklinks/node()" />
					</div>
					</xsl:if>	
					<div class="contact-info" role="complementary">
						<xsl:comment> com.omniupdate.div label="search" path="/includes/department.inc"</xsl:comment> 
						<xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/includes/department.inc"); ?</xsl:processing-instruction>
						<xsl:comment> /com.omniupdate.div </xsl:comment>
					</div>
					<span class="contact-info"><a class="sitemap_link" href="{$ou:sitepath}/siteindex.html">site index</a></span>
				</nav>
				<!-- end Secondary Navigation -->
				
				<h1 id="skiptocontent" class="acc">Main Content</h1>
				<div class="left">
					<!-- Banner Text -->
					
				<xsl:choose>
					<xsl:when test="(document/config/parameter[@name='slideshow']/option[@value='yes']/@selected = 'true')">
						<xsl:choose>
							<xsl:when test="not(document/maincontent/banner/slideshow/table)">
							<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
							<p>There is no slideshow added in this area. <br /> Please select the edit button and add a default slideshow using the insert snippet option on the toolbar.</p>
							</xsl:when>						
							<xsl:when test="not($ou:action = 'edt')">
							<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
							<xsl:call-template name="nivoslider" />
							</xsl:when>
							<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="not(document/maincontent/banner/slideshow/table)">
								<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
								<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
								<p>There is no slideshow added in this area. <br /> Please select the edit button and add a default slideshow using the insert snippet option on the toolbar.</p>
								</xsl:when>
								<xsl:otherwise>
								<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
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
						<xsl:if test="document/maincontent/banner/banner_caption != ''">
                            <div class="banner_text">
                                <h2 class="pagetitle acc"><xsl:copy-of select="document/title/node()" /></h2>
                                <div class="banner_caption subsite" role="complementary">
                                   <xsl:copy-of select="document/maincontent/banner/banner_caption/node()" />
                                </div>
                            </div>
                        </xsl:if>
			            <div class="banner_image_subsite" role="banner">
			            	<xsl:copy-of select="document/maincontent/banner/image/node()" />
			            </div>
			            </xsl:when>
			            <xsl:otherwise>
			            <div>
			                <h2 class="pagetitle acc"><xsl:copy-of select="document/title/node()" /></h2>
			                <div class="banner_caption subsite" role="complementary" style="background-color: grey; width: 660px;">
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

					<div class="content_wrapper">
						<xsl:choose>
						<xsl:when test="(document/config/parameter[@name='columns']/option[@value='1col']/@selected = 'true')">
							<h2 class="pagetitle"><xsl:copy-of select="document/title/node()" /></h2>
							<xsl:apply-templates select="/document/maincontent/column_two/node()" mode="copy" />
							
						</xsl:when>
						<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true') or (document/config/parameter[@name='columns']/option[@value='3col']/@selected = 'true')">
							<!-- Column 1 Wysiwyg -->
	                		<div class="left" role="region">
		            			
		                		<xsl:apply-templates select="/document/maincontent/column_one/node()" mode="copy" />
		                				                		
	                		</div>
	                		<xsl:choose>
		                		<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true')">
			                		
			                		<div class="right">
			                			<xsl:apply-templates select="/document/maincontent/column_two/node()" mode="copy" />
			                        </div>
			            			
		            			</xsl:when>
		            			<xsl:otherwise>
			            			<div class="right">
 										<div class="l" role="article">
 											
 											<xsl:apply-templates select="/document/maincontent/column_two/node()" mode="copy" />
 													                        
 										</div>
 										<div class="r" role="article">
                    						
                    						<xsl:apply-templates select="/document/maincontent/column_three/node()" mode="copy" />
                    						
                    					</div>
                    				</div>
		            			</xsl:otherwise>
	            			</xsl:choose>
						</xsl:when>
						</xsl:choose>
	        		</div>
        		</div>
			</div>
			<!-- Footer -->
			<div id="footer">
			<xsl:call-template name="footer_php" />
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
