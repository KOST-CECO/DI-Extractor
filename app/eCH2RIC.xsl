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
		exclude-result-prefixes="xs xsi dcterms arelda">
		
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
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
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
