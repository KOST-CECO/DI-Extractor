<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition   -  type GEVER ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="arelda:dokument">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>_</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:variable name="fileid">
			<xsl:value-of select="arelda:dateiRef"/>
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
					<xsl:attribute name="origin">//dokument/titel</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:value-of select="arelda:titel"/>
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<xsl:if test="arelda:entstehungszeitraum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
						<xsl:with-param name="orig">//dokument/entstehungszeitraum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="arelda:registrierdatum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:registrierdatum"/>
						<xsl:with-param name="orig">//dokument/registrierdatum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:attribute name="isadId">1.4</xsl:attribute>
					<xsl:attribute name="origin">ingest</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:text>item</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) -->
				<!--   -->
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle [Autor] -->
			<xsl:if test="arelda:autor/text()">
				<xsl:element name="context">
					<xsl:attribute name="isadId">2</xsl:attribute>
					<xsl:element name="creator">
						<xsl:attribute name="isadId">2.1</xsl:attribute>
						<xsl:attribute name="origin">//dokument/autor</xsl:attribute>
						<xsl:value-of select="arelda:autor"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<!-- 3.3 Inhalt und innere Ordnung -->
			<xsl:if test="arelda:dokumenttyp or arelda:anwendung or /arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name">
				<xsl:element name="contentStructure">
					<xsl:attribute name="isadId">3</xsl:attribute>
					<!-- 3.3.1 Form und Inhalt -->
					<xsl:element name="scopeContent">
						<xsl:attribute name="isadId">3.1</xsl:attribute>
						<xsl:element name="content">
							<xsl:attribute name="origin">//dokument/dokumenttyp</xsl:attribute>
							<xsl:value-of select="arelda:dokumenttyp/text()"/>
						</xsl:element>
					</xsl:element>
					<!--   -->
					<!-- 3.3.4 Ornungssystem und Klassifikation -->
					<xsl:call-template name="xI2filename">
						<xsl:with-param name="fileid">
							<xsl:value-of select="$fileid"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.4 Zugangs- und Benutzungsbedingungen -->
			<xsl:call-template name="xI2access">
				<!-- 3.4.1 Zugangsbestimmungen -->
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:with-param name="orig">//dokument</xsl:with-param>
			</xsl:call-template>
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="notes">
					<xsl:attribute name="isadId">6</xsl:attribute>
					<xsl:element name="note">
						<xsl:attribute name="isadId">6.1</xsl:attribute>
						<xsl:attribute name="origin">//dokument/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:bemerkung"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- additionalData -->
			<xsl:if test="arelda:zusatzDaten">
				<xsl:element name="additionalData">
					<xsl:element name="mdWrap">
						<!-- additionalData dokument -->
						<xsl:if test="arelda:anwendung">
							<xsl:element name="property">
								<xsl:attribute name="origin">//ordnungssystemposition/anwendung</xsl:attribute>
								<xsl:attribute name="key">anwendung</xsl:attribute>
								<xsl:value-of select="arelda:anwendung"/>
							</xsl:element>
						</xsl:if>
						<!-- additionalData zusatzDaten -->
						<xsl:for-each select="arelda:zusatzDaten/arelda:merkmal">
							<xsl:element name="property">
								<xsl:attribute name="origin">//dokument/zusatzDaten/merkmal</xsl:attribute>
								<xsl:attribute name="key"><xsl:value-of select="./@name"/></xsl:attribute>
								<xsl:value-of select="./text()"/>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!--   -->
	<!-- Ordnungsystemposition  -  type FILE +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
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
				<xsl:attribute name="isadId">1</xsl:attribute>
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xI2reference">
					<xsl:with-param name="signature" select="$signature"/>
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:choose>
					<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName">
						<xsl:element name="title">
							<xsl:attribute name="isadId">1.2</xsl:attribute>
							<xsl:attribute name="origin">//datei/originalName</xsl:attribute>
							<xsl:attribute name="obligation">mandatory</xsl:attribute>
							<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName/text()"/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name">
						<xsl:element name="title">
							<xsl:attribute name="isadId">1.2</xsl:attribute>
							<xsl:attribute name="origin">//datei/name</xsl:attribute>
							<xsl:attribute name="obligation">mandatory</xsl:attribute>
							<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name/text()"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>dummy title</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:attribute name="isadId">1.4</xsl:attribute>
					<xsl:attribute name="origin">ingest</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:text>representation</xsl:text>
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
			<!-- 3.3 Inhalt und innere Ordnung -->
			<xsl:if test="arelda:dokumenttyp or arelda:anwendung or /arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name">
				<xsl:element name="contentStructure">
					<xsl:attribute name="isadId">3</xsl:attribute>
					<!-- 3.3.1 Form und Inhalt -->
					<!--   -->
					<!-- 3.3.4 Ornungssystem und Klassifikation -->
					<xsl:call-template name="xI2filename">
						<xsl:with-param name="fileid">
							<xsl:value-of select="$fileid"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:element name="conditionsAccessUse">
				<xsl:attribute name="isadId">4</xsl:attribute>
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
			<!-- 
			<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()">
				<xsl:element name="notes">
					<xsl:attribute name="isadId">6</xsl:attribute>
					<xsl:element name="note">
						<xsl:attribute name="isadId">6.1</xsl:attribute>
						<xsl:attribute name="origin">//datei/eigenschaft</xsl:attribute>
						<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			 -->
			<!-- additionalData -->
			<!--   -->
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
