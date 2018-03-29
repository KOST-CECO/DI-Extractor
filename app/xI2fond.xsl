<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ablieferung - Provenienz - Ordnungssystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:variable name="signature">
			<xsl:value-of select="$archsig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<xsl:attribute name="isadId">1</xsl:attribute>
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="xI2reference">
				<xsl:with-param name="signature" select="$signature"/>
				<xsl:with-param name="orig">archival</xsl:with-param>
			</xsl:call-template>
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:attribute name="isadId">1.2</xsl:attribute>
				<xsl:attribute name="origin">archival</xsl:attribute>
				<xsl:attribute name="obligation">mandatory</xsl:attribute>
				<xsl:choose>
					<xsl:when test="$fondtitle">
						<xsl:value-of select="$fondtitle"/>
					</xsl:when>
					<xsl:when test="arelda:provenienz/arelda:registratur/text()">
						<xsl:value-of select="arelda:provenienz/arelda:registratur"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:ordnungssystem/arelda:name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<xsl:if test="arelda:entstehungszeitraum">
				<xsl:call-template name="xI2date">
					<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
					<xsl:with-param name="orig">//ablieferung/entstehungszeitraum</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:existenzzeitraum">
				<xsl:call-template name="xI2date">
					<xsl:with-param name="range" select="arelda:provenienz/arelda:existenzzeitraum"/>
					<xsl:with-param name="orig">//provenienz/existenzzeitraum</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="arelda:ordnungssystem/arelda:anwendungszeitraum">
				<xsl:call-template name="xI2date">
					<xsl:with-param name="range" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
					<xsl:with-param name="orig">//ordnungssystem/anwendungszeitraum</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- 3.1.4 Verzeichnungsstufe -->
			<xsl:element name="descriptionLevel">
				<xsl:attribute name="isadId">1.4</xsl:attribute>
				<xsl:attribute name="origin">ingest</xsl:attribute>
				<xsl:attribute name="obligation">mandatory</xsl:attribute>
				<xsl:text>fonds</xsl:text>
			</xsl:element>
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
		</xsl:element>
		<xsl:element name="context">
			<xsl:attribute name="isadId">2</xsl:attribute>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="creator">
					<xsl:attribute name="isadId">2.1</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/aktenbildnerName</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:aktenbildnerName"/>
				</xsl:element>
			</xsl:if>
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<xsl:if test="arelda:provenienz/arelda:geschichteAktenbildner/text()">
				<xsl:element name="adminBioHistory">
					<xsl:attribute name="isadId">2.2</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/geschichteAktenbildner</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:geschichteAktenbildner"/>
				</xsl:element>
			</xsl:if>
			<!-- 3.2.3 Bestandesgeschichte -->
			<xsl:if test="arelda:provenienz/arelda:systemName/text()">
				<xsl:element name="archivalHistory">
					<xsl:attribute name="isadId">2.3</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/systemName</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:systemName/text()"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:systemBeschreibung/text()">
				<xsl:element name="archivalHistory">
					<xsl:attribute name="isadId">2.3</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/systemBeschreibung</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:systemBeschreibung/text()"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:registratur/text()">
				<xsl:element name="archivalHistory">
					<xsl:attribute name="isadId">2.3</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/registratur</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:registratur/text()"/>
				</xsl:element>
			</xsl:if>
			<!-- Typ FILES  -->
			<xsl:if test="arelda:provenienz/arelda:verwandteSysteme/text()">
				<xsl:element name="archivalHistory">
					<xsl:attribute name="isadId">2.3</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/verwandteSysteme</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:verwandteSysteme/text()"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:archivierungsmodusLoeschvorschriften/text()">
				<xsl:element name="archivalHistory">
					<xsl:attribute name="isadId">2.3</xsl:attribute>
					<xsl:attribute name="origin">//provenienz/archivierungsmodusLoeschvorschriften</xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:archivierungsmodusLoeschvorschriften/text()"/>
				</xsl:element>
			</xsl:if>
			<!--    -->
			<!-- 3.2.4 Abgebende Stelle -->
			<xsl:if test="arelda:ablieferndeStelle/text()">
				<xsl:element name="acqInfo">
					<xsl:attribute name="isadId">2.4</xsl:attribute>
					<xsl:attribute name="origin">//ablieferung/ablieferndeStelle</xsl:attribute>
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<xsl:element name="contentStructure">
			<xsl:attribute name="isadId">3</xsl:attribute>
			<!-- 3.3.1 Form und Inhalt -->
			<xsl:if test="arelda:ablieferungsteile/text()">
				<xsl:element name="scopeContent">
					<xsl:attribute name="isadId">3.1</xsl:attribute>
					<xsl:element name="content">
						<xsl:attribute name="origin">//ablieferung/ablieferungsteile</xsl:attribute>
						<xsl:value-of select="arelda:ablieferungsteile"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- 3.3.2 Bewertung und Kassation -->
			<xsl:if test="arelda:referenzBewertungsentscheid/text()">
				<xsl:element name="appraisalDestruction">
					<xsl:attribute name="isadId">3.2</xsl:attribute>
					<xsl:attribute name="origin">//ablieferung/referenzBewertungsentscheid</xsl:attribute>
					<xsl:value-of select="arelda:referenzBewertungsentscheid"/>
				</xsl:element>
			</xsl:if>
			<!-- 3.3.4 Ornungssystem und Klassifikation -->
			<xsl:if test="arelda:ordnungssystem/arelda:name/text()">
				<xsl:element name="arrangement">
					<xsl:attribute name="isadId">3.4</xsl:attribute>
					<xsl:attribute name="origin">//arelda:ordnungssystem/name</xsl:attribute>
					<xsl:value-of select="arelda:ordnungssystem/arelda:name"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<!-- 3.4 Zugangs- und Benutzungsbedingungen -->
		<xsl:call-template name="xI2access">
			<!-- 3.4.1 Zugangsbestimmungen -->
			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
			<xsl:with-param name="orig">//ablieferung</xsl:with-param>
		</xsl:call-template>
		<!--   -->
		<!-- 3.6.1 Allgemeine Anmerkungen -->
		<xsl:if test="arelda:bemerkung or arelda:provenienz/arelda:bemerkung or //ordnungssystem/bemerkung">
			<xsl:element name="notes">
				<xsl:attribute name="isadId">6</xsl:attribute>
				<!-- 3.6.1 Anmerkungen Ablieferung -->
				<xsl:if test="arelda:bemerkung/text()">
					<xsl:element name="note">
						<xsl:attribute name="origin">//ablieferung/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
				<!-- 3.6.1 Anmerkungen Provenienz -->
				<xsl:if test="arelda:provenienz/arelda:bemerkung/text()">
					<xsl:element name="note">
						<xsl:attribute name="origin">//provenienz/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:provenienz/arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
				<!-- 3.6.1 Anmerkungen Ordnungssystem -->
				<xsl:if test="arelda:ordnungssystem/arelda:bemerkung/text()">
					<xsl:element name="note">
						<xsl:attribute name="origin">//ordnungssystem/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:ordnungssystem/arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:if>
		<!-- additionalData -->
		<xsl:if test="../arelda:zusatzDaten or arelda:zusatzDaten or arelda:ordnungssystem/arelda:zusatzDaten">
			<xsl:element name="additionalData">
				<xsl:element name="mdWrap">
					<!-- <xsl:element name="property">
						<xsl:attribute name="origin">//paket@xmlns</xsl:attribute>
						<xsl:attribute name="key">@xmlns</xsl:attribute>
						<xsl:for-each select="namespace::*">
							<xsl:value-of select="."/>
						</xsl:for-each>
					</xsl:element> -->
					<xsl:element name="property">
						<xsl:attribute name="origin">//paket/@xmlns</xsl:attribute>
						<xsl:attribute name="key">namespace</xsl:attribute>
						<xsl:value-of select="namespace-uri()"/>
					</xsl:element>
					<xsl:element name="property">
						<xsl:attribute name="origin">//paket/paketTyp</xsl:attribute>
						<xsl:attribute name="key">paketTyp</xsl:attribute>
						<xsl:value-of select="../arelda:paketTyp/text()"/>
					</xsl:element>
					<xsl:element name="property">
						<xsl:attribute name="origin">//paket/@schemaVersion</xsl:attribute>
						<xsl:attribute name="key">schemaVersion</xsl:attribute>
						<xsl:value-of select="../@schemaVersion"/>
					</xsl:element>
					<!-- additionalData ablieferung -->
					<xsl:if test="./arelda:ablieferungstyp/text()">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ablieferung/ablieferungstyp</xsl:attribute>
							<xsl:attribute name="key">ablieferungsTyp</xsl:attribute>
							<xsl:value-of select="./arelda:ablieferungstyp"/>
						</xsl:element>
					</xsl:if>
					<xsl:if test="./arelda:ablieferungsnummer/text()">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ablieferung/ablieferungsnummer</xsl:attribute>
							<xsl:attribute name="key">ablieferungsnummer</xsl:attribute>
							<xsl:value-of select="./arelda:ablieferungsnummer"/>
						</xsl:element>
					</xsl:if>
					<xsl:if test="./arelda:angebotsnummer/text()">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ablieferung/angebotsnummer</xsl:attribute>
							<xsl:attribute name="key">angebotsnummer</xsl:attribute>
							<xsl:value-of select="./arelda:angebotsnummer"/>
						</xsl:element>
					</xsl:if>
					<!-- additionalData ordnungssystem -->
					<xsl:if test="arelda:ordnungssystem/arelda:generation/text()">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ordnungssystem/generation</xsl:attribute>
							<xsl:attribute name="key">generation</xsl:attribute>
							<xsl:value-of select="arelda:ordnungssystem/arelda:generation"/>
						</xsl:element>
					</xsl:if>
					<xsl:if test="arelda:ordnungssystem/arelda:mitbenutzung/text()">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ordnungssystem/mitbenutzung</xsl:attribute>
							<xsl:attribute name="key">mitbenutzung</xsl:attribute>
							<xsl:value-of select="arelda:ordnungssystem/arelda:mitbenutzung"/>
						</xsl:element>
					</xsl:if>
					<!-- additionalData zusatzDaten -->
					<xsl:for-each select="../arelda:zusatzDaten/arelda:merkmal">
						<xsl:element name="property">
							<xsl:attribute name="origin">//paket/zusatzDaten/merkmal</xsl:attribute>
							<xsl:attribute name="key"><xsl:value-of select="./@name"/></xsl:attribute>
							<xsl:value-of select="./text()"/>
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="arelda:zusatzDaten/arelda:merkmal">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ablieferung/zusatzDaten/merkmal</xsl:attribute>
							<xsl:attribute name="key"><xsl:value-of select="./@name"/></xsl:attribute>
							<xsl:value-of select="./text()"/>
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="arelda:ordnungssystem/arelda:zusatzDaten/arelda:merkmal">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ordnungssystem/zusatzDaten/merkmal</xsl:attribute>
							<xsl:attribute name="key"><xsl:value-of select="./@name"/></xsl:attribute>
							<xsl:value-of select="./text()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
