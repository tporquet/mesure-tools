<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
>
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>

<xsl:template match="/">
  <xsl:apply-templates select="soapenv:Envelope/soapenv:Body/*[local-name()='ReportResponse']" />
</xsl:template>

<xsl:template match="soapenv:Envelope/soapenv:Body/*[local-name()='ReportResponse']">
<!-- Report type (eg. JR1 (R3)) -->
<xsl:value-of select="*[local-name()='ReportDefinition']/@Name"/> (R<xsl:value-of select="*[local-name()='ReportDefinition']/@Release"/>)
<!-- Customer Name -->
<xsl:choose>
<xsl:when test="*[local-name()='Report']/*[local-name()='Report']/*[local-name()='Customer']/*[local-name()='Name'] != ''">
<xsl:value-of select="*[local-name()='Report']/*[local-name()='Report']/*[local-name()='Customer']/*[local-name()='Name']"/>
</xsl:when>
<xsl:otherwise>
<!-- IOP reports have a customer name in another element -->
<xsl:value-of select="*[local-name()='CustomerReference']/*[local-name()='Name']"/>
</xsl:otherwise>
</xsl:choose>
<!-- Report creation date -->
Date run:
<xsl:choose>
<xsl:when test="*[local-name()='Report']/*[local-name()='Report']/@Created != ''">
<xsl:value-of select="substring(*[local-name()='Report']/*[local-name()='Report']/@Created,1,10)"/>
</xsl:when>
<xsl:otherwise>
<!-- IOP reports have a creation date in another element -->
<xsl:value-of select="substring(@Created,1,10)"/>
</xsl:otherwise>
</xsl:choose>
Journal&#09;Publisher&#09;Platform&#09;Print ISSN&#09;Online ISSN&#09;<xsl:value-of select="substring(*[local-name()='ReportDefinition']/*[local-name()='Filters']/*[local-name()='UsageDateRange']/*[local-name()='Begin'],1,7)"/>&#09;Reporting Period HTML&#09;Reporting Period PDF
<xsl:apply-templates select="*[local-name()='Report']/*[local-name()='Report']/*[local-name()='Customer']/*[local-name()='ReportItems']"/>
</xsl:template>

<xsl:template match="*[local-name()='ReportItems']">
<xsl:value-of select="concat(*[local-name()='ItemName']
                             ,'&#09;'
                             ,*[local-name()='ItemPublisher']
                             ,'&#09;'
                             ,*[local-name()='ItemPlatform']
                             ,'&#09;')"/>
<!-- print issn -->
<xsl:value-of select="*[local-name()='ItemIdentifier'][*[local-name()='Type']='Print_ISSN']/*[local-name()='Value']"/>
<xsl:text>&#09;</xsl:text>
<!-- online issn -->
<xsl:value-of select="*[local-name()='ItemIdentifier'][*[local-name()='Type']='Online_ISSN']/*[local-name()='Value']"/>
<xsl:text>&#09;</xsl:text>
<!-- total -->
<xsl:value-of select="*[local-name()='ItemPerformance']/*[local-name()='Instance'][*[local-name()='MetricType']='ft_total']/*[local-name()='Count']"/>
<xsl:text>&#09;</xsl:text>		    		 
<!-- html -->				    		 
<xsl:value-of select="*[local-name()='ItemPerformance']/*[local-name()='Instance'][*[local-name()='MetricType']='ft_html']/*[local-name()='Count']"/>
<xsl:text>&#09;</xsl:text>		    		 
<!-- pdf -->				    		 
<xsl:value-of select="*[local-name()='ItemPerformance']/*[local-name()='Instance'][*[local-name()='MetricType']='ft_pdf']/*[local-name()='Count']"/>
<xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>

