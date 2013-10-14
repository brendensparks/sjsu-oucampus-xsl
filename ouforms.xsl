<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="ou xsl xs">
	
<xsl:import href="datasets.xsl"/>
	
<xsl:template match="ouform" mode="copy">

	<div id="status"></div>
	
	<xsl:variable name="uuid" select="//ouform/@uuid"/>
	
	<xsl:variable name="isPoll">
		<xsl:for-each select="//ouform/elements/element">
			<xsl:if test="./@type = 'input-radio'">
				<xsl:if test="(contains(./advanced/node(),'type=poll'))">true</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
		


	<xsl:choose>
		<xsl:when test="$isPoll='true'">
			<xsl:call-template name="ouform_poll"/>
		</xsl:when>
		<xsl:otherwise>
			<form id="form" name="contact-form" method="post" class="ldpforms">
				
				<xsl:for-each select="elements">
				
					<xsl:for-each select="./element">
						
						<xsl:variable name="adv" select="./advanced/node()"/>
						
						<xsl:if test="contains(ou:get-adv($adv,'fieldset_start'),'true')">
							<xsl:text disable-output-escaping="yes">&lt;fieldset&gt;</xsl:text>
							<legend class="none">
							<xsl:attribute name="class">
							<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
							   </xsl:attribute>
							<xsl:value-of select="ou:get-adv($adv,'fieldset_label')"/>
							</legend>
						</xsl:if>
						
						
					<!-- Single-line Text Field -->
						<xsl:if test="./@type = 'input-text'">
							<xsl:choose>
								<xsl:when test="contains(ou:get-adv($adv,'legend'),'true')">
										<br /><span class="clearfix none">
										<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
											<xsl:attribute name="class">
												<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
											</xsl:attribute>
										</xsl:if>
										<xsl:copy-of select="./default/node()"/>
									</span>
								</xsl:when>
								<xsl:otherwise>
								<br />
									<span id="{./@name}" class="clearfix none">
										<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
											<xsl:attribute name="class">
												<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
											</xsl:attribute>
										</xsl:if>
										<label for="{concat('id_',./@name)}"><xsl:value-of select="./label/node()"/></label>
										<!-- if the document is HTML5 you can use placeholder attribute eg. placeholder="{./default/node()}" -->
										<xsl:choose>
										<xsl:when test="not(contains(ou:get-adv($adv,'size'),'false'))">
										<input type="text" name="{./@name}" id="{concat('id_',./@name)}" size="{ou:get-adv($adv,'size')}" />
										</xsl:when>
										<xsl:otherwise>
										<input type="text" name="{./@name}" id="{concat('id_',./@name)}" />
										</xsl:otherwise>
										</xsl:choose>
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						
						
						<!-- Multi-line Text Field -->
						<xsl:if test="./@type = 'textarea'">
							
							<span id="{./@name}" class="clearfix none">
								<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
									<xsl:attribute name="class">
										<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
									</xsl:attribute>
								</xsl:if>
								<label for="{concat('id_',./@name)}"><xsl:value-of select="./label/node()"/></label>
												
								<!-- if the document is HTML5 you can use placeholder attribute eg. placeholder="{./default/node()}" -->
								<xsl:element name="textarea">
								
										<xsl:attribute name="name"><xsl:value-of select="./@name" /></xsl:attribute>
										<xsl:attribute name="id"><xsl:value-of select="concat('id_',./@name)" /></xsl:attribute>
										
										<xsl:if test="not(contains(ou:get-adv($adv,'cols'),'false'))">
										<xsl:attribute name="cols"><xsl:value-of select="ou:get-adv($adv,'cols')" /></xsl:attribute>
										</xsl:if>
										
										<xsl:if test="not(contains(ou:get-adv($adv,'rows'),'false'))">
										<xsl:attribute name="rows"><xsl:value-of select="ou:get-adv($adv,'rows')" /></xsl:attribute>
										</xsl:if>
										
										<xsl:if test="not(contains(ou:get-adv($adv,'size'),'false'))">
										<xsl:attribute name="size"><xsl:value-of select="ou:get-adv($adv,'size')" /></xsl:attribute>
										</xsl:if>
										
										<xsl:copy-of select="./default/node()"/><xsl:value-of select="''"/>
								</xsl:element>
								
							</span>
						</xsl:if>
						
						
						<!-- Radio Button Control-->
						<xsl:if test="./@type = 'input-radio'">
						
							<span id="{./@name}" class="clearfix none">
								<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
									<xsl:attribute name="class">
										<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
									</xsl:attribute>
								 </xsl:if>
								<xsl:variable name="field_name" select="./@name"/>
								<label><xsl:value-of select="./label/node()"/></label>
							
								<xsl:choose>
									<xsl:when test="not(contains($adv,'dataset'))">
										<xsl:for-each select="./options/option">
											<label class="radio">
											<input type="radio" name="{$field_name}" value="{./@value}">
												<xsl:if test="./@selected = 'true'">									
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input><xsl:copy-of select="./node()"/>
											</label>
				
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="tokenize(ou:create-dataset($adv), ',')" >
											<label class="radio">
											<input type="radio" name="{$field_name}" value="{.}">
											</input><xsl:copy-of select="."/></label>
										</xsl:for-each>	
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</xsl:if>
						
						
						<!-- Checkbox Control-->
						<xsl:if test="./@type = 'input-checkbox'">
						
							<span id="{./@name}" class="clearfix none">
								<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
									<xsl:attribute name="class">
										<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
									</xsl:attribute>
								</xsl:if>
								<!--code-php-start-->
								 <xsl:variable name="field_name" select="concat(./@name,'[]')"/> 
								<!--code-php-end-->
								<!--code-asp-start-->
								<!--asp <xsl:variable name="field_name" select="./@name"/> asp-->
								<!--code-asp-end-->
								
								<label ><xsl:value-of select="./label/node()"/></label>
									
								<xsl:choose>
									<xsl:when test="not(contains($adv,'dataset'))">
										<xsl:for-each select="./options/option">
											<label class="checkbox">
											<input type="checkbox" name="{$field_name}" value="{./@value}" >
												<xsl:if test="./@selected = 'true'">									
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input>
											<xsl:copy-of select="./node()"/>
												</label>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="tokenize(ou:create-dataset($adv), ',')" >
											<label class="checkbox">
											<input type="checkbox" name="{$field_name}" value="{.}">
											</input>
												<xsl:copy-of select="."/></label>
										</xsl:for-each>	
									</xsl:otherwise>
								</xsl:choose>
								</span>
						</xsl:if>
					
						
						<!-- List Box -->
						<xsl:if test="./@type = 'select-single'">
						
							<span id="{./@name}" class="clearfix none">
								<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
									<xsl:attribute name="class">
										<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
									</xsl:attribute>
								</xsl:if>
								<!--code-php-start-->
								 <xsl:variable name="field_name" select="concat(./@name,'[]')"/> 
								<!--code-php-end-->
								<!--code-asp-start-->
								<!--asp <xsl:variable name="field_name" select="./@name"/> asp-->
								<!--code-asp-end-->
								
								<label for="{concat('id_',./@name)}"><xsl:value-of select="./label/node()"/></label>
								
								<!-- adds a * on required fields End -->	
								<select name="{$field_name}" id="{concat('id_',./@name)}">
									<xsl:choose>
										<xsl:when test="not(contains($adv,'dataset'))">
											<xsl:for-each select="./options/option">
												<option value="{./@value}" >
													<xsl:if test="./@selected = 'true'">									
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:copy-of select="./node()"/>
												</option>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:for-each select="tokenize(ou:create-dataset($adv), ',')" >
												<option value="{.}" >
													<xsl:copy-of select="."/>
												</option>
											</xsl:for-each>	
										</xsl:otherwise>
									</xsl:choose>
								</select>
							</span>
						</xsl:if>
						
						<!-- Multi-Select List-->
						<xsl:if test="./@type = 'select-multiple'">
						
							<span id="{./@name}" class="clearfix none">
								<xsl:if test="not(contains(ou:get-adv($adv,'addclass'),'false'))">
									<xsl:attribute name="class">
										<xsl:value-of select="ou:ldp-create-class($adv,'none')"/>
									</xsl:attribute>
								</xsl:if>
								<!--code-php-start-->
								 <xsl:variable name="field_name" select="concat(./@name,'[]')"/> 
								<!--code-php-end-->
								<!--code-asp-start-->
								<!--asp <xsl:variable name="field_name" select="./@name"/> asp-->
								<!--code-asp-end-->
								
								<label for="{concat('id_',./@name)}"><xsl:value-of select="./label/node()"/></label>
							
								<select name="{$field_name}" multiple="multiple" size="5" id="{concat('id_',./@name)}">
									<xsl:choose>
										<xsl:when test="not(contains($adv,'dataset'))">
											<xsl:for-each select="./options/option">
												<option value="{./@value}" >
													<xsl:if test="./@selected = 'true'">									
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:copy-of select="./node()"/>
												</option>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:for-each select="tokenize(ou:create-dataset($adv), ',')" >
												<option value="{.}" >
													<xsl:copy-of select="."/>
												</option>
											</xsl:for-each>	
										</xsl:otherwise>
									</xsl:choose>	
								</select>
							</span>
						</xsl:if>
						
						
						
						<xsl:if test="contains(ou:get-adv($adv,'fieldset_end'),'true')">
							<xsl:text disable-output-escaping="yes">&lt;/fieldset&gt;</xsl:text>
						</xsl:if>
					</xsl:for-each>
				
				</xsl:for-each>
				
				<input type="hidden" name="form_uuid" value ="{$uuid}"/>
				<input type="hidden" name="site_name" value ="{$ou:site}"/>
				<xsl:if test="not($ou:action='prv')">
					<br/><input type="submit" name="button" id="btn btn-info" class="submit" value="Submit" />
				</xsl:if>
			</form>

    	</xsl:otherwise>
	</xsl:choose>
</xsl:template> 

<xsl:template name="ouform_poll">
    <xsl:variable name="uuid" select="//ouform/@uuid"/>
	<div class="ldp-poll-container clearfix">
            <div class="ldp-poll-form">
                
                <form id="ldp-poll" name="ldp-poll" method="post" class="ldpforms">
                    <xsl:for-each select="//ouform/elements/element">
                         <xsl:if test="./@type = 'input-radio'">
                            
                            <div id="{./@name}">
                                <xsl:variable name="field_name" select="./@name"/>
                                <h4><xsl:value-of select="./label"/></h4>
                                    <xsl:for-each select="./options/option">
										
										<input type="radio" class="ldp--inputRadio" name="{$field_name}" value="{./@value}" title="{./node()}" id="{lower-case(replace(./node(),' ','-'))}">
                                            <xsl:if test="./@selected = 'true'">									
                                                <xsl:attribute name="checked">checked</xsl:attribute>
                                            </xsl:if>
										</input><label class="ldp--labelRadio" for="{lower-case(replace(./node(),' ','-'))}"><xsl:copy-of select="./node()"/></label>
                                    </xsl:for-each>
                            </div>
                        </xsl:if>
                    </xsl:for-each>	
                    <input type="hidden" name="polltext" value ="poll_text"/>	
					<input type="hidden" name="site_name" value ="{$ou:site}"/>
                    <input type="hidden" name="type" value ="poll"/>	
                    <input type="hidden" name="form_uuid" value ="{$uuid}"/>
                    <xsl:if test="not($ou:action='prv')">
                        <input type="submit" name="button" id="button" class="submit" value="Submit" />
                    </xsl:if>
                </form>		
                <xsl:if test="not($ou:action='prv')">
					<p><a href="#" class="results" >View Results</a></p>
                </xsl:if>
            </div>
            <div class="ldp-poll-results">
                
            </div>
        </div>     
        
        
    </xsl:template>
		
<xsl:function name="ou:forms-js">		
	<script type="text/javascript" src="/sjsuhome/assets/js/ouforms.js"></script>			
</xsl:function>
		
<xsl:function name="ou:forms-css">
	<link rel="stylesheet" href="/sjsuhome/css/ouforms-bootstrap.css"/>
</xsl:function>		

<xsl:function name="ou:get-adv">
	<xsl:param name="adv"/>
	<xsl:param name="key"/>
	<xsl:choose>
		<xsl:when test="contains($adv,$key)">
			<xsl:value-of select="substring-before(substring-after($adv,concat($key,'=')),';')"/>
		</xsl:when>
		<xsl:otherwise>
			false
		</xsl:otherwise>
	</xsl:choose>
</xsl:function>

<xsl:function name="ou:ldp-create-class">
	<xsl:param name="adv" />
	<xsl:param name="predefined-class" />
	<xsl:variable name="class-name">
	<xsl:if test="contains($adv,'addclass')">
		<xsl:value-of select="ou:get-adv($adv,'addclass')"/>
	</xsl:if>
	</xsl:variable>
	<xsl:value-of select="normalize-space(concat($predefined-class,' ',$class-name))"/>
</xsl:function>

</xsl:stylesheet>
