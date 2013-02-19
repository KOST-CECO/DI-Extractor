<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.loc.gov/standards/premis/v1" xmlns:I017="http://kost-ceco.ch/gever/I017">
	<xsl:param name="techfile"/>
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- Technical Information -->
	<xsl:variable name="techdata" select="document($techfile)/techdata"/>
	<!-- <xsl:variable name="techdata" select="document('C:\Software\xampp\htdocs\augev\Referenzimplementierung\I0172aip\wdir\techdata.xml')/techdata"/> -->
	<!-- Schema location -->
	<xsl:variable name="location">http://www.loc.gov/standards/premis/v1 http://www.loc.gov/standards/premis/v1/PREMIS-v1-1.xsd</xsl:variable>
	<!-- Root node transformation sets namespace and schema location -->
	<xsl:template match="/">
		<xsl:element name="premis">
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<xsl:apply-templates select="//I017:Dossier"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="I017:Dossier">
		<xsl:for-each select="I017:Unterlage">
			<!-- PREMIS object -->
			<xsl:element name="object">
				<xsl:attribute name="xmlID"><xsl:value-of select="generate-id(I017:UnterlageAktenzeichen)"/></xsl:attribute>
				<!-- PREMIS objectIdentifier -->
				<xsl:variable name="fname">
					<xsl:value-of select="I017:Erscheinungsform/I017:ErscheinungsformURN"/>
				</xsl:variable>
				<xsl:element name="objectIdentifier">
					<xsl:element name="objectIdentifierType">URL</xsl:element>
					<xsl:element name="objectIdentifierValue"><xsl:text>../primaryData/</xsl:text>
						<xsl:value-of select="$fname"/>
					</xsl:element>
				</xsl:element>
				<xsl:if test="$techdata/file[name=$fname]/size">
					<!-- PREMIS objectCategory-->
					<xsl:element name="objectCategory">file</xsl:element>
					<!-- PREMIS objectCharacteristics-->
					<xsl:element name="objectCharacteristics">
						<xsl:element name="fixity">
							<xsl:element name="messageDigestAlgorithm">
								<xsl:value-of select="$techdata/file[name=$fname]/checksum/@type"/>
							</xsl:element>
							<xsl:element name="messageDigest">
								<xsl:value-of select="$techdata/file[name=$fname]/checksum"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="size">
							<xsl:value-of select="$techdata/file[name=$fname]/size"/>
						</xsl:element>
						<xsl:element name="format">
							<xsl:element name="formatDesignation">
								<xsl:element name="formatName">
									<xsl:value-of select="$techdata/file[name=$fname]/mimetype"/>
								</xsl:element>
								<xsl:element name="formatVersion">
									<xsl:value-of select="$techdata/file[name=$fname]/format"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					<!-- PREMIS creatingApplication-->
					<xsl:element name="creatingApplication">
						<xsl:element name="dateCreatedByApplication">
						<xsl:value-of select="I017:Erscheinungsform/I017:ErscheinungsformErstellungsdatum"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
