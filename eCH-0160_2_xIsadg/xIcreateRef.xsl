<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- helper functions and named templates -->
	<xsl:param name="archsignatur"/>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="reference">
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$archsignatur"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Ordnungsystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsignatur"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="arelda:dossier">
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Dossier -->
	<xsl:template match="arelda:dossier">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates select="arelda:dokument">
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Dokument -->
	<xsl:template match="arelda:dokument">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
