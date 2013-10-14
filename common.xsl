<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"

xmlns:ou="http://omniupdate.com/XSL/Variables"
xmlns:ouc="http://omniupdate.com/XSL/Variables"
exclude-result-prefixes="ou xsl xs">

<!-- filter column two entries by First letter and display in side bar-->
	<xsl:template name="indexfilter">
		<ul>
			<xsl:for-each select="document/maincontent/column_two/h3[@class='doc_col_header']">
				<xsl:variable name="index"><xsl:value-of select="." /></xsl:variable>
				<li><a href='#{$index}'><xsl:value-of select="$index" /></a></li>	
			</xsl:for-each>
		</ul>
	</xsl:template>

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

<!-- The contents of the <head> element for every page -->
	<xsl:template name="head">
		<!-- Page Title -->
		<xsl:choose>
			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'home') or (document/config/parameter[@name='pagetype'] = 'subhome')">
				<xsl:choose>
					<xsl:when test="document/title = ''">
						<title><xsl:value-of select="concat($ou:subsite, ' | San Jose State University')" /></title>
					</xsl:when>
					<xsl:otherwise>
						<title><xsl:value-of select="concat( ./document/title, ' | San Jose State University')" /></title>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="document/config/parameter[@name='exception'] = '404'">
				<title><xsl:value-of select="/document/title" /></title>
			</xsl:when>
			<xsl:otherwise>
				<title><xsl:value-of select="concat( ./document/title,' | ', $ou:subsite,' | San Jose State University')" /></title>
			</xsl:otherwise>
		</xsl:choose>
		<!-- meta data -->
		<xsl:copy-of select="document/metadata/node()" />
		<!-- Begin Virtual Javascript Includes -->
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/js-top.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:choose>
				<xsl:when test="(document/config/parameter[@name='exception'] = '404')" >
					<xsl:comment> com.omniupdate.div label="script1" </xsl:comment> 
					<xsl:comment>#include virtual="/sjsuhome/includes/404-top-js.inc" </xsl:comment>
					<xsl:comment> /com.omniupdate.div </xsl:comment>					
				</xsl:when>
				<xsl:otherwise>
					<xsl:comment> com.omniupdate.div label="script1" </xsl:comment> 
					<xsl:comment>#include virtual="/sjsuhome/includes/js-top.inc" </xsl:comment>
					<xsl:comment> /com.omniupdate.div </xsl:comment>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<!-- End Virtual Javascript Includes -->
		<!-- Begin Virtual CSS Includes -->
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/css.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="css" </xsl:comment> 
			<xsl:comment>#include virtual="/sjsuhome/includes/css.inc" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:if>
		<!-- End Virtual CSS Includes -->
		<!-- Begin LDP  CSS -->			
		<xsl:variable name="galleryExists">
			<xsl:choose>
				<xsl:when test="//gallery">1</xsl:when> 
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$galleryExists = 1">
			<link rel="stylesheet" href="/sjsuhome/assets/css/colorbox.css" media="screen" />
			<link rel="stylesheet" href="/sjsuhome/assets/css/ou--ldp--gallery.css" media="screen" />			
		</xsl:if>

		<xsl:if test="//ouform">
			<link rel="stylesheet" href="/sjsuhome/assets/css/ou--bootstrap.css" media="screen" />
			<link rel="stylesheet" href="/sjsuhome/assets/css/ou--ldp--forms.css" media="screen" />
		</xsl:if>

		<xsl:variable name="addPollCSS">
			<xsl:for-each select="//ouform/elements/element">
				<xsl:if test="./@type = 'input-radio'">
					<xsl:if test="(contains(./advanced/node(),'type=poll'))">yes</xsl:if>
				</xsl:if>
			</xsl:for-each>		
		</xsl:variable>
		<xsl:if test="$addPollCSS='yes'">
			<link rel="stylesheet" href="/sjsuhome/assets/css/ou--ldp--polls.css" media="screen" />
		</xsl:if>	
		<!-- End LDP  CSS -->

		<!-- OTHER INCLUDE -->
		<xsl:if test="($ou:externalinc != '')">
			<xsl:choose>
				<xsl:when test="$ou:action = 'prv' or $ou:action = 'edt'">
					<xsl:value-of select="unparsed-text($ou:externalinc, 'utf-8')" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:when test="$ou:action = 'pub' or $ou:action = 'cmp'">
					<xsl:value-of select="unparsed-text($ou:externalinc, 'utf-8')" disable-output-escaping="yes"/>					
				<!-- Broken version:
					<xsl:comment>#include virtual="<xsl:value-of select="$ou:externalinc"/>"</xsl:comment> -->
				<!-- Fixed version, but doesn't use full externalinc value:
					<xsl:comment>#include virtual="<xsl:value-of select="$ou:sitepath"/>/includes/siteinclude.inc" </xsl:comment> -->
				</xsl:when>
				<xsl:otherwise><!-- blank --></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<!-- /OTHER INCLUDE -->

		<!-- headcode -->
		<xsl:copy-of select="document/headcode/node()" />		
	</xsl:template>

<!-- chooses to use either homenav, meganav, or primarynav based on pagetype and site settings -->
<xsl:template name="mainnav">
	<xsl:choose>
		<xsl:when test="(document/config/parameter[@name='pagetype'] = 'home') or (document/config/parameter[@name='pagetype'] = 'tophome') or (document/config/parameter[@name='pagetype'] = 'top-level_interior')">
			<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
				<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/homenav.inc', 'utf-8')" disable-output-escaping="yes"/>
			</xsl:if>
			<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
				<xsl:comment> com.omniupdate.div label="topnav"</xsl:comment> 
				<xsl:comment>#include virtual="/sjsuhome/includes/homenav.inc" </xsl:comment>
				<xsl:comment> /com.omniupdate.div </xsl:comment>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="doc(concat($root, '/includes'))/list/file[. eq 'meganav.inc']">	
					<xsl:comment> com.omniupdate.div label="topnav" path="/includes/meganav.inc"</xsl:comment> 
					<xsl:comment>#include virtual="<xsl:value-of select="$ou:sitepath"/>/includes/meganav.inc" </xsl:comment>
					<xsl:comment> /com.omniupdate.div </xsl:comment>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
						<xsl:value-of select="unparsed-text(concat($ou:httproot,'primarynav.html'), 'utf-8')" disable-output-escaping="yes"/>
					</xsl:if>
					<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
						<xsl:comment> com.omniupdate.div label="primarynav" </xsl:comment> 
						<xsl:comment>#include virtual="<xsl:value-of select="$ou:sitepath"/>/primarynav.html" </xsl:comment>
						<xsl:comment> /com.omniupdate.div </xsl:comment>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
Builds the top Navigation based on the folders in the root of the site whose index page have sitemap="yes". Also includes directory's sidenav.inc file for drop down
-->
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

<xsl:template name="bannerarea">
		<!-- home, tophome and subhome banner -->
		<xsl:choose>
			<xsl:when test="(document/config/parameter[@name='slideshow']/option[@value='yes']/@selected = 'true')">
				<xsl:choose>
					<xsl:when test="not(document/maincontent/banner/slideshow/table)">
						<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
						<p>There is no slideshow added in this area. <br /> Please select the edit button and add a default slideshow using the insert snippet option on the toolbar.</p>
					</xsl:when>						
					<xsl:when test="not($ou:action = 'edt')">
						<xsl:call-template name="nivoslider" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="not(document/maincontent/banner/slideshow/table)">
								<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
								<p>There is no slideshow added in this area. <br /> Please select the edit button and add a default slideshow using the insert snippet option on the toolbar.</p>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="document/maincontent/banner/slideshow/comment()" />
								<img>
									<xsl:attribute name="src" ><xsl:value-of select="document/maincontent/banner/slideshow/table/tbody/tr[2]/td[1]/img/@src" /></xsl:attribute>
									<xsl:attribute name="alt" ><xsl:value-of select="document/maincontent/banner/slideshow/table/tbody/tr[2]/td[1]/img/@alt" /></xsl:attribute>
									<xsl:attribute name="title" ><xsl:value-of select="concat('#htmlcaption',position())" /></xsl:attribute>
								</img>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>						
			</xsl:when>
			<xsl:when test="(document/config/parameter[@name='bannerstatic']/option[@value='yes']/@selected = 'false')">
				<div class="banner-empty">
					<xsl:comment> nothing to see here </xsl:comment>
				</div>
			</xsl:when>
			<xsl:otherwise>
					<div class="banner-static">					
						<xsl:choose>
							<xsl:when test="not($ou:action = 'edt')">
								<xsl:if test="document/maincontent/banner/banner_caption != ''">
									<div class="banner_caption">
										<xsl:copy-of select="document/maincontent/banner/banner_caption/node()" />    
									</div><!-- /.banner_caption -->
								</xsl:if>					            
								<div class="banner_image">
									<xsl:copy-of select="document/maincontent/banner/image/node()" />
								</div><!-- /.banner_image -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="document/maincontent/banner/banner_caption != ''">
									<div class="banner_caption">
										<xsl:copy-of select="document/maincontent/banner/banner_caption/node()" />    
									</div><!-- /.banner_caption -->
								</xsl:if>	
								<div class="banner_image">
									<xsl:copy-of select="document/maincontent/banner/image/node()" />
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</div><!-- banner-static -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="quickicons">
		<!-- Begin Virtual Quick Icons Include -->
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/quickicons.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="quickicons" </xsl:comment> 
			<xsl:comment>#include virtual="/sjsuhome/includes/quickicons.inc" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:if>
		<!-- End Virtual Quick Icons Include -->		
	</xsl:template>

	<xsl:template name="socialmedia">
		<xsl:if test="($ou:facebookAcc != '') or ($ou:twitterAcc != '') or ($ou:rssAcc != '')">
			<div id="socialicons">
				<ul>			
					<xsl:if test="$ou:facebookAcc != ''"><li class="qi smFa" ><a href="{$ou:facebookAcc}" title="Facebook">Facebook</a></li></xsl:if>
					<xsl:if test="$ou:twitterAcc != ''"><li class="qi smTw"><a href="{$ou:twitterAcc}" title="Twitter">Twitter</a></li></xsl:if>				
					<xsl:if test="$ou:linkedinAcc != ''"><li class="qi smLi"><a href="{$ou:linkedinAcc}" title="Linked In">LinkedIn</a></li></xsl:if>								
					<xsl:if test="$ou:pinterestAcc != ''"><li class="qi smPi"><a href="{$ou:pinterestAcc}" title="Pinterest">Pinterest</a></li></xsl:if>								
					<xsl:if test="(document/config/parameter[@name='pagetype'] = 'home')">
						<li class="qi smLi"><a href="http://www.linkedin.com/company/san-jose-state-university" title="LinkedIn">LinkedIn</a></li>
						<li class="qi smPi"><a href="http://pinterest.com/sjsu/" title="Pinterest">Pinterest</a></li>
						<li class="qi smYt"><a href="http://www.youtube.com/user/sjsu" title="YouTube">YouTube</a></li>
					</xsl:if>
					<xsl:if test="$ou:rssAcc != ''"><li class="qi smRS"><a href="{$ou:rssAcc}" title="RSS">RSS</a></li></xsl:if>
				</ul>			
			</div>	
		</xsl:if>
	</xsl:template>

	<xsl:template name="homepagequicklinks">
        <!-- Begin Virtual Quick Links Include -->
        <xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
            <xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/home-quicklinks.inc', 'utf-8')" disable-output-escaping="yes"/>
        </xsl:if>
        <xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
            <xsl:comment> com.omniupdate.div label="quickicons" </xsl:comment> 
            <xsl:comment>#include virtual="/sjsuhome/includes/home-quicklinks.inc" </xsl:comment>
            <xsl:comment> /com.omniupdate.div </xsl:comment>
        </xsl:if>
        <!-- End Virtual Quick Links Include -->		
	</xsl:template>	
	
<!--
If the page isn't at the root level, it displays the contents of 'sidenav.inc' from one level higher.
If there are child pages, it displays the contents of 'sidenav.inc from its current directory
-->
	<xsl:template name="secondarynavigation">
		<xsl:choose>
			<xsl:when test="document/config/parameter[@name='pagetype'] = 'subhome'">
				<nav class="secnav_subsite" role="navigation">
					<xsl:if test="(document/config/parameter[@name='quicklinks']/option[@value='show']/@selected = 'true')">
						<div id="quicklinks">
							<h2 class="quicklinkTitle">Quick Links</h2>
							<xsl:apply-templates select="document/maincontent/quicklinks/node()" mode="copy" />
						</div>
					</xsl:if>	
					<div class="contact-info">
						<xsl:comment> com.omniupdate.div label="search" path="/includes/department.inc"</xsl:comment> 
						<xsl:comment>#include virtual="<xsl:value-of select="$ou:sitepath"/>/includes/department.inc" </xsl:comment>
						<xsl:comment> /com.omniupdate.div </xsl:comment>
					</div>
					<span class="contact-info"><a class="sitemap_link" href="{$ou:sitepath}/siteindex.html">site index</a></span>
				</nav>
			</xsl:when>
			<xsl:when test="(document/config/parameter[@name='exception'] = '404')" >
				<xsl:comment> 404 page - no side navigation </xsl:comment>
			</xsl:when>
			<xsl:otherwise>
				<nav class="secnav" role="navigation">
					<h2>Navigate</h2>
					<a class="back_up_level" href="../"><span class="navarrowback"><!-- &nbsp; --></span>BACK to <xsl:value-of select="$back2" /></a>
					<xsl:if test="(document/config/parameter[@name='pagetype'] = 'forms')" >
						<xsl:call-template name="formsindexfilter" />
					</xsl:if>
					<xsl:if test="(document/config/parameter[@name='pagetype'] = 'siteindex')" >
						<xsl:call-template name="siteindexfilter" />
					</xsl:if>				
					<xsl:if test="($dirname != '/')" >
						<!-- #currnav is sitenav.inc from the current folder, which contains the children of the current page -->
						<ul id="childrenNav">
							<xsl:comment> com.omniupdate.div label="sidenav" path="<xsl:value-of select="$dirname"/>sidenav.inc" </xsl:comment> 
							<xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,$dirname)"/>sidenav.inc"</xsl:comment>
							<xsl:comment> /com.omniupdate.div </xsl:comment>
						</ul>			
						<!-- #prevnav is sitenav.inc from the parent directory, which contains the siblings of the current page -->
						<ul id="siblingNav">
							<xsl:comment> com.omniupdate.div label="parentnav" path="<xsl:value-of select="$parent-path"/>/sidenav.inc" </xsl:comment> 
							<xsl:comment>#include virtual="<xsl:value-of select="concat($ou:sitepath,$parent-path)"/>/sidenav.inc"</xsl:comment>
							<xsl:comment> /com.omniupdate.div </xsl:comment>		
						</ul>
					</xsl:if>	
				</nav><!-- /.secnav -->
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	
	<!-- unique content from special templates -->
	<xsl:template name="onecolumn">
		<xsl:variable name="rssfeed" select="document/config/parameter[@name='rssfeed']" />
		<xsl:variable name="rssfeeditems" select="document/config/parameter[@name='rssfeeditems']" />		
		<xsl:choose>
			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'forms')">			
				<xsl:copy-of select="document/maincontent/column_two/comment()" />
				<xsl:call-template name="forms"/>						        			
			</xsl:when>
			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'staff')">
		     	<xsl:copy-of select="document/maincontent/column_two/comment()" />			
				<xsl:call-template name="staff_template"/>					        		
			</xsl:when>					
			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'siteindex')" >
				<xsl:call-template name="siteindex" />	    				
			</xsl:when>							
			<xsl:when test="(document/config/parameter[@name='pagetype'] = 'news')">		
				<script src="http://www.google.com/jsapi?key=ABQIAAAAeqmXqXocwWEAMdOhU8DYjhSM2vXT2j2xHE_iOcqCbZQaOoosvRQNgEtu-7RQkfQtj1iaY3J7DBonyw" type="text/javascript"><!-- &nbsp; --></script>				
				<script type="text/javascript">
				        google.load("feeds", "1");
				        function OnLoad() {
				        var feedControl = new google.feeds.FeedControl();
				                feedControl.addFeed("<xsl:value-of select="$rssfeed" />");
				                feedControl.setNumEntries(<xsl:value-of select="$rssfeeditems" />);
				                feedControl.draw(document.getElementById("newsfeed"));
				        }
				        google.setOnLoadCallback(OnLoad);
				</script>
				
				<div id="newsfeed">Loading rss feed...</div>			
				<p><a href="{$rssfeed}">View more news posts</a></p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- Scripts called at the end of each page just prior to the </body>  -->
	<xsl:template name="scripts">
		<xsl:variable name="uuid" select="//ouform/@uuid"/>
		<!-- Begin Virtual Javascript Includes -->
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/js-bottom.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:choose>					
				<xsl:when test="(document/config/parameter[@name='exception'] = '404')" >
					<xsl:comment> com.omniupdate.div label="script1" </xsl:comment> 
					<xsl:comment>#include virtual="/sjsuhome/includes/404-bottom-js.inc" </xsl:comment>
					<xsl:comment> /com.omniupdate.div </xsl:comment>					
				</xsl:when>
				<xsl:otherwise>
					<xsl:comment> com.omniupdate.div label="script2" </xsl:comment> 
					<xsl:comment>#include virtual="/sjsuhome/includes/js-bottom.inc" </xsl:comment>
					<xsl:comment> /com.omniupdate.div </xsl:comment>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<!-- End Virtual Javascript Includes -->
		<!-- Begin LDP JS -->
		<xsl:variable name="galleryExists">
			<xsl:choose>
				<xsl:when test="//gallery">1</xsl:when> 
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$galleryExists = 1">
			<script src="/sjsuhome/assets/js/jquery.colorbox-min.js"></script>
			<script>
				jQuery(document).ready(function () {
					jQuery('.colorboxSlide').colorbox({ opacity:0.5 , rel:'photoGallery' });
				});
			</script>
		</xsl:if>
	
		<xsl:if test="//ouform">
			<script src="/sjsuhome/assets/js/ou-forms.js" ></script>
		</xsl:if>
		<xsl:variable name="addPollJS">
			<xsl:for-each select="//ouform/elements/element">
				<xsl:if test="./@type = 'input-radio'">
					<xsl:if test="(contains(./advanced/node(),'type=poll'))">true</xsl:if>
				</xsl:if>
			</xsl:for-each>		
		</xsl:variable>
		<xsl:if test="$addPollJS='true'">
		<script type="text/javascript" charset="utf-8">
            var poll="true";
            var form_id="<xsl:value-of select="//ouform/@uuid"/>";
            
            var names="";
            $('#ldp-poll input:radio').each(function(data){
            names=$(this).val()+":"+$(this).attr('title')+","+names;
            });
            var ajax_data="uuid="+form_id+"&amp;response=html"+"&amp;names="+ encodeURIComponent(names); 
            
            function animateResults(){
            $(".ldp--poll-results div").each(function(){
            var percentage = $(this).next().text();
            $(this).css({width: "0%"}).animate({width: percentage}, 'slow');});
            }
            function get_results(){
            $('.ldp--poll-results').html("");
            $('.ldp--poll-form').fadeOut(5);
            $('.ldp--poll-results').fadeIn(700);
            $.ajax({
            url:"/ldp/polls/get_poll.php",
			cache: false,
            data: ajax_data,
            success:function(data){
            $(".ldp--poll-results").html(data);
            $(".ldp--poll-results").append('<a href="#" class="poll-back">Return To Poll</a>');
            animateResults();
            }
            });
            }
            $(document).ready(function(){
            
            $(".results").click(function(){
            get_results();
            return false;
            });
            $(".ldp--poll-results").delegate(".poll-back","click",function(){
            $('.ldp--poll-results').hide();
            $('.ldp--poll-form').fadeIn(700);
            
            return false;
            });
            
            });
            
            
        </script>
        
        <script type="text/javascript">
            $(document).ready(function(){
            var form_data = $('#ldp-poll').serialize();
            $("#ldp-poll").bind("submit", function() {
            
            $.ajax({
            type  : "POST",
            cache : false,
			url  : "/ldp/modules/forms.php",
            data  : $(this).serialize(),
            complete: function(){},
            success: function(data) {
            $(".spanerror").removeClass("spanerror");$(".errmsg").html("").removeClass("errmsg");
            var resultObj = jQuery.parseJSON(data);
            var errC=/[faultcode]+\s:/;
            var faultCode=errC.exec(resultObj.message);
            if(resultObj.active == false){
            if(!faultCode)
            {
            $("#status").removeClass("success");
            $("#status").addClass("error");
            var dataSet=resultObj.message+"<br/>";
            $.each(resultObj.data, function(i,data){
            var d = data.message;
            highlightID="#"+data.name;
            $(highlightID).addClass("spanerror");
            $(highlightID).find("span").html(data.message).addClass("errmsg");
            });
            $("#status").html(dataSet);
            } //err Code
            else
            {
            var dataSet=resultObj.message+" "+resultObj.data;
            $("#status").addClass("error");
            $("#status").html(dataSet);
            }
            }
            else{
            $("#status").removeClass("error");
            $("#status").addClass("success");
            if(!poll){
            $("#ldp-poll").remove();
            $("#status").html(resultObj.message);
            }
            else{
            get_results();
            }
            
            }
            
            },
            error: function(data){
            
            }
            });
            
            return false;
            });
            
            
            });
        </script>
		</xsl:if>
		<!-- End LDP JS -->			
	</xsl:template>

	<xsl:template name="search">
		<!-- Begin Virtual Search Form Include -->
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/search.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="search" </xsl:comment> 
			<xsl:comment>#include virtual="/sjsuhome/includes/search.inc" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>					
		</xsl:if>
		<!-- End Virtual Search Form Include -->
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
	
	<!-- Footer Includes (virtual) -->
	<xsl:template name="footer">
		<xsl:if test="$ou:action = 'prv' or $ou:action = 'edt'">
			<xsl:value-of select="unparsed-text('http://www.sjsu.edu/sjsuhome/includes/2013-footer.inc', 'utf-8')" disable-output-escaping="yes"/>
		</xsl:if>
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">
			<xsl:comment> com.omniupdate.div label="footer" </xsl:comment> 
			<xsl:comment>#include virtual="/sjsuhome/includes/2013-footer.inc" </xsl:comment>
			<xsl:comment> /com.omniupdate.div </xsl:comment>
		</xsl:if>
		<div id="hidden"><xsl:comment> com.omniupdate.ob </xsl:comment><xsl:comment> /com.omniupdate.ob </xsl:comment></div>
		<!-- the directedit.js replaces the "Last Published" href in footer.inc with the content in this hidden div -->
	</xsl:template>

	<xsl:template name="gacode">    
		<xsl:if test="$ou:action = 'pub' or $ou:action = 'cmp'">			
			<xsl:choose>
				<xsl:when test="$ou:sitepath = ''"> 
					<xsl:comment> com.omniupdate.div label="gacode" </xsl:comment> 
					<xsl:comment>#include virtual="/includes/gacode.inc" </xsl:comment>
					<xsl:comment> /com.omniupdate.div </xsl:comment>
				</xsl:when>
				<xsl:when test="(document/config/parameter[@name='exception'] = '404')" >
					<xsl:comment>#include virtual="/sjsuhome/includes/gacode404.inc" </xsl:comment>
				</xsl:when>		
				<xsl:otherwise>
					<xsl:comment>#include virtual="/sjsuhome/includes/gacode.inc" </xsl:comment>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>		
	</xsl:template>	

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

</xsl:stylesheet>
