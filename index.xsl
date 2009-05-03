<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/1999/xhtml"
        xmlns:art="http://silisec.org/apps/article-1"
	exclude-result-prefixes="art xhtml"
        >
<xsl:output
  method="html"
  encoding="us-ascii"
  doctype-system="http://www.w3.org/TR/html4/loose.dtd"
  doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
  indent="yes"
  />
<xsl:param name="articlesxml" select="'articles.xml'" />
<xsl:variable name="articles" select="document($articlesxml)/art:articles" />


<!-- The title of the output document is set from the title of the first
     article encountered, which should be the chronologically latest.
-->
<xsl:template match="xhtml:title/text()">
  <xsl:value-of
      select="$articles/art:article[position()=1]/art:title/text()" />
</xsl:template>


<!-- The element with ID 'template' will be replicated for each
     article, with some text and elements substituted with those 
     of the article:

     1. The text of elements with class 'article-title'
     will be replaced with the text of the article title.

     2. The text of elements with class 'article-byline' will be
     replaced with a byline built from the article date and author.

     3. The children of elements with the class 'article-body' will
     be replaced with the article body.
-->
<xsl:template match="*[@id='template']">
  <xsl:apply-templates select="$articles/art:article">
    <xsl:with-param name="template" select="." />
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="art:article">
  <xsl:param name="template" />
  <xsl:apply-templates select="$template/*">
    <xsl:with-param name="article" select="." />
  </xsl:apply-templates>
  <xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="*[@class='article-title']/text()">
  <xsl:param name="article" />
  <xsl:value-of select="$article/art:title/text()" />
</xsl:template>

<xsl:template match="*[@class='article-byline']/text()">
  <xsl:param name="article" />
  <xsl:value-of select="$article/art:date/text()" />
  <xsl:text> by </xsl:text>
  <xsl:value-of select="$article/art:author/text()" />
</xsl:template>

<xsl:template match="*[@class='article-body']">
  <xsl:param name="article" />
  <xsl:copy>
    <xsl:apply-templates select="@*|$article/xhtml:body/*" />
  </xsl:copy>
</xsl:template>


<!-- For everything else, copy the input to the output. -->
<xsl:template match="@*|node()">
  <xsl:param name="article" />
  <xsl:copy>
    <xsl:apply-templates select="@*|node()">
      <xsl:with-param name="article" select="$article" />
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>