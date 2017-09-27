<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:dossier">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<xsl:attribute name="isadId">1</xsl:attribute>
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xI2reference">
					<xsl:with-param name="signature" select="$signature"/>
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:element name="title">
					<xsl:attribute name="isadId">1.2</xsl:attribute>
					<xsl:attribute name="origin">//dossier/titel</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:value-of select="arelda:titel"/>
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<xsl:if test="arelda:entstehungszeitraum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
						<xsl:with-param name="orig">//dossier/entstehungszeitraum</xsl:with-param>
						<xsl:with-param name="comment" select="arelda:entstehungszeitraumAnmerkung"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="arelda:eroeffnungsdatum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:eroeffnungsdatum"/>
						<xsl:with-param name="orig">//dossier/eroeffnungsdatum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="arelda:abschlussdatum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:abschlussdatum"/>
						<xsl:with-param name="orig">//dossier/abschlussdatum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:attribute name="isadId">1.4</xsl:attribute>
					<xsl:attribute name="origin">ingest</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:text>Dossier</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) nur in FilesSIP -->
				<xsl:if test="arelda:umfang/text()">
					<xsl:element name="extentMedium">
						<xsl:element name="description">
							<xsl:value-of select="arelda:umfang/text()"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<!--   -->
			</xsl:element>
			<xsl:element name="context">
				<xsl:attribute name="isadId">2</xsl:attribute>
				<!-- 3.2.1 Name der Provenienzstelle -->
				<!--   -->
				<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
				<!--   -->
				<!-- 3.2.3 Bestandesgeschichte -->
			</xsl:element>
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<xsl:element name="contentStructure">
				<xsl:attribute name="isadId">3</xsl:attribute>
				<!-- 3.3.1 Form und Inhalt -->
				<xsl:if test="arelda:formInhalt or arelda:inhalt">
					<xsl:element name="scopeContent">
						<xsl:attribute name="isadId">3.1</xsl:attribute>
						<xsl:if test="arelda:formInhalt">
							<xsl:element name="scope">
								<xsl:choose>
									<xsl:when test="arelda:formInhalt/text()='Fotos'">
										<xsl:text>image</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Film'">
										<xsl:text>video</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Video'">
										<xsl:text>video</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Datenbanken'">
										<xsl:text>structured_data</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Tondokumente'">
										<xsl:text>audio</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='schriftliche Unterlagen'">
										<xsl:text>text</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>hybrid</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</xsl:if>
						<xsl:if test="arelda:formInhalt">
							<xsl:element name="scope">
								<xsl:attribute name="origin">//dossier/formInhalt</xsl:attribute>
								<xsl:value-of select="arelda:formInhalt/text()"/>
							</xsl:element>
						</xsl:if>
						<xsl:if test="arelda:inhalt">
							<xsl:element name="content">
								<xsl:attribute name="origin">//dossier/inhalt</xsl:attribute>
								<xsl:value-of select="arelda:inhalt/text()"/>
							</xsl:element>
						</xsl:if>
					</xsl:element>
				</xsl:if>
				<!--   -->
				<!-- 3.3.2 Bewertung und Kassation -->
			</xsl:element>
			<!--   -->
			<xsl:element name="conditionsAccessUse">
				<xsl:attribute name="isadId">4</xsl:attribute>
				<!-- 3.4.1 Zugangsbestimmungen -->
				<xsl:call-template name="xI2access">
					<xsl:with-param name="position" select="."/>
					<xsl:with-param name="orig">//dossier</xsl:with-param>
				</xsl:call-template>
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:if test="arelda:erscheinungsform">
					<xsl:element name="physTech">
						<xsl:attribute name="isadId">4.4</xsl:attribute>
						<xsl:attribute name="origin">ingest</xsl:attribute>
						<xsl:choose>
							<xsl:when test="arelda:erscheinungsform/text()='digital'">
								<xsl:text>digital</xsl:text>
							</xsl:when>
							<xsl:when test="arelda:erscheinungsform/text()='nicht digital'">
								<xsl:text>analog</xsl:text>
							</xsl:when>
							<xsl:when test="arelda:erscheinungsform/text()='gemischt'">
								<xsl:text>hybrid</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>not_defined</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:if>
				<xsl:if test="arelda:erscheinungsform">
					<xsl:element name="physTech">
						<xsl:attribute name="isadId">4.4</xsl:attribute>
						<xsl:attribute name="origin">//dossier/erscheinungsform</xsl:attribute>
						<xsl:value-of select="arelda:erscheinungsform/text()"/>
					</xsl:element>
				</xsl:if>
				<!--   -->
			</xsl:element>
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="notes">
					<xsl:attribute name="isadId">6</xsl:attribute>
					<xsl:element name="note">
						<xsl:attribute name="origin">//dossier/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:bemerkung"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- additionalReference -->
			<xsl:element name="additionalReference">
				<xsl:if test="arelda:aktenzeichen/text()">
					<xsl:element name="recordReference">
						<xsl:attribute name="origin">//dossier/aktenzeichen</xsl:attribute>
						<xsl:value-of select="arelda:aktenzeichen/text()"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="arelda:zusatzmerkmal/text()">
					<xsl:element name="recordReference">
						<xsl:attribute name="origin">//dossier/zusatzmerkmal</xsl:attribute>
						<xsl:value-of select="arelda:zusatzmerkmal/text()"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
			<!-- additionalData -->
			<xsl:if test="arelda:zusatzDaten">
				<xsl:call-template name="xI2mdwrap">
					<xsl:with-param name="orig">//dossier/zusatzDaten/merkmal</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--  GEVER SIP -->
			<xsl:apply-templates select="arelda:dokument">
				<xsl:with-param name="sig" select="$signature"/>
			</xsl:apply-templates>
			<!--  FILE SIP -->
			<xsl:apply-templates select="arelda:dateiRef">
				<xsl:with-param name="sig" select="$signature"/>
			</xsl:apply-templates>
			<!--  Sub-Dossier -->
			<xsl:apply-templates select="arelda:dossier">
				<xsl:with-param name="sig" select="$signature"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>