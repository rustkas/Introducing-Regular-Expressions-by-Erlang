<xml:stylsheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
<xsl:template match="li">
        <xsl:apply-templates/>
    </xsl:template>
<xsl:template match="p">
        <xsl:apply-templates/>
    </xsl:template>
<xsl:template match="title">
        <xsl:apply-templates/>
    </xsl:template>
<xsl:template match="topic">
        <xsl:apply-templates/>
    </xsl:template>
<xsl:template match="ul">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>