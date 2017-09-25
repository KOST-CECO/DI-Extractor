<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xI2access -->
	<xsl:template name="xI2access">
		<xsl:param name="position"/>
		<xsl:param name="orig"/>
		<!--   -->
		<xsl:element name="accessConditions">
			<xsl:attribute name="isadId">4.1</xsl:attribute>
			<!--   -->
			<xsl:if test="arelda:datenschutz">
				<xsl:element name="hasPrivacyProtection">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/datenschutz</xsl:text></xsl:attribute>
					<xsl:value-of select="arelda:datenschutz"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:oeffentlichkeitsstatus">
				<xsl:element name="openToThePublic">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/oeffentlichkeitsstatus</xsl:text></xsl:attribute>
					<xsl:choose>
						<xsl:when test="arelda:oeffentlichkeitsstatus/text()='einsehbar' or arelda:oeffentlichkeitsstatus/text()='accessible'">
							<xsl:text>public</xsl:text>
						</xsl:when>
						<xsl:when test="arelda:oeffentlichkeitsstatus/text()='nicht einsehbar' or arelda:oeffentlichkeitsstatus/text()='not accessible'">
							<xsl:text>not public</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>undefined</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:klassifizierungskategorie">
				<xsl:element name="classification">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/klassifizierungskategorie</xsl:text></xsl:attribute>
					<xsl:choose>
						<xsl:when test="arelda:klassifizierungskategorie/text()='geheim'">
							<xsl:text>secret</xsl:text>
						</xsl:when>
						<xsl:when test="arelda:klassifizierungskategorie/text()='vertraulich'">
							<xsl:text>confidential</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>unclassified</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:oeffentlichkeitsstatusBegruendung">
				<xsl:element name="otherAccessConditions">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/oeffentlichkeitsstatusBegruendung</xsl:text></xsl:attribute>
					<xsl:value-of select="arelda:oeffentlichkeitsstatusBegruendung/text()"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:sonstigeBestimmungen">
				<xsl:element name="accessConditionsNotes">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/sonstigeBestimmungen</xsl:text></xsl:attribute>
					<xsl:value-of select="arelda:sonstigeBestimmungen/text()"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:schutzfrist/text()">
				<xsl:element name="retentionPeriod">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/schutzfrist</xsl:text></xsl:attribute>
					<xsl:value-of select="arelda:schutzfrist"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:schutzfristenkategorie/text()">
				<xsl:element name="retentionPeriodConditions">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/schutzfristenkategorie</xsl:text></xsl:attribute>
					<xsl:value-of select="arelda:schutzfristenkategorie"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:if test="arelda:referenzSchutzfristenFormular/text()">
				<xsl:element name="retentionPeriodNotes">
					<xsl:attribute name="origin"><xsl:value-of select="$orig"/><xsl:text>/referenzSchutzfristenFormular</xsl:text></xsl:attribute>
					<xsl:value-of select="arelda:referenzSchutzfristenFormular"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
