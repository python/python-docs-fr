This is the French Translation of the Python Documentation
==========================================================

TODO
----

- Wait for the Documentation Contribution Agreement to be redacted
- Setup "The Knight Who Say Ni"


Translation Progression
-----------------------

============  =====  =====  =====
          ..    2.7    3.5    3.6
============  =====  =====  =====
    about.po   100%   100%   100%
     bugs.po   100%   100%   100%
       c-api     9%    12%    11%
 contents.po   100%   100%   100%
copyright.po   100%   100%   100%
distributing   100%   100%   100%
   distutils    32%    33%    33%
   extending    21%    24%    24%
         faq    29%    33%    32%
 glossary.po    85%   100%   100%
       howto     7%     6%     6%
     install    45%    46%    43%
  installing   100%   100%    66%
     library    16%    20%    19%
  license.po   100%   100%   100%
   reference     5%     5%     5%
   sphinx.po   100%   100%   100%
    tutorial   100%   100%   100%
       using    31%    21%    19%
    whatsnew     6%    41%     7%
     ~total~    19%    25%    19%
============  =====  =====  =====


Contributing to the Translation
-------------------------------

Your help is welcome, you can start with easy tasks like reviewing
fuzzy entries to help keeping the documentation up to date.  You can
also proofread already translated entries, and finally translate
untranslated ones.


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

- Prioritize the higher version, identical strings between version can
  automatically be reused.
- Do not translate content of ``:ref:...`` and ``:term:...``
- Put english words, if you have to use them, in *italics* (surrounded
  by stars).
- ``::`` at the end of some paragraphs have to be translated to ``:
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
- IRC channel `#python-fr <irc.lc/freenode/python-fr>`_ on freenode.
- The `liste traductions <http://lists.afpy.org/mailman/listinfo/traductions>`_
- `Glossaire traduc.org <http://glossaire.traduc.org>`_
- `Glossaires et Dictionnaires of traduc.org
  <https://traduc.org/Glossaires_et_dictionnaires>`_
- glossary.po, as it's already translated.


Glossary
--------

For consistency in our translations, here are some propositions and
reminders for frequent terms you'll have to translate, don't hesitate
to open an issue if you disagree.

- double quote: *guillemet*
- simple quote: *guillemet simple*, *apostrophe* (*apostrophe* is to glue,
  *guillemet* is to surround, use when appropriate)
- -like: *-compatible* (when appropriate)
- abstract data type: *type abstrait*
- argument: *argument* (Don't mix with parameter)
- parameter: *paramètre*
- backslash: *antislash*, *backslash* (in italics)
- bound: *lier*
- bug: *bogue*, *bug* (in italics)
- debugging: *débogage*
- built-in: *primitive*, *native*
- identifier: *identifiant*
- immutable: *immuable*
- interpreter: *interpréteur*
- library: *bibliothèque*
- list compréhension: *liste en compréhension*
- mutable: *variable*
- prompt: *invite*
- regular expression: *expression rationnelle*, *expression régulière*
- socket: *socket* (in italics)
- statement: *instruction*
- underscore: *tiret bas*, *underscore* (in italics)
- little-endian, big-endian: `petit-boutise, gros-boutiste
  <https://fr.wikipedia.org/wiki/Endianness>`_


Project History
---------------

This project was started `around 2012
<https://github.com/AFPy/python_doc_fr/commit/b77bdff59036b6b5a4804d5f519ce3ea341e027c>`_
by `afpy <https://www.afpy.org/>`_ members, in 2017 this project
became the official french Python documentation translation thanks to
`PEP 545 <https://www.python.org/dev/peps/pep-0545/>`_.
