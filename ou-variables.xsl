<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ou="http://omniupdate.com/XSL/Variables" exclude-result-prefixes="ou">

<!-- Initialize OU Variables -->
<xsl:param name="ou:action" />
<xsl:param name="ou:dirname" /> 
<xsl:param name="ou:filename" />
<xsl:param name="ou:path" />
<xsl:param name="ou:site" />
<xsl:param name="ou:root" />
<xsl:param name="ou:ftproot" />

<!-- user based OU variables -->
<xsl:param name="ou:facebookAcc" />
<xsl:param name="ou:twitterAcc" />
<xsl:param name="ou:linkedinAcc" />
<xsl:param name="ou:pinterestAcc" />
<xsl:param name="ou:rssAcc" />
<xsl:param name="ou:subsite" />
<xsl:param name="ou:enclosingunit" />
<xsl:param name="ou:encunitlink" />
<xsl:param name="ou:sitepath" />
<xsl:param name="ou:externalinc"/>
<xsl:param name="rssfeed" />
<xsl:param name="rssfeeditems" />
<xsl:param name="rssfeedtitle" />

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

</xsl:stylesheet>
