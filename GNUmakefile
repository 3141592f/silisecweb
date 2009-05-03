SRCDIR  ?= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
VPATH   ?= $(SRCDIR)
XSLT    ?= xsltproc
INSTALL ?= install
SITE    ?= $(HOME)/Sites/silisec

all: index.html atom.xml

install: install-srcdir install-generated

index.html: index.xsl index.xml articles.xml
	$(XSLT) -o $@ --param articlesxml "'$(filter %articles.xml,$^)'" \
	  $< $(filter %index.xml,$^)

atom.xml: atom.xsl articles.xml
	$(XSLT) -o $@ $< $(filter %articles.xml,$^)


install-srcdir: main.css
	$(INSTALL) -d -m 0755 $(SITE)
	$(INSTALL) -C -m 0644 $^ $(SITE)

install-generated: index.html atom.xml
	$(INSTALL) -d -m 0755 $(SITE)
	$(INSTALL) -C -m 0644 $^ $(SITE)

clean:
	rm -f index.html atom.xml