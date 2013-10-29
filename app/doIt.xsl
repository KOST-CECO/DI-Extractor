<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<xsl:template match="/tree">
		<xhtml>
			<head/>
			<body>
				<ul>
					<xsl:apply-templates select="node[depth='0']"/>
				</ul>
			</body>
		</xhtml>
	</xsl:template>
	<xsl:template match="node">
    <xsl:variable name="thisNodeId" select="generate-id(.)"/>
    <xsl:variable name="depth" select="depth"/>
    <xsl:variable name="descendants">
    	<xsl:apply-templates select="following-sibling::node[depth = $depth + 1][generate-id(preceding-sibling::node[depth = $depth][1]) = $thisNodeId]"/>
    	</xsl:variable>
    <xsl:variable name="descendantsNb">
    	<xsl:value-of select="count(following-sibling::node[depth = $depth + 1][generate-id(preceding-sibling::node[depth = $depth][1]) = $thisNodeId])"/>
    	</xsl:variable>
    <li>
    	<xsl:value-of select="name"/>
    	</li>
    <xsl:if test="$descendantsNb &gt; 0">
    	<ul>
    		<xsl:copy-of select="$descendants"/>
    		</ul>
    	</xsl:if>
    </xsl:template>
</xsl:stylesheet>
