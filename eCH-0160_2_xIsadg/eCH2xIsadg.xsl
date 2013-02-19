<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- Functions -->
	<xsl:function name="arelda:toXdate">
		<xsl:param name="date"/>
		<xsl:param name="spread" as="xs:string"/>
		<xsl:choose>
			<xsl:when test="string-length($date) = 4">
				<xsl:choose>
					<xsl:when test="compare($spread, 'bottom')=0">
						<xsl:value-of select="$date"/>
						<xsl:text>-01-01</xsl:text>
					</xsl:when>
					<xsl:when test="compare($spread, 'ceiling')=0">
						<xsl:value-of select="$date"/>
						<xsl:text>-12-31</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$date"/>
						<xsl:text>-01-01</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="string-length($date) = 10">
				<xsl:value-of select="$date"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>unknown</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- Schema location -->
	<xsl:variable name="location">ISADG xIsadg_v1.6.xsd</xsl:variable>
	<!-- Root node transformation sets namespace and schema location -->
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
	<!-- Ablieferung  -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 -->
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
			<!-- 3.1.2 -->
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
			<!-- 3.1.3 -->
			<xsl:choose>
				<xsl:when test="arelda:entstehungszeitraum">
					<xsl:element name="dates">
						<xsl:element name="fromDate">
							<xsl:value-of select="arelda:entstehungszeitraum/arelda:von/arelda:datum"/>
						</xsl:element>
						<xsl:element name="toDate">
							<xsl:value-of select="arelda:entstehungszeitraum/arelda:bis/arelda:datum"/>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				<xsl:when test="arelda:ordnungssystem/arelda:anwendungszeitraum">
					<xsl:variable name="az_from" select="arelda:toXdate(arelda:ordnungssystem/arelda:anwendungszeitraum/arelda:von/arelda:datum, 'bottom')"/>	
					<xsl:variable name="az_to" select="arelda:toXdate(arelda:ordnungssystem/arelda:anwendungszeitraum/arelda:bis/arelda:datum, 'ceiling')"/>
					<xsl:element name="dates">
						<xsl:element name="fromDate">
							<xsl:value-of select="$az_from"/>
						</xsl:element>
						<xsl:element name="toDate">
							<xsl:value-of select="$az_to"/>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<!-- 3.1.4 -->
			<xsl:element name="descriptionLevel">
				<xsl:text>Bestand</xsl:text>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
