<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xIreference -->
	<xsl:template name="xIreference">
		<xsl:param name="signature"/>
		<xsl:element name="referenceCode">
			<xsl:choose>
				<xsl:when test="$reffile//reference">
					<xsl:value-of select="$archsignatur"/>
					<xsl:text>.</xsl:text>
					<xsl:value-of select="$reffile//reference/identity[referenceCode=$signature]/referenceNo/text()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$signature"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
