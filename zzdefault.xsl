<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou xsl xs">

<xsl:import href="home.xsl" />
<xsl:import href="nivoslider.xsl" />
<xsl:import href="nivosliderhome.xsl" />
<xsl:import href="subhome.xsl" />
<xsl:import href="subhome_php.xsl" />
<xsl:import href="tophome.xsl" />
<xsl:import href="tophome_php.xsl" />
<xsl:import href="interior.xsl" />
<xsl:import href="interior_php.xsl" />
<xsl:import href="top-level_interior.xsl" />
<xsl:import href="top-level_interior_php.xsl" />
<xsl:import href="onecolumn.xsl" />
<xsl:import href="onecolphp.xsl" />
<xsl:import href="siteindex.xsl" />
<xsl:import href="footer.xsl" />
<xsl:import href="zzbreadcrumb.xsl" />
<xsl:import href="redirect.xsl" />

<xsl:output method="html" version="5.0" cdata-section-elements="script"/>

<!-- Initialize OU Variables -->
<xsl:param name="ou:action" />
<xsl:param name="ou:dirname" /> 
<xsl:param name="ou:filename" />
<xsl:param name="ou:path" />
<xsl:param name="ou:site" />
<xsl:param name="ou:facebookAcc" />
<xsl:param name="ou:twitterAcc" />
<xsl:param name="ou:rssAcc" />
<xsl:param name="ou:subsite" />
<xsl:param name="ou:enclosingunit" />
<xsl:param name="ou:encunitlink" />
<xsl:param name="ou:sitepath" />
<xsl:param name="ou:root" />
<xsl:param name="ou:ftproot" />
<xsl:param name="rssfeed" />
<xsl:param name="rssfeeditems" />
<xsl:param name="rssfeedtitle" />
<xsl:param name="ou:externalinc"/>

<!-- Parameters used by imported stylesheets -->
<xsl:param name="dirname">
	<xsl:choose>
		<xsl:when test="string-length($ou:dirname) = 1">
			<xsl:value-of select="$ou:dirname" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($ou:dirname,'/')" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:param>

<!-- variables used by imported stylesheets -->
<xsl:variable name="root" as="xs:string" select="concat($ou:root, $ou:site)"/>
<xsl:variable name="path" as="xs:string" select="concat($ou:root,$ou:site,$ou:dirname,'/')" />
<xsl:variable name="excludedDir" as="xs:string" select="'_resources|OMNI-ASSETS|OMNI-RESOURCES|includes|_trash|assets|docs|pics|links|OMNI-INF|_configuration|_specialcontent|images'" />
<xsl:variable name="httproot" select="12"/>

<!-- define the parent-path for backto link-->
<xsl:variable name="parent-path">
	<xsl:value-of select="replace($ou:dirname, '/[^/]+$', '')" />
</xsl:variable>
<xsl:variable name="back2">
	<xsl:choose>
		<xsl:when test="($dirname = '/')" >
			HOME	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="doc(concat($ou:root,$ou:site,$parent-path,'/index.pcf'))/document/title/text()" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>	


<!-- filter column two entries by First letter and display in side bar-->
<xsl:template name="indexfilter">
	<ul>
		<xsl:for-each select="document/maincontent/column_two/h3[@class='doc_col_header']">
		<xsl:variable name="index"><xsl:value-of select="." /></xsl:variable>
		<li><a href='#{$index}'><xsl:value-of select="$index" /></a></li>	
		</xsl:for-each>
	</ul>
</xsl:template>

<!-- Determine which xsl template to call -->
<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'onecolphp') or (document/config/parameter[@name='pagetype'] = 'forms_php') or (document/config/parameter[@name='pagetype'] = 'news_php') or (document/config/parameter[@name='pagetype'] = 'staff_php') or (document/config/parameter[@name='pagetype'] = 'siteindex_php')">
			<xsl:call-template name="onecolphp" />
		</xsl:when>	
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'tophome')">
			<xsl:call-template name="tophome" />
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'tophomephp')">
			<xsl:call-template name="tophomephp" />
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'home')">
			<xsl:call-template name="home" />
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'forms') or (document/config/parameter[@name='pagetype'] = 'news') or (document/config/parameter[@name='pagetype'] = 'staff') or (document/config/parameter[@name='pagetype'] = 'siteindex')">
			<xsl:call-template name="onecolumn" />
		</xsl:when>		
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'interior')">
			<xsl:call-template name="interior" />
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'interiorphp')">
			<xsl:call-template name="interiorphp" />
		</xsl:when>
        <xsl:when test="(document/config/parameter[@name='pagetype'] = 'top-level_interior')">
            <xsl:call-template name="top-level_interior" />
        </xsl:when>
        <xsl:when test="(document/config/parameter[@name='pagetype'] = 'top-level_interior_php')">
            <xsl:call-template name="top-level_interior_php" />
        </xsl:when>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'subhome')">
			<xsl:call-template name="subhome" />
		</xsl:when>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'subhomephp')">
			<xsl:call-template name="subhomephp" />
		</xsl:when>
        <xsl:when test="(document/config/parameter[@name='pagetype'] = 'redirect')">
            <xsl:call-template name="redirect" />
        </xsl:when> 
		<xsl:otherwise>
			<xsl:call-template name="interior" />
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<!-- The contents of the Head section for every page -->
<xsl:template name="head">
    <!-- <meta charset="UTF-8" /> -->
    <!-- Page Title -->
	<xsl:choose>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'home')">
		<title><xsl:value-of select="concat( ./document/title, ' | San Jose State University')" /></title>
		</xsl:when>
		<xsl:otherwise>
		<title><xsl:value-of select="concat( $ou:subsite ,' | ', ./document/title, ' | San Jose State University')" /></title>
		</xsl:otherwise>
	</xsl:choose>
    <!-- meta data -->
    <xsl:copy-of select="document/metadata/node()" />
    <xsl:choose>
        <!-- Determine if pagetype is a php page -->
        <xsl:when test="contains(document/config/parameter[@name='pagetype'], 'php')">
            <!-- Page is a PHP Page -->
            <!-- Begin PHP Javascript Includes -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://sjsu.edu/sjsuhome/includes/include-global1-js.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="footer" </xsl:comment> 
                <xsl:processing-instruction name="php">include($_SERVER['DOCUMENT_ROOT'] . "/sjsuhome/includes/include-global1-js.inc"); ?</xsl:processing-instruction>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End PHP Javascript Includes -->
            <!-- Being PHP CSS Includes -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://sjsu.edu/sjsuhome/includes/include-global-css.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="css" </xsl:comment> 
                <xsl:processing-instruction name="php"> include($_SERVER['DOCUMENT_ROOT'] . "/sjsuhome/includes/include-global-css.inc"); ?</xsl:processing-instruction>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>	
            <!-- End PHP CSS Includes -->
        </xsl:when>
        <xsl:otherwise>
            <!-- Page is NOT a PHP Page -->
            <!-- Begin Virtual Javascript Includes -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global1-js.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="script1" </xsl:comment> 
                <xsl:comment>#include virtual="/sjsuhome/includes/include-global1-js.inc" </xsl:comment>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End Virtual Javascript Includes -->
            <!-- Begin Virtual CSS Includes -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global-css.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="css" </xsl:comment> 
                <xsl:comment>#include virtual="/sjsuhome/includes/include-global-css.inc" </xsl:comment>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End Virtual CSS Includes -->
        </xsl:otherwise>
    </xsl:choose>
    <!-- OTHER INCLUDE -->
    <xsl:choose>
        <xsl:when test="($ou:externalinc != '')">
             <xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,'/includes/siteinclude.inc')"/>"</xsl:comment>
        </xsl:when>
        <xsl:otherwise>
            <xsl:comment></xsl:comment>
        </xsl:otherwise>
    </xsl:choose>
    <!-- /OTHER INCLUDE -->
    <!-- headcode -->
    <xsl:copy-of select="document/headcode/node()" />
</xsl:template>

<!-- builds the top Navigation based on the folders in the root of the site whose index page have sitemap="yes" 
Aso includes directory's sidenav.inc file for drop down-->
<xsl:template name="topnav">
<xsl:param name="currentPath" />
<ul id="topnav">	 	
	 	<xsl:for-each select="doc($currentPath)/list/directory">
	 		<xsl:sort order="ascending" />
	 		<xsl:for-each select=".">
	 		<xsl:if test="not(contains($excludedDir,. ))">
	 		<xsl:variable name="index" select="concat($currentPath, '/' , . , '/index.pcf')"/>
			<li><a>
	 		<xsl:attribute name="href"><xsl:value-of select="concat($ou:sitepath,'/',.,'/')"/></xsl:attribute>
	 		<h2 class="navname"><xsl:value-of select="document($index)/document/title" /></h2>
	 		<span class="navarrow"></span></a>
	 		<div class="sub">
	 			<ul><xsl:comment> com.omniupdate.div label="<xsl:value-of select="."/>" path="<xsl:value-of select="concat('/',.,'/sidenav.inc')"/>" </xsl:comment>

	 				<xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,'/',.,'/sidenav.inc')"/>"</xsl:comment>

	 				<xsl:comment> /com.omniupdate.div </xsl:comment>	 				
	 			</ul>
	 		</div>
	 		</li>
			</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
</ul>	 
</xsl:template>


<!-- builds the top Navigation based on the folders in the root of the site whose index page have sitemap="yes" 
Aso includes directory's sidenav.inc file for drop down as php includes-->
<xsl:template name="topnavphp">
<xsl:param name="currentPath" />
<ul id="topnav">	 	
	 	<xsl:for-each select="doc($currentPath)/list/directory">
	 		<xsl:sort order="ascending" />
	 		<xsl:for-each select=".">
	 		<xsl:if test="not(contains($excludedDir,. ))">
	 		<xsl:variable name="index" select="concat($currentPath, '/' , . , '/index.pcf')"/>
			<li><a>
	 		<xsl:attribute name="href"><xsl:value-of select="concat($ou:sitepath,'/',.,'/')"/></xsl:attribute>
	 		<h2 class="navname"><xsl:value-of select="document($index)/document/title" /></h2>
	 		<span class="navarrow"></span></a>
	 		<div class="sub">
	 			<ul><xsl:comment> com.omniupdate.div label="<xsl:value-of select="."/>" path="<xsl:value-of select="concat('/',.,'/sidenav.inc')"/>" </xsl:comment>
	 				<xsl:processing-instruction name="php"> include( $_SERVER["DOCUMENT_ROOT"] . "<xsl:value-of select="concat($ou:sitepath,'/',.,'/sidenav.inc')"/>"); ?</xsl:processing-instruction>
	 				<xsl:comment> /com.omniupdate.div </xsl:comment>	 				
	 			</ul>
	 		</div>
	 		</li>
			</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
</ul>	 
</xsl:template>

<xsl:template name="quickicons">
	<xsl:choose>
        <!-- Determine if pagetype is a php page -->
        <xsl:when test="contains(document/config/parameter[@name='pagetype'], 'php')">
            <!-- Begin PHP Quick Icons Include -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global-quickicons.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="quickicons" </xsl:comment> 
                <xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/sjsuhome/includes/include-global-quickicons.inc"); ?</xsl:processing-instruction>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End  PHP Quick Icons Include -->
        </xsl:when>
        <xsl:otherwise>
            <!-- Begin Virtual Quick Icons Include -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global-quickicons.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="quickicons" </xsl:comment> 
                <xsl:comment>#include virtual="/sjsuhome/includes/include-global-quickicons.inc" </xsl:comment>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End Virtual Quick Icons Include -->
        </xsl:otherwise>
    </xsl:choose> 
</xsl:template>


<xsl:template name="socialmedia">
    <xsl:choose>
        <!-- Determine if pagetype is a php page -->
        <xsl:when test="contains(document/config/parameter[@name='pagetype'], 'php')">
            <!-- Begin PHP Social Media Include -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://sjsu.edu/sjsuhome/includes/include-global-sharethis.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="footer" </xsl:comment> 
                <xsl:processing-instruction name="php"> include($_SERVER['DOCUMENT_ROOT'] . "/sjsuhome/includes/include-global-sharethis.inc"); ?</xsl:processing-instruction>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End PHP Social Media Include -->
        </xsl:when>
        <xsl:otherwise>
            <!-- Begin Virtual Social Media Include -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global-sharethis.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="sharethis" </xsl:comment> 
                <xsl:comment>#include virtual="/sjsuhome/includes/include-global-sharethis.inc" </xsl:comment>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End Virtual Social Media Include -->
        </xsl:otherwise>
    </xsl:choose>
	<div id="socialicons">
	    <xsl:if test="$ou:twitterAcc != ''"><a href="{$ou:twitterAcc}" class="btn_t" title="Twitter">Twitter</a></xsl:if>
        <xsl:if test="$ou:facebookAcc != ''"><a href="{$ou:facebookAcc}" class="btn_f" title="Facebook">Facebook</a></xsl:if>
        <xsl:if test="$ou:rssAcc != ''"><a href="{$ou:rssAcc}" class="btn_r" title="RSS">RSS</a></xsl:if>
	</div>
</xsl:template>


<!-- Scripts called at the end of each page just prior to the </body>  -->
<xsl:template name="scripts">
    <xsl:choose>
        <!-- Determine if pagetype is a php page -->
        <xsl:when test="contains(document/config/parameter[@name='pagetype'], 'php')">
            <!-- Begin PHP Javacript Includes -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://sjsu.edu/sjsuhome/includes/include-global2-js.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="script2" </xsl:comment> 
                <xsl:processing-instruction name="php"> include($_SERVER['DOCUMENT_ROOT'] . "/sjsuhome/includes/include-global2-js.inc"); ?</xsl:processing-instruction>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End PHP Javascript Includes -->
        </xsl:when>
        <xsl:otherwise>
            <!-- Begin Virtual Javascript Includes -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global2-js.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="script2" </xsl:comment> 
                <xsl:comment>#include virtual="/sjsuhome/includes/include-global2-js.inc" </xsl:comment>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End Virtual Javascript Includes -->
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- The contents of the search field located at the top of every page -->
<xsl:template name="search">
    <xsl:choose>
        <!-- Determine if pagetype is a php page -->
        <xsl:when test="contains(document/config/parameter[@name='pagetype'], 'php')">
            <!-- Begin PHP Search Form Include -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global-search.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="search" </xsl:comment> 
                <xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/sjsuhome/includes/include-global-search.inc"); ?</xsl:processing-instruction>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End PHP Search Form Include -->
        </xsl:when>
        <xsl:otherwise>
            <!-- Begin Virtual Search Form Include -->
            <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
                <xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/include-global-search.inc', 'utf-8')" disable-output-escaping="yes"/>
            </xsl:if>
            <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
                <xsl:comment> com.omniupdate.div label="search" </xsl:comment> 
                <xsl:comment>#include virtual="/sjsuhome/includes/include-global-search.inc" </xsl:comment>
                <xsl:comment> /com.omniupdate.div </xsl:comment>
            </xsl:if>
            <!-- End Virtual Search Form Include -->
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- transforms the staff directory table snippet into to desired html output-->
<xsl:template name="staff_template">
<xsl:for-each select="document/maincontent/column_two/table/tbody/tr">
	<xsl:if test="not(./th)">
		<a>
		<xsl:attribute name="class">profile_col</xsl:attribute>
		<xsl:attribute name="href" >
            <xsl:choose>
                <xsl:when test="./td[6] != '' and ./td[6] != '&nbsp;'">
                   <xsl:choose>
                        <xsl:when test="contains (./td[6],'@')" >
                        <xsl:value-of select="concat('mailto:',./td[6])" />
                        </xsl:when>
                        <xsl:when test="contains (./td[6], 'nbsp;')"></xsl:when>
                        <xsl:otherwise>
                        <xsl:value-of select="./td[6]" />
                        </xsl:otherwise>
                    </xsl:choose>   
                </xsl:when>
                <xsl:otherwise>#</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
		<span class="cphoto">
		<img>
			<xsl:attribute name="src" ><xsl:value-of select="./td[1]/img/@src" /></xsl:attribute>
			<xsl:attribute name="alt" ><xsl:value-of select="concat(./td[2], ' ', ./td[3])" /></xsl:attribute>
			<xsl:if test="./td[1]/img/@width">
				<xsl:attribute name="width" ><xsl:value-of select="./td[1]/img/@width" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="./td[1]/img/@height">
				<xsl:attribute name="height" ><xsl:value-of select="./td[1]/img/@height" /></xsl:attribute>
			</xsl:if>
		</img>
		</span>
		<span class="rprofile">
			<span class="rprofile_l"><xsl:value-of select="concat(./td[2], ' ', ./td[3])" /><br /><xsl:value-of select="./td[4]" /></span>
			<span class="rprofile_r"><xsl:value-of select="./td[5]" /><br/><xsl:value-of select="./td[6]" /></span>
		</span>
		</a>
	</xsl:if>		
</xsl:for-each>
</xsl:template>

<!-- transforms the Forms table snippet into to desired html output-->
<xsl:template name="forms">
<xsl:for-each-group select="document/maincontent/column_two/table/tbody/tr" group-by="upper-case(substring(./td[1],1,1))">
<xsl:sort select="current-grouping-key()" />

<xsl:if test="not(./th)">
	<xsl:variable name="groupkey" select="current-grouping-key()" />
	
	<h3 class="doc_col_header" id="{$groupkey}"><xsl:value-of select="$groupkey" /></h3>
	<ul class="doc_index">
	<xsl:for-each select="current-group()">
	<xsl:sort select="./td[1]" />
		<xsl:choose>
    		<xsl:when test="./td[1]/a">
        		<xsl:variable name="pageloc" >
        			<xsl:value-of select="./td[1]/a/@href"/> 
        		</xsl:variable>
                <xsl:variable name="target">
                    <xsl:value-of select="./td[1]/a/@target"/> 
                </xsl:variable>
        		<li class="doc_col">
                    <a>
                        <xsl:attribute name="href" select="$pageloc" />
                        <xsl:if test="$target != ''"><xsl:attribute name="target" select="$target" /></xsl:if>
                        <span class="rdoc">
                            <span class="rdoc_name"><xsl:value-of select="./td[1]"/></span>
                            <span class="rdoc_type"><xsl:value-of select="./td[2]" /></span>
                        </span>
                    </a>
                </li>
    		</xsl:when>
    		<xsl:otherwise>
        		<li class="doc_col">
        			<a href="#">
                        <span class="rdoc">
                            <span class="rdoc_name"><xsl:value-of select="./td[1]"/></span>
                            <span class="rdoc_type"><xsl:value-of select="./td[2]" /></span>
                        </span>
                    </a>
                </li>
    		</xsl:otherwise>
		</xsl:choose>
		
	</xsl:for-each>
	 <li class="backtotop"><a href="#scrolltotop">
        <span class="rdoc">
            Back to top
        </span>
    </a></li>
	</ul>
</xsl:if>	
</xsl:for-each-group>
</xsl:template>

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

<!-- generates the side bar navigation for the Forms page -->
<xsl:template name="formsindexfilter">
	<ul>
	<xsl:for-each-group select="document/maincontent/column_two/table/tbody/tr" group-by="upper-case(substring(./td[1],1,1))">
	<xsl:sort select="current-grouping-key()" />
	<xsl:variable name="groupkey" select="current-grouping-key()" />
	<li><a href='#{$groupkey}'><xsl:value-of select="$groupkey" /></a></li>	
	</xsl:for-each-group>
	</ul>
</xsl:template>

<!-- Footer Includes (virtual) -->
<xsl:template name="footer">
	<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
		<xsl:value-of select="unparsed-text('http://dev.sjsu.edu/sjsuhome/includes/footer.inc', 'utf-8')" disable-output-escaping="yes"/>
	</xsl:if>
	<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
		<xsl:comment> com.omniupdate.div label="footer" </xsl:comment> 
		<xsl:comment>#include virtual="/sjsuhome/includes/footer.inc" </xsl:comment>
		<xsl:comment> /com.omniupdate.div </xsl:comment>
	</xsl:if>
	<div id="hidden"><xsl:comment> com.omniupdate.ob </xsl:comment><xsl:comment> /com.omniupdate.ob </xsl:comment></div>
</xsl:template>

<!-- Footer Includes (php) -->
<xsl:template name="footer_php">
	<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
		<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/footer.inc', 'utf-8')" disable-output-escaping="yes"/>
	</xsl:if>
	<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
		<xsl:comment> com.omniupdate.div label="footer" </xsl:comment> 
		<xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/sjsuhome/includes/footer.inc"); ?</xsl:processing-instruction>
		<xsl:comment> /com.omniupdate.div </xsl:comment>
	</xsl:if>
	<div id="hidden"><xsl:comment> com.omniupdate.ob </xsl:comment><xsl:comment> /com.omniupdate.ob </xsl:comment></div>
</xsl:template>

<!-- GaCode Includes (virtual) -->
<xsl:template name="gacode">    
    <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
    
    <xsl:choose>
    <xsl:when test="$ou:sitepath = ''"> 
        <xsl:comment> com.omniupdate.div label="gacode" </xsl:comment> 
        <xsl:comment>#include virtual="/includes/gacode.inc" </xsl:comment>
        <xsl:comment> /com.omniupdate.div </xsl:comment>
    </xsl:when>
    <xsl:otherwise>
        <xsl:comment>#include virtual="/sjsuhome/includes/gacode.inc" </xsl:comment>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:if>

</xsl:template>

<!-- GaCode Includes (php) -->
<xsl:template name="gacode_php">
    <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">

    <xsl:choose>
    <xsl:when test="$ou:sitepath = ''"> 
        <xsl:comment> com.omniupdate.div label="gacode"</xsl:comment> 
        <xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/includes/gacode.inc"); ?</xsl:processing-instruction>
        <xsl:comment> /com.omniupdate.div </xsl:comment>
    </xsl:when>
    <xsl:otherwise>
        <xsl:processing-instruction name="php"> include($_SERVER["DOCUMENT_ROOT"] . "/sjsuhome/includes/gacode.inc"); ?</xsl:processing-instruction>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:if>   

</xsl:template>
</xsl:stylesheet>
