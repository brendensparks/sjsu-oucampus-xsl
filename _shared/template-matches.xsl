<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
]>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ou="http://omniupdate.com/XSL/Variables"
	xmlns:ouc="http://omniupdate.com/XSL/Variables" exclude-result-prefixes="xs ou ouc">
	
	<xsl:template match="ouc:*[$ou:action !='edt']" mode="copy side-col banner">
		<xsl:apply-templates mode="#current" />
	</xsl:template>
	
	<xsl:template match="ouc:div" mode="copy side-col banner">
		<xsl:copy>
			<xsl:attribute name="wysiwyg-class"><xsl:value-of select="$bodyClass" /></xsl:attribute>
			<xsl:apply-templates select="attribute()|node()" mode="#current" />
		</xsl:copy>
	</xsl:template>
	
	<!--<xsl:template match="ouc:editor" mode="copy">
		<xsl:copy>
			<xsl:attribute name="wysiwyg-class"><xsl:value-of select="concat($bodyClass, ' ', @wysiwyg-class)" /></xsl:attribute>
			<xsl:apply-templates select="@*[not(name()='wysiwyg-class')]|node()" mode="copy" />
		</xsl:copy>
	</xsl:template>-->
	
	<!-- The following template matches all items except processing instructions, copies them, then processes any children. -->
	<xsl:template match="attribute()|text()|comment()" mode="copy banner side-col polls">
		<xsl:copy />
	</xsl:template>
	
	<xsl:template match="element()" mode="copy banner side-col polls">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="attribute()|node()" mode="#current"/>
		</xsl:element>
	</xsl:template>
	
	<!-- The following template matches processing instructions, outputs the proper syntax with the code escaped properly. -->
	<xsl:template match="processing-instruction()" mode="copy side-col banner">
		<xsl:processing-instruction name="php">
			<xsl:value-of select="." disable-output-escaping="yes" />
			?</xsl:processing-instruction>
	</xsl:template>
	
	<!-- Visual warning for broken dependencies tags -->
	<xsl:template match="a[contains(@href,'*** Broken')]" mode="copy banner side-col">
		<a href="{@href}" style="color: red;"><xsl:value-of select="."/></a> <span style="color: red;">[BROKEN LINK]</span>
	</xsl:template>
	
</xsl:stylesheet>
