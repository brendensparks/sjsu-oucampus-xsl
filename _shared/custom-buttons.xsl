<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
]>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ou="http://omniupdate.com/XSL/Variables"
    xmlns:ouc="http://omniupdate.com/XSL/Variables"
    exclude-result-prefixes="xs ou ouc">
    
    
    <!-- Creates a default style for edit buttons -->
    <xsl:template name="editButtonStyle">
        <xsl:if test="$ou:action = 'edt'">
            <style type="text/css">
                .oucEditButton{
                filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#ffffff', EndColorStr='#dbdbdb');
                -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorStr='#ffffff', EndColorStr='#dbdbdb')";
                border: 1px solid #F10303;
                -moz-box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.4);
                -webkit-box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.4);
                box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.4);
                border-radius: 7px;
                -webkit-border-radius: 7px;
                -moz-border-radius: 7px;
                padding: 5px 0px 5px 37px;
                text-decoration: none;
                text-shadow: #fff 0 1px 0;
                /*float: left;*/
                margin-right: 15px;
                /*margin-bottom: 15px;*/
                display: block;
                color: #455868;
                line-height: 18px;
                font-size: 13px;
                font-weight: bold;
                width:126px;
                background:url(/_resources/img/edit.png) no-repeat 4px 0px ;
                }
                
                a:hover.oucEditButton{
                
                filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#ffffff', EndColorStr='#eeeeee');
                -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorStr='#ffffff', EndColorStr='#eeeeee')";
                color: #000;
                display: block;
                }
                
                a:active.oucEditButton{
                
                filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#dbdbdb', EndColorStr='#ffffff');
                -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorStr='#dbdbdb', EndColorStr='#ffffff')";
                text-shadow: 0px -1px 0 rgba(255, 255, 255, 0.5);
                margin-top: 1px;
                }
            </style>	
        </xsl:if>
    </xsl:template> 
</xsl:stylesheet>