<?xml version="1.0" encoding="utf-8"?>


<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou xsl xs">
	<!--
OU GALLERIES

Transforms gallery asset XML into a dynamic gallery on the web page. 

Dependencies - see vars xsl
$galleryType
-->
	<!-- The following template matches the LDP gallery nodes and outputs the proper HTML Code based on a specified parameter -->
	<xsl:template match="gallery" mode="copy">
		<xsl:variable name="galleryType" select="/document/config/parameter[@name='galleryType']/option[@selected='true']/@value" />
		<xsl:variable name="galleryId" select="@asset_id"/>
		<!-- Start ColorBox -->
			<ul class="bs--thumbnails">
				<xsl:for-each select="images/image">
					<li>
						<a class="colorboxSlide bs--thumbnail photoGallery" href="{@url}" rel="ColorBox[{$galleryId}]" title="{./description}">
							<img src="{./thumbnail/@url}" alt="{./caption}" style="height: {thumbnail/height}; width: {thumbnail/width};" title="{./title}" />
						</a>
					</li>
				</xsl:for-each>
			</ul>
				<!-- End ColorBox -->
	</xsl:template>
	
	<!-- Adds ColorBox CSS to the <head> element -->
	<xsl:function name="ou:gallery-headcode">
		<link rel="stylesheet" href="http://www.sjsu.edu/sjsuhome/assets/css/colorbox.css" media="screen" />
		<link rel="stylesheet" href="http://www.sjsu.edu/sjsuhome/assets/css/bootstrap-thumbnails.css" media="screen" />
	</xsl:function>

	<!-- Loads the ColorBox plugin and initializes the photo gallery -->
	<xsl:function name="ou:gallery-footcode">
		<script src="http://www.sjsu.edu/sjsuhome/assets/js/jquery.colorbox-min.js"></script>
		<script>
			jQuery(document).ready(function () {
				jQuery('.colorboxSlide').colorbox({ opacity:0.5 , rel:'photoGallery' });
			});
		</script>	
	</xsl:function>







</xsl:stylesheet>	
