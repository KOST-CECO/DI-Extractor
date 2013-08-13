<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- parameter -->
	<xsl:param name="fondtitle"/>
	<!-- helper functions and named templates -->
	<xsl:include href="xIdate.xsl"/>
	<xsl:include href="xIaccess.xsl"/>
	<xsl:include href="xIreference.xsl"/>
	<!-- schema location -->
	<xsl:variable name="location">ISADG xIsadg_v1.6.1.xsd</xsl:variable>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="archivalDescription">
			<!--    
			<xsl:variable name="temp">
				<xsl:element name="xlink:dummy" namespace="http://www.scope.ch/Uebernahme"/>
			</xsl:variable>
			<xsl:copy-of select="msxsl:node-set($temp)//namespace::*"/>
			-->
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz - Ordnungsystem -->
	<xsl:include href="xIfond.xsl"/>
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition"/>
	</xsl:template>
	<!-- Ordnungsystemposition -->
	<xsl:include href="xIserie.xsl"/>
	<!-- Dossier -->
	<xsl:include href="xIfile.xsl"/>
	<!-- Dokument -->
	<xsl:include href="xIitem.xsl"/>
</xsl:stylesheet>
