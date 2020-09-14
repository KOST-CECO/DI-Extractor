<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rico="https://www.ica.org/standards/RiC/ontology#"
		xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template RICdate -->
	<xsl:template name="RICdate">
		<xsl:param name="range"/>
		<xsl:if test="not ($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:choose>
				<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 4">
					<xsl:element name="rico:beginningDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
							<xsl:attribute name="circa">true</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$range/arelda:von/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 10">
					<xsl:element name="rico:beginningDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
							<xsl:attribute name="circa">true</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$range/arelda:von/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$range/arelda:von/arelda:datum/text() = 'keine Angabe'">
					<xsl:element name="rico:beginningDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 4">
					<xsl:element name="rico:endDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
							<xsl:attribute name="circa">true</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 10">
					<xsl:element name="rico:endDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
							<xsl:attribute name="circa">true</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$range/arelda:bis/arelda:datum/text() = 'keine Angabe'">
					<xsl:element name="rico:endDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
