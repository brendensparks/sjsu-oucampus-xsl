<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou">


<xsl:template name="z_footer">
	<h1 class="acc">Footer Navigation</h1>
	<ul id="globalnav">
		<li><a href="http://my.sjsu.edu">MySJSU</a></li>
		<li><a href="http://www.sjsu.edu/siteindex">A-Z Index</a></li>
		<li><a href="http://www.sjsu.edu/directory">Directory</a></li>
		<li><a href="http://www.sjsu.edu/map">Campus Map</a></li>
	</ul>
	<div class="footernav">
		<div class="col one">
			<h2>Colleges</h2>
			<ul>
				<li><a href="#">Applied Sciences &amp; Arts</a></li>
				<li><a href="#">Business</a></li>
				<li><a href="#">Education</a></li>
				<li><a href="#">Engineering</a></li>
				<li><a href="#">Humanities &amp; the Arts</a></li>
				<li><a href="#">Science</a></li>
				<li><a href="#">Social Sciences</a></li>
			</ul>
		</div>
		<div class="col two">
		<h2>Study at SJSU</h2>
			<ul>
				<li><a href="#">Apply Now</a></li>
				<li><a href="#">Colleges &amp; Departments</a></li>
				<li><a href="#">Financial Aid</a></li>
				<li><a href="#">Continuing Studies</a></li>
				<li><a href="#">Graduate Studies</a></li>
				<li><a href="#">Graduate Admissions</a></li>
				<li><a href="#">International Programs</a></li>
			</ul>
		</div>
		<div class="col three">
		<h2>Student Services</h2>
			<ul>
				<li><a href="#">Advising Hub</a></li>
				<li><a href="#">Alert-SJSU</a></li>
				<li><a href="#">Catalog</a></li>
				<li><a href="#">Class Schedules</a></li>
				<li><a href="#">Final Exam Schedule</a></li>
				<li><a href="#">eCampus</a></li>
				<li><a href="#">Career Center</a></li>
			</ul>
		</div>
		<div class="col four">
		<h2>Resources</h2>
			<ul>
				<li><a href="#">Academic Calendar</a></li>
				<li><a href="#">Accessibility</a></li>
				<li><a href="http://www.facebook.com/sanjosestate">University Facebook</a></li>
				<li><a href="http://twitter.com/#!/SJSU">University Twitter Feed</a></li>
			</ul>
		</div>
	</div>
	
	<div class="left">
        &copy;2011 SJSU<br />
        <xsl:if test="$ou:action ='edt' or $ou:action ='prv'" ><a href="#">Last Modified: </a></xsl:if>
        <xsl:comment> com.omniupdate.ob </xsl:comment><xsl:comment> /com.omniupdate.ob </xsl:comment>
    </div>
    <div class="right">
    	<a href="/" class="btn_logo_f" title="SJSU">SJSU</a>
        <a href="http://www.sjsu.edu/map/">One Washington Square, <br />
        San Jos&eacute;, CA 95192 <br />
        408-924-1000</a>
    </div>

</xsl:template>
</xsl:stylesheet>
