<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- parameter -->
	<xsl:param name="fondtitle"/>
	<!-- helper functions and named templates -->
	<xsl:include href="xIdate.xsl"/>
	<xsl:include href="xIaccess.xsl"/>
	<xsl:include href="xIreference.xsl"/>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="archivalDescription">
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz - Ordnungsystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:choose>
					<xsl:when test="arelda:provenienz/arelda:systemName/text()">
						<xsl:variable name="ref">
							<xsl:value-of select="arelda:provenienz/arelda:systemName"/>
							<xsl:if test="arelda:ordnungssystem/arelda:generation/text()">
								<xsl:text>: </xsl:text>
								<xsl:value-of select="arelda:ordnungssystem/arelda:generation"/>
							</xsl:if>
						</xsl:variable>
						<xsl:value-of select="arelda:xIreference($ref)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:xIreference(arelda:ablieferungsnummer)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition"/>
	</xsl:template>
	<!-- Ordnungsystemposition -->
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<!-- 3.1.1 Signatur -->
				<xsl:element name="referenceCode">
					<xsl:value-of select="arelda:xIreference(arelda:nummer)"/>
				</xsl:element>
			</xsl:element>
			<xsl:apply-templates select="arelda:ordnungssystemposition"/>
			<xsl:apply-templates select="arelda:dossier"/>
		</xsl:element>
	</xsl:template>
	<!-- Dossier -->
	<xsl:template match="arelda:dossier">
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<!-- 3.1.1 Signatur -->
				<xsl:element name="referenceCode">
					<xsl:value-of select="arelda:xIreference(arelda:aktenzeichen)"/>
				</xsl:element>
				<!--   -->
			</xsl:element>
			<xsl:apply-templates select="arelda:dokument"/>
		</xsl:element>
	</xsl:template>
	<!-- Dokument -->
	<xsl:template match="arelda:dokument">
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<!-- 3.1.1 Signatur -->
				<xsl:element name="referenceCode">
					<xsl:value-of select="arelda:xIreference(@id)"/>
				</xsl:element>
			</xsl:element>
			<xsl:apply-templates select="arelda:ordnungssystemposition"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
