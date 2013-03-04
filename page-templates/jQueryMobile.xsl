<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Base on jQuery Mobile 1.0 rc2 -->
	<!-- Imports SAM XSL templates -->
	<xsl:import href="../admin/xsl-library/master-import.xsl" />

	<!-- Set the character set -->
	<xsl:output method="html" encoding="utf-8" indent="yes" />

	<!-- Params that are passed to XSL from SAM -->
	<xsl:param name="browsemode" select="'edit'" />
	<xsl:param name="userlogin" select="1" />
	<xsl:param name="version" select="xxx" />
	<xsl:param name="menumode" select="1" />
	<xsl:param name="bucket" select="Inline" />
	<xsl:param name="debug" select="1" />
	<xsl:param name="debugtext" select="1" />
	<xsl:param name="messagetext" />
	<xsl:param name="action" />
	<xsl:param name="cwidth" />

	<!-- Some handy variables for later -->
	<xsl:variable name="myHomePageID"><xsl:value-of select="/SAM/page/navigation/breadcrumb[position() = 2]/@link-id" /></xsl:variable>
	<xsl:variable name="myPrimaryPageID"><xsl:value-of select="/SAM/page/navigation/breadcrumb[position() = 3]/@link-id" /></xsl:variable>
	<xsl:variable name="mySecondaryPageID"><xsl:value-of select="/SAM/page/navigation/breadcrumb[position() = 4]/@link-id" /></xsl:variable>
	<xsl:variable name="hasSidebar"><xsl:if test="count(/SAM/page/chunk/meta[@name='Content-Group' and value='Sidebar']) &gt; 0">true</xsl:if></xsl:variable>

	<!-- The entry point for the template -->
	<xsl:template match="/SAM">

		<!-- Set the DOCTYPE targeting HTML5 -->
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html> 
		
			<head>

				<!-- Required meta tags -->
				<meta charset="utf-8">
				<meta name="viewport" content="width=device-width, initial-scale=1"> 
				
				<!-- Common meta tags -->
				<meta name="author" content="" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				
				<!-- These meta keywords and description fields concatenate chunk and page metadata that is defined in SAM -->
				<meta name="Keywords"><xsl:attribute name="content"><xsl:for-each select="/SAM/page/keywords"><xsl:value-of select="." /></xsl:for-each><xsl:for-each select="/SAM/page/chunk/meta[@name = 'Keywords']"><xsl:value-of select="value" /></xsl:for-each></xsl:attribute></meta>
				<meta name="Description"><xsl:attribute name="content"><xsl:for-each select="/SAM/page/description"><xsl:value-of select="." /></xsl:for-each><xsl:for-each select="/SAM/page/chunk/meta[@name = 'Description']"><xsl:value-of select="value" /></xsl:for-each></xsl:attribute></meta>		

				<!-- Favicon and touch icon links -->
				<!--<link rel="shortcut icon" href="/favicon.ico" />-->
				<!--<link rel="apple-touch-icon" href="/apple-touch-icon.png" />-->
				
				<title><xsl:value-of select="/SAM/page/title" disable-output-escaping="yes" /></title>
				
				<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.css" />
				<!--<link rel="stylesheet" href="/css/jquery.mobile-1.0rc2.min.css" />-->
				
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
				<script><xsl:text disable-output-escaping="yes"><![CDATA[!window.jQuery && document.write(unescape('%3Cscript src="/js/jquery-1.6.4.min.js"%3E%3C/script%3E'))]]></xsl:text></script>
				
				<script src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
				<script><xsl:text disable-output-escaping="yes"><![CDATA[!window.jQuery.widget && document.write(unescape('%3Cscript src="/js/jquery.mobile-1.0rc2.min.js"%3E%3C/script%3E'))]]></xsl:text></script>

			</head> 
		
			<body> 
				<!-- Add class names for primary, secondary and active pages. Also adds class for home page and inidcator for if the page has a sidebar -->
<<<<<<< HEAD
				<xsl:attribute name="class">p<xsl:value-of select="$myPrimaryPageID" /> p<xsl:value-of select="$mySecondaryPageID" /> p<xsl:value-of select="/SAM/page/@id" /><xsl:if test="/SAM/page/@id = $myHomePageID"> home</xsl:if><xsl:if test="$hasSidebar = 'true'"> hasSidebar</xsl:if></xsl:attribute>
=======
				<xsl:attribute name="class">p<xsl:value-of select="$myPrimaryPageID" /> p<xsl:value-of select="$mySecondaryPageID" /> p<xsl:value-of select="/SAM/page/@id" />
    			<xsl:if test="/SAM/page/@id = $myHomePageID"> home</xsl:if>
    			<xsl:if test="$hasSidebar = 'true'"> hasSidebar</xsl:if>
>>>>>>> Update to jQuery Mobile 1.3.0
    				
				<div data-role="page">
		
					<div data-role="header">
						<xsl:call-template name="header" />
					</div><!-- /header -->
		
					<div data-role="content">	
						<xsl:call-template name="navigation" />
						<xsl:call-template name="inline" />
						<xsl:call-template name="sidebar" />
						
					</div><!-- /content -->
		
					<div data-role="footer">
						<xsl:call-template name="footer" />
						<xsl:call-template name="footerNav" />
					</div><!-- /footer -->
		
				</div><!-- /page -->
		
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="header">
	</xsl:template>
	
	<xsl:template name="navigation">
		<nav class="primaryNav">
			<div class="pageWidth">
				<xsl:call-template name="ulNavigation" />
			</div>
		</nav>
	</xsl:template>
	
	<xsl:template name="inline">
		<section>
			<xsl:call-template name="bucket-handler">
				<xsl:with-param name="bucket-label">Inline</xsl:with-param>
			</xsl:call-template>
		</section>
	</xsl:template>
	
	<xsl:template name="sidebar">
		<aside>
			<xsl:call-template name="bucket-handler">
				<xsl:with-param name="bucket-label">Sidebar</xsl:with-param>
			</xsl:call-template>
		</aside>
	</xsl:template>
	
	<xsl:template name="footer">
		<footer>
			<xsl:call-template name="bucket-handler">
				<xsl:with-param name="bucket-label">Footer</xsl:with-param>
			</xsl:call-template>
		</footer>
	</xsl:template>
	
	<xsl:template name="footerNav">
		<nav class="leftNav">
			<xsl:call-template name="ulNavigation">
				<xsl:with-param name="parent" select="$myPrimaryPageID" />
				<xsl:with-param name="depth" select="9999" />
			</xsl:call-template>
		</nav>
	</xsl:template>
</xsl:stylesheet>