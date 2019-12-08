# Makefile for French Python Documentation
#
# Here is what you can do:
#
# - make  # Automatically build an html local version
# - make todo  # To list remaining tasks
# - make verifs # To check for correctness: wrapping, spelling
# - make wrap # To check for wrapping
# - make spell # To check for spelling
# - make merge  # To merge pot from upstream
# - make fuzzy  # To find fuzzy strings
# - make progress  # To compute current progression
# - make upgrade_venv  # To upgrade the venv that compiles the doc
#
# Modes are: autobuild-stable, autobuild-dev, and autobuild-html,
# documented in gen/src/3.6/Doc/Makefile as we're only delegating the
# real work to the Python Doc Makefile.

# Configuration

# The version of poutils we use (Hardcoding it allows for pip to skip
# hitting internet if it's already installed).
POUTILS_VERSION := 0.1.2

# The CPYTHON_CURRENT_COMMIT is the commit, in the cpython repository,
# from which we generated our po files.  We use it here so when we
# test build, we're building with the .rst files that generated our
# .po files.
CPYTHON_CURRENT_COMMIT := e21aa61e96f8343200e765d119ebe778873a6bf1

CPYTHON_PATH := $(realpath ../cpython/)

LANGUAGE := fr
BRANCH := 3.8


# Internal variables

UPSTREAM := https://github.com/python/cpython
VENV := $(shell pwd)/venv/
PYTHON := $(shell which python3)
MODE := html
WORKTREES := $(VENV)/worktrees/
WORKTREE := $(WORKTREES)/$(CPYTHON_CURRENT_COMMIT)/
JOBS := auto


.PHONY: all
all: setup
	mkdir -p $(WORKTREE)/locales/$(LANGUAGE)/LC_MESSAGES/
	cp --parents *.po */*.po $(WORKTREE)/locales/$(LANGUAGE)/LC_MESSAGES/
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
	# Setup the main clone
	if ! [ -d $(CPYTHON_PATH) ]; then \
	    git clone --depth 16 --branch $(BRANCH) $(UPSTREAM) $(CPYTHON_PATH); \
	fi

	# Setup the current worktree
	if ! [ -d $(WORKTREE) ]; then                                                        \
	    rm -fr $(WORKTREES);                                                             \
	    git -C $(CPYTHON_PATH) worktree prune;                                           \
	    mkdir -p $(WORKTREES);                                                           \
	    if [ -n "$(CPYTHON_CURRENT_COMMIT)" ];                                           \
	    then                                                                             \
	        depth=32;                                                                    \
	        while ! git -C $(CPYTHON_PATH) rev-parse $(CPYTHON_CURRENT_COMMIT);          \
	        do                                                                           \
	            depth=$$((depth * 2));                                                   \
	            git -C $(CPYTHON_PATH) fetch --depth $$depth $(UPSTREAM);                \
	        done                                                                         \
	    else                                                                             \
	        git -C $(CPYTHON_PATH) fetch --depth 1 $(UPSTREAM);                          \
	    fi;                                                                              \
	    git -C $(CPYTHON_PATH) worktree add $(WORKTREE)/ $(CPYTHON_CURRENT_COMMIT);      \
	    $(MAKE) -C $(WORKTREE)/Doc/ VENVDIR=$(WORKTREE)/Doc/venv/ PYTHON=$(PYTHON) venv; \
	fi


.PHONY: venv
venv:
	if [ ! -d $(VENV) ]; then $(PYTHON) -m venv --prompt python-docs-fr $(VENV); fi
	$(VENV)/bin/pip install -q -U pip poutils==$(POUTILS_VERSION)


.PHONY: serve
serve:
	$(MAKE) -C $(WORKTREE)/Doc/ serve


.PHONY: progress
progress:
	@python3 -c 'import sys; print("{:.1%}".format(int(sys.argv[1]) / int(sys.argv[2])))'  \
	$(shell msgcat *.po */*.po | msgattrib --translated | grep -c '^msgid') \
	$(shell msgcat *.po */*.po | grep -c '^msgid')


.PHONY: todo
todo: venv
	$(VENV)/bin/potodo

.PHONY: wrap
wrap: venv
	$(VENV)/bin/powrap --check --quiet *.po **/*.po

.PHONY: spell
spell: venv
	$(VENV)/bin/pospell -p dict -l fr_FR *.po **/*.po

.PHONY: fuzzy
fuzzy: venv
	$(VENV)/bin/potodo -f

.PHONY: verifs
verifs: wrap spell

.PHONY: merge
merge: setup
	git -C $(CPYTHON_PATH) fetch $(UPSTREAM)
	git -C $(CPYTHON_PATH) worktree add $(WORKTREES)/$(BRANCH) $(BRANCH)
	$(MAKE) -C $(WORKTREES)/$(BRANCH)/Doc/ VENVDIR=$(WORKTREES)/$(BRANCH)/Doc/venv/ PYTHON=$(PYTHON) venv;
	(cd $(WORKTREES)/$(BRANCH); $(WORKTREES)/$(BRANCH)/Doc/venv/bin/sphinx-build -Q -b gettext -D gettext_compact=0 Doc pot/)
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
	rm -fr $(WORKTREES)/$(BRANCH)
	git -C $(CPYTHON_PATH) worktree prune

.PHONY: clean
clean:
	rm -fr venv
	find -name '*.mo' -delete
