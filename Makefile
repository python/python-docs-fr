# Makefile for French Python Documentation
#
# Here is what you can do:
#
# - make  # Automatically build an HTML local version
# - make todo  # To list remaining tasks and show current progression
# - make verifs  # To check for correctness: wrapping, spelling
# - make wrap  # To rewrap modified files
# - make spell  # To check for spelling
# - make clean # To remove build artifacts
# - make fuzzy  # To find fuzzy strings
#
# Modes are: autobuild-stable, autobuild-dev, and autobuild-html,
# documented in gen/src/3.6/Doc/Makefile as we're only delegating the
# real work to the Python Doc Makefile.

# Configuration

# The CPYTHON_CURRENT_COMMIT is the commit, in the cpython repository,
# from which we generated our po files.  We use it here so when we
# test build, we're building with the .rst files that generated our
# .po files.
CPYTHON_CURRENT_COMMIT := 100da7c31aeb3888962bf33c8cc3594272964815
LANGUAGE := fr
BRANCH := 3.10

EXCLUDED := \
	whatsnew/2.?.po \
	whatsnew/3.[0-8].po \
	c-api/ \
	distutils/ \
	install/ \
	library/2to3.po \
	library/distutils.po \
	library/imp.po \
	library/tkinter.tix.po \
	library/test.po \
	library/aifc.po \
	library/asynchat.po \
	library/asyncore.po \
	library/audioop.po \
	library/cgi.po \
	library/cgitb.po \
	library/chunk.po \
	library/crypt.po \
	library/imghdr.po \
	library/msilib.po \
	library/nntplib.po \
	library/nis.po \
	library/ossaudiodev.po \
	library/pipes.po \
	library/smtpd.po \
	library/sndhdr.po \
	library/spwd.po \
	library/sunau.po \
	library/telnetlib.po \
	library/uu.po \
	library/xdrlib.po

# Internal variables

UPSTREAM := https://github.com/python/cpython

PYTHON := $(shell which python3)
MODE := html
POSPELL_TMP_DIR := .pospell/
JOBS := auto
SPHINXERRORHANDLING = -W

# Detect OS

ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

ifeq ($(detected_OS),Darwin)        # Mac OS X
    CP_CMD := gcp                   # accessible with `brew install coreutils` or `brew upgrade coreutils`
else
    CP_CMD := cp
endif

.PHONY: all
all: ensure_prerequisites
	git -C venv/cpython checkout $(CPYTHON_CURRENT_COMMIT) || (git -C venv/cpython fetch && git -C venv/cpython checkout $(CPYTHON_CURRENT_COMMIT))
	mkdir -p locales/$(LANGUAGE)/LC_MESSAGES/
	$(CP_CMD) -u --parents *.po */*.po locales/$(LANGUAGE)/LC_MESSAGES/
	$(MAKE) -C venv/cpython/Doc/ \
	  JOBS='$(JOBS)'             \
	  SPHINXOPTS='-D locale_dirs=$(abspath locales) \
	  -D language=$(LANGUAGE)           \
	  -D gettext_compact=0              \
	  -D latex_engine=xelatex           \
	  -D latex_elements.inputenc=       \
	  -D latex_elements.fontenc='       \
	  SPHINXERRORHANDLING=$(SPHINXERRORHANDLING) \
	  $(MODE)
	@echo "Build success, open file://$(abspath venv/cpython/)/Doc/build/html/index.html or run 'make htmlview' to see them."


# We clone cpython/ inside venv/ because venv/ is the only directory
# excluded by cpython' Sphinx configuration.
venv/cpython/.git/HEAD:
	git clone https://github.com/python/cpython venv/cpython


.PHONY: ensure_prerequisites
ensure_prerequisites: venv/cpython/.git/HEAD
	@if ! (blurb help >/dev/null 2>&1 && sphinx-build --version >/dev/null 2>&1); then \
	    git -C venv/cpython/ checkout $(BRANCH); \
	    echo "You're missing dependencies please install:"; \
	    echo ""; \
	    echo "  python -m pip install -r requirements.txt -r venv/cpython/Doc/requirements.txt"; \
	    exit 1; \
	fi

.PHONY: htmlview
htmlview: MODE=htmlview
htmlview: all

.PHONY: todo
todo: ensure_prerequisites
	potodo --api-url 'https://git.afpy.org/api/v1/repos/AFPy/python-docs-fr/issues?state=open&type=issues' --exclude venv .venv $(EXCLUDED)

.PHONY: wrap
wrap: ensure_prerequisites
	@echo "Re wrapping modified files"
	powrap -m

SRCS = $(shell git diff --name-only $(BRANCH) | grep '.po$$')
# foo/bar.po => $(POSPELL_TMP_DIR)/foo/bar.po.out
DESTS = $(addprefix $(POSPELL_TMP_DIR)/,$(addsuffix .out,$(SRCS)))

.PHONY: spell
spell: ensure_prerequisites $(DESTS)

.PHONY: line-length
line-length:
	@echo "Searching for long lines..."
	@awk '{if (length(gensub(/శ్రీనివాస్/, ".", "g", $$0)) > 80 && length(gensub(/[^ ]/, "", "g")) > 1) {print FILENAME ":" FNR, "line too long:", $$0; ERRORS+=1}} END {if (ERRORS>0) {exit 1}}' *.po */*.po

.PHONY: sphinx-lint
sphinx-lint:
	@echo "Checking all files using sphinx-lint..."
	@sphinx-lint --enable all --disable line-too-long *.po */*.po

$(POSPELL_TMP_DIR)/%.po.out: %.po dict
	@echo "Pospell checking $<..."
	@mkdir -p $(@D)
	pospell -p dict -l fr_FR $< && touch $@

.PHONY: fuzzy
fuzzy: ensure_prerequisites
	potodo --only-fuzzy --api-url 'https://git.afpy.org/api/v1/repos/AFPy/python-docs-fr/issues?state=open&type=issues' --exclude venv .venv $(EXCLUDED)

.PHONY: check-headers
check-headers:
	@grep -L '^# Copyright (C) [0-9-]*, Python Software Foundation' *.po */*.po | while read -r file;\
	do \
		echo "Please update the po comment in $$file"; \
	done
	@grep -L '^"Project-Id-Version: Python 3\\n"$$' *.po */*.po | while read -r file;\
	do \
		echo "Please update the 'Project-Id-Version' header in $$file"; \
	done
	@grep -L '^"Language: fr\\n"$$' *.po */*.po | while read -r file;\
	do \
		echo "Please update the 'Language' header in $$file"; \
	done
	@grep -L '^"Language-Team: FRENCH <traductions@lists.afpy.org>\\n"' *.po */*.po | while read -r file;\
	do \
		echo "Please update the 'Language-Team' header in $$file"; \
	done

.PHONY: verifs
verifs: spell line-length sphinx-lint check-headers

.PHONY: clean
clean:
	@echo "Cleaning *.mo and $(POSPELL_TMP_DIR)"
	rm -fr $(POSPELL_TMP_DIR) locales/$(LANGUAGE)/LC_MESSAGES/
	find -name '*.mo' -delete
	@echo "Cleaning build directory"
	$(MAKE) -C venv/cpython/Doc/ clean
