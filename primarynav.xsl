<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou xsl xs">
<xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="yes" indent="yes"/>

<!-- Initialize OU Variables -->
<xsl:param name="ou:action" />
<xsl:param name="ou:dirname" /> 
<xsl:param name="ou:filename" />
<xsl:param name="ou:path" />
<xsl:param name="ou:site" />
<xsl:param name="ou:sitepath" />
<xsl:param name="ou:root" />

<xsl:variable name="root" as="xs:string" select="concat($ou:root, $ou:site)"/>
<xsl:variable name="path" as="xs:string" select="concat($ou:root,$ou:site,$ou:dirname,'/')" />
<xsl:variable name="excludedDir" as="xs:string" select="'_resources,OMNI-ASSETS,OMNI-RESOURCES,includes,_trash,assets,docs,pics,links,OMNI-INF,_configuration,_specialcontent'" />

<xsl:template match="/">
<ul id="topnav">
		<xsl:call-template name="topnav">	
			<xsl:with-param name="currentPath" select="$root"/>
		</xsl:call-template>
</ul>	
</xsl:template>

<!-- builds the top Navigation based on the folders in the root of the site whose index page have sitemap="yes" 
Aso includes directory's sidenav.inc file for drop down-->
<xsl:template name="topnav">
<xsl:param name="currentPath" />
	 	
	 	<xsl:for-each select="doc($currentPath)/list/directory" >	 		
	 		<xsl:sort select="if(doc-available(concat($currentPath, '/' , . , '/index.pcf'))) then (document(concat($currentPath, '/' , . , '/index.pcf'))/document/config/parameter[@name='primarynav']) else ''" order="ascending" />

	 		
	 		<xsl:variable name="index" select="concat($currentPath, '/' , . , '/index.pcf')"/>
	 		<xsl:variable name="child" select="concat($currentPath,'/',.)"/>
	 		<xsl:if test="doc-available($index)  and not(contains($index, 'trash'))">
	 		<xsl:if test="(document($index)/document/config/parameter[@name='primarynav'] != '')">
	 		<xsl:choose>
			<xsl:when test="doc($child)/list/directory != ''">
			<li><a>
	 		<xsl:attribute name="href"><xsl:value-of select="concat($ou:sitepath,'/',.,'/')"/></xsl:attribute>
	 		<h2 class="navname"><xsl:value-of select="document($index)/document/title" /></h2>
	 		<span class="navarrow">&nbsp;</span></a>
	 		
	 		<div class="sub">
	 			<ul><xsl:comment> com.omniupdate.div label="<xsl:value-of select="."/>" path="<xsl:value-of select="concat('/',.,'/sidenav.inc')"/>" </xsl:comment>

	 				<xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,'/',.,'/sidenav.inc')"/>"</xsl:comment>

	 				<xsl:comment> /com.omniupdate.div </xsl:comment>	 				
	 			</ul>
	 		</div>
	 		
	 		</li>
	 		</xsl:when>
	 		<xsl:otherwise>
	 		<li><a>
	 		<xsl:attribute name="href"><xsl:value-of select="concat($ou:sitepath,'/',.,'/')"/></xsl:attribute>
	 		<h2 class="navname"><xsl:value-of select="document($index)/document/title" /></h2></a>
	 		</li>
	 		</xsl:otherwise>
	 		</xsl:choose>
			</xsl:if>
			</xsl:if>
		</xsl:for-each>
 
</xsl:template>


<!-- builds the top Navigation based on the folders in the root of the site whose index page have sitemap="yes" 
Aso includes directory's sidenav.inc file for drop down as php includes-->
<xsl:template name="topnavphp">
<xsl:param name="currentPath" />
	 	<xsl:for-each select="doc($currentPath)/list/directory" >	 		
	 		<xsl:sort select="if(doc-available(concat($currentPath, '/' , . , '/index.pcf'))) then (document(concat($currentPath, '/' , . , '/index.pcf'))/document/config/parameter[@name='primarynav']) else ''" order="ascending" />

	 		<xsl:variable name="index" select="concat($currentPath, '/' , . , '/index.pcf')"/>
	 		<xsl:variable name="child" select="concat($currentPath,'/',.)"/>
	 		<xsl:if test="doc-available($index)">
	 		<xsl:if test="(document($index)/document/config/parameter[@name='primarynav'] != '')">
	 		<xsl:choose>
			<xsl:when test="doc($child)/list/directory != ''">
			<li><a>
	 		<xsl:attribute name="href"><xsl:value-of select="concat($ou:sitepath,'/',.,'/')"/></xsl:attribute>
	 		<h2 class="navname"><xsl:value-of select="document($index)/document/title" /></h2>
	 		<span class="navarrow">&nbsp;</span></a>
	 		
	 		<div class="sub">
	 			<ul><xsl:comment> com.omniupdate.div label="<xsl:value-of select="."/>" path="<xsl:value-of select="concat('/',.,'/sidenav.inc')"/>" </xsl:comment>
	 				<xsl:processing-instruction name="php"> include( $_SERVER["DOCUMENT_ROOT"] . "<xsl:value-of select="concat($ou:sitepath,'/',.,'/sidenav.inc')"/>"); ?</xsl:processing-instruction>
	 				<xsl:comment> /com.omniupdate.div </xsl:comment>	 				
	 			</ul>
	 		</div>
	 		
	 		</li>
	 		</xsl:when>
	 		<xsl:otherwise>
	 		<li><a>
	 		<xsl:attribute name="href"><xsl:value-of select="concat($ou:sitepath,'/',.,'/')"/></xsl:attribute>
	 		<h2 class="navname"><xsl:value-of select="document($index)/document/title" /></h2></a>
	 		</li>
	 		</xsl:otherwise>
	 		</xsl:choose>
			</xsl:if>
			</xsl:if>
		</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
