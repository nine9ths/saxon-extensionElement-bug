<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:c="http://schema.highwire.org/Compound"
  xmlns:app="http://www.w3.org/2007/app"
  xmlns:hwp="http://schema.highwire.org/Journal"
  xmlns:l="http://schema.highwire.org/Linking"
  xmlns:nlm="http://schema.highwire.org/NLM/Journal"
  xmlns:r="http://schema.highwire.org/Revision"
  xmlns:x="http://www.w3.org/1999/xhtml"
  xmlns:atom="http://www.w3.org/2005/Atom"
  exclude-result-prefixes="xs">
  
  <xsl:output indent="yes"/>
  
  <xsl:template match="Distribution">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="Reference">
    
    <xsl:variable name="atom:entry.existing" as="element(atom:entry)*"
      select="doc('feed.atom')/atom:feed/atom:entry"/>
    
    <links>
      <xsl:sequence select="$atom:entry.existing/atom:link[exists(@c:role)][@rel eq 'http://schema.highwire.org/Compound#parent']"/>
      
      <xsl:variable name="atom:link.managed" as="element(atom:link)*"
        select="
        $atom:entry.existing/atom:link[
        matches(@rel,'^(self|edit(-media)?)$') or
        exists(@c:role) or
        matches(@rel,'http://schema.highwire.org/Publishing#.+') or
        exists(@c:via)]"/>
      
      <xsl:variable name="atom:link.excluded" as="element(atom:link)*"
        select="
        $atom:entry.existing/atom:link[
        (@rel eq 'http://schema.highwire.org/Compound#parent') or
        (@href = ('forthcoming:yes','pending:yes'))]"/>
      
      
      <!-- Uncommenting this fixes the buggy behavior -->
      <!--<xsl:message select="$atom:link.managed except $atom:link.excluded"/>-->
      
      <xsl:sequence select="$atom:link.managed except $atom:link.excluded"/>
    </links>
    
  </xsl:template>
  
  
  
</xsl:stylesheet>