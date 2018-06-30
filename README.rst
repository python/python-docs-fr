French Translation of the Python Documentation
==============================================

**Translated: 28%**

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

You'll first need a `github account <https://github.com/join>`_.

Then you'll need to fork the project by clicking the ``Fork`` button
on `python-docs-fr <https://github.com/python/python-docs-fr>`_. This
creates a copy of the whole project on your github account: a place
where you have the rights to do modifications.

To modify po files you'll need to synchronize the project files to
your computer by using ``git``: https://help.github.com/articles/set-up-git/.

Once the project files are synchronized to your computer, you'll be
able to modify them, those are ``.po`` files and can be modified using
various tools:

- `poedit <http://www.poedit.net/>`_ (recommended)
- gted
- gtranslator
- lokalize
- betterpoeditor
- vim or emacs with an appropriate mode
- Vé on Android
- Probably many others

Before commiting, you should use `grammalecte
<https://www.dicollecte.org/>`_ to check for your translations.

After commiting (this is just "naming the modification"), synchronize
the file back to github using ``git push``.

And now, from your github project, a buttun should appear "Compare &
pull request", this is asking us, the main project, to pull your
modifications. This step may take some time as we'll review your
modifications before accepting them, and we may ask for modifications.


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
double quote               guillemet
e.g.                       e.g. (pour *exempli gratia*)
garbage collector          ramasse-miettes
identifier                 identifiant
immutable                  immuable
interpreter                interpréteur
library                    bibliothèque
list comprehension         liste en compréhension
little-endian, big-endian  `petit-boutiste, gros-boutiste
                           <https://fr.wikipedia.org/wiki/Endianness>`_
mutable                    muable
namespace                  *namespace*, espace de noms
parameter                  paramètre
prompt                     invite
raise                      lever
regular expression         expression rationnelle, expression régulière
return                     renvoie, donne (On évite
                           "retourne" qui pourrait porter à confusion.
simple quote               guillemet simple, apostrophe (apostrophe
                           is to glue, guillemet is to surround)
socket                     *socket*
statement                  instruction
thread                     fil d'exécution
underscore                 tiret bas, *underscore*
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

    -#: ../Doc/library/signal.rst:406
    +#: ../Doc/library/signal.rst:408

To tell git they are not usefull information, you can do the following
after ensuring ``~/.local/bin/`` is in your ``PATH``.

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
like::

  ~/
  ├── python-docs-fr/
  └── cpython/

To clone CPython you may use::

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

You'll need the ``transifex-client`` and ``poindent``
from Pypi.

You'll need to configure ``tx`` via ``tx init`` if not already done.

You should work on a separate ``transifex`` branch.

.. code-block:: bash

   tx pull
   poindent --modified
   git commit -m "tx pull"
   git checkout 3.6
   git merge transifex -Xours
   tx push -t
