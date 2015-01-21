The output of [saxon.extensionElement.bug.xsl](saxon.extensionElement.bug.xsl) when run on [source.xml](source.xml) the [output](output.without.extensionElement.xml) supposed to contain two "builtin" links (among other links) like this:
    
    <atom:link c:role="http://schema.highwire.org/Publishing/builtin"
               href="/foo/data/2014-033425"/>
    <atom:link c:role="http://schema.highwire.org/Publishing/builtin"
               href="/foo/data/2014-033425.atom?form=feed"
               rel="alternate"
               type="application/atom+xml; type=feed"/>

However, when this is run with the included [saxon.config](saxon.config) which declares an extensionElement, the first link is omitted from the [output](output.with.extensionElement.xml). Note, that the stylesheet does not actually use the Saxon SQL extension which is declared in the config file. 

Confusingly, while using the extensionElement config, uncommenting the xsl:message near the end of the stylesheet with the same @select as the xsl:sequence results in the desired output with the missing link restored.

This example has been distilled out down from a much more complicated stylesheet which *did* make use of custom extension elements and interacted with a database. However, during the distillation process we discovered that it was simply the act of registering an extension element that triggered the buggy behavior.

