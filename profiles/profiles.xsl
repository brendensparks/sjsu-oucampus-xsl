<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
<!ENTITY times	"&#215;">
]>
<xsl:stylesheet version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:ou="http://omniupdate.com/XSL/Variables"
xmlns:ouc="http://omniupdate.com/XSL/Variables"
exclude-result-prefixes="xs ou ouc">
	
	<xsl:import href="../interior.xsl" />
	<xsl:import href="helper.xsl" />
	
	
	<xsl:template name="middle-column">
		
		<ul class="breadcrumb panel">
			<xsl:call-template name="breadcrumb">
				<xsl:with-param name="path" select="$ou:dirname"/>								
			</xsl:call-template>
		</ul>
		
		<xsl:choose>
			<xsl:when test="profile">  <!-- Check to see if Profile Page (profile node exists) -->
				
				<xsl:copy-of select="ou:multieditButton()" />
				<xsl:apply-templates select="ou:getProfile(./profile)" mode="single"/>
				
				<div class="row">
					<div class="columns large-12">
						<xsl:apply-templates select="ouc:div[@label='maincontent']" mode="copy" />
						<p>
							&nbsp;
						</p>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise> <!-- LISTING VIEW -->
				
				<xsl:if test="$ou:action = 'edt' or $ou:action = 'prv'">
					<div class="alert-box warning radius">
						<span style="margin-right:1em" class="icon icon-refresh pull-left"></span><span> Directory listing will only be updated upon publish. It is recommended that you set this page to 'Schedule Publish' on a recurring basis.</span>
						<a href="javascript:close();" class="close">&times;</a>
					</div>
				</xsl:if>
				
				<xsl:apply-templates select="ouc:div[@label='maincontent']" mode="copy" />
				
				<xsl:if test="$ou:action = 'edt' or $ou:action = 'prv'">
					<div class="alert-box secondary radius">
						<span style="margin-right:1em" class="icon icon-exclamation-sign pull-left"></span> Only published profile pages will be displayed.
						<a href="javascript:close();" class="close">&times;</a>
					</div>
				</xsl:if>
				
				<xsl:variable name="columns"><xsl:choose>
					<xsl:when test="ou:pcfparam('layout') = 'onecol'">3</xsl:when>
					<xsl:when test="ou:pcfparam('layout') = 'threecol'">1</xsl:when>
					<xsl:otherwise>2</xsl:otherwise>
					</xsl:choose></xsl:variable>
				<ul class="large-block-grid-{$columns}">
					<xsl:apply-templates select="ou:getProfiles($dirname, $ou:filename)/profile" mode="listing" />
				</ul>
			</xsl:otherwise>
		</xsl:choose>
		
		
	</xsl:template>
	
	<xsl:template match="profile" mode="single">
		<article class="row">
			<div class="small-3 large-5 columns">
				<img class="thumbnail" src="{./image/img/@src}" alt="{./image/img/@alt}" />
			</div>
			<div class="small-9 large-7 columns">
				<h2 class="subheader profile">
					<xsl:value-of select="lastname"/>,&nbsp;<xsl:value-of select="firstname"/>&nbsp;<xsl:value-of select="middlename"/>&nbsp;<xsl:value-of select="suffix"/>
				</h2>
				<xsl:call-template name="info" />
				<xsl:apply-templates select="bio" mode="copy" />
			</div>
		</article>
	</xsl:template>
	
	<xsl:template match="profile" mode="listing">
		<li>
		<article class="row">
			<div class="small-3 large-4 columns">
				<a href="{@href}"><img class="thumbnail" src="{image/img/@src}" alt="{image/img/@alt}" /></a>
			</div>
			<div class="small-9 large-8 columns">
				<h3 class="subheader profile">
					<small><xsl:value-of select="lastname"/>,&nbsp;<xsl:value-of select="firstname"/>&nbsp;<xsl:value-of select="middlename"/>&nbsp;<xsl:value-of select="suffix"/></small>
				</h3>
				<xsl:call-template name="info" />
			</div>
		</article>
		</li>
	</xsl:template>
	
	<xsl:template name="info">
		<p>
			<xsl:if test="title/text() != ''">		
				<strong>
					<xsl:value-of select="title"/>
				</strong>
				<br />
			</xsl:if>
			<xsl:if test="department/text() != ''">
				<xsl:value-of select="department"/>
				<br />
			</xsl:if>
			<xsl:if test="email/text() != ''">
				<span class="icon icon-envelope"></span>&nbsp;<a href="mailto:{email/text()}"><xsl:value-of select="email"/></a><br />
			</xsl:if>
			<xsl:if test="phone/text() != ''">
				<span class="icon icon-phone"></span>&nbsp;<a href="tel:{phone/text()}"><xsl:value-of select="phone"/></a><br />
			</xsl:if>
			<xsl:if test="office/text() != ''">
				<span class="icon icon-home"></span>&nbsp;<xsl:value-of select="office"/><br />
			</xsl:if>
		</p>
	</xsl:template>
	
</xsl:stylesheet>
