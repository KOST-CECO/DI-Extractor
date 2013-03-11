<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xIaccess -->
	<xsl:template name="xIaccess">
		<xsl:param name="position"/>
		<xsl:element name="accessConditions">
			<xsl:if test="arelda:datenschutz">
				<xsl:element name="hasPrivacyProtection">
					<xsl:value-of select="arelda:datenschutz"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
