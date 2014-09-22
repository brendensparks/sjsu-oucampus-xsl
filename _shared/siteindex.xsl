<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ou="http://omniupdate.com/XSL/Variables"
    exclude-result-prefixes="xs ou">
    <xsl:output method="html" version="5.0" />
    
    <xsl:param name="ou:action" />
    <xsl:param name="ou:dirname" />
    <xsl:param name="ou:filename" />
    <xsl:param name="ou:httproot" />
    <xsl:param name="ou:path" />
    <xsl:param name="ou:root" />
    <xsl:param name="ou:site" />
    
    <!-- stores string of all file paths -->
    <xsl:variable name="allfiles">
        <xsl:call-template name="getAllFiles">	
            <xsl:with-param name="currentPath" select="$root"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:template name="siteindex">
        
        <xsl:for-each-group select="tokenize($allfiles,',')[position() != last()]" group-by="upper-case(substring(document(.)/document/title,1,1))">
            
            <xsl:sort select="current-grouping-key()" />
            <xsl:variable name="groupkey" select="current-grouping-key()" />
            <h3 class="doc_col_header" id="{$groupkey}"><xsl:value-of select="$groupkey" /></h3>
            <ul class="doc_index">
                <xsl:for-each select="current-group()">
                    
                    <xsl:sort select="document(.)/document/title" />
                    
                    <xsl:variable name="pageloc" >
                        <xsl:value-of select="concat($ou:sitepath,replace(substring-after(.,$root),'pcf','html'))"/> 
                    </xsl:variable>
                    
                    <!--<xsl:value-of select="$pageloc" />-->
                    <li class="doc_col">
                        <a href="{$pageloc}">
                            <span class="rdoc">
                                <span class="rdoc_name">
									<xsl:value-of select="document(.)/document/title" />
									<xsl:if test="document(.)/config/parameter[@name='subtitle']">
										<xsl:value-of select="document(.)/config/parameter[@name='subtitle']" />
									</xsl:if>								
								</span>
                            </span>
                        </a></li>
                    
                </xsl:for-each>
                <li class="backtotop"><a href="#scrolltotop">
                    <span class="rdoc">
                        Back to top
                    </span>
                </a></li> 
            </ul>
        </xsl:for-each-group>
        
    </xsl:template>
    
    <!-- Site Index Filter generates the Alpha listing in the sidebar -->
    <xsl:template name="siteindexfilter">
        <ul>
            <xsl:for-each-group select="tokenize($allfiles,',')[position() != last()]" group-by="upper-case(substring(document(.)/document/title,1,1))">
                <xsl:sort select="current-grouping-key()" />
                <xsl:variable name="groupkey" select="current-grouping-key()" />
                <li><a href='#{$groupkey}'><xsl:value-of select="$groupkey" /></a></li>	
            </xsl:for-each-group>
        </ul>
    </xsl:template>
    
    <!-- template that returns a string of all of the filepaths in the directory -->
    <xsl:template name="getAllFiles">
        <xsl:param name="currentPath" />       
      <xsl:analyze-string select="tokenize($currentPath,'/')[last()]" regex="{$excludedDir}">          
            <xsl:non-matching-substring>        
            <xsl:for-each select="doc($currentPath)/list/file">
                <xsl:if test="contains(.,'.pcf') and document(concat($currentPath,'/',.))/document/config/parameter[@name='sitemap']/option[@value='yes']/@selected='true'
                    and document(concat($currentPath,'/',.))/document/title != ''">
                    <xsl:value-of select="concat($currentPath,'/',.,',')" />
                </xsl:if>
            </xsl:for-each>	
            <xsl:for-each select="doc($currentPath)/list/directory">
                <xsl:call-template name="getAllFiles">
                    <xsl:with-param name="currentPath" select="concat($currentPath,'/',.)" />		
                </xsl:call-template>
            </xsl:for-each>	
        </xsl:non-matching-substring> 
        </xsl:analyze-string>
    </xsl:template>
    
</xsl:stylesheet>
