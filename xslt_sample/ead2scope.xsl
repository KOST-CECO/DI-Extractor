<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ead="urn:isbn:1-931666-22-9" xmlns:sc="http://www.scope.ch/Uebernahme" xmlns:premis="http://www.loc.gov/standards/premis/v1">
	<xsl:param name="url"/>
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- Schema location -->
	<xsl:variable name="location">http://www.scope.ch/Uebernahme Uebernah.xsd</xsl:variable>
	<!-- Input data -->
	<xsl:variable name="eadfile" select="document('../metaData/ead.xml')/ead:ead"/>
	<xsl:variable name="premisfile" select="document('../metaData/premis.xml')/premis:premis"/>
	<xsl:template match="/">
		<xsl:element name="sc:Uebernahmen">
			<!--    
			<xsl:variable name="temp">
				<xsl:element name="xlink:dummy" namespace="http://www.scope.ch/Uebernahme"/>
			</xsl:variable>
			<xsl:copy-of select="msxsl:node-set($temp)//namespace::*"/>
			-->
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<xsl:apply-templates select="$eadfile//ead:eadheader"/>
			<xsl:apply-templates select="$eadfile//ead:archdesc"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ead:archdesc">
		<xsl:call-template name="VZ"/>
		<xsl:apply-templates select="ead:dsc/ead:c01"/>
	</xsl:template>
	<xsl:template match="ead:c01">
		<xsl:variable name="id" select="../../ead:did/ead:unitid"/>
		<xsl:call-template name="VZ">
			<xsl:with-param name="ref" select="$id"/>
		</xsl:call-template>
		<xsl:apply-templates mode="c0" select="ead:c02"/>
	</xsl:template>
	<xsl:template mode="c0" match="*">
		<xsl:call-template name="VZ">
			<xsl:with-param name="ref" select="../ead:did/ead:unitid"/>
		</xsl:call-template>
		<xsl:apply-templates mode="c0" select="*[@level]"/>
	</xsl:template>
	<!-- Template: Scope Uebersicht -->
	<xsl:template match="ead:eadheader">
		<xsl:element name="sc:Uebersicht">
			<xsl:element name="sc:AblieferndeStelle">
				<xsl:value-of select="//ead:publisher"/>
			</xsl:element>
			<xsl:element name="sc:Kontraktperson">
				<xsl:value-of select="//ead:author"/>
			</xsl:element>
			<xsl:element name="sc:AktenbildendeStelle">
				<xsl:value-of select="$eadfile//ead:origination/ead:name"/>
			</xsl:element>
			<xsl:element name="sc:Ablage">
				<xsl:value-of select="//ead:defitem[ead:label='Registratur']/ead:item"/>
			</xsl:element>
			<xsl:element name="sc:EDVSystem">
				<xsl:value-of select="//ead:defitem[ead:label='EDV-System']/ead:item"/>
			</xsl:element>
			<xsl:element name="sc:Titel">
				<xsl:value-of select="//ead:titleproper"/>
			</xsl:element>
			<xsl:element name="sc:Zeitraum">
				<xsl:value-of select="//ead:publicationstmt/ead:date"/>
			</xsl:element>
			<xsl:element name="sc:Beschreibung">
				<xsl:value-of select="//ead:subtitle"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Template: Scope Verzeichnungseinheit -->
	<xsl:template name="VZ">
		<xsl:param name="ref"/>
		<xsl:element name="sc:Verzeichnungseinheit">
			<xsl:element name="sc:VerzeichnungseinheitId">
				<xsl:choose>
					<xsl:when test="ead:did/ead:unitid">
						<xsl:value-of select="ead:did/ead:unitid"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="generate-id(ead:did/ead:unitid)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:if test="$ref">
				<xsl:element name="sc:VaterId">
					<xsl:value-of select="$ref"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="sc:Titel">
				<xsl:value-of select="ead:did/ead:unittitle"/>
			</xsl:element>
			<xsl:element name="sc:Signatur">
				<xsl:if test="ead:did/ead:unitid">
					<xsl:value-of select="ead:did/ead:unitid"/>
				</xsl:if>
			</xsl:element>
			<xsl:element name="sc:Eintragstyp">
				<xsl:choose>
					<xsl:when test="@level='collection'">
						<xsl:text>Kollektion</xsl:text>
					</xsl:when>
					<xsl:when test="@level='fonds'">
						<xsl:text>Bestand</xsl:text>
					</xsl:when>
					<xsl:when test="@level='series'">
						<xsl:text>Serie</xsl:text>
					</xsl:when>
					<xsl:when test="@level='subseries'">
						<xsl:text>Subserie</xsl:text>
					</xsl:when>
					<xsl:when test="@level='file'">
						<xsl:text>Dossier</xsl:text>
					</xsl:when>
					<xsl:when test="@level='item'">
						<xsl:text>Dokument</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@level"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- PREMIS file info sc:Entstehungszeitraum -->
			<xsl:if test="ead:dao">
				<xsl:variable name="id" select="substring(ead:dao/@xpointer,30,string-length(ead:dao/@xpointer)-32)"/>
				<xsl:variable name="date" select="$premisfile/premis:object[@xmlID=$id]//premis:dateCreatedByApplication"/>
				<xsl:if test="$date">
					<xsl:element name="sc:EntstehungszeitraumVonDatum">
						<xsl:value-of select="$date"/>
					</xsl:element>
					<xsl:element name="sc:EntstehungszeitraumBisDatum">
						<xsl:value-of select="$date"/>
					</xsl:element>
				</xsl:if>
			</xsl:if>
			<xsl:if test="ead:did/ead:materialspec/text()">
				<xsl:element name="sc:Archivalienart">
					<xsl:value-of select="ead:did/ead:materialspec"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="ead:did/ead:origination/ead:name/text()">
				<xsl:element name="sc:ReserveText1">
					<xsl:value-of select="ead:did/ead:origination/ead:name"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="ead:did/ead:abstract/text()">
				<xsl:element name="sc:ReserveText2">
					<xsl:value-of select="ead:did/ead:abstract"/>
				</xsl:element>
			</xsl:if>
			<!-- PREMIS file info sc:Datei -->
			<xsl:if test="ead:dao">
				<xsl:element name="sc:Datei">
					<xsl:variable name="id" select="substring(ead:dao/@xpointer,30,string-length(ead:dao/@xpointer)-32)"/>
					<xsl:choose>
						<xsl:when test="$url">
							<xsl:value-of select="$url"/>
							<xsl:value-of select="substring($premisfile/premis:object[@xmlID=$id]//premis:objectIdentifierValue,4)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$premisfile/premis:object[@xmlID=$id]//premis:objectIdentifierValue"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
