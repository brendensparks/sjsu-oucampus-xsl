<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ou="http://omniupdate.com/XSL/Variables"
  exclude-result-prefixes="xs ou">
<xsl:output method="xml" indent="yes" />
<xsl:strip-space elements="*" />

<xsl:param name="ou:action" />
<xsl:param name="ou:dirname" />
<xsl:param name="ou:filename" />
<xsl:param name="ou:httproot" />
<xsl:param name="ou:path" />
<xsl:param name="ou:root" />
<xsl:param name="ou:site" />

<xsl:param name="ou:websiteurl" />
<xsl:variable name="sjsuwebsiteurl">
    <xsl:choose>
      <!-- if no value, default to 'www.sjsu.edu' -->
      <xsl:when test="not($ou:websiteurl)"> 
		  <xsl:value-of select="'http://www.sjsu.edu/'" />
      </xsl:when>
      <!-- else use provided value -->
     <xsl:when test="$ou:websiteurl">
     	<xsl:value-of select="$ou:websiteurl"/>
     </xsl:when>                       
   </xsl:choose>
</xsl:variable>
      
      
<xsl:variable name="root" as="xs:string" select="concat($ou:root, $ou:site)"/>
<xsl:variable name="path" as="xs:string" select="concat($ou:root,$ou:site,$ou:dirname,'/')" />
<xsl:variable name="excludedDir" as="xs:string" select="'_resources|OMNI-ASSETS|OMNI-RESOURCES|includes|_trash|assets|docs|pics|links|OMNI-INF|_configuration|_specialcontent'" />
<xsl:variable name="httproot" select="12"/>

<xsl:template match="/">
	<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
		<xsl:call-template name="archive">	
			<xsl:with-param name="currentPath" select="$root"/>
		</xsl:call-template>
	</urlset>
</xsl:template>

<xsl:template name="archive">
	<xsl:param name="currentPath" />
	<xsl:analyze-string select="tokenize($currentPath,'/')[last()]" regex="{$excludedDir}">          
            <xsl:non-matching-substring>
		
	 	<xsl:for-each select="doc($currentPath)/list/file">					
			<xsl:call-template name="file">
				<xsl:with-param name="currentPath" select="substring-after($currentPath,concat($ou:root,$ou:site,'/'))" />
			</xsl:call-template>				
	 	</xsl:for-each>	
	 	<xsl:for-each select="doc($currentPath)/list/directory">
	 		<xsl:sort order="ascending" />
	 		<xsl:call-template name="archive">
				<xsl:with-param name="currentPath" select="concat($currentPath,'/',.)" />			
			</xsl:call-template>
		</xsl:for-each>		 	
		 	
 	 </xsl:non-matching-substring> 
        </xsl:analyze-string>
</xsl:template>

<xsl:template name="directory">
  Directory: <xsl:value-of select="."/><br/>
</xsl:template>

<xsl:template name="file" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
	<xsl:param name="currentFile" as="xs:string" select="$path" />
	<xsl:param name="currentPath" />
	<xsl:if test="contains(.,'.pcf')">
	<xsl:choose>
	<xsl:when test="$currentPath = ''">
		<xsl:if test="document(concat($root,'/',.))/document/config/parameter[@name='sitemap']/option[@value='yes']/@selected='true'" >
		<!-- <url><loc><xsl:value-of select="concat($ou:httproot,replace(.,'pcf','html'))" /></loc></url> -->
		<url><loc><xsl:value-of select="concat($sjsuwebsiteurl,$ou:site,'/',replace(.,'pcf','html'))" /></loc></url>

		</xsl:if>
	</xsl:when>
	<xsl:otherwise>
		<xsl:if test="document(concat($root,'/',$currentPath,'/',.))/document/config/parameter[@name='sitemap']/option[@value='yes']/@selected='true'" >
		<!-- <url><loc><xsl:value-of select="concat($ou:httproot,$currentPath,'/',replace(.,'pcf','html'))" /></loc></url> -->
		<url><loc><xsl:value-of select="concat($sjsuwebsiteurl,$ou:site,'/',$currentPath,'/',replace(.,'pcf','html'))" /></loc></url>
		</xsl:if>
	</xsl:otherwise>
	</xsl:choose>
	</xsl:if>

</xsl:template>
</xsl:stylesheet>
