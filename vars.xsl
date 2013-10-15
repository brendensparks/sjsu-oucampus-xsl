<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<!-- 
IMPLEMENTATION VARIABLES for Kitchen Sink v2
Define global implementation variables here, so that they may be accessed by all page types and in the info/debug tabs.
This also provides a convenient area for complicated logic to exist without clouding up the general xsl/html structure.

Contributors: Your Name Here
Last Updated 4/2013
-->
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ou="http://omniupdate.com/XSL/Variables"
    xmlns:fn="http://omniupdate.com/XSL/Functions"
    xmlns:ouc="http://omniupdate.com/XSL/Variables"
    exclude-result-prefixes="ou xsl xs fn ouc">
    
	<xsl:import href="ou-variables.xsl"/> <!-- system variables -->
		
	<!-- 
	
	Utility Variables (depended on by utility xsls for consistency and flexbility)
	
	-->
	
	<!-- remove propsparams function, debug references, and modify breadcrumbs xsl if not using these 2 variables -->
	<xsl:param name="props-file" select="'_props.pcf'"/> 	
	<xsl:param name="props-path" select="concat($ou:root, $ou:site, $dirname, $props-file)"/>		
	
	<xsl:param name="dirname" select="if(string-length($ou:dirname) = 1) then $ou:dirname else concat($ou:dirname,'/')" />
	
	<xsl:param name="domain" select="substring($ou:httproot,1,string-length($ou:httproot)-1)" />				
	<xsl:param name="path" select="substring($ou:root,1,string-length($ou:httproot)-1)"/>

	<!-- set correct defaults so that dir var is optional -->
	<!-- optionally, remove dir var option by setting the parameter directly. -->
	<xsl:param name="serverType" select="ou:testVariable($ou:serverType,'php')"/> <!-- php or asp used by functions, nested nav xsl -->
	<xsl:param name="index-file" select="ou:testVariable($ou:index-file,'index')"/> <!-- index or default used by archive, breadcrumb, nested nav xsl -->
	<xsl:param name="extension" select="ou:testVariable($ou:extension,'html')"/> <!-- html, asp, php, etc. used by archive, baedcrumb, nested nav xsl -->

	<!-- 
	
	Implementation Specific Variables (Directory Variables, Page Variables, Special Tests, Variable Precendence Tests) 
	
	-->
	
	<!-- base directory variables (not required to be set in Access Settings) -->
	<xsl:param name="ou:production_root"/>	<!-- indicate the publishing subfolder used by ougalleries, nested-nav, functions xsl -->
		<xsl:variable name="production_root" select="if(string-length($ou:production_root)>0) then(concat('/',$ou:production_root)) else ''"/> <!-- used by debug, info tab. can also be used to include files. -->
	<xsl:param name="ou:serverType"/> 
	<xsl:param name="ou:index-file"/>
	<xsl:param name="ou:extension"/>
	
	<!-- other directory variables -->
	




	<!-- general page information -->
	<xsl:variable name="pageType" select="ou:pcfparam('pagetype')"/>
	<xsl:variable name="pageTitle" select="/document/*:properties/title" />
	<xsl:variable name="galleryType" select="ou:assignVariable('galleryType','PrettyPhoto')"/>	
			
	<!-- other variables -->



						
	
</xsl:stylesheet>
