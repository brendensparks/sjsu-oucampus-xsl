<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<!-- 
Kitchen Sink v2.4 - 2/14/2014

VARIABLE DEBUG
A useful XSL for variable reference, testing, & debugging. It is not intended for all end users but rather source editors and xsl developers.
Uses similar layout to "info.xsl".

Contributors: Your Name Here
Last Updated: Enter Date Here
-->
<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ou="http://omniupdate.com/XSL/Variables"
    xmlns:fn="http://omniupdate.com/XSL/Functions"
    xmlns:ouc="http://omniupdate.com/XSL/Variables"
    exclude-result-prefixes="ou xsl xs fn ouc">
		
	<xsl:import href="../common.xsl"/>
	<xsl:param name="ou:ftproot"/>
	<xsl:param name="ou:ftphome"/>
	<xsl:param name="ou:ftpdir"/>
			
<xsl:template name="debug" match="/">	
	<html lang="en">
		<head>
			<link href="//netdna.bootstrapcdn.com/bootswatch/3.1.0/cerulean/bootstrap.min.css" rel="stylesheet"/>
			<link href="/_resources/css/oustaging.css" rel="stylesheet" />
			<style>
				body{
				font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
				}
				.ox-regioneditbutton {
				display: none;
				}
			</style>
		</head>
	<body id="info">
		
	
			<div class="container">
				
			<h1>Variable Debug Tab</h1>
				<p>The following is a list of XSL variables for this page or section for debugging and development purposes. 
				Feel free to add your own (globally defined) variables here. This page depends on the import of any XSL in which variables are
				defined, such as ouvariables, vars, and common XSL stylesheets.</p>
				<p><small><em>This view will not be published.</em></small></p>
				
				<div class="row">
					<div class="col-md-6">
						<h3>OUCampus System Variables</h3>
						<p>These are parameters provided by the system, instantiated in vars.xsl</p>
						<hr/>
						<h4>File/Directory</h4><em>Page or directory specific</em>
						<dl>
							<xsl:copy-of select="ou:displayVariable('ou:filename',$ou:filename)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:path',$ou:path)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:created',$ou:created)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:modified',$ou:modified)"/>
							<xsl:copy-of select="ou:displayVariable('ou:feed',$ou:feed)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:dirname',$ou:dirname)"/>
						</dl>
						<!-- protected information -->
						<hr/>
						<h4>Staging</h4><em>Site specific, staging server information</em>
						<dl>
							<xsl:copy-of select="ou:displayVariable('ou:action',$ou:action)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:root',$ou:root)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:site',$ou:site)"/>	
						</dl>
						<hr/>
						<h4>Production</h4><em>Site specific, production server informaiton</em>
						<dl>
						
							<xsl:copy-of select="ou:displayVariable('ou:ftphome',$ou:ftphome)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:ftpdir',$ou:ftpdir)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:httproot',$ou:httproot)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:ftproot',$ou:ftproot)"/>	
						</dl>
						<hr/>					
						<h4>User</h4><em>User specific information, if available</em>
						<dl>
							<xsl:copy-of select="ou:displayVariable('ou:username',$ou:username)"/>	
							<xsl:copy-of select="ou:displayVariable('ou:firstname',$ou:firstname)"/>
							<xsl:copy-of select="ou:displayVariable('ou:lastname',$ou:lastname)"/>		
							<xsl:copy-of select="ou:displayVariable('ou:email',$ou:email)"/>	
						</dl>					
					</div>
					
					<div class="col-md-6">
						<h3>XSL Variables</h3>
						<p>Globally defined XSL variables or parameters, in vars.xsl</p>		
						<hr/>
						<h4>Skeleton Variables</h4><em>Standard variable set</em>
						<dl>
							<xsl:copy-of select="ou:displayVariable('Server Type',$serverType)"/>	
							<xsl:copy-of select="ou:displayVariable('Index File',$index-file)"/>	
							<xsl:copy-of select="ou:displayVariable('Extension',$extension)"/>	
							<xsl:copy-of select="ou:displayVariable('Dirname',$dirname)"/>	
							<xsl:copy-of select="ou:displayVariable('Domain',$domain)"/>								
							<xsl:copy-of select="ou:displayVariable('path',$path)"/>		
							<xsl:copy-of select="ou:displayVariable('Props File',$props-file)"/>	
							<xsl:copy-of select="ou:displayVariable('Props Path',$props-path)"/>		
							<xsl:copy-of select="ou:displayVariable('Production Root',$ou:production_root)"/>	
							<!--<xsl:copy-of select="ou:displayVariable('Navigation Start',$ou:navigationStart)"/>-->	
							<!--<xsl:copy-of select="ou:displayVariable('Breadcrumb Start',$ou:breadcrumbStart)"/>-->	
						</dl>
						<hr/>
						<h4>Implementation Specific Variables</h4><em>These vary from project to project.</em>
							<xsl:copy-of select="ou:displayVariable('Page Type',$layout)"/>	
							<xsl:copy-of select="ou:displayVariable('Page Title',$pageTitle)"/>							
										
					</div>
				</div>


		</div>
		
		<em><small><p>This view is configured by debug.xsl</p></small></em>
		
	</body>
</html>
</xsl:template>

<!-- display a variable for debug purposes -->
<xsl:function name="ou:displayVariable">
<xsl:param name="name"/> <xsl:param name="var"/>
<dt><xsl:value-of select="$name"/></dt> <dd><xsl:value-of select="$var"/></dd>
</xsl:function>



</xsl:stylesheet>
