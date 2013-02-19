<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="urn:isbn:1-931666-22-9" xmlns:I017="http://kost-ceco.ch/gever/I017" xmlns:premis="http://www.loc.gov/standards/premis/v1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- Dossier -->
	<xsl:template mode="file" match="I017:Dossier">
		<xsl:param name="level"/>
		<xsl:param name="signatur"/>
		<xsl:variable name="sig">
			<xsl:value-of select="$signatur"/>
			<xsl:text>:</xsl:text>
			<xsl:value-of select="I017:DossierAktenzeichen"/>
			<xsl:if test="I017:DossierBandnummer/text()">
				<xsl:text>:</xsl:text>
				<xsl:value-of select="I017:DossierBandnummer"/>
			</xsl:if>
		</xsl:variable>
		<!-- C0... Dossier -->
		<xsl:element name="c0{$level}">
			<xsl:attribute name="level">file</xsl:attribute>
			<!-- DID Dossier -->
			<xsl:element name="did">
				<xsl:if test="I017:DossierAktenzeichen/text()">
					<xsl:element name="unitid">
						<xsl:attribute name="label">signatur</xsl:attribute>
						<xsl:value-of select="$sig"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:DossierTitel/text()">
					<xsl:element name="unittitle">
						<xsl:value-of select="I017:DossierTitel"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:DossierEröffnungsdatum/text()">
					<xsl:element name="unitdate">
						<xsl:value-of select="I017:DossierEröffnungsdatum"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:DossierBemerkung/text()">
					<xsl:element name="abstract">
						<xsl:value-of select="I017:DossierBemerkung"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:DossierStandort/text()">
					<xsl:element name="physloc">
						<xsl:attribute name="label">Standort</xsl:attribute>
						<xsl:value-of select="I017:DossierStandort"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
			<!-- CONTROLACCESS Dossier -->
			<xsl:if test="I017:DossierSchlagwort">
				<xsl:element name="controlaccess">
					<xsl:for-each select="I017:DossierSchlagwort">
						<xsl:element name="subject">
							<xsl:value-of select="text()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<!-- ACCESS Dossier -->
			<xsl:if test="I017:DossierKlassifizierungskategorie/text()">
				<xsl:element name="accessrestrict">
					<xsl:element name="list">
						<xsl:if test="I017:DossierKlassifizierungskategorie/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Klassifizierungskategorie</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:DossierKlassifizierungskategorie"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:DossierDatenschutzstufe/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Datenschutzstufe</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:DossierDatenschutzstufe"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:DossierÖffentlichkeitsstatus/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Öffentlichkeitsstatus</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:DossierÖffentlichkeitsstatus"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:DossierÖffentlichkeitsstatusBegründung/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">ÖffentlichkeitsstatusBegründung</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:DossierÖffentlichkeitsstatusBegründung"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- RELATED Dossier -->
			<xsl:if test="I017:DossierVerweis/text()">
				<xsl:element name="relatedmaterial">
					<xsl:element name="list">
						<xsl:for-each select="I017:DossierVerweis">
							<xsl:element name="item">
								<xsl:value-of select="text()"/>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- ODD Dossier -->
			<xsl:element name="odd">
				<xsl:element name="list">
					<xsl:if test="I017:DossierStatus/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Status</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:DossierStatus"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:DossierArchivwürdigkeit/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Archivwürdigkeit</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:DossierArchivwürdigkeit"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
			<!-- C0 Dokument -->
			<xsl:apply-templates mode="item" select="I017:Unterlage">
				<xsl:with-param name="level" select="count(ancestor-or-self::*)"/>
				<xsl:with-param name="signatur" select="$sig"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
