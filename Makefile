#
# Makefile for github-mirror
#

# WARNING: The install and uninstall targets assume this application
# is the only one in use by this account and will clobber the crontab
# of whatever user runs make.

NAME=github-mirror
VERSION=1.0

default: build

M4FILES=crontab

crontab: crontab.m4
	m4 -D__DIR__=$(shell pwd) < $< > $@
TO_CLEAN += $(M4FILES)


build: $(M4FILES)


install: build
	crontab crontab

uninstall:
	crontab -r


NAMEVER=$(NAME)-$(VERSION)
TARBALL=$(NAMEVER).tar.gz
$(TARBALL): clean
	mkdir -p .$(NAMEVER)
	cp * .$(NAMEVER)
	mv .$(NAMEVER) $(NAMEVER)
	$(MAKE) -C $(NAMEVER) clean
	tar czf $(TARBALL) $(NAMEVER)
	rm -rf $(NAMEVER)
TO_CLEAN += $(TARBALL) $(NAMEVER) .$(NAMEVER)

tar: $(TARBALL)

tardump: $(TARBALL)
	tar tzvf $(TARBALL)


# Just in case there was a run...
TO_CLEAN += archive

clean:
	rm -rf $(TO_CLEAN) *~
