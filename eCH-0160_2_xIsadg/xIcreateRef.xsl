<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- helper functions and named templates -->
	<xsl:template name="xIreference">
		<xsl:param name="ref"/>
		<xsl:element name="referenceCode">
			<xsl:value-of select="generate-id($ref)"/>
		</xsl:element>
	</xsl:template>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="reference">
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz - Ordnungsystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="xIreference">
				<xsl:with-param name="ref" select="arelda:ordnungssystem"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition"/>
	</xsl:template>
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="xIreference">
				<xsl:with-param name="ref" select="arelda:nummer"/>
			</xsl:call-template>
		</xsl:element>
		<xsl:apply-templates select="arelda:ordnungssystemposition"/>
		<xsl:apply-templates select="arelda:dossier"/>
	</xsl:template>
	<!-- Dossier -->
	<xsl:template match="arelda:dossier">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="xIreference">
				<xsl:with-param name="ref" select="arelda:aktenzeichen"/>
			</xsl:call-template>
		</xsl:element>
		<xsl:apply-templates select="arelda:dokument"/>
	</xsl:template>
	<!-- Dokument -->
	<xsl:template match="arelda:dokument">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="xIreference">
				<xsl:with-param name="ref" select="@id"/>
			</xsl:call-template>
		</xsl:element>
		<xsl:apply-templates select="arelda:ordnungssystemposition"/>
	</xsl:template>
</xsl:stylesheet>
