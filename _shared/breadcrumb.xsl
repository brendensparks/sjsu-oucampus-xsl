<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:ou="http://omniupdate.com/XSL/Variables" 
	exclude-result-prefixes="xs ou">

<xsl:variable name="root" as="xs:string" select="concat('/usr/local/omni/oucampus-sjsu/sjsu/', $ou:site)" />
<xsl:variable name="file" as="xs:string">index.pcf</xsl:variable>
<xsl:variable name="domainroot" select="concat($ou:httproot,$ou:site)" />
<xsl:variable name="bcRoot">
	<xsl:value-of select="replace($domainroot, '/[^/]+$', '')" />
</xsl:variable>

<xsl:template name="bc">
	<!-- initiates parameters, sets a default value if no parameters were passed in -->
	<xsl:param name="path" as="xs:string">/</xsl:param>
	<xsl:param name="title" as="xs:string">New Page</xsl:param>
	
	<xsl:call-template name="bc-folders">
		<xsl:with-param name="path" select="$path"/>
	</xsl:call-template>
	
<!--	&gt;&#160;<xsl:copy-of select="document/title/text()" />-->
	
</xsl:template>

<xsl:template name="bc-folders">
	<xsl:param name="path" as="xs:string" required="yes"/>
		
	<xsl:if test="$path != '/'">
		<xsl:variable name="list" select="tokenize(substring($path, 2), '/')"/>
		<xsl:variable name="parent" select="concat('/', string-join(remove($list, count($list)), '/'))"/>
		<xsl:call-template name="bc-folders">
			<xsl:with-param name="path" select="$parent"/>
		</xsl:call-template>
	</xsl:if>
	
	<xsl:variable name="href" select="if ($path = '/') then $path else concat($path, '/')"/>
	<!--<xsl:variable name="bchref" select="if ($href = '/') then concat('/',$ou:site,$path) else concat('/',$ou:site, $path, '/')"/>-->
	<xsl:variable name="bchref">
	<xsl:choose>
		<xsl:when test="($href = '/')">
			<xsl:value-of select="concat('/',$ou:site,$path, '/')" />
		</xsl:when>
		<xsl:when test="($ou:sitepath = '')">
			<xsl:value-of select="concat($bcRoot,$path)" />
		</xsl:when>
		<xsl:when test="($ou:sitepath != '')">
			<xsl:value-of select="concat('/',$ou:site, $path, '/')" />
		</xsl:when>
	</xsl:choose>
	</xsl:variable>
	<xsl:choose>
		<xsl:when test="$path = '/' and $ou:sitepath = ''">
			<a href="http://www.sjsu.edu/">SJSU Home</a><span class="bc-spacer">&gt;</span><a href="{$ou:httproot}"><xsl:value-of select="$ou:subsite" /></a>
		</xsl:when>	
		<xsl:when test="$path = '/' and $ou:sitepath != ''">
			<a href="http://www.sjsu.edu/">SJSU Home</a><span class="bc-spacer">&gt;</span><a href="{$ou:sitepath}"><xsl:value-of select="$ou:subsite" /></a>
		</xsl:when>
		<xsl:otherwise>
			<span class="bc-spacer">&gt;</span><a href="{$bchref}"><xsl:value-of select="doc(concat($root, $href, $file))/document/title/text()"/></a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>

