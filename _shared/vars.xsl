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
    
    <!-- remove propsparams function, debug references, and modify breadcrumbs xsl if not using these 2 variables -->
    <xsl:param name="props-file" select="'_props.pcf'"/> 	
    <xsl:param name="props-path" select="concat($ou:root, $ou:site, $dirname, $props-file)"/>
    
    <xsl:param name="index-filename" select="'index.pcf'"/>
    <xsl:param name="index-path" select="concat($ou:root, $ou:site, $dirname, $index-filename)"/>
    
    <xsl:param name="dirname" select="if(string-length($ou:dirname) = 1) then $ou:dirname else concat($ou:dirname,'/')" />
    
    <xsl:param name="domain" select="substring($ou:httproot,1,string-length($ou:httproot)-1)" />				
    <xsl:param name="path" select="substring($ou:root,1,string-length($ou:httproot)-1)"/>
    
    <!-- set correct defaults so that dir var is optional -->
    <!-- optionally, remove dir var option by setting the parameter directly. -->
    <xsl:param name="serverType" select="ou:testVariable($ou:serverType,'php')"/> <!-- php or asp used by functions, nested nav xsl -->
    <xsl:param name="index-file" select="ou:testVariable($ou:index-file,'index')"/> <!-- index or default used by archive, breadcrumb, nested nav xsl -->
    <xsl:param name="extension" select="ou:testVariable($ou:extension,'html')"/> <!-- html, asp, php, etc. used by archive, baedcrumb, nested nav xsl -->
    
    <!-- Implementation Specific Variables (Directory Variables, Page Variables, Special Tests, Variable Precendence Tests) -->
    
    <!-- base directory variables (not required to be set in Access Settings) -->
    <xsl:param name="ou:production_root"/>	<!-- indicate the publishing subfolder used by ougalleries, nested-nav, functions xsl -->
    <xsl:variable name="production_root" select="if(string-length($ou:production_root)>0) then(concat('/',$ou:production_root)) else ''"/> <!-- used by debug, info tab. can also be used to include files. -->
    <xsl:param name="ou:serverType"/> 
    <xsl:param name="ou:index-file"/>
    <xsl:param name="ou:extension"/>
    
    <!-- other directory variables -->
    <xsl:param name="ou:nav-top-level"></xsl:param>
    <xsl:variable name="nav-top-level" select="if(string-length($ou:nav-top-level) &gt; 1) then $ou:nav-top-level else '/'"/>
    
    <!-- general page information -->
    <xsl:variable name="layout" select="ou:pcfparam('pagetype')"/>
    <xsl:variable name="pageTitle" select="/document/*:properties/title" />
    <xsl:variable name="galleryType" select="ou:assignVariable('galleryType','PrettyPhoto')"/>	
    
    <!-- other variables -->
    <xsl:param name="ou:includeDir">
        <xsl:choose>
            <xsl:when test="($ou:devSwitch = 'true')">
                http://dev.sjsu.edu/_resources/includes
            </xsl:when>
            <xsl:otherwise>
                http://www.sjsu.edu/_resources/includes
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    
</xsl:stylesheet>
