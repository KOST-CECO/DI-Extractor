<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:I017="http://kost-ceco.ch/gever/I017" xmlns="urn:isbn:1-931666-22-9">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<xsl:param name="collsig"/>
	<xsl:param name="colltitle"/>
	<xsl:param name="sipAbl"/>
	<xsl:param name="sipKont"/>
	<xsl:param name="sipProv"/>
	<xsl:param name="sipReg"/>
	<xsl:param name="sipEDV"/>
	<xsl:param name="sipTit"/>
	<xsl:param name="sipZtr"/>
	<xsl:param name="sipBeschr"/>
	<xsl:param name="sipdate"/>
	<!-- Schema location -->
	<xsl:variable name="location">urn:isbn:1-931666-22-9 http://www.loc.gov/ead/ead.xsd</xsl:variable>
	<!-- Dossier -->
	<xsl:include href="dossier2ead.xsl"/>
	<!-- Unterlage -->
	<xsl:include href="unterlage2ead.xsl"/>
	<!-- Root node transformation sets namespace and schema location -->
	<xsl:template match="/I017:Ordnungssystem">
		<xsl:element name="ead">
			<!--
			<xsl:variable name="temp">
				<xsl:element name="xlink:dummy" namespace="http://www.w3.org/1999/xlink"/>
			</xsl:variable>
			<xsl:copy-of select="msxsl:node-set($temp)//namespace::*"/>
			-->
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<!-- EADHEADER -->
			<xsl:element name="eadheader">
				<xsl:element name="eadid"/>
				<xsl:element name="filedesc">
					<xsl:element name="titlestmt">
						<xsl:element name="titleproper">
							<xsl:value-of select="$sipTit"/>
						</xsl:element>
						<xsl:element name="subtitle">
							<xsl:value-of select="$sipBeschr"/>
						</xsl:element>
						<xsl:element name="author">
							<xsl:value-of select="$sipKont"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="publicationstmt">
						<xsl:element name="publisher">
							<xsl:value-of select="$sipAbl"/>
						</xsl:element>
						<xsl:element name="date">
							<xsl:attribute name="type">coverage</xsl:attribute>
							<xsl:value-of select="$sipZtr"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="notestmt">
						<xsl:element name="note">
							<xsl:element name="list">
								<xsl:element name="defitem">
									<xsl:element name="label">
										<xsl:text>Registratur</xsl:text>
									</xsl:element>
									<xsl:element name="item">
										<!-- <xsl:value-of select="I017:aktenbildendeStelle/I017:AktenbildnerRegistratur"/> -->
										<xsl:value-of select="$sipReg"/>
									</xsl:element>
								</xsl:element>
								<xsl:element name="defitem">
									<xsl:element name="label">
										<xsl:text>EDV-System</xsl:text>
									</xsl:element>
									<xsl:element name="item">
										<xsl:value-of select="$sipEDV"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<xsl:element name="profiledesc">
					<xsl:element name="creation">
						<xsl:element name="date">
							<xsl:value-of select="$sipdate"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<!-- ARCHDESC -->
			<xsl:element name="archdesc">
				<xsl:attribute name="level">fonds</xsl:attribute>
				<xsl:element name="did">
					<xsl:element name="unitid">
						<xsl:attribute name="label">signatur</xsl:attribute>
						<xsl:value-of select="$collsig"/>
					</xsl:element>
					<xsl:element name="unittitle">
						<!-- <xsl:value-of select="I017:OrdnungssystemName"/> -->
						<xsl:value-of select="$colltitle"/>
					</xsl:element>
					<xsl:element name="origination">
						<xsl:attribute name="label">Aktenbildner</xsl:attribute>
						<xsl:element name="name">
							<xsl:attribute name="role">provenance</xsl:attribute>
							<!-- <xsl:value-of select="I017:aktenbildendeStelle/I017:AktenbildnerName"/> -->
							<xsl:value-of select="$sipProv"/>
						</xsl:element>
					</xsl:element>
					<xsl:if test="I017:aktenbildendeStelle/I017:AktenbildnerBemerkung/text()">
						<xsl:element name="abstract">
							<xsl:attribute name="label">Aktenbildner</xsl:attribute>
							<xsl:value-of select="I017:aktenbildendeStelle/I017:AktenbildnerBemerkung"/>
						</xsl:element>
					</xsl:if>
				</xsl:element>
				<!-- DSC -->
				<xsl:element name="dsc">
					<xsl:apply-templates mode="c0" select="I017:Ordnungssystemposition">
						<xsl:with-param name="level">1</xsl:with-param>
						<xsl:with-param name="signatur">
							<xsl:value-of select="$collsig"/>
						</xsl:with-param>
					</xsl:apply-templates>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- C0... Aktenplan -->
	<xsl:template mode="c0" match="I017:Ordnungssystemposition">
		<xsl:param name="level"/>
		<xsl:param name="signatur"/>
		<xsl:variable name="sig">
			<xsl:value-of select="$signatur"/>
			<xsl:text>:</xsl:text>
			<xsl:value-of select="I017:OrdnungssystempositionNummer"/>
		</xsl:variable>
		<xsl:element name="c0{$level}">
			<xsl:choose>
				<xsl:when test="$level = 1">
					<xsl:attribute name="level">series</xsl:attribute>
				</xsl:when>
				<xsl:when test="$level = 2">
					<xsl:attribute name="level">subseries</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="level">subgrp</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="filing">
				<xsl:with-param name="signatur" select="$sig"/>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="$level > 1">
					<xsl:apply-templates mode="c0" select="I017:Ordnungssystemposition">
						<xsl:with-param name="level" select="count(ancestor-or-self::*)"/>
						<xsl:with-param name="signatur" select="$signatur"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="c0" select="I017:Ordnungssystemposition">
						<xsl:with-param name="level" select="count(ancestor-or-self::*)"/>
						<xsl:with-param name="signatur" select="$sig"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="I017:Dossier">
				<xsl:apply-templates mode="file" select="I017:Dossier">
					<xsl:with-param name="level" select="count(ancestor-or-self::*)"/>
					<xsl:with-param name="signatur" select="$sig"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!-- DID Aktenplan -->
	<xsl:template name="filing">
		<xsl:param name="signatur"/>
		<xsl:element name="did">
			<xsl:if test="I017:OrdnungssystempositionNummer/text()">
				<xsl:element name="unitid">
					<xsl:attribute name="label">signatur</xsl:attribute>
					<xsl:value-of select="$signatur"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="I017:OrdnungssystempositionTitel/text()">
				<xsl:element name="unittitle">
					<xsl:value-of select="I017:OrdnungssystempositionTitel"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="I017:OrdnungssystempositionBemerkung/text()">
				<xsl:element name="abstract">
					<xsl:value-of select="I017:OrdnungssystempositionBemerkung"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="I017:OrdnungssystempositionStandort/text()">
				<xsl:element name="physloc">
					<xsl:attribute name="label">Standort</xsl:attribute>
					<xsl:value-of select="I017:OrdnungssystempositionStandort"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<!-- CONTROLACCESS Aktenplan -->
		<xsl:if test="I017:OrdnungssystempositionSchlagwort">
			<xsl:element name="controlaccess">
				<xsl:for-each select="I017:OrdnungssystempositionSchlagwort">
					<xsl:element name="subject">
						<xsl:value-of select="text()"/>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</xsl:if>
		<!-- ACCESS Aktenplan -->
		<xsl:if test="I017:OrdnungssystempositionKlassifizierungskategorie/text()">
			<xsl:element name="accessrestrict">
				<xsl:element name="list">
					<xsl:if test="I017:OrdnungssystempositionKlassifizierungskategorie/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Klassifizierungskategorie</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:OrdnungssystempositionKlassifizierungskategorie"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:OrdnungssystempositionDatenschutzstufe/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Datenschutzstufe</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:OrdnungssystempositionDatenschutzstufe"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:OrdnungssystempositionÖffentlichkeitsstatus/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">Öffentlichkeitsstatus</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:OrdnungssystempositionÖffentlichkeitsstatus"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<xsl:if test="I017:OrdnungssystempositionÖffentlichkeitsstatusBegründung/text()">
						<xsl:element name="defitem">
							<xsl:element name="label">ÖffentlichkeitsstatusBegründung</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="I017:OrdnungssystempositionÖffentlichkeitsstatusBegründung"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- RELATED Aktenplan -->
		<xsl:if test="I017:OrdnungssystempositionVerweis/text()">
			<xsl:element name="relatedmaterial">
				<xsl:element name="list">
					<xsl:for-each select="I017:OrdnungssystempositionVerweis">
						<xsl:element name="item">
							<xsl:value-of select="text()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- ODD Aktenplan -->
		<xsl:element name="odd">
			<xsl:element name="list">
				<xsl:if test="I017:OrdnungssystempositionStatus/text()">
					<xsl:element name="defitem">
						<xsl:element name="label">Status</xsl:element>
						<xsl:element name="item">
							<xsl:value-of select="I017:OrdnungssystempositionStatus"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:OrdnungssystempositionArchivwürdigkeit/text()">
					<xsl:element name="defitem">
						<xsl:element name="label">Archivwürdigkeit</xsl:element>
						<xsl:element name="item">
							<xsl:value-of select="I017:OrdnungssystempositionArchivwürdigkeit"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:if test="I017:Rubrik_Dossierbildung/text()">
					<xsl:element name="defitem">
						<xsl:element name="label">Rubrik Dossierbildung</xsl:element>
						<xsl:element name="item">
							<xsl:value-of select="I017:Rubrik_Dossierbildung"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
