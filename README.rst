French Translation of the Python Documentation
==============================================

We currently only translate stable documentation versions. That's why
the master branch is empty. See the 3.6 branch for real content.


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

You can either contribute on `transifex/python-doc/public
<https://www.transifex.com/python-doc/public/>`_, or by simply openning an
issue on this repository, or by editing the ``po`` files.

To modify those files you first have to fork this project and follow
github instructions to clone it.

Next, to edit the files, you can use an editor of your choice, there's many:

- Highly recommended: `poedit <http://www.poedit.net/>`_
- gted
- gtranslator
- lokalize
- betterpoeditor
- vim or emacs with an appropriate mode
- Vé on Android
- Probably many others

Finally, once your contribution is done, do a ``pull request`` so we
can review and merge it.


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


Where to get help
~~~~~~~~~~~~~~~~~

The coordinator for this translation is `mdk <https://mdk.fr/>`_.

Feel free to ask your questions on ``#python-fr`` on `freenode
<https://webchat.freenode.net/>`_.


Priorities
----------

The ``tutorial/`` directory has a high priority as translations aim
for newcomers, then here are files most read in the original version:

- library/functions.po
- library/stdtypes.po
- library/string.po
- library/re.po
- library/datetime.po
- library/csv.po
- library/os.po
- library/random.po
- library/json.po
- library/subprocess.po


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
built-in                   primitive, native
debugging                  débogage
double quote               guillemet
call stack                 pile d'appels
e.g.                       e.g. (pour *exempli gratia*)
garbage collector          ramasse-miettes
identifier                 identifiant
immutable                  immuable
interpreter                interpréteur
library                    bibliothèque
list compréhension         liste en compréhension
little-endian, big-endian  `petit-boutiste, gros-boutiste
                           <https://fr.wikipedia.org/wiki/Endianness>`_
mutable                    variable
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

You'll need the ``transifex-client``, ``pomerge``, and ``poindent``
from Pypi, and you'll need to configure ``tx`` via ``tx init``, and then:

.. code-block:: bash

   tx pull
   pomerge --from .tx/*.po .tx/**/*.po --to *.po **/*.po
   poindent --modified

Now you should review and commit the pull, then push:

.. code-block:: bash

   pomerge --from *.po **/*.po --to .tx/*.po .tx/**/*.po
   tx push -t
