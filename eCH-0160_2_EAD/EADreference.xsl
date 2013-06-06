<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2012 rel. 2 (http://www.altova.com) by Thomas Bula (Bundesamt für Informatik und Telekommunikation) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- function EADreference -->
	<xsl:function name="arelda:EADreference" as="xs:anyURI">
		<xsl:param name="referenceCode"/>
		<xsl:variable name="ref">
			<xsl:value-of select="$referenceCode"/>
		</xsl:variable>
		<xsl:value-of select="translate($ref, ' äöüÄÖÜéèàÉÈÀ', '_aouAOUeeaEEA')"/>
	</xsl:function>
</xsl:stylesheet>
