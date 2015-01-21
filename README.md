When the stylesheet [saxon.extensionElement.bug.xsl](saxon.extensionElement.bug.xsl) is run on [source.xml](source.xml), the [output](output.without.extensionElement.xml) is supposed to contain two "builtin" links (among other links) like this:
    
    <atom:link c:role="http://schema.highwire.org/Publishing/builtin"
               href="/foo/data/2014-033425"/>
    <atom:link c:role="http://schema.highwire.org/Publishing/builtin"
               href="/foo/data/2014-033425.atom?form=feed"
               rel="alternate"
               type="application/atom+xml; type=feed"/>

However, when run with the included [saxon.config](saxon.config) which declares an extensionElement, the first link is omitted from the [output](output.with.extensionElement.xml). Note, that the stylesheet does not actually use the Saxon SQL extension which is declared in the config file. 

Confusingly, while using the extensionElement config, uncommenting the xsl:message near the end of the stylesheet with the same @select as the xsl:sequence results in the desired output, i.e. the link is no longer omitted.

I'm seeing this behavior with Saxon 9.5.1.7 bundled with Oxygen 16.1 (build 2014112517) although I also have seen it in Oxygen 16.0 and with our dev Saxon-EE 9.5.1.5J jar.

This example has been distilled down from a much more complicated stylesheet which *did* make use of custom extension elements and interacted with a database. However, during the distillation process we discovered that it was simply the act of registering an extension element that triggered the buggy behavior.

