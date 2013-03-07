<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- named template checkXdate -->
	<xsl:template name="insertXdate">
		<xsl:param name="datum"/>
		<xsl:element name="dates">
			<xsl:choose>
				<xsl:when test="string-length($datum/arelda:von/arelda:datum) = 4">
					<xsl:element name="fromYear">
						<xsl:value-of select="$datum/arelda:von/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="string-length($datum/arelda:von/arelda:datum) = 10">
					<xsl:element name="fromDate">
						<xsl:value-of select="$datum/arelda:von/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="fromDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="string-length($datum/arelda:bis/arelda:datum) = 4">
					<xsl:element name="toYear">
						<xsl:value-of select="$datum/arelda:bis/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="string-length($datum/arelda:bis/arelda:datum) = 10">
					<xsl:element name="toDate">
						<xsl:value-of select="$datum/arelda:bis/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="toDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!-- schema location -->
	<xsl:variable name="location">ISADG xIsadg_v1.6.xsd</xsl:variable>
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
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz - Ordnungsystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:choose>
					<xsl:when test="arelda:provenienz/arelda:systemName/text()">
						<xsl:value-of select="arelda:provenienz/arelda:systemName"/>
						<xsl:if test="arelda:ordnungssystem/arelda:generation/text()">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="arelda:ordnungssystem/arelda:generation"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:ablieferungsnummer"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:choose>
					<xsl:when test="arelda:provenienz/arelda:registratur/text()">
						<xsl:value-of select="arelda:provenienz/arelda:registratur"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:ordnungssystem/arelda:name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<xsl:choose>
				<xsl:when test="arelda:entstehungszeitraum">
					<xsl:call-template name="insertXdate">
						<xsl:with-param name="datum" select="arelda:entstehungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="arelda:ordnungssystem/arelda:anwendungszeitraum">
					<xsl:call-template name="insertXdate">
						<xsl:with-param name="datum" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<!-- 3.1.4 Verzeichnungsstufe -->
			<xsl:element name="descriptionLevel">
				<xsl:text>Bestand</xsl:text>
			</xsl:element>
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
		</xsl:element>
		<!-- 3.6.1 Allgemeine Anmerkungen -->
		<xsl:element name="notes">
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
