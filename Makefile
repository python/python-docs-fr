# Makefile for French Python Documentation
#
# Here is what you can do:
#
# - make  # Automatically build an html local version
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
CPYTHON_CURRENT_COMMIT := b30934e9afb0af3f8e2e5f0992445be775b3c630

CPYTHON_PATH := ../cpython/

LANGUAGE := fr
BRANCH := 3.9

EXCLUDED := whatsnew/ c-api/

# Internal variables

UPSTREAM := https://github.com/python/cpython
VENV := $(shell pwd)/venv/
PYTHON := $(shell which python3)
MODE := html
POSPELL_TMP_DIR := .pospell/
WORKTREES := $(VENV)/worktrees/
WORKTREE := $(WORKTREES)/$(CPYTHON_CURRENT_COMMIT)/
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
all: setup
	mkdir -p $(WORKTREE)/locales/$(LANGUAGE)/LC_MESSAGES/
	$(CP_CMD) -uv --parents *.po */*.po $(WORKTREE)/locales/$(LANGUAGE)/LC_MESSAGES/ | cut -d"'" -f2
	$(MAKE) -C $(WORKTREE)/Doc/ VENVDIR=$(WORKTREE)/Doc/venv/ PYTHON=$(PYTHON) \
	  SPHINXOPTS='-qW -j$(JOBS)   \
	  -D locale_dirs=../locales   \
	  -D language=$(LANGUAGE)     \
	  -D gettext_compact=0        \
	  -D latex_engine=xelatex     \
	  -D latex_elements.inputenc= \
	  -D latex_elements.fontenc=' \
	  $(MODE) && echo "Build success, open file://$(WORKTREE)/Doc/build/html/index.html or run 'make serve' to see them."


.PHONY: setup
setup: venv
	echo "Setup the main clone"
	if ! [ -d $(CPYTHON_PATH) ]; then \
	    git clone --depth 16 --branch $(BRANCH) $(UPSTREAM) $(CPYTHON_PATH); \
	fi

	echo "Setup the current worktree"
	if ! [ -d $(WORKTREE) ]; then                                                        \
	    rm -fr $(WORKTREES);                                                             \
	    git -C $(CPYTHON_PATH) worktree prune;                                           \
	    mkdir -p $(WORKTREES);                                                           \
	    if [ -n "$(CPYTHON_CURRENT_COMMIT)" ];                                           \
	    then                                                                             \
	        depth=32;                                                                    \
	        while ! git -C $(CPYTHON_PATH) cat-file -e $(CPYTHON_CURRENT_COMMIT);        \
	        do                                                                           \
	            depth=$$((depth * 2));                                                   \
	            git -C $(CPYTHON_PATH) fetch --depth $$depth $(UPSTREAM) $(BRANCH);      \
	        done                                                                         \
	    else                                                                             \
	        git -C $(CPYTHON_PATH) fetch --depth 1 $(UPSTREAM);                          \
	    fi;                                                                              \
	    git -C $(CPYTHON_PATH) worktree add $(WORKTREE)/ $(CPYTHON_CURRENT_COMMIT);      \
	    $(MAKE) -C $(WORKTREE)/Doc/ VENVDIR=$(WORKTREE)/Doc/venv/ PYTHON=$(PYTHON) venv; \
	fi


.PHONY: venv
venv:
	echo "Setup venv in $(VENV)"
	if [ ! -d $(VENV) ]; then $(PYTHON) -m venv --prompt python-docs-fr $(VENV); fi
	$(VENV)/bin/python -m pip install -q -r requirements.txt 2> $(VENV)/pip-install.log
	if grep -q 'pip install --upgrade pip' $(VENV)/pip-install.log; then \
	    $(VENV)/bin/pip install -q --upgrade pip; \
	fi


.PHONY: serve
serve:
	$(MAKE) -C $(WORKTREE)/Doc/ serve


.PHONY: progress
progress:
	$(PYTHON) -c 'import sys; print("{:.1%}".format(int(sys.argv[1]) / int(sys.argv[2])))'  \
	$(shell msgcat *.po */*.po | msgattrib --translated | grep -c '^msgid') \
	$(shell msgcat *.po */*.po | grep -c '^msgid')


.PHONY: todo
todo: venv
	$(VENV)/bin/potodo --exclude $(VENV) $(EXCLUDED)

.PHONY: wrap
wrap: venv
	echo "Verify wrapping"
	$(VENV)/bin/powrap --check --quiet *.po **/*.po

SRCS = $(shell git diff --name-only $(BRANCH) | grep '.po$$')
# foo/bar.po => $(POSPELL_TMP_DIR)/foo/bar.po.out
DESTS = $(addprefix $(POSPELL_TMP_DIR)/,$(addsuffix .out,$(SRCS)))

.PHONY: spell
spell: venv $(DESTS)

$(POSPELL_TMP_DIR)/%.po.out: %.po dict
	echo "Pospell checking $<..."
	mkdir -p $(@D)
	$(VENV)/bin/pospell -p dict -l fr_FR $< && touch $@

.PHONY: fuzzy
fuzzy: venv
	$(VENV)/bin/potodo -f --exclude $(VENV) $(EXCLUDED)

.PHONY: verifs
verifs: wrap spell

.PHONY: merge
merge: setup
	echo "Merge from $(UPSTREAM)"
	git -C $(CPYTHON_PATH) fetch $(UPSTREAM)
	rm -fr $(WORKTREES)/$(BRANCH)
	git -C $(CPYTHON_PATH) worktree prune
	git -C $(CPYTHON_PATH) worktree add $(WORKTREES)/$(BRANCH) $(word 1,$(shell git -C $(CPYTHON_PATH) remote -v | grep python/cpython))/$(BRANCH)
	$(MAKE) -C $(WORKTREES)/$(BRANCH)/Doc/ VENVDIR=$(WORKTREES)/$(BRANCH)/Doc/venv/ PYTHON=$(PYTHON) venv;
	(cd $(WORKTREES)/$(BRANCH)/Doc; $(WORKTREES)/$(BRANCH)/Doc/venv/bin/sphinx-build -Q -b gettext -D gettext_compact=0 . ../pot)
	find $(WORKTREES)/$(BRANCH) -name '*.pot' |\
	    while read -r POT;\
	    do\
	        PO="./$$(echo "$$POT" | sed "s#$(WORKTREES)/$(BRANCH)/pot/##; s#\.pot\$$#.po#")";\
	        mkdir -p "$$(dirname "$$PO")";\
	        if [ -f "$$PO" ];\
	        then\
	            case "$$POT" in\
	            *whatsnew*) msgmerge --backup=off --force-po --no-fuzzy-matching -U "$$PO" "$$POT" ;;\
	            *)          msgmerge --backup=off --force-po -U "$$PO" "$$POT" ;;\
	            esac\
	        else\
	            msgcat -o "$$PO" "$$POT";\
	        fi\
	    done
	echo "Replacing CPYTHON_CURRENT_COMMIT Makefile by: " $(shell git -C $(WORKTREES)/$(BRANCH) rev-parse HEAD)
	sed -i 's/^CPYTHON_CURRENT_COMMIT :=.*/CPYTHON_CURRENT_COMMIT := $(shell git -C $(WORKTREES)/$(BRANCH) rev-parse HEAD)/' Makefile
	rm -fr $(WORKTREES)/$(BRANCH)
	git -C $(CPYTHON_PATH) worktree prune
	sed -i 's|^#: .*Doc/|#: |' *.po */*.po
	-$(VENV)/bin/powrap -m
	printf 'To add, you can use:\n  git status -s | grep "^ M .*\.po" | cut -d" " -f3 | while read -r file; do if [ $$(git diff "$$file" | wc -l) -gt 13 ]; then git add "$$file"; fi ; done'

.PHONY: clean
clean:
	echo "Cleaning *.mo, $(VENV), and $(POSPELL_TMP_DIR)"
	rm -fr $(VENV) $(POSPELL_TMP_DIR)
	find -name '*.mo' -delete
