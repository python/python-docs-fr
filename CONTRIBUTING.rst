Guide de contribution à la documention via GitHub.
===================================================

Prérequis
---------

- Un compte `Github <https://github.com/join>`_.
- Un client ``git`` `Linux <https://git-scm.com/>`_ ou `Windows <https://gitforwindows.org/>`_.
- Un éditeur de fichier ``.po`` (comme `poedit <https://poedit.net/>`_).

Instructions :
--------------

Pour commencer vous aurez besoin de *forker* le dépôt des sources `python-docs-fr
<https://github.com/python/python-docs-fr>`_ en cliquant sur son bouton
``Fork``. Ceci crée une copie du projet sur votre compte Github : un endroit
où vous avez le droit de faire des modifications.

Étape par étape :

.. code-block:: bash

    # Clonez votre fork Github avec `git` en utilisant ssh :
    git clone git@github.com/VOTRE_NOM_DE_COMPTE_GITHUB/python-docs-fr.git

    # *OU* HTTPS :
    git clone https://github.com/VOTRE_NOM_DE_COMPTE_GITHUB/python-docs-fr.git

    # Allez dans le répertoire cloné :
    cd python-docs-fr/

    # Ajoutez le dépôt officiel (nommé upstream)
    # Ceci permet à *git* de savoir quoi/où est *upstream*
    git remote add upstream https://github.com/python/python-docs-fr.git

Ensuite, vous devez trouver un fichier sur lequel travailler
(pour vous aiguillez vous pouvez vous rendre à `Que traduire ?`_ et lire
les explications concernant `potodo`_ qui vous permettra de voir ce qui a
déjà été traduit et ce qui ne l'a pas été).

Une fois que vous avez choisi un fichier sur lequel travailler, veuillez
ouvrir un `ticket sur Github <https://github.com/python/python-docs-fr/issues>`_
en indiquant dans le titre ``Je travaille sur DOSSIER/FICHIER.po``
(par exemple «Je travaille sur library/csv.po»).
Ceci permet à `potodo`_ de détecter via l'API Github les fichiers ``.po`` réservés
dans les tickets et les *pull requests*.

N'hésitez pas non plus à vous équiper de quelques outils pour vous aider dans
votre traduction (voir `Outils utiles pour la traduction`_)

Vous êtes maintenant prêt. Chaque fois que vous commencerez un nouveau fichier,
suivez cette procédure :

.. code-block:: bash

    # Pour travailler, nous aurons besoin d'une branche, basée sur une version à jour
    # (fraîchement récupérée) de la branche upstream/3.8. On met donc à jour notre
    # version locale.
    git fetch upstream

    # On créé ensuite une branche. Il est pratique de nommer la branche en fonction du
    # fichier sur lequel on travaille. Par exemple, si vous travaillez sur
    # « library/sys.po », vous pouvez nommer votre branche « library-sys ».
    # Cette nouvelle branche nommée « library-sys » est basée sur « upstream/3.8 ».
    git checkout -b library-sys upstream/3.8

    # Vous pouvez maintenant travailler sur le fichier (typiquement, en utilisant poedit).
    # N'oubliez pas de configurer votre nom et votre email dans Poedit.
    # (Édition -> Préférences -> Général)
    # Vérifiez aussi qu'il est configuré pour passer à la ligne à 79 caractères.
    # (Édition -> Préférences -> Avancé -> Passer à la ligne à : 79)
    #
    # Ici, remplacez « library/sys.po » par le fichier que vous avez choisi précédemment.
    # poedit library/sys.po ou lancez simplement poedit puis « Fichier » → « Ouvrir »

    # Si vous n'utilisez pas poedit, vous pouvez utiliser `powrap` (voir la section *outils*)
    # qui va reformater correctement le fichier que avez vous avez modifié.
    # Exécutez `powrap -m` (reformater tous les fichiers modifiés)
    # ou `powrap library/sys.po` (un fichier en particulier) :
    powrap -m

    # Pour l'orthographe, une liste blanche de certains termes techniques ou
    # de noms propres, comme « Guido », « C99 » ou « sérialisable », est
    # stockée dans le fichier « dict » à la racine du projet.  Vous pouvez
    # bien sûr y ajouter une entrée si nécessaire.
    # La commande suivante va lancer les vérifications nécessaires.
    make verifs

    # C'est le moment de git add et git commit
    # git add va permettre de déplacer nos modifications dans l'index de Git en
    # attendant d'être déplacée dans le dépôt local.
    git add library/sys.po

    # Puis on bascule les modifications dans le dépôt local avec un commit.
    git commit -m "Traduction de library/sys.po"  # Ou un autre message plus inspiré :)

    # Poussez ensuite vos modifications sur votre fork Github.
    # Le -u n'est utile qu'une fois pour que votre client git se souvienne que cette
    # branche est liée à votre fork Github (et donc que vos futurs `git pull` et
    # `git push` sachent quoi tirer)
    git push -u origin

    # La commande précédente vous affichera un lien pour ouvrir une pull request sur
    # Github. Si vous l'avez manqué, allez simplement sur https://github.com/python/python-docs-fr/pulls
    # et un joli bouton « Compare & pull request » devrait apparaître au bout de
    # quelques secondes vous indiquant que vous pouvez demander une pull request.

    # À partir de là, quelqu'un passera en revue vos modifications, et vous fera des
    # suggestions/corrections. Pour les prendre en compte, retournez sur votre branche
    # contenant du fichier concerné (au cas où vous auriez commencé quelque chose d'autre
    # sur une autre branche) :
    git checkout library/sys
    git pull  # pour rapatrier les modifications que vous auriez accepté
              # sur l'interface web.

    # Réglez les problèmes, puis commitez à nouveau :
    git commit -a -m "prise en compte des remarques"
    git push

Vous avez peut-être remarqué que cela ressemble à un triangle, avec un
segment manquant :

- Vous récupérez depuis *upstream* (le dépôt commun public sur Github)
- Vous poussez sur *origin* (votre clone sur Github)

C'est le travail de quelqu'un d'autre d'ajouter le dernier segment,
de votre *origin* au *upstream* public, pour « boucler la boucle ». C'est le
rôle des personnes qui *fusionnent* les *pull requests* après les avoir relues.

Vous avez peut-être aussi remarqué que vous n'avez jamais commité sur une
branche de version (``3.7``, ``3.8``, etc.), seulement récupéré les
modifications à partir d'elles.

Toutes les traductions sont faites sur la dernière version.
Nous ne traduisons jamais sur une version plus ancienne. Par exemple,
si la dernière version de python est Python 3.8, nous ne voulons pas
traduire directement sur la version python 3.5.
Si nécessaire, les traductions seraient rétroportées sur les versions
les plus anciennes par l'`équipe de documentation
<https://www.python.org/dev/peps/pep-8015/#documentation-team>`_.

Que traduire ?
~~~~~~~~~~~~~~

Vous pouvez utiliser `potodo`_, un outil fait pour trouver des fichiers ``po``
à traduire.
Une fois installé, utilisez la commande ``potodo`` dans votre clone local.
Vous pouvez choisir n'importe quel fichier non réservé dans la liste
renvoyée par la commande.

**Nous vous recommandons de ne pas commencer avec un fichier de ``c-api``
car c'est une partie très technique.**

Vous pouvez commencer par des tâches faciles comme réviser les entrées
*fuzzy* pour aider à garder la documentation à jour (trouvez les entrées
*fuzzy* l'aide de `make fuzzy`).

Vous pouvez également relire des entrées déjà traduites pour vous faire une
idée, et passer ensuite à la traduction de celles qui ne sont pas traduites.
Vous pouvez les trouver à l'aide de `make todo`...

Vous pouvez aussi « traduire » des liens hypertextes
(par exemple s'il s'agit d'un lien vers un article de Wikipédia qui possède une
traduction).
Modifiez le lien et sa description dans ce cas.
Si aucune traduction de la cible n'existe, ne traduisez pas le titre.

Dans les fichiers, ne traduisez pas le contenu des balises telles que
``:ref :...`` et ``:term :...``.

Si vous devez utiliser des mots anglais, mettez les en *italique*
(entourés par des astérisques).

Pour les caractères spéciaux, référez vous à la section
`Les caractères spéciaux`_

Utilisation du futur
~~~~~~~~~~~~~~~~~~~~

Dans la description du comportement de Python (au sens large, c'est-à-dire
l'interpréteur lui-même mais aussi toutes les bibliothèques), la version
originale utilise souvent le futur : « if you do this, il will produce
that … ». En français, l'utilisation du présent convient tout à fait et le
présent est souvent plus facile à lire : « si vous faites ceci, il se
produit cela … ». On ne conserve le futur que si la deuxième proposition
se situe réellement dans le futur (par exemple, on peut penser qu'un
processus de compilation n'est pas immédiat) ou pour des raisons de
concordance des temps.

Traduction de *should*
~~~~~~~~~~~~~~~~~~~~~~

La version originale est très polie envers le lecteur ; elle lui intime
rarement des obligations, préférant employer « you should ». Cependant, en
français, il est d'usage d'être plus direct pour être correctement compris :
« vous devez ». *Vous devriez* est en effet généralement compris comme quelque
chose dont l'on peut de temps en temps se passer, alors que c'est très
rarement le cas pour les « you should » de cette documentation.

Les caractères spéciaux
-------------------------

La touche de composition :
~~~~~~~~~~~~~~~~~~~~~~~~~~

Cette `touche <https://fr.wikipedia.org/wiki/Touche_de_composition>`_,
absente par défault des claviers, permet de saisir des
caractères spéciaux en combinant les caractères déjà présents sur le
clavier. C'est à l'utilisateur de définir la touche de composition.

Avec une touche de composition, vous pouvez utiliser les
compositions suivantes :

- :kbd:`Compose < <` donne «
- :kbd:`Compose > >` donne »
- :kbd:`Compose SPACE SPACE` donne une espace insécable
- :kbd:`Compose . . .` donne ``…``

Comme vous l'avez noté, presque toutes les compositions sont faciles
à retenir, vous pouvez donc essayer les autres et elles devraient tout
simplement fonctionner :

- :kbd:`Compose C =` donne ``€``
- :kbd:`Compose 1 2` donne ``½``
- :kbd:`Compose ' E` donne ``É``
- … …

Comment définir la touche de composition ?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cela dépend de votre système d'exploitation et de votre clavier.

=> Sous Linux/Unix/\*BSD (tel OpenBSD), vous pouvez la configurer à l'aide de
l'outil graphique de configuration de votre clavier ou via
``dpkg-reconfigure keyboard-configuration``
(pour `Ubuntu <https://help.ubuntu.com/community/ComposeKey>`_ ou Debian
et distributions assimilées).

À minima, vous pouvez configurer votre fichier '~/.Xmodmap' pour
ajouter l'équivalent de :

.. code-block:: shell

    # key Compose
    keycode 115 = Multi_key


Utilisez ``xev`` pour connaitre la bonne correspondance de la touche que vous
voulez assigner !

Ensuite, dans votre fichier '~/.xsession', ajoutez :

.. code-block:: shell

    # Gestion des touches clavier
    xmodmap $HOME/.Xmodmap

Sous X, avec un bureau graphique, tel que Gnome, ou Xfce, il faut aller
modifier dans les paramètres > clavier > Disposition : puis
'Touche composée'. Pour finir, redémarrez votre session.

=> Sous Windows, vous
pouvez utiliser `wincompose <https://github.com/SamHocevar/wincompose>`_.

Le cas de « --- », « -- »,  « ... » :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La version anglaise utilise une chose nommée
`smartquotes <http://docutils.sourceforge.net/docs/user/smartquotes.html>`_,
qui fonctionne en anglais, mais cause des problèmes dans d'autres langues.
Nous l'avons donc désactivée dans la version française.

Les *smartquotes* sont normalement responsables de la transformation de
``--`` en *en-dash* (``—``), de ``---`` en *em-dash* (``—``), et de
``...`` en *ellipses* ``…``.

=> Si vous voyez :
| « -- » ou « --- » : faites :kbd:`Compose - - -`
| « ... » : faites :kbd:`Compose . . .`

Le cas de « "…" » :
~~~~~~~~~~~~~~~~~~~

Les guillemets français ``«`` et ``»`` ne sont pas identiques aux
guillemets anglais ``"``. Cependant, Python utilise les guillemets
anglais comme délimiteurs de chaîne de caractères. Il convient donc de
traduire les guillemets mais pas les délimiteurs de chaîne.

=> Si vous voyez :
| « "…" » : faites :kbd:`Compose < <` ou :kbd:`Compose > >`

Le cas de « :: »
~~~~~~~~~~~~~~~~

| Du point de vue du langage *reStructuredText* (ou *rst*) utilisé dans la
  documentation nous voyons soit « bla bla:: », soit « bla bla. :: ».
| ``::`` collé à la fin d'un mot signifie « affiche ``:`` et introduit un bloc de code »,
  mais un ``::`` après une espace signifie « introduit juste un bloc de code ».

En français, nous mettons une espace insécable devant nos deux-points, comme :
« Et voilà : ».

=> Traduisez ``mot deux-points deux-points`` par
``mot espace-insécable deux-points deux-points``.

Pour saisir une espace insécable faites : :kbd:`Compose SPACE SPACE`

Outils utiles pour la traduction
--------------------------------

Potodo
~~~~~~

| Permet de d'identifier les parties de la documention qu'il reste à traduire.
| Installez-le à l'aide de *pip* (``pip install potodo``) dans un environnement
  ``python3.6`` ou plus.
| `Lien vers le repository <https://github.com/seluj78/potodo>`__

Pogrep
~~~~~~

| Permet de rechercher dans la documentation des termes. Utile si on a un doute
  sur comment traduire un terme ou chercher la traduction d'un terme dans
  d'autres fichiers.
| Installez-le à l'aide de *pip* (``pip install pogrep``) dans un
  environnement.
| `Lien vers le repository <https://github.com/JulienPalard/pogrep>`__

Padpo (beta)
~~~~~~~~~~~~~~~

| Analyseur de code qui vérifie la grammaire et l'orthographe et la syntaxe
  du fichier .po.
| Installez-le à l'aide de *pip* (``pip install padpo``) dans un environnement
  ``python3.7`` ou plus.
| `Lien vers le repository <https://github.com/vpoulailleau/padpo>`__

Powrap
~~~~~~

| Formateur de fichier .po.
| Installez-le à l'aide de *pip* (``pip install powrap``) dans un
  environnement.
| `Lien vers le repository <https://github.com/JulienPalard/powrap>`__

Ressources de traduction
-------------------------

- les canaux IRC sur freenode :
  - `#python-docs-fr <http://irc.lc/freenode/python-docs-fr>`_
  Communauté python autour de la documentation française.
  - `#python-fr <http://irc.lc/freenode/python-fr>`_
  Communauté python française.
  - `#python-doc <http://irc.lc/freenode/python-fr>`_
  Communauté python autour de la documentation anglaise.
- la `liste traductions AFPy <http://lists.afpy.org/mailman/listinfo/traductions>`_ ;
- la `liste de diffusion doc-sig
  <https://mail.python.org/mailman/listinfo/doc-sig>`_ ;
- les `glossaires et dictionnaires de traduc.org
  <https://traduc.org/Glossaires_et_dictionnaires>`_, en particulier le
  `grand dictionnaire terminologique <http://gdt.oqlf.gouv.qc.ca/>`_
  de l'Office québécois de la langue française ;
- le `glossaire Python <https://docs.python.org/fr/3/glossary.html>`_, car
  il est déjà traduit ;
- le `guide stylistique pour le français de localisation des produits Sun
  <https://web.archive.org/web/20160821182818/http://frenchmozilla.org/FTP/TEMP/guide_stylistique_December05.pdf>`_ donne
  beaucoup de conseils pour éviter une traduction trop mot à mot ;
- Wikipédia : En allant sur l'article d'un sujet sur la version anglaise
  de Wikipédia, puis en basculant sur la version francaise pour voir
  comment le sujet est traduit.
- `Petites leçons de typographie <https://jacques-andre.fr/faqtypo/lessons.pdf>`_,
  résumé succint de typographie, utile pour apprendre le bon usage des
  majuscules, des espaces, etc.

Glossaire
---------

Afin d'assurer la cohérence de nos traductions, voici quelques propositions et
rappels pour les termes fréquents à traduire, n'hésitez pas à ouvrir un ticket
si vous n'êtes pas d'accord.

Pour trouver facilement comment un terme est déjà traduit dans notre
documentation, vous pouvez utiliser `pogrep`_.

========================== ===============================================
Terme                      Traduction proposée
========================== ===============================================
-like                      -compatible
abstract data type         type abstrait
argument                   argument (à ne pas confondre avec *paramètre*)
backslash                  antislash, *backslash*
backtrace                  trace d'appels, trace de pile
bound                      lier
bug                        bogue, *bug*
built-in                   native
callback                   fonction de rappel
call stack                 pile d'appels
debugging                  débogage
deep copy                  copie récursive (préféré), ou copie profonde
double quote               guillemet
deprecated                 obsolète
-like                      -compatible
e.g.                       p. ex. (on n'utilise pas l'anglicisme « e.g. »,
                           lui-même issu du latin *exempli gratia*).
                           On sépare les deux mots par  une espace
                           insécable pour éviter les retours à la ligne
                           malheureux.
et al.                     et autres, `à accorder
                           <https://fr.wikipedia.org/wiki/Et_al.>`_
                           suivant le contexte
export                     exportation
expression                 expression
garbage collector          ramasse-miettes
getter                     accesseur
i.e.                       c.-à-d. (on n'utilise pas l'anglicisme « i.e »,
                           lui-même issu du latin *id est*)
identifier                 identifiant
immutable                  immuable
import                     importation
installer                  installateur
interpreter                interpréteur
library                    bibliothèque
list comprehension         liste en compréhension (liste en intension est
                           valide, mais nous ne l'utilisons pas)
little-endian, big-endian  `petit-boutiste, gros-boutiste
                           <https://fr.wikipedia.org/wiki/Endianness>`_
mixin type                 type de mélange
mutable                    muable
namespace                  espace de nommage
                           (sauf pour le XML où c'est espace de noms)
parameter                  paramètre
pickle (v.)                sérialiser
prompt                     invite
raise                      lever
regular expression         expression rationnelle, expression régulière
return                     renvoie, donne (on évite « retourne » qui
                           pourrait porter à confusion).
setter                     mutateur
simple quote               guillemet simple
socket                     connecteur ou interface de connexion
statement                  instruction
subprocess                 sous-processus
thread                     fil d'exécution
traceback                  trace d'appels, trace de pile
underscore                 tiret bas, *underscore*
whitespace                 caractère d'espacement
========================== ===============================================

Simplifier les diffs git
------------------------

Les diffs git sont souvent encombrés de changements inutiles de numéros
de ligne, comme :

.. code-block:: diff

    -#: ../Doc/library/signal.rst:406
    +#: ../Doc/library/signal.rst:408

Pour dire à git que ce ne sont pas des informations utiles, vous pouvez faire
ce qui suit après vous être assuré que ``~/.local/bin/`` se trouve dans votre
``PATH``.

.. code-block:: bash

    cat <<EOF > ~/.local/bin/podiff
    #!/bin/sh
    grep -v '^#:' "\$1"
    EOF

    chmod a+x ~/.local/bin/podiff

    git config diff.podiff.textconv podiff


Maintenance
-----------

Toutes ces commandes doivent être exécutées à partir de la racine d'un clone
de ``python-docs-fr``, et certains s'attendent à trouver un clone de CPython
à jour à proximité, comme :

.. code-block:: bash

  ~/
  ├── python-docs-fr/
  └── cpython/

Pour cloner CPython, vous pouvez utiliser :

.. code-block:: bash

  git clone --depth 1 --no-single-branch https://github.com/python/cpython.git

Ceci évite de télécharger tout l'historique (inutile pour générer la
documentation) mais récupère néanmoins toutes les branches.


Fusionner les fichiers *pot* de CPython
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make merge


Trouver les chaînes de caractères *fuzzy*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make fuzzy


Lancer un *build* en local
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make


Synchroniser la traduction avec Transifex
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vous aurez besoin de ``transifex-client`` et ``powrap``,
depuis PyPI.

Vous devrez configurer ``tx`` via ``tx init`` si ce n'est déjà fait.

Propagez d'abord les traductions connues localement :

.. code-block:: bash

   pomerge --no-overwrite --from-files **/*.po --to-files **/*.po
   powrap --modified
   git commit -m "Propagating known translations."


Ensuite récupérez les changements depuis Transifex :

.. code-block:: bash

   tx pull -f --parallel
   pomerge --from-files **/*.po
   git checkout -- .
   pomerge --no-overwrite --mark-as-fuzzy --to-files **/*.po
   powrap --modified
   git add -p
   git commit -m "tx pull"
   tx push -t -f --no-interactive --parallel
