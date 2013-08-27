<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:EAD="urn:isbn:1-931666-22-9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template EADreference -->
	<xsl:template name="EADreference">
		<xsl:param name="signature"/>
			<xsl:element name="EAD:unitid">
				<xsl:attribute name="label">refCode</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$reffile//reference">
					<xsl:value-of select="$archsig"/>
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
