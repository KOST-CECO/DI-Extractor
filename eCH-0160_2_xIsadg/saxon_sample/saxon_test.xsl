<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Test</title>
			</head>
			<body>
				<xsl:apply-templates select="buecher/buch"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="buch">
		<table width="500">
			<xsl:apply-templates select="title"/>
			<xsl:apply-templates select="autor"/>
			<xsl:apply-templates select="erscheinungsjahr"/>
		</table>
	</xsl:template>
	<xsl:template match="title">
		<tr>
			<td bgcolor="yellow">
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="autor">
		<tr>
			<td bgcolor="green">
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="erscheinungsjahr">
		<tr>
			<td>
				<xsl:value-of select="."/>
			</td>
		</tr>
		<tr>
			<td>
				<hr/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
