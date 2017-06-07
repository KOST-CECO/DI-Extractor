<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="premis" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:premis="http://www.loc.gov/standards/premis/v1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- Technical Information -->
	<xsl:variable name="location">http://www.loc.gov/standards/premis/v1 http://www.loc.gov/standards/premis/v1/PREMIS-v1-1.xsd</xsl:variable>
	<!-- Root node transformation sets namespace and schema location -->
	<xsl:template match="/">
		<xsl:element name="premis:premis" namespace="http://www.loc.gov/standards/premis/v1">
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<xsl:copy-of select="/premis:premis/*"/>
			<xsl:apply-templates select="/premis:premis"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="premis:premis">
		<xsl:element name="premis:event" namespace="http://www.loc.gov/standards/premis/v1">
			<xsl:element name="premis:eventIdentifier" namespace="http://www.loc.gov/standards/premis/v1">
				<xsl:element name="premis:eventIdentifierType" namespace="http://www.loc.gov/standards/premis/v1">
					<xsl:text>xmlID</xsl:text>
				</xsl:element>
				<xsl:element name="premis:eventIdentifierValue" namespace="http://www.loc.gov/standards/premis/v1">
					<xsl:value-of select="generate-id()"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="premis:eventType" namespace="http://www.loc.gov/standards/premis/v1">
				<xsl:text>ingest</xsl:text>
			</xsl:element>
			<xsl:element name="premis:eventDateTime" namespace="http://www.loc.gov/standards/premis/v1">
				<xsl:text>2006-02-01T10:22:19</xsl:text>
			</xsl:element>
			<xsl:for-each select="premis:object">
				<xsl:element name="premis:linkingObjectIdentifier" namespace="http://www.loc.gov/standards/premis/v1">
					<xsl:element name="premis:linkingObjectIdentifierType" namespace="http://www.loc.gov/standards/premis/v1">
						<xsl:text>xmlID</xsl:text>
					</xsl:element>
					<xsl:element name="premis:linkingObjectIdentifierValue" namespace="http://www.loc.gov/standards/premis/v1">
						<xsl:value-of select="@xmlID"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
