<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:dbk="http://docbook.org/ns/docbook"
  xmlns:css="http://www.w3.org/1996/css" 
  xmlns:hub="http://transpect.io/hub"
  xmlns:tr="http://transpect.io"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns="http://docbook.org/ns/docbook"
  version="2.0" 
  exclude-result-prefixes="#all"
  xpath-default-namespace="http://docbook.org/ns/docbook">

  <xsl:import href="http://transpect.io/evolve-hub/xsl/evolve-hub.xsl"/>
  <xsl:import href="http://transpect.io/xslt-util/uri-to-relative-path/xsl/uri-to-relative-path.xsl"/>
  
  <xsl:template match="@fileref" mode="hub:lists">
    <xsl:variable name="fileref" select="tr:uri-to-relative-path(
      /hub/info/keywordset/keyword[@role eq 'source-dir-uri'],
      concat(/hub/info/keywordset/keyword[@role eq 'source-dir-uri'], replace(., 'container:', '/'))
      )"/>
    <xsl:attribute name="fileref" select="$fileref"/>
  </xsl:template>
  
  <!-- handle pseudo tables frequently used for numbered equations in MS Word, 
    special table format necessary to avoid accidental use. -->
  
  <xsl:template match="informaltable[@role = ('docx2tex_equation-table', 'docx2tex_Gleichungstabelle')]
    [exists(.//equation)][not(exists(.//mediaobject))]" mode="hub:lists">
    <xsl:apply-templates select=".//equation" mode="#current"/>
  </xsl:template>
  
  <xsl:template match="blockquote[@role = 'hub:lists']" mode="hub:postprocess-lists">
    <xsl:apply-templates mode="#current"/>
  </xsl:template>

</xsl:stylesheet>