<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="urn:isbn:1-931666-22-9" xmlns:I017="http://kost-ceco.ch/gever/I017" xmlns:premis="http://www.loc.gov/standards/premis/v1">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<xsl:param name="premisfile"/>
	<!-- Unterlage -->
	<xsl:template mode="item" match="I017:Unterlage">
		<xsl:param name="level"/>
		<xsl:param name="signatur"/>
		<xsl:variable name="sig">
			<xsl:value-of select="$signatur"/>
			<xsl:text>:</xsl:text>
			<xsl:value-of select="I017:UnterlageAktenzeichen"/>
			<xsl:if test="I017:UnterlageVersion/text()">
				<xsl:text>:</xsl:text>
				<xsl:value-of select="I017:UnterlageVersion"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="premis" select="document($premisfile)/premis:premis"/>
		<!-- <xsl:variable name="premis" select="document('./wdir/premis.xml')/premis:premis"/>  -->
		<!-- C0... Unterlage -->
		<xsl:element name="c0{$level}">
			<xsl:attribute name="level">item</xsl:attribute>
			<!-- DID Unterlage -->
			<xsl:element name="did">
				<xsl:if test="I017:UnterlageAktenzeichen/text()">
					<xsl:element name="unitid">
						<xsl:attribute name="label">signatur</xsl:attribute>
						<xsl:value-of select="$sig"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:UnterlageBetreff/text()">
					<xsl:element name="unittitle">
						<xsl:value-of select="I017:UnterlageBetreff"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:UnterlageRegistrierdatum/text()">
					<xsl:element name="unitdate">
						<xsl:value-of select="I017:UnterlageRegistrierdatum"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:UnterlageBemerkung/text()">
					<xsl:element name="abstract">
						<xsl:value-of select="I017:UnterlageBemerkung"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
			<!-- CONTROLACCESS Unterlage -->
			<xsl:if test="I017:UnterlageSchlagwort">
				<xsl:element name="controlaccess">
					<xsl:for-each select="I017:UnterlageSchlagwort">
						<xsl:element name="subject">
							<xsl:value-of select="text()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<!-- ACCESS Unterlage -->
			<xsl:if test="I017:UnterlageKlassifizierungskategorie/text()">
				<xsl:element name="accessrestrict">
					<xsl:element name="list">
						<xsl:if test="I017:UnterlageKlassifizierungskategorie/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Klassifizierungskategorie</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:UnterlageKlassifizierungskategorie"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:UnterlageDatenschutzstufe/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Datenschutzstufe</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:UnterlageDatenschutzstufe"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:UnterlageÖffentlichkeitsstatus/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Öffentlichkeitsstatus</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:UnterlageÖffentlichkeitsstatus"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:UnterlageÖffentlichkeitsstatusBegründung/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">ÖffentlichkeitsstatusBegründung</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:UnterlageÖffentlichkeitsstatusBegründung"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- RELATED Unterlage -->
			<xsl:if test="I017:UnterlageVerweis/text()">
				<xsl:element name="relatedmaterial">
					<xsl:element name="list">
						<xsl:for-each select="I017:UnterlageVerweis">
							<xsl:element name="item">
								<xsl:value-of select="text()"/>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- ODD Unterlage -->
			<xsl:element name="odd">
				<xsl:element name="list">
					<xsl:if test="I017:UnterlageStatus/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Status</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:UnterlageStatus"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:UnterlageVersion/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Version</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:UnterlageVersion"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:Unterlagedigitale/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">digitale Signatur Verifikation</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:Unterlagedigitale"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:UnterlageAdressat/text()">
						<xsl:for-each select="I017:UnterlageAdressat">
							<xsl:element name="defitem">
								<xsl:element name="label">Adressat</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="text()"/>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="I017:UnterlageEmpfängerKopie/text()">
						<xsl:for-each select="I017:UnterlageEmpfängerKopie">
							<xsl:element name="defitem">
								<xsl:element name="label">Empfänger Kopie</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="text()"/>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="I017:UnterlageUnterzeichner/text()">
						<xsl:for-each select="I017:UnterlageUnterzeichner">
							<xsl:element name="defitem">
								<xsl:element name="label">Unterzeichner</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="text()"/>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="I017:UnterlageAbsenderadresse/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Absenderadresse</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:UnterlageAbsenderadresse"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:UnterlageFremdaktenzeichen/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Fremdaktenzeichen</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:UnterlageFremdaktenzeichen"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:UnterlageAbsendedatum/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Absendedatum</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:UnterlageAbsendedatum"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:UnterlageEingangsdatum/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Eingangsdatum</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:UnterlageEingangsdatum"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
			<!-- DAO -->
			<xsl:element name="dao">
				<xsl:if test="I017:Erscheinungsform/I017:ErscheinungsformURN/text()">
					<xsl:variable name="id">
						<xsl:text>../primaryData/</xsl:text>
						<xsl:value-of select="I017:Erscheinungsform/I017:ErscheinungsformURN"/>
					</xsl:variable>
					<xsl:variable name="pointer">
						<xsl:value-of select="$premis/premis:object[premis:objectIdentifier/premis:objectIdentifierValue=$id]/@xmlID"/>
					</xsl:variable>
					<xsl:attribute name="xpointer">premis.xml#xpointer(//xmlID('<xsl:value-of select="$pointer"/>'))</xsl:attribute>
				</xsl:if>
				<xsl:element name="daodesc">
					<xsl:element name="list">
						<xsl:if test="I017:Erscheinungsform/I017:ErscheinungsformFormat/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Format</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:Erscheinungsform/I017:ErscheinungsformFormat/text()"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:Erscheinungsform/I017:ErscheinungsformErstellungsdatum/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">Erstellungsdatum</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:Erscheinungsform/I017:ErscheinungsformErstellungsdatum/text()"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="I017:Erscheinungsform/I017:ErscheinungsformURN/text()">
							<xsl:element name="defitem">
								<xsl:element name="label">URN</xsl:element>
								<xsl:element name="item">
									<xsl:value-of select="I017:Erscheinungsform/I017:ErscheinungsformURN/text()"/>
								</xsl:element>
							</xsl:element>
						</xsl:if>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
