<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xI2filename -->
	<xsl:template name="xI2filename">
			<xsl:param name="fileid"/>
		<!--   -->
		<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name">
			<xsl:element name="arrangement">
				<xsl:attribute name="isadId">3.4</xsl:attribute>
				<xsl:attribute name="origin">//ordner/name + //datei/name</xsl:attribute>
				<xsl:for-each select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name/text()">
					<xsl:for-each select="ancestor::*">
						<xsl:if test="./arelda:name">
							<xsl:if test="./arelda:name/text() != 'content'">
								<xsl:text>/</xsl:text>
								<xsl:value-of select="./arelda:name/text()"/>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:element>
		</xsl:if>
		<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName">
			<xsl:element name="arrangement">
				<xsl:attribute name="isadId">3.4</xsl:attribute>
				<xsl:attribute name="origin">//ordner/originalName + //datei/originalName</xsl:attribute>
				<xsl:for-each select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName/text()">
					<xsl:for-each select="ancestor::*">
						<xsl:if test="./arelda:originalName">
							<xsl:if test="./arelda:originalName/text() != 'content'">
								<xsl:text>/</xsl:text>
								<xsl:value-of select="./arelda:originalName/text()"/>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>