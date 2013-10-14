<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:ou="http://omniupdate.com/XSL/Variables"
xmlns:ouc="http://omniupdate.com/XSL/Variables"
exclude-result-prefixes="ou xsl xs">

	<xsl:import href="nivoslider.xsl" />
	<xsl:import href="siteindex.xsl" />
	<xsl:import href="breadcrumb.xsl" />
	<xsl:import href="common.xsl" />
	<xsl:import href="ou-variables.xsl" />

	<xsl:output method="html" version="5.0" cdata-section-elements="script"/>

	<!-- Start Copy Mode -->
	<xsl:template match="attribute()|element()|text()|comment()|processing-instruction()" mode="copy">
		<xsl:copy>
			<xsl:apply-templates select="attribute()|element()|text()|comment()|processing-instruction()" mode="copy"/>
		</xsl:copy>
	</xsl:template>
	<!-- End Copy Mode -->
	
	<!-- Start Processing Instruction for Copy Mode -->
	<xsl:template match="processing-instruction('php')" mode="copy">
		<xsl:text disable-output-escaping="yes">&lt;?php </xsl:text>
		<xsl:value-of select="." disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	<!-- End Pocessing Instruction for Copy Mode -->


	<!-- build the html output from the pcf-->
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="head"/>
				<xsl:call-template name="gacode"/>
			</head>
			<body>
				<!-- determines which class to assign to <body> based on the pagetype and columns parameters -->
				<xsl:choose>
					<xsl:when test="(document/config/parameter[@name='pagetype'] = 'home')">
						<xsl:attribute name="class">v1</xsl:attribute>
					</xsl:when>				
					<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true')">
						<xsl:attribute name="class">col-2</xsl:attribute>
					</xsl:when>
					<xsl:when test="(document/config/parameter[@name='columns']/option[@value='3col']/@selected = 'true')">
						<xsl:attribute name="class">col-3</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">col-1</xsl:attribute>
					</xsl:otherwise>	
				</xsl:choose>
<xsl:comment>googleoff: all</xsl:comment>
				<div id="skip" class="acc"><a href="#skiptocontent">Skip to Main Content</a></div>
				<div id="bg">
					<!-- emergency announcement page -->
					<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
						<xsl:value-of select="unparsed-text('http://www.sjsu.edu/oucampusemergency/index.html', 'utf-8')" disable-output-escaping="yes"/>
					</xsl:if>
					<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
						<xsl:comment> com.omniupdate.div label="alert" </xsl:comment> 
						<xsl:comment>#include virtual="/oucampusemergency/index.html" </xsl:comment>
						<xsl:comment> /com.omniupdate.div </xsl:comment>
					</xsl:if>
					<!-- /emergency announcement page -->
					<div id="container">
						<!-- determines which class to assign to <container> based on the pagetype parameters -->
						<xsl:attribute name="class">
							<xsl:if test="(document/config/parameter[@name='fullwidth']/option[@value='yes']/@selected = 'true')">fullwidth </xsl:if>													
							<xsl:if test="(document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'top-level-interior')">toplevel </xsl:if>
						</xsl:attribute>

						<a href="http://www.sjsu.edu" id="sjsuhomelink"></a>
						<a href="http://www.sjsu.edu/sjsuhome/sjsu-feature" id="doodlelink"></a>
						<div role="banner">
							<xsl:choose><!-- assigns an ID based on if it's a top level page -->
								<xsl:when test="(document/config/parameter[@name='pagetype'] = 'home') or (document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'top-level_interior')">
									<xsl:attribute name="id" select="string('top_home')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="id" select="string('top_subsite')" />
								</xsl:otherwise>									
							</xsl:choose>
							<div class="left">
								<xsl:choose>
									<xsl:when test="(document/config/parameter[@name='pagetype'] = 'home') or (document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'top-level_interior')">
										<a href="http://www.sjsu.edu" class="btn_logo" title="San José State University"><h1>San José State University</h1></a>									
									</xsl:when>
									<xsl:otherwise>
										<a href="{$ou:sitepath}/"><h1 class="subsite_name"><xsl:value-of select="$ou:subsite"/></h1></a>
										<span class="subsitetitle">San José State University</span>
										<xsl:if test="$ou:encunitlink != ''">
											<a href="{$ou:encunitlink}"><span>
												<xsl:choose>
													<xsl:when test="(string-length($ou:enclosingunit) &lt; 37)">
														<xsl:attribute name="class">subsite_enclosingunit</xsl:attribute>
													</xsl:when>
													<xsl:otherwise>
														<xsl:attribute name="class">subsite_enclosingunit_wrapped</xsl:attribute>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:value-of select="$ou:enclosingunit"/>										
											</span></a>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</div><!-- /logo and sitename -->
					        <div class="right">

									<xsl:call-template name="search"/>

	        				</div><!-- /search -->
						</div><!-- /[banner] -->
						<h2 class="acc">Site Navigation</h2>
						<nav class="nav-main" role="navigation">
							<xsl:call-template name="mainnav" />
						</nav><!-- /main site navigation menu -->
						<!-- load breadcrumbs -->
						<xsl:if test="(document/config/parameter[@name='pagetype'] != 'home')">
							<div id="breadcrumb">
								<xsl:call-template name="bc">
									<xsl:with-param name="path" select="$ou:dirname"/>								
								</xsl:call-template>
							</div><!-- /#breadcrumb -->
						</xsl:if>
						<div id="content" role="main">
<xsl:comment>googleon: all</xsl:comment>							
							<xsl:if test="(document/config/parameter[@name='pagetype'] != 'home') and (document/config/parameter[@name='pagetype'] != 'subhome')">
								<h1 class="pagetitle" id="scrolltotop"><xsl:value-of select="document/title" /></h1>
							</xsl:if>
<xsl:comment>googleoff: all</xsl:comment>
							<xsl:if test="(document/config/parameter[@name='fullwidth']/option[@value='yes']/@selected = 'true')">
								<nav class="secnavalt" role="navigation">
									<h2>Navigate</h2>
									<a class="back_up_level" href="../"><span class="navarrowback"><!-- &nbsp; --></span>BACK to <xsl:value-of select="$back2" /></a>
								</nav>
							</xsl:if>							
							<xsl:if test="(document/config/parameter[@name='pagetype'] != 'home') and (not(document/config/parameter[@name='fullwidth']/option[@value='yes']/@selected = 'true'))">
							<!-- load the quickicons, social media links and secondary navigation for every pagetype but the homepage -->

								<div class="sidebar">
								<xsl:call-template name="quickicons" />
								<xsl:call-template name="socialmedia" />
								<xsl:call-template name="secondarynavigation" />
								</div><!-- /.sidebar -->
							</xsl:if>							
							<xsl:if test="(document/config/parameter[@name='pagetype'] = 'home') or (document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'subhome')">
								<xsl:call-template name="bannerarea" />
							</xsl:if>
							<xsl:if test="(document/config/parameter[@name='pagetype'] = 'home')">
								<!-- load the quickicons and social media links sooner if it's the campus homepage -->
								<xsl:call-template name="quickicons" />
								<xsl:call-template name="socialmedia" />
								<xsl:call-template name="homepagequicklinks" />
							</xsl:if>							
							<div class="content_wrapper"><!-- contains the 1/2/3 columns of user-editable content -->
								<xsl:if test="(document/config/parameter[@name='pagetype'] = 'staff')">
									<xsl:attribute name="role" select="string('directory')" />
								</xsl:if>
								<div class="left"><!-- see Footnote A -->
<xsl:comment>googleon: all</xsl:comment>
									<xsl:choose>
										<xsl:when test="(document/config/parameter[@name='pagetype'] = 'forms') or (document/config/parameter[@name='pagetype'] = 'staff') or (document/config/parameter[@name='pagetype'] = 'news') or (document/config/parameter[@name='pagetype'] = 'siteindex')">
											<xsl:call-template name="onecolumn" />
										</xsl:when>
										<xsl:when test="(document/config/parameter[@name='columns']/option[@value='1col']/@selected = 'true')">
											<xsl:copy-of select="document/maincontent/column_two/node()" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:copy-of select="document/maincontent/column_one/node()" />
										</xsl:otherwise>
									</xsl:choose>
								</div><!-- .left -->
								<xsl:if test="(document/config/parameter[@name='columns']/option[@value='1col']/@selected != 'true') and (document/config/parameter[@name='pagetype'] != 'onecolumn')">
									<!-- loads an additional set of <div>s if 2col or 3col layout -->
									<xsl:choose>
										<xsl:when test="(document/config/parameter[@name='columns']/option[@value='2col']/@selected = 'true')">
											<!-- loads column_two for the 2col configuration-->
											<div class="right">
												<xsl:copy-of select="document/maincontent/column_two/node()" />
											</div>
										</xsl:when>
										<xsl:otherwise>
											<!-- loads column_two and column_three -->
											<div class="middle">
												<xsl:copy-of select="document/maincontent/column_two/node()" />
											</div><!-- /.middle -->
											<div class="right">
												<xsl:copy-of select="document/maincontent/column_three/node()" />
											</div><!-- /.right -->
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</div><!-- /.content_wrapper -->
						</div><!-- /#content -->
						<div id="footer">
<xsl:comment>googleoff: all</xsl:comment>
							<h2 class="acc">SJSU Links and Resources</h2>							
							<xsl:call-template name="footer" />
<xsl:comment>googleon: all</xsl:comment>							
						</div><!-- end Footer -->
					</div><!-- /#container -->
				</div><!-- /#bg -->
				<xsl:call-template name="scripts" />
				<xsl:if test="(document/config/parameter[@name='pagetype'] = 'home')">
					<xsl:call-template name="campustour" />
				</xsl:if>
				<xsl:if test="document/colorbox">
					<xsl:call-template name="colorboxStrategicPlan" />
				</xsl:if>
				<xsl:copy-of select="document/footcode/node()" />				
			</body>
		</html>

	</xsl:template>

</xsl:stylesheet>
<!--
Footnote A:
Depending on whether the page configured to be 1, 2 or 3 columns, the following HTML structure is built differently.
The xml node column_two always holds the primary page content and is visible in every layout option (1col, 2col, 3col). In 1col, column_two is 660px wide.
column_one is always the thinner sidebar on the left (often containing a calendar) and is visible in 2col and 3col. When present, column_two is reduced in width to 460px.
column_three appears only in 3col. When present, column_two is reduced in width to 220px
Special templates (forms, staff, news) load additional content where necessary.
-->
