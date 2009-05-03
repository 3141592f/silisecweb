<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:atom="http://www.w3.org/2005/Atom"
        xmlns:art="http://silisec.org/apps/article-1"
        exclude-result-prefixes="xhtml atom art"
        >
<xsl:output
  method="xml"
  encoding="utf-8"
  indent="yes"
  />

<xsl:template match="/">
  <atom:feed xmlns="http://www.w3.org/2005/Atom">
    <atom:title>silisec</atom:title>
    <atom:link href="http://silisec.org" />
    <xsl:apply-templates select="art:articles/art:article" />
  </atom:feed>
</xsl:template>

<xsl:template match="art:article">
  <xsl:variable name="date" select="normalize-space(art:date/text())" />
  <atom:entry>
    <atom:title><xsl:value-of select="art:title/text()" /></atom:title>
    <atom:updated><xsl:value-of
      select="art:date/text()" />T00:00:00Z</atom:updated>
    <atom:content type="xhtml">
      <xsl:apply-templates select="xhtml:body/*" />
    </atom:content>
  </atom:entry>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:param name="article" />
  <xsl:copy>
    <xsl:apply-templates select="@*|node()">
      <xsl:with-param name="article" select="$article" />
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>