<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ablieferung - Provenienz - Ordnungsystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:variable name="signature">
			<xsl:value-of select="$archsig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="xI2reference">
				<xsl:with-param name="signature" select="$signature"/>
				<xsl:with-param name="org">archival</xsl:with-param>
			</xsl:call-template>
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:attribute name="isadId">1.2</xsl:attribute>
				<xsl:attribute name="origin">archival</xsl:attribute>
				<xsl:attribute name="obligation">mandatory</xsl:attribute>
				<xsl:choose>
					<xsl:when test="$fondtitle">
						<xsl:value-of select="$fondtitle"/>
					</xsl:when>
					<xsl:when test="arelda:provenienz/arelda:registratur/text()">
						<xsl:value-of select="arelda:provenienz/arelda:registratur"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:ordnungssystem/arelda:name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<xsl:if test="arelda:entstehungszeitraum">
				<xsl:call-template name="xI2date">
					<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
					<xsl:with-param name="org">/entstehungszeitraum</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:existenzzeitraum">
				<xsl:call-template name="xI2date">
					<xsl:with-param name="range" select="arelda:provenienz/arelda:existenzzeitraum"/>
					<xsl:with-param name="org">/provenienz/existenzzeitraum</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="arelda:ordnungssystem/arelda:anwendungszeitraum">
				<xsl:call-template name="xI2date">
					<xsl:with-param name="range" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
					<xsl:with-param name="org">/ordnungssystem/anwendungszeitraum</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- 3.1.4 Verzeichnungsstufe -->
			<xsl:element name="descriptionLevel">
				<xsl:attribute name="isadId">1.4</xsl:attribute>
				<xsl:attribute name="origin">ingest</xsl:attribute>
				<xsl:attribute name="obligation">mandatory</xsl:attribute>
				<xsl:text>Bestand</xsl:text>
			</xsl:element>
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
		</xsl:element>
		<xsl:element name="context">
			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="creator">
					<xsl:value-of select="arelda:provenienz/arelda:aktenbildnerName"/>
				</xsl:element>
			</xsl:if>
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<xsl:if test="arelda:provenienz/arelda:geschichteAktenbildner/text()">
				<xsl:element name="adminBioHistory">
					<xsl:value-of select="arelda:provenienz/arelda:geschichteAktenbildner"/>
				</xsl:element>
			</xsl:if>
			<!-- 3.2.3 Bestandesgeschichte -->
			<xsl:if test="arelda:provenienz/arelda:systemBeschreibung/text()">
				<xsl:element name="archivalHistory">
					<xsl:value-of select="arelda:provenienz/arelda:systemBeschreibung/text()"/>
				</xsl:element>
			</xsl:if>
			<!-- 3.2.4 Abgebende Stelle -->
			<xsl:if test="arelda:ablieferndeStelle/text()">
				<xsl:element name="acqInfo">
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<xsl:element name="contentStructure">
			<!-- 3.3.1 Form und Inhalt -->
			<xsl:if test="arelda:ablieferungsteile/text()">
				<xsl:element name="scopeContent">
					<xsl:element name="content">
						<xsl:value-of select="arelda:ablieferungsteile"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- 3.3.2 Bewertung und Kassation -->
			<xsl:if test="arelda:referenzBewertungsentscheid/text()">
				<xsl:element name="appraisalDestruction">
					<xsl:value-of select="arelda:referenzBewertungsentscheid"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<xsl:element name="conditionsAccessUse">
			<!-- 3.3.4 Ornungssystem und Klassifikation -->
			<!-- ToDo -->
			<!-- 3.4.1 Zugangsbestimmungen -->
			<!-- ToDo -->
			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
			<!--   -->
		</xsl:element>
		<xsl:element name="notes">
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="note">
					<xsl:value-of select="arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:bemerkung/text()">
				<xsl:element name="note">
					<xsl:value-of select="arelda:provenienz/arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:ordnungssystem/arelda:bemerkung/text()">
				<xsl:element name="note">
					<xsl:value-of select="arelda:ordnungssystem/arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
