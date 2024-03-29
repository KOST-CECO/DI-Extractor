<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition   -  type GEVER-->
	<xsl:template match="arelda:dokument">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>_</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xIreference">
					<xsl:with-param name="signature" select="$signature"/>
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:element name="title">
					<xsl:value-of select="arelda:titel"/>
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<xsl:if test="arelda:entstehungszeitraum">
					<xsl:call-template name="xIdate">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
					</xsl:call-template>
				</xsl:if>
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:text>Dokument</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) -->
				<!--   -->
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<xsl:element name="contentStructure">
				<!-- 3.3.1 Form und Inhalt -->
				<xsl:if test="arelda:dokumenttyp">
					<xsl:element name="scopeContent">
						<xsl:element name="content">
							<xsl:value-of select="arelda:dokumenttyp/text()"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<!--   -->
				<!-- 3.3.2 Bewertung und Kassation -->
			</xsl:element>
			<!--   -->
			<xsl:element name="conditionsAccessUse">
				<!-- 3.4.1 Zugangsbestimmungen -->
				<xsl:call-template name="xIaccess">
					<xsl:with-param name="position" select="."/>
				</xsl:call-template>
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:if test="arelda:erscheinungsform">
					<xsl:element name="physTech">
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
				<!--   -->
			</xsl:element>
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="notes">
					<xsl:element name="note">
						<xsl:value-of select="arelda:bemerkung"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!-- Ordnungsystemposition  -  type FILE -->
	<xsl:template match="arelda:dateiRef">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>_</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:variable name="fileid">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xIreference">
					<xsl:with-param name="signature" select="$signature"/>
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:element name="title">
					<xsl:choose>
						<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName">
							<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName/text()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name/text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:text>Dokument</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) -->
				<!--   -->
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<!-- 3.3.1 Form und Inhalt -->
			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation -->
			<!--   -->
			<xsl:element name="conditionsAccessUse">
				<!-- 3.4.1 Zugangsbestimmungen -->
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:element name="physTech">
					<xsl:choose>
						<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]">
							<xsl:text>digital</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>not_defined</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<!--   -->
			</xsl:element>
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()">
				<xsl:element name="notes">
					<xsl:element name="note">
						<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
