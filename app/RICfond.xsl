<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
	xmlns:rico="https://www.ica.org/standards/RiC/ontology#" 
	xmlns:arelda="http://bar.admin.ch/arelda/v4">

	<!-- Ablieferung - Provenienz - Ordnungssystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:variable name="signature">
			<xsl:call-template name="RICreference">
				<xsl:with-param name="signature">
					<xsl:value-of select="$archsig"/>
					<xsl:text>.</xsl:text>
					<xsl:number/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<!-- rico:RecordSet Packet -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about">
				<xsl:value-of select="$signature"/>
			</xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Fonds</xsl:text>
			</xsl:element>
			<!-- Record Set -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#RecordSet</xsl:attribute>
			</xsl:element>

		<!-- 3.1.1 Signatur -->
		<!-- identifier -->
		<xsl:element name="rico:identifier">
			<xsl:value-of select="$signature"/>
		</xsl:element>
			
			<!-- 3.1.2 Titel -->
			<!-- title -->
			<xsl:variable name="title">
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
			</xsl:variable>
			<xsl:element name="rico:title">
				<xsl:attribute name="xml:lang"><xsl:value-of select="$lng"/></xsl:attribute>
				<xsl:value-of select="$title"/>
			</xsl:element>

			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<!-- beginningDate - endDate -->
			<xsl:choose>
				<xsl:when test="arelda:entstehungszeitraum">
					<xsl:call-template name="RICdate">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="arelda:ordnungssystem/arelda:anwendungszeitraum">
					<xsl:call-template name="RICdate">
						<xsl:with-param name="range" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>

			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- RecordSet Type -->
			<xsl:element name="rico:hasRecordSetType">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Fonds</xsl:attribute>
			</xsl:element>

			<!-- 3.1.5 Umfang (Menge und Abmessung) -->

			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="rico:hasProvenance">
					<xsl:attribute name="rdf:resource">agent_001</xsl:attribute>
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
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="rico:createdBy">
					<xsl:attribute name="rdf:resource">agent_002</xsl:attribute>
				</xsl:element>
			</xsl:if>

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

			<!-- 3.4.1 Zugangsbestimmungen -->

			<!-- ToDo -->

			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->

			<!--   -->

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
			
			<!-- 1. Instantiation -->
			<xsl:element name="rico:hasInstantiation">
				<xsl:element name="rico:Instantiation">
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="$signature"/>
						<xsl:text>-i1</xsl:text>
					</xsl:attribute>
					<!-- instantiates -->
					<xsl:element name="rico:instantiates">
						<xsl:attribute name="rdf:resource"><xsl:value-of select="$signature"/></xsl:attribute>
					</xsl:element>
					<!-- title -->
					<xsl:element name="rico:title">
						<xsl:attribute name="xml:lang"><xsl:value-of select="$lng"/></xsl:attribute>
						<xsl:value-of select="$title"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>

		</xsl:element>
		
		<!-- Agents -->
		
		<!-- 3.2.1 Name der Provenienzstelle -->
		<xsl:element name="rdf:Description"><xsl:attribute name="rdf:about">agent_001</xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Creator</xsl:text>
			</xsl:element>
			<!-- describes -->
			<xsl:element name="rico:describes">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>creator</xsl:text>
			</xsl:element>
			<!-- Provenance Of -->
			<xsl:element name="rico:isProvenanceOf">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<!-- Corporate Body -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#CorporateBody</xsl:attribute>
			</xsl:element>
			<!-- title -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="rico:title">
					<xsl:attribute name="xml:lang"><xsl:value-of select="$lng"/></xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:aktenbildnerName"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		
		<!-- 3.2.4 Abgebende Stelle -->
		<xsl:element name="rdf:Description"><xsl:attribute name="rdf:about">agent_002</xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Submission Body</xsl:text>
			</xsl:element>
			<!-- describes -->
			<xsl:element name="rico:describes">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>submission body</xsl:text>
			</xsl:element>
			<!-- Creator Of -->
			<xsl:element name="rico:isCreatorOf">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<!-- Corporate Body -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#CorporateBody</xsl:attribute>
			</xsl:element>
			<!-- title -->
			<xsl:if test="arelda:ablieferndeStelle/text()">
				<xsl:element name="rico:title">
					<xsl:attribute name="xml:lang"><xsl:value-of select="$lng"/></xsl:attribute>
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>
