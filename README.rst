French Translation of the Python Documentation
==============================================

|build| |progression|

.. |build| image:: https://travis-ci.org/python/python-docs-fr.svg?branch=3.7
   :target: https://travis-ci.org/python/python-docs-fr
   :width: 45%

.. |progression| image:: https://img.shields.io/badge/dynamic/json.svg?label=fr&query=%24.fr&url=http%3A%2F%2Fgce.zhsj.me%2Fpython/newest
   :width: 45%

Documentation Contribution Agreement
------------------------------------

NOTE REGARDING THE LICENSE FOR TRANSLATIONS: Python's documentation is
maintained using a global network of volunteers. By posting this
project on Transifex, Github, and other public places, and inviting
you to participate, we are proposing an agreement that you will
provide your improvements to Python's documentation or the translation
of Python's documentation for the PSF's use under the CC0 license
(available at
https://creativecommons.org/publicdomain/zero/1.0/legalcode). In
return, you may publicly claim credit for the portion of the
translation you contributed and if your translation is accepted by the
PSF, you may (but are not required to) submit a patch including an
appropriate annotation in the Misc/ACKS or TRANSLATORS file. Although
nothing in this Documentation Contribution Agreement obligates the PSF
to incorporate your textual contribution, your participation in the
Python community is welcomed and appreciated.

You signify acceptance of this agreement by submitting your work to
the PSF for inclusion in the documentation.


Contributing to the Translation
-------------------------------

How to Contribute
~~~~~~~~~~~~~~~~~

You can contribute using:

- github (preferred solution)
- `transifex <https://www.transifex.com/python-doc/public/>`_
- Or just by opening `an issue on github <https://github.com/python/python-docs-fr/issues>`_


Contributing using Github
~~~~~~~~~~~~~~~~~~~~~~~~~

Prerequisites:

- A `github account <https://github.com/join>`_.
- ``git`` `installed <https://help.github.com/articles/set-up-git/>`_ (for windows, see
  https://gitforwindows.org/).
- A ``.po`` file editor (Use `poedit <https://poedit.net/>`_
  if you don't already have one).


Getting Started:

You'll need to fork the `python-docs-fr
<https://github.com/python/python-docs-fr>`_ source repository by clicking its ``Fork``
button. This creates a copy of the whole project on your github
account: a place where you have the rights to do modifications.

Step by step:

.. code-block:: bash

    # Clone your github fork with `git` using ssh or https:
    git clone git@github.com:YOUR_GITHUB_USERNAME/python-docs-fr.git
    git clone https://github.com:YOUR_GITHUB_USERNAME/python-docs-fr.git

    # Go into the cloned directory:
    cd python-docs-fr/

    # Add the upstream (the public repository) using HTTPS (won't ask for password):
    # This is so git knows what/where the upstream is.
    git remote add upstream https://github.com/python/python-docs-fr.git

Next, you need to find a file to work on.
You can use `potodo <https://github.com/seluj78/potodo>`, a tool made to find ``po`` to do.
Install it using pip (``pip install potodo``) in a ``python3.7`` environement.
Then run the command ``potodo`` in your cloned fork.
From the list returned by the command, you can choose any file that is not reserved.

**We recommend not starting with a file from ``c-api`` as it is very technical.**

Once you've choosen a file to work one, please open an `issue on github <https://github.com/python/python-docs-fr>` in the format of `I'm working on FOLDER/FILE.po`. This is done to update ``potodo`` as it checks the github API for reserved ``.po`` files in issues and pull requests.

Now you're ready to start a work session. Each time you'll start a new file, start here:

.. code-block:: bash

    # To work, we'll need a branch, based on an up-to-date (freshly fetched)
    # upstream/3.7 branch. We will name our branch "library-sys" but you shall name yours
    # whatever you want. Usually you'll name a branch based on the file you're working on.
    # For example, If you're working on "library/venv.po" you can name your branch "library-venv"

    # Update your local version to the latest
    git fetch upstream
    # Create a new branch named "library-sys" based on "upstream/3.7"
    git checkout -b library-sys upstream/3.7

    # You can now work on the file, typically using poedit,
    # Of course, replace "library/sys.po" by the file you've chose earlier
    poedit library/sys.po

    # When you are done translating, you can run pospell (pip install pospell).
    # This tool was made to check if you don't have any french mistakes.
    # You can run the following command: pospell -p dict -l fr_FR **/*.po to check all files
    # or replace **/*.po by your specific file (recommended).

    # You can then run powrap (pip install powrap) which will rewrap
    # You modified file to the correct line length of `80`.
    # Run this command: `powrap **/*.po` or replace `**/*.po` with your modified file.

    # When everything powrap and pospell passes without errors,
    # you can commit your work with a nice explicit message:
    git commit -a -m "Working on library/sys.po."

    # Then push your modifications to your github fork,
    # as they are ephemeral branches, let's not configure git to track them all,
    # "origin HEAD" is a "special" syntax to say "Push on origin,
    # on a branch with the same name as the local one",
    # it's nice as it's exactly what we want:
    git push origin HEAD

    # The previous command will print you a link to open a PR on github.
    # If you missed it, just go to
    # https://github.com/python/python-docs-fr/ and a nice "Compare & pull request"
    # button should appear after a few seconds telling you can ask for a pull request.

    # Now someone is reviewing your modifications, and you'll want to fix their
    # findings, get back to your branch
    # (in case you started something else on another branch):
    git checkout glossary
    # Fix the issues, then commit again:
    git commit -a -m "glossary: small fixes."
    git push origin HEAD


You may have noted that this looks like a triangle, with a missing segment:

- You're fetching from upstream (public common repo on github)
- You're pushing to origin (your clone on github)

So yes it's the work of someone to add the last segment, from your
origin to the public upstream, to "close the loop", that's the role of
the people who merges pull requests after proofreading them.

You may also have noted you never ever commit on a version branch
(``3.6``, ``3.7``, ...), only pull from them, consider them read-only
you'll avoid problems.

Before commiting, you should use `grammalecte
<https://grammalecte.net/>`_ to check for your translations.


All the translations must be made on the latest release.
We never translate on an oldest version. For example, if the latest python release
is Python 3.7, we don't want to translate directly on the python 3.5 release.
If needed translations would be backported on the oldest versions by the
`documentation team <https://www.python.org/dev/peps/pep-8015/#documentation-team>`.


What to translate
~~~~~~~~~~~~~~~~~

You can start with easy tasks like reviewing fuzzy entries to help
keeping the documentation up to date (find them using ``make fuzzy``).

You can also proofread already translated entries, and finally
translate untranslated ones (find them using ``make todo``)..

- Do not translate content of ``:ref:...`` and ``:term:...``
- Put english words, if you have to use them, in *italics* (surrounded
  by stars).
- ``::`` at the end of some paragraphs have to be translated to `` :
  ::`` in French to place the space before the column.
- If you translate a link title, please translate the link too
  (typically if it's Wikipedia and the article has a translation). If
  no translation of the target exists, do not translate the
  title.


The case of "::"
~~~~~~~~~~~~~~~~

From the reStructuredText point of view, ``::`` glued at the end of a
word means "output ``:`` and introduce a code block", but a ``::``
after a space means "Just introduce a code block".

So in english rst, we see either ``blah blah::`` or ``blah blah. ::``.

In french, we're putting a no-break space before our columns, like:
``Et voilà :``.

Using no-break space in rst is natural, you'll simply write ``Et
voilà ::``, as the ``::`` is not precedded by a normal space it
will output the column and introduce the code block, you're done.

If you don't know how to type a no-break space there's a trick,
translate column column by space, column, space, column column. the
"space column" will render your space and your column as french needs,
and the trailing "space column column" will output nothing and
introduce the code block. No it does not magically inserts a no-break
space, so it's still not really valid french. Yes, better learn how to
type no-break space.


Where to get help
~~~~~~~~~~~~~~~~~

The coordinator for this translation is `mdk <https://mdk.fr/>`_.

Feel free to ask your questions on the ``#python-fr`` channel on `freenode
<https://webchat.freenode.net/>`_ (does not require registration) or the
`AFPy traductions mailing list <https://lists.afpy.org/mailman/listinfo/traductions>`_.


Translation Resources
---------------------

- `Le Grand Dictionnaire Terminologique <http://gdt.oqlf.gouv.qc.ca/>`_
- IRC channel `#python-fr <http://irc.lc/freenode/python-fr>`_ on freenode.
- The `liste traductions <http://lists.afpy.org/mailman/listinfo/traductions>`_.
- The `doc-sig mailing list
  <https://mail.python.org/mailman/listinfo/doc-sig>`_.
- `Glossaire traduc.org <http://glossaire.traduc.org>`_
- `Glossaires et Dictionnaires of traduc.org
  <https://traduc.org/Glossaires_et_dictionnaires>`_
- `glossary.po <https://docs.python.org/fr/3/glossary.html>`_, as it's
  already translated.
- `deepl.com/translator <https://www.deepl.com>`_


Glossary
--------

For consistency in our translations, here are some propositions and
reminders for frequent terms you'll have to translate, don't hesitate
to open an issue if you disagree.

To easily find how a term is already translated in our documentation,
you may use
`find_in_po.py <https://gist.github.com/JulienPalard/c430ac23446da2081060ab17bf006ac1>`_.

========================== ===========================================
Term                       Proposed Translation
========================== ===========================================
-like                      -compatible
abstract data type         type abstrait
argument                   argument (Don't mix with parameter)
backslash                  antislash, *backslash*
bound                      lier
bug                        bogue, *bug*
built-in                   native
call stack                 pile d'appels
debugging                  débogage
deep copy                  copie récursive (préféré), ou copie profonde.
double quote               guillemet
e.g.                       e.g. (pour *exempli gratia*)
garbage collector          ramasse-miettes
identifier                 identifiant
immutable                  immuable
installer                  installateur
interpreter                interpréteur
library                    bibliothèque
list comprehension         liste en compréhension (liste en intension est
                           valide, mais nous ne l'utilisons pas)
little-endian, big-endian  `petit-boutiste, gros-boutiste
                           <https://fr.wikipedia.org/wiki/Endianness>`_
mutable                    muable
namespace                  espace de nommage
                           (sauf pour le XML où c'est espace de noms)
parameter                  paramètre
prompt                     invite
raise                      lever
regular expression         expression rationnelle, expression régulière
return                     renvoie, donne (on évite
                           "retourne" qui pourrait porter à confusion).
simple quote               guillemet simple, apostrophe (apostrophe
                           is to glue, guillemet is to surround)
socket                     *socket*
statement                  instruction
subprocess                 sous-processus
thread                     fil d'exécution
underscore                 tiret bas, *underscore*
expression				         expression
========================== ===========================================


Project History
---------------

This project was started `around 2012
<https://github.com/AFPy/python_doc_fr/commit/b77bdff59036b6b5a4804d5f519ce3ea341e027c>`_
by `afpy <https://www.afpy.org/>`_ members, in 2017 this project
became the official french Python documentation translation thanks to
`PEP 545 <https://www.python.org/dev/peps/pep-0545/>`_.


Simplify git diffs
------------------

Git diffs are often crowded with useless line number changes, like:

.. code-block:: diff

    -#: ../Doc/library/signal.rst:406
    +#: ../Doc/library/signal.rst:408

To tell git they are not usefull information, you can do the following
after ensuring ``~/.local/bin/`` is in your ``PATH``.

.. code-block:: bash

    cat <<EOF > ~/.local/bin/podiff
    #!/bin/sh
    grep -v '^#:' "\$1"
    EOF

    chmod a+x ~/.local/bin/podiff

    git config diff.podiff.textconv podiff


Maintenance
-----------

All those snippets are to run from the root of a ``python-docs-fr``
clone, and some expect to find an up-to-date CPython clone near to it,
like:

.. code-block:: bash

  ~/
  ├── python-docs-fr/
  └── cpython/

To clone CPython you may use:

.. code-block:: bash

  git clone --depth 1 --no-single-branch https://github.com/python/cpython.git

This avoids to download the whole history (not usefull to build
documentation) but still fetches all branches.


Merge pot files from CPython
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make merge


Find fuzzy strings
~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make fuzzy


Run a test build locally
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make


Synchronize translation with Transifex
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You'll need the ``transifex-client`` and ``powrap``
from Pypi.

You'll need to configure ``tx`` via ``tx init`` if not already done.

First propagate known translations locally:

.. code-block:: bash

   pomerge --from-files **/*.po --to-files **/*.po
   powrap --modified
   git commit -m "Propagating known translations."


Then pull from transifex:

.. code-block:: bash

   pomerge --from-files **/*.po
   tx pull -f
   pomerge --to-files **/*.po
   pomerge --from-files **/*.po
   git checkout -- .
   pomerge --to-files **/*.po
   powrap --modified
   git commit -m "tx pull"
   tx push -t -f
