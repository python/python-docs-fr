# Makefile for French Python Documentation
#
# Here is what you can do:
#
# - make  # Automatically build an HTML local version
# - make todo  # To list remaining tasks
# - make verifs  # To check for correctness: wrapping, spelling
# - make wrap  # To check for wrapping
# - make spell  # To check for spelling
# - make merge  # To merge pot from upstream
# - make fuzzy  # To find fuzzy strings
# - make progress  # To compute current progression
#
# Modes are: autobuild-stable, autobuild-dev, and autobuild-html,
# documented in gen/src/3.6/Doc/Makefile as we're only delegating the
# real work to the Python Doc Makefile.

# Configuration

# The CPYTHON_CURRENT_COMMIT is the commit, in the cpython repository,
# from which we generated our po files.  We use it here so when we
# test build, we're building with the .rst files that generated our
# .po files.
CPYTHON_CURRENT_COMMIT := 895591c1f0bdec5ad357fe6a5fd0875990061357

CPYTHON_PATH := ../cpython/

LANGUAGE := fr
BRANCH := 3.9

EXCLUDED := whatsnew/ c-api/

# Internal variables

UPSTREAM := https://github.com/python/cpython

PYTHON := $(shell which python3)
MODE := html
POSPELL_TMP_DIR := .pospell/
JOBS := auto

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
	git -C $(CPYTHON_PATH) checkout $(CPYTHON_CURRENT_COMMIT)
	mkdir -p locales/$(LANGUAGE)/LC_MESSAGES/
	$(CP_CMD) -u --parents *.po */*.po locales/$(LANGUAGE)/LC_MESSAGES/
	$(MAKE) -C $(CPYTHON_PATH)/Doc/     \
	  SPHINXOPTS='-qW -j$(JOBS)         \
	  -D locale_dirs=$(abspath locales) \
	  -D language=$(LANGUAGE)           \
	  -D gettext_compact=0           \
	  -D latex_engine=xelatex           \
	  -D latex_elements.inputenc=       \
	  -D latex_elements.fontenc='       \
	  $(MODE)
	git -C $(CPYTHON_PATH) checkout -
	@echo "Build success, open file://$(abspath $(CPYTHON_PATH))/Doc/build/html/index.html or run 'make serve' to see them."


.PHONY: ensure_prerequisites
ensure_prerequisites:
	@if [ -z $(CPYTHON_PATH) ]; then \
	    echo "Your CPYTHON_PATH is empty, please provide one."; \
	    exit 1; \
	fi
	@if ! [ -d $(CPYTHON_PATH) ]; then \
	    echo "Building the translation requires a cpython clone."; \
	    echo "Please provide the path to a clone using the CPYTHON_PATH variable."; \
	    echo "(Currently CPYTHON_PATH is $(CPYTHON_PATH)."; \
	    echo "So you may want to run:"; \
	    echo ""; \
	    echo "  git clone $(UPSTREAM) $(CPYTHON_PATH)"; \
	    exit 1; \
	fi
	@if [ -n "$$(git -C $(CPYTHON_PATH) status --porcelain)" ]; then \
	    echo "Your cpython clone at $(CPYTHON_PATH) is not clean."; \
	    echo "In order to avoid breaking things, please clean it first."; \
	    exit 1; \
	fi
	@if ! (blurb help >/dev/null 2>&1 && sphinx-build --version >/dev/null 2>&1); then \
	    echo "You're missing dependencies, please enable a venv and install:"; \
	    echo ""; \
	    echo "  python -m pip install -r requirements.txt -r $(CPYTHON_PATH)/Doc/requirements.txt"; \
	    exit 1; \
	fi

.PHONY: serve
serve:
	$(MAKE) -C $(CPYTHON_PATH)/Doc/ serve


.PHONY: progress
progress:
	@$(PYTHON) -c 'import sys; print("{:.1%}".format(int(sys.argv[1]) / int(sys.argv[2])))'  \
	$(shell msgcat *.po */*.po | msgattrib --translated | grep -c '^msgid') \
	$(shell msgcat *.po */*.po | grep -c '^msgid')


.PHONY: todo
todo: ensure_prerequisites
	potodo --exclude venv .venv $(EXCLUDED)

.PHONY: wrap
wrap: ensure_prerequisites
	@echo "Verify wrapping"
	powrap --check --quiet *.po **/*.po

SRCS = $(shell git diff --name-only $(BRANCH) | grep '.po$$')
# foo/bar.po => $(POSPELL_TMP_DIR)/foo/bar.po.out
DESTS = $(addprefix $(POSPELL_TMP_DIR)/,$(addsuffix .out,$(SRCS)))

.PHONY: spell
spell: ensure_prerequisites $(DESTS)

$(POSPELL_TMP_DIR)/%.po.out: %.po dict
	@echo "Pospell checking $<..."
	mkdir -p $(@D)
	pospell -p dict -l fr_FR $< && touch $@

.PHONY: fuzzy
fuzzy: ensure_prerequisites
	potodo -f --exclude venv .venv $(EXCLUDED)

.PHONY: verifs
verifs: wrap spell

.PHONY: merge
merge: ensure_prerequisites
	@echo "Merge from $(UPSTREAM)"
	git -C $(CPYTHON_PATH) checkout $(BRANCH)
	git -C $(CPYTHON_PATH) pull --ff-only
	(cd $(CPYTHON_PATH)/Doc; sphinx-build -Q -b gettext -D gettext_compact=0 . ../pot)
	find $(CPYTHON_PATH)/pot/ -name '*.pot' |\
	    while read -r POT; \
	    do \
	        PO="./$$(echo "$$POT" | sed "s#$(CPYTHON_PATH)/pot/##; s#\.pot\$$#.po#")"; \
	        mkdir -p "$$(dirname "$$PO")"; \
	        if [ -f "$$PO" ]; \
	        then \
	            msgmerge --backup=off --force-po -U "$$PO" "$$POT"; \
	        else \
	            msgcat -o "$$PO" "$$POT"; \
	        fi \
	    done
	rm -fr $(CPYTHON_PATH)/pot/
	@echo "Replacing CPYTHON_CURRENT_COMMIT in Makefile by: " $(shell git -C $(CPYTHON_PATH) rev-parse HEAD)
	sed -i 's/^CPYTHON_CURRENT_COMMIT :=.*/CPYTHON_CURRENT_COMMIT := $(shell git -C $(CPYTHON_PATH) rev-parse HEAD)/' Makefile
	sed -i 's|^#: .*Doc/|#: |' *.po */*.po
	powrap -m
	@printf 'To add, you can use:\n  git status -s | grep "^ M .*\.po" | cut -d" " -f3 | while read -r file; do if [ $$(git diff "$$file" | wc -l) -gt 13 ]; then git add "$$file"; fi ; done'

.PHONY: clean
clean:
	@echo "Cleaning *.mo and $(POSPELL_TMP_DIR)"
	rm -fr $(POSPELL_TMP_DIR)
	find -name '*.mo' -delete
