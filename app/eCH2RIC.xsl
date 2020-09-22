<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
		xmlns:dcterms="http://purl.org/dc/terms/" 
		xmlns:rico="https://www.ica.org/standards/RiC/ontology#" 
		xmlns:arelda="http://bar.admin.ch/arelda/v4" 
		exclude-result-prefixes="xs xsi arelda">
		
	<!-- !DOCTYPE rdf:RDF
	<xsl:output method="xml" doctype-system="rico.dtd" encoding="UTF-8" indent="yes" media-type="application/xml"/> 
	-->
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	
	<!-- parameter -->
	<xsl:param name="fondtitle"/>
	<xsl:param name="archsig"/>
	<xsl:param name="reffilename"/>
	<xsl:param name="baseuri"/>
	<xsl:variable name="reffile" select="document($reffilename)"/>
	<xsl:param name="language"/>
	<xsl:variable name="lng">
		<xsl:choose>
			<xsl:when test="$language">
				<xsl:value-of select="$language"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>de</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!-- helper functions and named templates -->
	<xsl:include href="RICdate.xsl"/>
	<xsl:include href="RICaccess.xsl"/>
	<xsl:include href="RICreference.xsl"/>
	
	<!-- Ablieferung - Provenienz -->
	<xsl:include href="RICfond.xsl"/>
	
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<rdf:RDF>
			<xsl:attribute name="xml:base"><xsl:value-of select="$baseuri"/></xsl:attribute>
			
			<!-- Packet / SIP -->
			<xsl:element name="rdf:Description"><xsl:attribute name="rdf:about"><xsl:value-of select="$archsig"/></xsl:attribute>
				<!-- label -->
				<xsl:element name="rdfs:label">
					<xsl:attribute name="xml:lang">en</xsl:attribute>
					<xsl:text>Package</xsl:text>
				</xsl:element>
				<!-- Record Resource -->
				<xsl:element name="rdf:type">
					<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#RecordResource</xsl:attribute>
				</xsl:element>
				<!-- technical Characteristics -->
				<xsl:element name="rico:technicalCharacteristics">
					<xsl:value-of select="arelda:ablieferung/@xsi:type"/>
				</xsl:element>
				<xsl:element name="rico:technicalCharacteristics">
					<xsl:value-of select="namespace-uri()"/>
				</xsl:element>
				<!-- identifier -->
				<xsl:if test="*/arelda:ablieferungsnummer/text()">
					<xsl:element name="rico:identifier">
						<xsl:value-of select="*/arelda:ablieferungsnummer"/>
					</xsl:element>
				</xsl:if>
				<!-- title -->
				<xsl:if test="*/*/arelda:registratur/text()">
					<xsl:element name="rico:title">
						<xsl:attribute name="xml:lang"><xsl:value-of select="$lng"/></xsl:attribute>
						<xsl:value-of select="*/*/arelda:registratur"/>
					</xsl:element>
				</xsl:if>
				<!-- includes -->
				<xsl:element name="rico:includes">
					<xsl:call-template name="RICreference">
						<xsl:with-param name="signature">
							<xsl:value-of select="$archsig"/>
							<xsl:text>.</xsl:text>
							<xsl:number/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
			</xsl:element>
			
			<xsl:apply-templates select="arelda:ablieferung"/>

			<!-- <xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/> -->
			
		</rdf:RDF>
	</xsl:template>
	
	<!-- Ordnungssystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<!-- Ordnungsystemposition -->
	<xsl:include href="RICserie.xsl"/>
	
	<!-- Dossier -->
	<xsl:include href="RICfile.xsl"/>
	
	<!-- Dokument -->
	<xsl:include href="RICitem.xsl"/>
</xsl:stylesheet>
