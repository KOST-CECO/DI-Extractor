<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:I017="http://kost-ceco.ch/gever/I017">
	<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>
	<xsl:template match="/">
		<xsl:value-of select="//I017:AktenbildnerName"/>
	</xsl:template>
</xsl:stylesheet>