<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- helper functions and named templates -->
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/">
		<xsl:element name="reference">
			<xsl:for-each select="reference/identity">
				<xsl:element name="identity">
					<xsl:element name="referenceCode">
						<xsl:value-of select="referenceCode/text()"/>
					</xsl:element>
					<xsl:element name="referenceNo">
						<xsl:number/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
