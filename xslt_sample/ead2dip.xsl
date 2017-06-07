<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="urn:isbn:1-931666-22-9" xmlns:premis="http://www.loc.gov/standards/premis/v1">
	<xsl:output method="xml" version="4.0" encoding="iso-8859-1" indent="yes" media-type="text/html" omit-xml-declaration="yes"/>
	<xsl:variable name="eadfile" select="document('../metaData/ead.xml')/ead:ead"/>
	<xsl:variable name="premisfile" select="document('../metaData/premis.xml')/premis:premis"/>
	<xsl:template match="/">
		<!-- HTML BODY -->
		<html>
			<head>
				<link rel="StyleSheet" href="dip.css" type="text/css"/>
				<title>Dissemination Information Package: <xsl:value-of select="$eadfile//ead:titleproper"/>
				</title>
				<body>
					<div>
						<span style="font-size: 30pt;">KOST </span>
						<span style="font-size: 20pt;">Dissemination Information Package (DIP) </span>
					</div>
					<xsl:call-template name="Paketinformation"/>
					<xsl:call-template name="Ablagestruktur"/>
					<xsl:call-template name="Unterlagen"/>
					<!-- Copyright-Zeile -->
					<div class="copyright">
						<xsl:text disable-output-escaping="yes">
Copyright © 2005-2008 by Koordinationsstelle für die dauerhafte Archivierung elektronischer Unterlagen &amp;nbsp; &amp;nbsp;</xsl:text>
						<a href="mailto:info@kost-ceco.ch">info@kost-ceco.ch</a>
					</div>
				</body>
			</head>
		</html>
	</xsl:template>
	<!-- PACKETINFORMATION  -->
	<xsl:template name="Paketinformation">
		<div>
			<table>
				<tr>
					<th colspan="2" class="title">Paketinformation</th>
				</tr>
				<tr>
					<td class="key">Signatur</td>
					<td class="value">
						<xsl:value-of select="$eadfile//ead:did[../@level='file']/ead:unitid"/>
					</td>
				</tr>
				<xsl:if test="$eadfile//ead:publicationstmt/ead:publisher/text()">
					<tr>
						<td class="key">Abliefernde Stelle</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:publicationstmt/ead:publisher"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:author/text()">
					<tr>
						<td class="key">Kontaktperson</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:author"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:origination/ead:name[@role='provenance']/text()">
					<tr>
						<td class="key">Aktenbildende Stelle</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:origination/ead:name[@role='provenance']"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:item[preceding-sibling::ead:label='Registratur']/text()">
					<tr>
						<td class="key">Ablage</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:item[preceding-sibling::ead:label='Registratur']"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:item[preceding-sibling::ead:label='EDV-System']/text()">
					<tr>
						<td class="key">EDV System</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:item[preceding-sibling::ead:label='EDV-System']"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:titleproper/text()">
					<tr>
						<td class="key">Ablieferungstitel</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:titleproper"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:publicationstmt/ead:date/text()">
					<tr>
						<td class="key">Zeitraum</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:publicationstmt/ead:date"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$eadfile//ead:subtitle/text()">
					<tr>
						<td class="key">Beschreibung</td>
						<td class="value">
							<xsl:value-of select="$eadfile//ead:subtitle"/>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="key">Verzeichnisstufe</td>
					<td class="value">Dossier</td>
				</tr>
				<tr>
					<td class="key">Anzahl Dokumente</td>
					<td class="value">
						<xsl:value-of select="count($eadfile//ead:dao)"/>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<!-- ABLAGESTRUKTUR    -->
	<xsl:template name="Ablagestruktur">
		<div>
			<table>
				<tr>
					<th colspan="2" class="title">Ablagestruktur
						<xsl:apply-templates mode="ablagestruktur" select="$eadfile//ead:archdesc"/>
					</th>
				</tr>
				<xsl:apply-templates mode="verzeichungeinheit" select="$eadfile//ead:archdesc/ead:did"/>
			</table>
		</div>
	</xsl:template>
	<!-- STRUKTUR  -->
	<xsl:template mode="ablagestruktur" match="ead:archdesc">
		<div class="struktur">
			<a>
				<xsl:attribute name="href">#<xsl:value-of select="./@level"/></xsl:attribute>
				<!-- level -->
				<b>
					<xsl:value-of select="./@level"/>
				</b>
				<!-- unitid -->
				<xsl:if test="//ead:unitid/text()">
					<xsl:text>:  </xsl:text>
					<xsl:value-of select="//ead:unitid"/>
				</xsl:if>
				<!-- unittitle -->
				<xsl:if test="//ead:unittitle/text()">
					<xsl:text>:  </xsl:text>
					<xsl:value-of select="//ead:unittitle"/>
				</xsl:if>
				<!-- go to next level -->
				<xsl:apply-templates mode="struktur" select="*/*/ead:did">
					<xsl:with-param name="level">1</xsl:with-param>
				</xsl:apply-templates>
			</a>
		</div>
	</xsl:template>
	<xsl:template mode="struktur" match="ead:did">
		<xsl:param name="level"/>
		<div class="struktur">
			<a>
				<xsl:attribute name="href">#<xsl:value-of select="../@level"/></xsl:attribute>
				<!-- level -->
				<b>
					<xsl:value-of select="../@level"/>
				</b>
				<!-- unitid -->
				<xsl:if test="ead:unitid/text()">
					<xsl:text>:  </xsl:text>
					<xsl:value-of select="ead:unitid"/>
				</xsl:if>
				<!-- unittitle -->
				<xsl:if test="ead:unittitle/text()">
					<xsl:text>:  </xsl:text>
					<xsl:value-of select="ead:unittitle"/>
				</xsl:if>
				<!-- go to next level -->
				<xsl:choose>
					<xsl:when test="not(../*/@level='item')">
						<xsl:apply-templates mode="struktur" select="../*/ead:did">
							<xsl:with-param name="level">
								<xsl:value-of select="count(ancestor-or-self::*)-3"/>
							</xsl:with-param>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<div class="struktur">
							<a href="#Digitale_Unterlagen">
								<b>Digitale Unterlagen</b>
							</a>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</div>
	</xsl:template>
	<!-- VERZEICHNUNGSEINHEIT  -->
	<xsl:template mode="verzeichungeinheit" match="ead:archdesc/ead:did">
		<tr>
			<td colspan="2" class="section">
				<a>
					<xsl:attribute name="name"><xsl:value-of select="../@level"/></xsl:attribute>
					<xsl:text/>
				</a>
				<!-- level -->
				<b>
					<xsl:value-of select="../@level"/>
				</b>
				<!-- unitid -->
				<xsl:if test="ead:unitid/text()">
					<xsl:text>:  </xsl:text>
					<xsl:value-of select="ead:unitid"/>
				</xsl:if>
			</td>
		</tr>
		<xsl:call-template name="verzeichnungsdetail"/>
		<!-- go to next level -->
		<xsl:apply-templates mode="verzeichnung" select="../ead:dsc/ead:c01/ead:did">
			<xsl:with-param name="level">1</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template mode="verzeichnung" match="ead:did">
		<xsl:param name="level"/>
		<tr>
			<td colspan="2" class="section">
				<a>
					<xsl:attribute name="name"><xsl:value-of select="../@level"/></xsl:attribute>
					<xsl:text/>
				</a>
				<!-- level -->
				<b>
					<xsl:value-of select="../@level"/>
				</b>
				<!-- unitid -->
				<xsl:if test="ead:unitid/text()">
					<xsl:text>:  </xsl:text>
					<xsl:value-of select="ead:unitid"/>
				</xsl:if>
			</td>
		</tr>
		<xsl:call-template name="verzeichnungsdetail"/>
		<!-- go to next level -->
		<xsl:if test="not(../*/@level='item')">
			<xsl:apply-templates mode="verzeichnung" select="../*/ead:did">
				<xsl:with-param name="level">
					<xsl:value-of select="count(ancestor-or-self::*)-3"/>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>
	<!-- level detail -->
	<xsl:template name="verzeichnungsdetail">
		<tr>
			<td class="key">Titel</td>
			<td class="value">
				<xsl:value-of select="ead:unittitle"/>
			</td>
		</tr>
		<xsl:if test="ead:unitdate/text()">
			<tr>
				<td class="key">Berichtzeit</td>
				<td class="value">
					<xsl:value-of select="ead:unitdate"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="ead:abstract/text()">
			<tr>
				<td class="key">Beschreibung</td>
				<td class="value">
					<xsl:value-of select="ead:abstract"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="../ead:accessrestrict">
			<tr>
				<td class="key">Klassifizierung</td>
				<td class="value">
					<xsl:value-of select="../ead:accessrestrict/*/*/ead:item[../ead:label='Klassifizierungskategorie']"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:if test="../ead:controlaccess">
			<tr>
				<td class="key">Schlagworte</td>
				<td class="value">
					<xsl:for-each select="../ead:controlaccess/*">
						<xsl:value-of select="text()"/>
						<br/>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<!-- UNTERLAGEN  -->
	<xsl:template name="Unterlagen">
		<div>
			<table>
				<tr>
					<th colspan="6" class="title">
						<a name="Digitale_Unterlagen">
							<xsl:text/>
						</a>Digitale Unterlagen
					</th>
				</tr>
				<tr>
					<td class="header">Nr.</td>
					<td class="header">Dokumentname</td>
					<td class="header">Beschreibung</td>
					<td class="header">Datum</td>
					<td class="header">Dateiformat</td>
					<td class="header">Erstellungsdatum</td>
				</tr>
				<xsl:for-each select="$eadfile//ead:did[../@level='item']">
					<xsl:variable name="id">
						<xsl:value-of select="substring(../ead:dao/@xpointer,30,string-length(../ead:dao/@xpointer)-32)"/>
					</xsl:variable>
					<tr>
						<td>
							<xsl:number value="position()" format="1"/>
						</td>
						<!-- item name -->
						<td>
							<xsl:variable name="url">
								<xsl:value-of select="$premisfile/premis:object[@xmlID=$id]//premis:objectIdentifierValue"/>
							</xsl:variable>
							<xsl:element name="a">
								<xsl:attribute name="target">_blank</xsl:attribute>
								<xsl:attribute name="href"><xsl:value-of select="$url"/></xsl:attribute>
								<xsl:value-of select="ead:unittitle"/>
							</xsl:element>
						</td>
						<!-- abstract -->
						<td>
							<xsl:value-of select="ead:abstract"/>
							<xsl:value-of select="ead:materialspec"/>
						</td>
						<!-- datum -->
						<td>
							<xsl:value-of select="ead:unitdate"/>
						</td>
						<!-- format -->
						<td>
							<xsl:value-of select="$premisfile/premis:object[@xmlID=$id]//premis:formatVersion"/>
						</td>
						<!-- erstellungsdatum -->
						<td>
							<xsl:value-of select="$premisfile/premis:object[@xmlID=$id]//premis:dateCreatedByApplication"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</div>
	</xsl:template>
</xsl:stylesheet>
