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

    <xsl:variable name="root" as="xs:string" select="concat($ou:root,$ou:site,$ou:production_root)"/>

    <xsl:variable name="section-index-filename" select="concat($index-file,'.',$extension)"/>
    <xsl:variable name="section-nav-filename" select="'_sidenav.inc'"/>
    
    <xsl:variable name="subpath" select="substring-after($ou:httproot, 'omniupdate.com')" />
    <xsl:variable name="subsite" select="if ($subpath = '/') then '' else substring($subpath, 1, string-length($subpath)-1)" />
    <xsl:variable name="nav-file">_sidenav.inc</xsl:variable>
    
    <xsl:template name="nested-nav">
        <xsl:variable name="parent" select="ou:findPrevDir($dirname)" />
            <xsl:if test="not($dirname = '/')">
                <ul id="parent_nav" class="side-nav">
                    <xsl:comment> ouc:div label="nest-parent" path="<xsl:value-of select="concat($parent, $nav-file)" />" </xsl:comment> 
                    <xsl:comment>#include virtual="<xsl:value-of select="concat($subsite, $parent, $nav-file)" />" </xsl:comment>
                    <xsl:processing-instruction name="php">	include($_SERVER['DOCUMENT_ROOT'] . "<xsl:value-of select="concat($subsite, $parent, $nav-file)" />"); ?</xsl:processing-instruction>
                    <xsl:comment> /ouc:div </xsl:comment>
                </ul>
            </xsl:if>	
        <ul id="child_nav" class="side-nav">
                <xsl:comment> ouc:div label="nest-child" path="<xsl:value-of select="concat($dirname, $nav-file)" />" </xsl:comment> 
                <xsl:processing-instruction name="php">	include($_SERVER['DOCUMENT_ROOT'] . "<xsl:value-of select="concat($subsite,$dirname, $nav-file)" />"); ?</xsl:processing-instruction>
                <xsl:comment> /ouc:div </xsl:comment>
         </ul>
    </xsl:template>

   

</xsl:stylesheet>