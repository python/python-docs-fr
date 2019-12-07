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

CPYTHON_CLONE := $(realpath ../cpython/)
SPHINX_CONF := $(CPYTHON_CLONE)/Doc/conf.py
LANGUAGE := fr
VENV := $(shell pwd)/venv/
PYTHON := $(shell which python3)
MODE := html
BRANCH := 3.8
COMMIT := e21aa61e96f8343200e765d119ebe778873a6bf1
WORKTREE := $(VENV)/worktree-$(COMMIT)/
JOBS := auto


.PHONY: all
all: $(WORKTREE)
	mkdir -p $(WORKTREE)/locales/$(LANGUAGE)/LC_MESSAGES/
	cp --parents *.po */*.po $(WORKTREE)/locales/$(LANGUAGE)/LC_MESSAGES/
	$(MAKE) -C $(WORKTREE)/Doc/ VENVDIR=$(VENV) PYTHON=$(PYTHON) \
	  SPHINXOPTS='-qW -j$(JOBS) -D locale_dirs=../locales -D language=$(LANGUAGE) -D gettext_compact=0 -D latex_engine=xelatex -D latex_elements.inputenc= -D latex_elements.fontenc=' \
	  $(MODE) && echo "Build success, open file://$(WORKTREE)/Doc/build/html/index.html or run 'make serve' to see them."


$(WORKTREE): $(VENV)/bin/activate $(SPHINX_CONF)
	git -C $(CPYTHON_CLONE) worktree prune
	git -C $(CPYTHON_CLONE) fetch https://github.com/python/cpython
	git -C $(CPYTHON_CLONE) worktree add $(WORKTREE)/ $(COMMIT)


.PHONY: serve
serve:
	$(MAKE) -C $(WORKTREE)/Doc/ serve


$(SPHINX_CONF):
	git clone --depth 1 --branch $(BRANCH) https://github.com/python/cpython.git $(CPYTHON_CLONE)
	[ -n "$(COMMIT)" ] && (i=1; while ! $$(git -C $(CPYTHON_CLONE) checkout $(COMMIT)); do i=$$((i * 2)); git -C $(CPYTHON_CLONE) fetch --depth $$i; done) || true


.PHONY: upgrade_venv
upgrade_venv:
	$(MAKE) -C $(CPYTHON_CLONE)/Doc/ VENVDIR=$(VENV) PYTHON=$(PYTHON) venv
	$(VENV)/bin/pip install -U pip potodo powrap pospell


$(VENV)/bin/activate: $(SPHINX_CONF)
	$(MAKE) -C $(CPYTHON_CLONE)/Doc/ VENVDIR=$(VENV) PYTHON=$(PYTHON) venv


.PHONY: progress
progress:
	@python3 -c 'import sys; print("{:.1%}".format(int(sys.argv[1]) / int(sys.argv[2])))'  \
	$(shell msgcat *.po */*.po | msgattrib --translated | grep -c '^msgid') \
	$(shell msgcat *.po */*.po | grep -c '^msgid')


$(VENV)/bin/potodo: $(VENV)/bin/activate
	$(VENV)/bin/pip install potodo

$(VENV)/bin/powrap: $(VENV)/bin/activate
	$(VENV)/bin/pip install powrap

$(VENV)/bin/pospell: $(VENV)/bin/activate
	$(VENV)/bin/pip install pospell

.PHONY: todo
todo: $(VENV)/bin/potodo
	$(VENV)/bin/potodo

.PHONY: verifs
verifs: wrap spell

.PHONY: wrap
wrap: $(VENV)/bin/powrap
	$(VENV)/bin/powrap --check --quiet *.po **/*.po

.PHONY: spell
spell: $(VENV)/bin/pospell
	$(VENV)/bin/pospell -p dict -l fr_FR *.po **/*.po

.PHONY: merge
merge: upgrade_venv
ifneq "$(shell cd $(CPYTHON_CLONE) 2>/dev/null && git describe --contains --all HEAD)" "$(BRANCH)"
	$(error "You're merging from a different branch:" "$(shell cd $(CPYTHON_CLONE) 2>/dev/null && git describe --contains --all HEAD)" vs "$(BRANCH)")
endif
	(cd $(CPYTHON_CLONE)/Doc; rm -f build/NEWS)
	(cd $(CPYTHON_CLONE); $(VENV)/bin/sphinx-build -Q -b gettext -D gettext_compact=0 Doc pot/)
	find $(CPYTHON_CLONE)/pot/ -name '*.pot' |\
	    while read -r POT;\
	    do\
	        PO="./$$(echo "$$POT" | sed "s#$(CPYTHON_CLONE)/pot/##; s#\.pot\$$#.po#")";\
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


.PHONY: fuzzy
fuzzy: $(VENV)/bin/potodo
	$(VENV)/bin/potodo -f
