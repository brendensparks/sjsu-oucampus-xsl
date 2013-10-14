<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              xmlns:ou="http://omniupdate.com/XSL/Variables" exclude-result-prefixes="ou">

<xsl:output omit-xml-declaration="yes" />
<xsl:strip-space elements="*" />

<xsl:param name="ou:action" />

<xsl:template name="nivosliderhome" match="/">

<div id="slider-wrapper" class="home-slider-wrapper">
<div class="nivo-caption-arrow"></div>
	<div id="slider" class="home-slider nivoslider">
		<xsl:for-each select="document/maincontent/banner/slideshow/table/tbody/tr">
			<xsl:if test="not(./th)">
				<img>
					<xsl:attribute name="src" ><xsl:value-of select="./td[1]/img/@src" /></xsl:attribute>
					<xsl:attribute name="alt" ><xsl:value-of select="./td[1]/img/@alt" /></xsl:attribute>
					<xsl:attribute name="title" ><xsl:value-of select="concat('#htmlcaption',position()-1)" /></xsl:attribute>
				</img>
			</xsl:if>		
		</xsl:for-each>
	</div>
	<xsl:for-each select="document/maincontent/banner/slideshow/table/tbody/tr">
	<xsl:if test="not(./th) and (./td[2] !='' or ./td[3] !='')">
	<div>
		<xsl:attribute name="id" ><xsl:value-of select="concat('htmlcaption',position()-1)" /></xsl:attribute>
		<xsl:attribute name="class" >nivo-html-caption</xsl:attribute>
		<xsl:attribute name="role" >complementary</xsl:attribute>
			<h3><xsl:value-of select="./td[2]" /></h3>
			<p><xsl:copy-of select="./td[3]/node()" /></p>
	</div>
	</xsl:if>		
	</xsl:for-each>
</div>			
</xsl:template>

<xsl:template name="gallery" match="/">

<div id="gallery">
	<ul>
		<xsl:for-each select="document/maincontent/banner/gallery/img">
			<xsl:if test="position() = 1">
				<li>
				<a><xsl:attribute name="class">btn_imgthumb</xsl:attribute>
					<xsl:attribute name="href" ><xsl:value-of select="./@src" /></xsl:attribute>
					<xsl:attribute name="title" ><xsl:value-of select="./@alt" /></xsl:attribute>
					Explore SJSU Campus Tour
				</a></li>
			</xsl:if>	
			<xsl:if test="position() gt 1">		
				<li>
				<xsl:attribute name="class">hide</xsl:attribute>
					<a>
					<xsl:attribute name="href" ><xsl:value-of select="./@src" /></xsl:attribute>
					<xsl:attribute name="title" ><xsl:value-of select="./@alt" /></xsl:attribute>
				</a></li>
			</xsl:if>
		</xsl:for-each>
	</ul>
</div>			
</xsl:template>
</xsl:stylesheet>

