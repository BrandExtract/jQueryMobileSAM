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

	<!-- Some configuration variables for the mobile site -->
	<xsl:variable name="showHeaderOnHome" select="'yes'" /> <!-- Should we show the persistent header on the home page yes/no -->
	<xsl:variable name="showFooterOnHome" select="'yes'" /> <!-- Should we show the persistent footer on the home page yes/no -->
	
	
	<!-- The entry point for the template -->
	<xsl:template match="/SAM">

		<!-- Set the DOCTYPE targeting HTML5 -->
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html> 
		
			<head>
				<!-- Required meta tags -->
				<meta charset="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1" /> 
				
				<!-- Common meta tags -->
				<meta name="description" content="" />
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
				<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
				<script src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
			</head> 
		
			<body> 
				<!-- Add class names for primary, secondary and active pages. Also adds class for home page and inidcator for if the page has a sidebar -->
				<xsl:attribute name="class">p<xsl:value-of select="$myPrimaryPageID" /> p<xsl:value-of select="$mySecondaryPageID" /> p<xsl:value-of select="/SAM/page/@id" /></xsl:attribute>
    			<xsl:if test="/SAM/page/@id = $myHomePageID"> home</xsl:if>
    			<xsl:if test="$hasSidebar = 'true'"> hasSidebar</xsl:if>
    				
				<div data-role="page" data-add-back-btn="true">
		
					<div data-role="header">
						<xsl:call-template name="persistHeader" />
					</div><!-- /header -->
		
					<div data-role="content">	
						<xsl:call-template name="header" />
						<xsl:call-template name="navigation" />
						<xsl:call-template name="inline" />
						<xsl:call-template name="sidebar" />
						<xsl:call-template name="footer" />
					</div><!-- /content -->
		
					<div data-role="footer">
						<xsl:call-template name="persistFooter" />
					</div><!-- /footer -->
		
				</div><!-- /page -->
		
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="persistHeader">
		<xsl:if test="/SAM/page/@id != $myHomePageID or $showHeaderOnHome = 'yes'">
			<!-- Enter content that should appear at the top of every singe page here -->
			PERSISTENT HEADER
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="header">
		<header>
			<xsl:call-template name="bucket-handler">
				<xsl:with-param name="bucket-label">Header</xsl:with-param>
			</xsl:call-template>
		</header>
	</xsl:template>
	
	<xsl:template name="navigation">
		<nav class="primaryNav">
			<xsl:call-template name="jqmulNavigation">
				<xsl:with-param name="depth" select="1" />
				<xsl:with-param name="parent" select="/SAM/page/@id" />
			</xsl:call-template>
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
	
	<xsl:template name="persistFooter">
		<xsl:if test="/SAM/page/@id != $myHomePageID or $showFooterOnHome = 'yes'">
			<!-- Enter content that should appear at the bottom of every singe page here -->
			PERSISTENT FOOTER
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="jqmulNavigation">
		<xsl:param name="parent" select="/SAM/page/navigation/breadcrumb[position() = 2]/@link-id"/>
		<xsl:param name="depth" select="1"/>
		<xsl:param name="complete" select="false" />
		<xsl:param name="suppressHidden" select="'false'" />
		<xsl:param name="suppressPopups" select="false()" />
		<xsl:param name="sortOrder" select="'ascending'" />
		<xsl:param name="idPrefix" select="'ulNav'" />
		<xsl:param name="count" select="0"/>
		<xsl:param name="alpha" select="0" />
		<xsl:param name="theme" select="a" />
		<xsl:if test="count(/SAM/navigation/link[@parent-id = $parent and (@navigable = 1 or /SAM/@directive = 'admin')]) &gt; 0">
			<xsl:text disable-output-escaping="yes"><![CDATA[<!--googleoff: index -->]]></xsl:text>
			<ul data-role="listview" data-theme="{$theme}">
				<xsl:for-each select="/SAM/navigation/link[@parent-id = $parent and (@navigable = 1 or (/SAM/@directive = 'admin' and ($suppressHidden = 'false' or $parent = 47)))]">
					<xsl:sort select="title[$alpha != 0]" data-type="text" order="ascending" />
					<xsl:sort select="@sequence[$sortOrder = 'ascending']" data-type="number" order="ascending" />
					<xsl:sort select="@sequence[$sortOrder = 'descending']" data-type="number" order="descending" />
					<xsl:if test="$count = 0 or position() &lt;= $count">
					<li id="{$idPrefix}{@id}">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="count(/SAM/page/navigation/breadcrumb[@link-id = current()/@id and position() != last()]) &gt; 0">active ancestor</xsl:when>
								<xsl:when test="count(/SAM/page/navigation/breadcrumb[@link-id = current()/@id]) &gt; 0">active</xsl:when>
								<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
							<xsl:if test="position() = 1"> first</xsl:if>
							<xsl:if test="position() = last()"> last</xsl:if>
						</xsl:attribute>
						 <xsl:choose>
								<xsl:when test="@id = /SAM/page/@id and 1=2">
								<xsl:value-of select="title" />
							  </xsl:when>
							  <xsl:otherwise>
								<xsl:call-template name="navigation-link"><xsl:with-param name="suppressPopups" select="$suppressPopups"/>
										<xsl:with-param name="useLabel">
											<xsl:value-of select="title" />
										</xsl:with-param>
									</xsl:call-template>
							  </xsl:otherwise>
								</xsl:choose>
						   
						<xsl:if test="count(/SAM/page/navigation/breadcrumb[@link-id = current()/@id or $complete = 'true']) &gt; 0 and $depth &gt; 1">
						   
								<xsl:call-template name="ulNavigation">
								  <xsl:with-param name="parent"><xsl:value-of select="@id" /></xsl:with-param>
								  <xsl:with-param name="depth"><xsl:value-of select="$depth - 1" /></xsl:with-param>
								  <xsl:with-param name="complete"><xsl:value-of select="$complete" /></xsl:with-param>
								  <xsl:with-param name="suppressHidden"><xsl:value-of select="$suppressHidden" /></xsl:with-param>
								  <xsl:with-param name="sortOrder"><xsl:value-of select="$sortOrder" /></xsl:with-param>
							  </xsl:call-template>
						   
						</xsl:if>
					</li>
					</xsl:if>
				</xsl:for-each>
			</ul>
			<xsl:text disable-output-escaping="yes"><![CDATA[<!--googleon: index -->]]></xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>