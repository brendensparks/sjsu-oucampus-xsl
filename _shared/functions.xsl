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
    
    <!-- The following function takes in two parameters (directory name and file name) and outputs the proper code to include the file on the page. -->
    <xsl:function name="ou:includeFile">
        <xsl:param name="dirname" />	<!-- directory name -->
        <xsl:param name="filename" />	<!-- file name -->
        <xsl:variable name="fullpath" select="concat($dirname,if(substring($dirname,string-length($dirname)) != '/') then '/' else '',$filename)" />	<!-- combines the two, ensuring the syntax contains the proper slashes -->
        
        <xsl:choose><!-- on publish, it will output the proper SSI code, but on staging we require the omni div tag -->
            <xsl:when test="$ou:action = 'pub'">
                <xsl:copy-of select="ou:ssi($fullpath)" />
            </xsl:when>
            <xsl:otherwise>
                <ouc:div label="{$fullpath}" path="{$fullpath}" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="ou:ssi">
        <xsl:param name="fullpath"/>
        <!--	<xsl:comment>#include virtual="<xsl:value-of select="$fullpath" />" </xsl:comment>-->
        <xsl:processing-instruction name="php"> include($_SERVER['DOCUMENT_ROOT'] . "<xsl:value-of select="$fullpath" />"); ?</xsl:processing-instruction>
    </xsl:function>


    <!-- modified version of ou:includeFile -->
    <xsl:function name="ou:includeFileHTML">
        <xsl:param name="dirname" />    <!-- directory name -->
        <xsl:param name="filename" />   <!-- file name -->
        <xsl:variable name="fullpath" select="concat($dirname,if(substring($dirname,string-length($dirname)) != '/') then '/' else '',$filename)" />    <!-- combines the two, ensuring the syntax contains the proper slashes -->
        
        <xsl:choose><!-- on publish, it will output the proper SSI code, but on staging we require the omni div tag -->
            <xsl:when test="$ou:action = 'pub'">
                <xsl:copy-of select="ou:ssihtml($fullpath)" />
            </xsl:when>
            <xsl:otherwise>
                <ouc:div label="{$fullpath}" path="{$fullpath}" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- modified version of ou:ssi -->
    <xsl:function name="ou:ssihtml">
        <xsl:param name="fullpath"/>
        <!--    <xsl:comment>#include virtual="<xsl:value-of select="$fullpath" />" </xsl:comment>-->
        <xsl:processing-instruction name="php"> include($_SERVER['DOCUMENT_ROOT'] . "<xsl:value-of select="$fullpath" />"); ?</xsl:processing-instruction>
    </xsl:function>
    
    <xsl:function name="ou:findPrevDir"> <!-- outputs parent directory path with trailing '/': /path/to/parent/ -->
        <xsl:param name="path" />
        <xsl:variable name="tokenPath" select="tokenize(substring($path, 2), '/')[if(substring($path,string-length($path)) = '/') then position() != last() else position()]" />
        <xsl:variable name="newPath" select="concat('/', string-join(remove($tokenPath, count($tokenPath)), '/') ,'/')"/>
        <xsl:value-of select="if($newPath = '//') then '/' else $newPath" />
    </xsl:function>
    
    <xsl:function name="ou:hasClass"> <!-- boolean that returns whether an element contains a class, much like JQuery's hasClass function -->
        <xsl:param name="element"/>
        <xsl:param name="classname"/>
        <xsl:value-of select="boolean($element/@class) and contains(concat(' ', $element/@class, ' '), concat(' ', $classname, ' '))"/>
    </xsl:function>
    
    <xsl:function name="ou:multieditButton"> <!-- call function to activate the multiedit button in edit mode -->
        <xsl:if test="$ou:action='edt'">
            <ouc:div label="multiedit" group="everyone" button="hide"><ouc:multiedit /></ouc:div>
        </xsl:if>
    </xsl:function>
    
    <!-- 
        PCF PARAMS
        An extremely useful function for getting page properties without needing to type the full xpath.
        How to use:
        The pcf has a parameter, name="pagetype". To get the value and store it in an XSL param : 
        <xsl:param name="pagetype" select="ou:pcfparam('pagetype')"/> 
        Use wherever you need it
        Contributors: Chul Kim
    -->
    <xsl:param name="pcfparams" select="/*:document/ouc:properties[@label='config']//parameter"/>
    <!-- save all page properties in a variable -->
    
    <xsl:function name="ou:pcfparam">
        <xsl:param name="name"/>
        <xsl:variable name="parameter" select="$pcfparams[@name=$name]"/>
        <xsl:choose>
            <xsl:when test="$parameter/@type = 'select' or $parameter/@type = 'radio'">
                <xsl:value-of select="$parameter/option[@selected = 'true']/@value"/>
            </xsl:when>
            <xsl:when test="$parameter/@type = 'checkbox'">
                <xsl:copy-of select="$parameter/option[@selected = 'true']/@value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$parameter/text()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- 
        PROPS PARAMS 
        Essentially a clone of pcfparams
        Use this to grab parameters from your section properties files.
        
        
        <xsl:param name="props-file" select="'_props.pcf'"/> 	
        <xsl:param name="props-path" select="concat($ou:root, $ou:site, $dirname, $props-file)"/>
        
        Note: $props-path is defined in vars xsl, and this variable is shared with breadcrumbs.xsl
        Contributors: Caroline Spooner
    -->
    
    <xsl:param name="propsparams" select="document($props-path)//parameter"/>
    <!-- save all section properties in a variable -->
    
    <xsl:function name="ou:propsparam">
        <xsl:param name="name"/>
        
        <xsl:variable name="parameter" select="$propsparams[@name=$name]"/>
        <xsl:choose>
            <xsl:when test="$parameter/@type = 'select' or $parameter/@type = 'radio'">
                <xsl:value-of select="$parameter/option[@selected = 'true']/@value"/>
            </xsl:when>
            <xsl:when test="$parameter/@type = 'checkbox'">
                <xsl:copy-of select="$parameter/option[@selected = 'true']/@value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$parameter/text()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- 
        ASSIGN VARIABLE
        Concisely assign fallback variables to prevent unexpected errors in development and post implementation.
        
        How to use:
        <xsl:param name="galleryType" select="ou:assignVariable('galleryType','PrettyPhoto')"/>	
        <xsl:variable name="navfile" select="ou:assignVariable('page-nav',$ou:navigation,$local-nav)"/>
        
        Third parameter may be a string or variable. The first parameter must always be a string, as required by the pcfparam function.
        
        Second version requires overwriteDirectory variable, which is typically defined in vars xsl.
        
        <xsl:variable name="overwriteDirectory" select="ou:assignVariable('overwriteDirectory','no')"/> 
        
        
        Note: requires the function ou:pcfparams
        Contributors: Caroline Spooner 
    -->
    
    <xsl:function name="ou:assignVariable">
        <!-- test if page property has value, give default value if none -->
        <xsl:param name="var"/>
        <xsl:param name="fallback"/>
        
        <xsl:variable name="pcf-var" select="ou:pcfparam($var)"/>
        
        <xsl:choose>
            <xsl:when test="string-length($pcf-var) > 0">
                <xsl:value-of select="$pcf-var"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$fallback"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
    <xsl:function name="ou:assignVariable">
        <!-- pcf - dir var - fallback precedence, also tests if there is a value for each -->
        <xsl:param name="var"/>
        <xsl:param name="dir-var"/>
        <xsl:param name="fallback"/>
        
        <xsl:variable name="overwriteDirectory" select="ou:pcfparam('overwriteDirectory')"/>
        
        <xsl:variable name="pcf-var" select="ou:pcfparam($var)"/>
        
        <xsl:choose>
            <xsl:when test="string-length($pcf-var) > 0 and $overwriteDirectory='yes'">
                <xsl:value-of select="$pcf-var"/>
            </xsl:when>
            <xsl:when test="string-length($dir-var) > 0 and $dir-var!='[auto]'">
                <xsl:value-of select="$dir-var"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$fallback"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    <xsl:function name="ou:testVariable"> <!-- test if variable has value, give default value if none -->
        <xsl:param name="var"/>
        <xsl:param name="fallback"/>
        
        <xsl:choose>	
            <xsl:when test="string-length($var) > 0"><xsl:value-of select="$var"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$fallback"/></xsl:otherwise>
        </xsl:choose>	
        
    </xsl:function>	
    
    <xsl:variable name="bodyClass">
        <xsl:choose>
            <xsl:when test="ou:pcfparam('layout') = 'onecol'">onecolpage</xsl:when>
            <xsl:when test="ou:pcfparam('layout') = 'twocol'">twocolpage</xsl:when>
            <xsl:when test="ou:pcfparam('layout') = 'threecol'">threecolpage</xsl:when>
            <xsl:otherwise>home</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
</xsl:stylesheet>
