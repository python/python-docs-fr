Guide de contribution à la documention via GitHub
=================================================

Instructions
------------

Prérequis
~~~~~~~~~

- un compte `Github <https://github.com/join>`_ ;
- un client ``git`` `Linux <https://git-scm.com/>`_ ou `Windows <https://gitforwindows.org/>`_ ;
- un éditeur de fichier ``.po`` (comme `Poedit <https://poedit.net/>`_).

Équipez-vous aussi de quelques outils pour vous aider dans
votre traduction (voir `Outils utiles pour la traduction`_).


*fork* personnel
~~~~~~~~~~~~~~~~

Pour commencer vous aurez besoin de *forker* le dépôt des sources `python-docs-fr
<https://github.com/python/python-docs-fr>`_ en cliquant sur son bouton
``Fork``. Ceci crée une copie du projet sur votre compte Github, c'est un endroit
où vous avez le droit de faire des modifications.

Étape par étape :

.. code-block:: bash

    # Clonez votre fork Github avec `git` en utilisant ssh
    git clone git@github.com:VOTRE_NOM_DE_COMPTE_GITHUB/python-docs-fr.git

    # ou bien via HTTPS
    git clone https://github.com/VOTRE_NOM_DE_COMPTE_GITHUB/python-docs-fr.git

    # Allez dans le répertoire cloné
    cd python-docs-fr/

    # Ajoutez le dépôt officiel (nommé upstream),
    # ceci permet à *git* de savoir quoi et où est *upstream*
    git remote add upstream https://github.com/python/python-docs-fr.git


Réservation d'un fichier
~~~~~~~~~~~~~~~~~~~~~~~~

Ensuite, vous devez trouver un fichier sur lequel travailler
(pour vous aiguiller, lisez la section `Que traduire ?`_). Nous vous conseillons
de choisir, si possible, un fichier traitant d'un sujet que vous maitrisez, cela
vous aidera grandement à produire une traduction de bonne qualité.

Une fois que vous avez choisi un fichier sur lequel travailler, veuillez
ouvrir un `ticket sur Github <https://github.com/python/python-docs-fr/issues>`_
en indiquant dans le titre ``Je travaille sur DOSSIER/FICHIER.po``
(par exemple « Je travaille sur library/sys.po »).
Ceci permet à `potodo`_ de détecter via l'API Github les fichiers ``.po`` réservés
dans les tickets et les *pull requests*.

Vous êtes maintenant prêt. Chaque fois que vous commencerez un nouveau fichier,
suivez cette procédure :

Pour travailler, nous aurons besoin d'une branche, basée sur une version à jour
(fraîchement récupérée) de la branche upstream/3.9. On met donc à jour notre
version locale.

.. code-block:: bash

    git fetch upstream


On crée ensuite une branche. Il est pratique de nommer la branche en fonction du
fichier sur lequel on travaille. Par exemple, si vous travaillez sur
« library/sys.po », vous pouvez nommer votre branche « library-sys ».
Cette nouvelle branche nommée « library-sys » est basée sur « upstream/3.9 ».

.. code-block:: bash

    git checkout -b library-sys upstream/3.9


Vous pouvez maintenant travailler sur le fichier.
Si vous utilisez Poedit, n'oubliez pas de configurer votre nom et votre adresse de courriel
(Édition → Préférences → Général).
Vérifiez aussi qu'il est configuré pour passer à la ligne à 79 caractères
(Édition → Préférences → Avancé → Passer à la ligne à 79).

Ici, remplacez « library/sys.po » par le fichier que vous avez choisi précédemment.

.. code-block:: bash

    poedit library/sys.po


Ou lancez simplement Poedit puis « Fichier » → « Ouvrir ».


Traduction
~~~~~~~~~~

Vous pouvez dès à présent commencer à traduire le fichier en respectant les `conventions`_ du projet.
Pour vous aider à ne pas faire de fautes d'orthographe, vous pouvez vérifier que tous les mots utilisés sont
bien dans le dictionnaire (ça ne vérifie pas la grammaire, pour cela utilisez `padpo (beta)`_). En cas
de doute, un `glossaire`_ répertorie déjà les traductions retenues pour certains termes techniques ou faux amis
en anglais.

.. code-block:: bash

    make spell

Vous pouvez aussi réindenter les fichiers avec :

.. code-block:: bash

    make wrap

Et pour faire les deux à la fois, lancez :

.. code-block:: bash

    make verifs

Une fois la traduction finie, il faut compiler la documentation, c'est-à-dire générer les fichiers HTML
affichés par le site, pour les relire. Si la commande précédente s'est exécutée sans erreur, la
compilation ne devrait pas échouer.

.. code-block:: bash

    make

Vérifiez alors le rendu de la traduction « en vrai ». Lancez un serveur de
documentation local :

.. code-block:: bash

    make serve

La documentation est publiée l'adresse `<http://localhost:8000/library/sys.html>`_
(ou tout autre port indiqué par la sortie de la commande précédente). Vous pouvez
recommencer les étapes de cette section autant de fois que nécessaire.

Poedit donne beaucoup d'avertissements, par exemple pour vous informer que
« la traduction devrait commencer par une majuscule » car c'est le cas pour
la source. Ces avertissements ne sont pas tous fondés. En cas de doute,
*affichez et relisez la page HTML produite* avec ``make serve``.

*pull request*
~~~~~~~~~~~~~~

Une fois que le *make verifs* ne lève pas d'erreur et que vous êtes certains de bien respecter les
`Conventions`_ de traduction, vient le moment d'envoyer votre travail sur le dépôt local.

``git add`` place nos modifications dans l'index de Git en
attendant d'être propagées dans le dépôt local.

.. code-block:: bash

    git add library/sys.po


``git commit`` permet de les propager :

.. code-block:: bash

    git commit -m "Traduction de library/sys.po"  # Ou un autre message plus inspiré :)

Poussez ensuite vos modifications sur votre *fork* Github avec ``git push``.
Le ``-u`` n'est utile qu'une fois pour que votre client git se souvienne que cette
branche est liée à votre *fork* Github (et donc que vos futurs ``git pull`` et
``git push`` sachent quoi tirer).

.. code-block:: bash

    git push -u origin

La commande précédente vous affiche un lien pour ouvrir une pull request sur
Github. Si vous l'avez manqué, allez simplement sur https://github.com/python/python-docs-fr/pulls
et un joli bouton « Compare & pull request » devrait apparaître au bout de
quelques secondes vous indiquant que vous pouvez demander une pull request.

Mettez dans le commentaire de la *pull request* le texte suivant :
« Closes #XXXX » où XXXX est le numéro du ticket GitHub créé pour réserver le fichier traduit.
Cela permet à Github de lier la *pull request* au ticket de réservation.

À partir de là, quelqu'un passera en revue vos modifications, et vous fera des
suggestions et corrections. Pour les prendre en compte, retournez sur votre branche
contenant le fichier concerné (au cas où vous auriez commencé quelque chose d'autre
sur une autre branche) :

.. code-block:: bash

    git checkout library-sys
    git pull  # pour rapatrier les modifications que vous auriez acceptées
              # sur l'interface web.

    # Réglez les problèmes, puis commitez à nouveau :
    git commit -a -m "prise en compte des remarques"
    git push


Vous avez peut-être remarqué que cela ressemble à un triangle, avec un
segment manquant :

- vous récupérez depuis *upstream* (le dépôt commun public sur Github) ;
- vous poussez sur *origin* (votre clone sur Github).

C'est le travail de quelqu'un d'autre d'ajouter le dernier segment,
de votre *origin* au *upstream* public, pour « boucler la boucle ». C'est le
rôle des personnes qui *fusionnent* les *pull requests* après les avoir relues.

Vous avez peut-être aussi remarqué que vous n'avez jamais commité sur une
branche de version (3.8, 3.9, etc.), seulement récupéré les
modifications à partir d'elles.

Toutes les traductions sont faites sur la dernière version.
Nous ne traduisons jamais sur une version plus ancienne. Par exemple,
si la dernière version de python est Python 3.9, nous ne voulons pas
traduire directement sur la version Python 3.5.
Si nécessaire, les traductions seraient rétroportées sur les versions
les plus anciennes par l'`équipe de documentation
<https://www.python.org/dev/peps/pep-8015/#documentation-team>`_.

Que traduire ?
--------------

Vous pouvez utiliser `potodo`_, un outil fait pour trouver des fichiers *po*
à traduire. Une fois installé, utilisez la commande ``make todo`` dans votre clone
local.

Vous pouvez choisir n'importe quel fichier non réservé dans la liste
renvoyée par la commande **à l'exception** des fichiers de :

- *c-api/* car c'est une partie très technique ;
- *whatsnew/* car les anciennes versions de Python sont pour la plupart obsolètes et leurs journaux de modifications ne sont pas les pages les plus consultées ;
- *distutils/* et *install/* car ces pages seront bientôt obsolètes.

Vous pouvez commencer par des tâches faciles comme réviser les entrées
*fuzzy* pour aider à garder la documentation à jour (trouvez-les à l'aide
de ``make fuzzy``). Une entrée *fuzzy* correspond à une entrée déjà traduite
mais dont la source en anglais a été remodifiée depuis (correction orthographique,
changement d'un terme, ajout ou suppression d'une phrase…). Elles sont
généralement plus « faciles » à traduire.

Vous pouvez également relire des entrées déjà traduites pour vous faire une
idée, et passer ensuite à la traduction de celles qui ne le sont pas encore.


Conventions
-----------

Certaines conventions ont été édictées pour homogénéiser la traduction.
Il faut suivre les règles de `style`_ imposées, les `règles rst`_ et
les traductions déjà définies dans le `glossaire`_.


Style
~~~~~

Une bonne traduction est une traduction qui transcrit fidèlement l'idée originelle
en français, sans rien ajouter ni enlever au fond, tout en restant claire, concise et
agréable à lire. Les traductions mot-à-mot sont à proscrire et il est permis — même
conseillé — d'intervertir des propositions ou de réarranger des phrases de la
documentation anglaise, si le rythme l'exige. Il faut aussi chercher des
équivalents français aux termes techniques et aux idiotismes rencontrés, et prendre
garde aux anglicismes.

Utilisation du futur
++++++++++++++++++++

Dans la description du comportement de Python (au sens large, c'est-à-dire
l'interpréteur lui-même mais aussi toutes les bibliothèques), la version
originale utilise souvent le futur : « if you do this, it will produce
that… ». En français, l'utilisation du présent convient tout à fait et le
présent est souvent plus facile à lire : « si vous faites ceci, il se
produit cela… ». On ne conserve le futur que si la seconde proposition
se situe réellement dans le futur (par exemple, on peut penser qu'un
processus de compilation n'est pas immédiat) ou pour des raisons de
concordance des temps.

Utilisation du conditionnel
+++++++++++++++++++++++++++

La version originale est très polie envers le lecteur ; elle lui intime
rarement des obligations, préférant employer « you should ». Cependant, en
français, il est d'usage d'être plus direct pour être correctement compris :
« vous devez ». *Vous devriez* est en effet généralement compris comme quelque
chose dont l'on peut de temps en temps se passer, alors que c'est très
rarement le cas pour les « you should » de cette documentation.
De la même manière, « can » est souvent mieux traduit sans introduire de notion
de possibilité, en particulier quand la phrase est à la voix passive ; la
phrase « these objects can be accessed by… » se traduit mieux par « on accède à
ces objets en… ».

Utilisation du masculin
+++++++++++++++++++++++

Dans un souci de lisibilité et en accord avec la préconisation de
l'Académie française, nous utilisons le masculin pour indiquer un
genre neutre. Par exemple : l'utilisateur ou le lecteur.

Règles rst
~~~~~~~~~~

Prototypes et exemples
++++++++++++++++++++++

Il ne faut pas traduire le nom des éléments de la bibliothèque standard (noms
de fonctions, paramètres de ces fonctions, constantes etc.) mais les laisser
tels quel, entourés d'astérisques dans les blocs de texte.
Si la documentation contient des exemples, vous *pouvez* traduire les noms
utilisés, en prenant garde d'être cohérent. Vous pouvez ainsi traduire :

.. code-block:: python

    def sample_function():
       result = thread.join(timeout=...)
       ...

en

.. code-block:: python

    def fonction_exemple():
       resultat = thread.join(timeout=...)
       ...

mais pas en

.. code-block:: python

    def fonction_exemple():
       resultat = fildexécution.attendre(délai=...)
       ...

Liens hypertextes
+++++++++++++++++

Il faut transformer les liens hypertextes qui redirigent vers une page dont il
existe une version française (c'est notamment très souvent le cas pour les
articles de Wikipédia). Modifiez le lien *et* sa description dans ce cas.
Si aucune traduction de la cible n'existe, ne traduisez pas la description.
Par exemple, ```Conway's Game of Life <https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life>`_``
doit devenir ```Jeu de la vie <https://fr.wikipedia.org/wiki/Jeu_de_la_vie>`_``.


Balises
+++++++

Ne traduisez pas le contenu des balises comme ``:ref:...`` ou ``:class:...``.
Vous devez cependant traduire les balises ``:term:...``, qui font référence à
un concept ou une primitive défini dans le `glossaire Python <https://docs.python.org/fr/3/glossary.html>`_.
La syntaxe est ``:term:nom_français<nom_anglais>``. Par exemple, traduisez
``:term:`dictionary``` en  ``:term:`dictionaire <dictionary>```.

Comme le glossaire est déjà traduit, il y a forcément une correspondance à chaque
terme que vous pouvez rencontrer.


Glossaire
~~~~~~~~~

Afin d'assurer la cohérence de la traduction, voici quelques
termes fréquents déjà traduits. Une liste blanche de noms propres, comme « Guido »,
« C99 » ou de certains anglicismes comme « sérialisable » ou « implémentation»,
est stockée dans le fichier « dict » à la racine du projet. Vous pouvez
y ajouter une entrée si cela est nécessaire.
Si vous devez *absolument* utiliser un mot anglais, mettez-le en italique
(entouré par des astérisques).

Pour trouver facilement comment un terme est déjà traduit dans la
documentation, vous pouvez utiliser `pogrep`_.

========================== ===============================================
Terme                      Traduction
========================== ===============================================
-like                      -compatible
abstract data type         type abstrait
argument                   argument (à ne pas confondre avec *paramètre*)
backslash                  antislash, *backslash*
backtrace                  trace d'appels, trace de pile
backport                   rétroporter
bound                      lier
bug                        bogue
built-in                   natif
bytecode                   code intermédiaire
callback                   fonction de rappel
call stack                 pile d'appels
caught (exception)         interceptée
debugging                  débogage
deep copy                  copie récursive (préféré), ou copie profonde
double quote               guillemet
deprecated                 obsolète
e.g.                       p. ex. (on n'utilise pas l'anglicisme « e.g. »,
                           lui-même issu du latin *exempli gratia*).
                           On sépare les deux mots par une espace
                           insécable pour éviter les retours à la ligne
                           malheureux.
et al.                     et autres, `à accorder
                           <https://fr.wikipedia.org/wiki/Et_al.>`_
                           suivant le contexte
export                     exportation
expression                 expression
framework                  cadriciel
garbage collector          ramasse-miettes
getter                     accesseur
i.e.                       c.-à-d. (on n'utilise pas l'anglicisme « i.e. »,
                           lui-même issu du latin *id est*)
identifier                 identifiant
immutable                  immuable
import                     importation
index                      indice (en particulier quand on parle de chaînes
                           de caractères)
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
                           pourrait porter à confusion)
setter                     mutateur
simple quote               guillemet simple
socket                     connecteur ou interface de connexion
statement                  instruction
subprocess                 sous-processus
support                    prendre en charge, implémenter (« supporter »
                           n'a pas le même sens en français)
specify                    définir, préciser (plutôt que « spécifier »)
typically                  normalement, habituellement, comme d'habitude
                           (plutôt que « typiquement »)
thread                     fil d'exécution
traceback                  trace d'appels, trace de pile
tuple                      n-uplet
underscore                 tiret bas, *underscore*
whitespace                 caractère d'espacement
========================== ===============================================

Ressources de traduction
------------------------

- les canaux IRC sur freenode :

  - `#python-docs-fr <http://irc.lc/freenode/python-docs-fr>`_ — communauté python autour de la documentation française,
  - `#python-fr <http://irc.lc/freenode/python-fr>`_  — communauté python francophone,
  - `#python-doc <http://irc.lc/freenode/python-fr>`_ — communauté python autour de la documentation anglophone ;
- les listes de diffusion relatives à la documentation (courriel) :

  - `de l'AFPy <http://lists.afpy.org/mailman/listinfo/traductions>`_,
  - `de cpython <https://mail.python.org/mailman/listinfo/doc-sig>`_ ;
- des glossaires et dictionnaires :

  - le `glossaire de la documentation Python <https://docs.python.org/fr/3/glossary.html>`_, car il est déjà traduit,
  - les `glossaires et dictionnaires de traduc.org <https://traduc.org/Glossaires_et_dictionnaires>`_, en particulier le  `grand dictionnaire terminologique <http://gdt.oqlf.gouv.qc.ca/>`_ de l'Office québécois de la langue française,
  - Wikipédia. En consultant un article sur la version anglaise, puis en basculant sur la version francaise pour voir comment le sujet de l'article est traduit ;
- le `guide stylistique pour le français de localisation des produits Sun
  <https://web.archive.org/web/20160821182818/http://frenchmozilla.org/FTP/TEMP/guide_stylistique_December05.pdf>`_ donne
  beaucoup de conseils pour éviter une traduction trop mot à mot ;
- `Petites leçons de typographie <https://jacques-andre.fr/faqtypo/lessons.pdf>`_,
  résumé succint de typographie, utile pour apprendre le bon usage des
  majuscules, des espaces, etc.

L'utilisation de traducteurs automatiques comme `DeepL https://www.deepl.com/` ou semi-automatiques comme
`reverso https://context.reverso.net/traduction/anglais-francais/` est proscrite.
Les traductions générées sont très souvent à retravailler, ils ignorent les règles énoncées sur cette
page et génèrent une documentation au style très « lourd ».


Caractères spéciaux et typographie
----------------------------------

La touche de composition
~~~~~~~~~~~~~~~~~~~~~~~~

Cette `touche <https://fr.wikipedia.org/wiki/Touche_de_composition>`_,
absente par défault des claviers, permet de saisir des
caractères spéciaux en combinant les caractères déjà présents sur le
clavier. C'est à l'utilisateur de définir la touche de composition.

Avec une touche de composition, vous pouvez utiliser les
compositions suivantes :

- :kbd:`Compose < <` donne ``«``
- :kbd:`Compose > >` donne ``»``
- :kbd:`Compose SPACE SPACE` donne une espace insécable
- :kbd:`Compose . . .` donne ``…``

Comme vous l'avez noté, presque toutes les compositions sont intuitives,
vous pouvez donc en essayer d'autres et elles devraient tout
simplement fonctionner :

- :kbd:`Compose C =` donne ``€``
- :kbd:`Compose 1 2` donne ``½``
- :kbd:`Compose ' E` donne ``É``
- etc.

Comment définir la touche de composition ?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cela dépend de votre système d'exploitation et de votre clavier.

=> Sous Linux, Unix et \*BSD (tel OpenBSD), vous pouvez la configurer à l'aide de
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
modifier dans les « Paramètres » → « Clavier » → « Disposition » →
« Touche composée ». Pour finir, redémarrez votre session.

=> Sous Windows, vous
pouvez utiliser `wincompose <https://github.com/SamHocevar/wincompose>`_.

Le cas de « --- », « -- »,  « ... »
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La version anglaise utilise les
`smartquotes <http://docutils.sourceforge.net/docs/user/smartquotes.html>`_,
qui fonctionnent en anglais, mais causent des problèmes dans d'autres langues.
Nous les avons donc désactivées (voir #303) dans la version française.

Les *smartquotes* sont normalement responsables de la transformation de
``--`` en *en-dash* (``—``), de ``---`` en *em-dash* (``—``), et de
``...`` en *ellipses* ``…``.

=> Si vous voyez :
| « -- » ou « --- » : faites :kbd:`Compose - - -`
| « ... » : faites :kbd:`Compose . . .`

Le cas de « "…" »
~~~~~~~~~~~~~~~~~

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

Pour saisir une espace insécable faites :kbd:`Compose SPACE SPACE`

Les doubles-espaces
~~~~~~~~~~~~~~~~~~~

La documentation originale comporte beaucoup de doubles-espaces.
Cela se fait en anglais, mais pas en français. De toute manière,
ils passent ensuite à une moulinette et le rendu des espaces est délégué
au HTML et au PDF, qui n'en tiennent pas compte.
Nous avons décidé de ne rien changer pour les doubles-espaces
coté traduction : nous ne les retirons pas et ce n'est pas grave
si des traducteurs en retirent par accident.

Les énumérations
~~~~~~~~~~~~~~~~

Chaque paragraphe d'une énumération introduite par un deux-point
doit se terminer par un point-virgule (bien entendu précédé d'une
espace insécable) quelle que soit sa ponctuation interne. Seul le dernier
paragraphe de l'énumération s'achève par un point ou, si la phrase
continue après l'énumération, une virgule. Si l'un des paragraphes est
lui-même une énumération, chacun des sous-paragraphes se termine par
une virgule et le dernier par un point-virgule.

Par exemple :

- le premier paragraphe de l'énumération ;
- le deuxième paragraphe, lui-aussi une énumération :

  - premier sous-paragraphe,
  - second sous-paragraphe ;

- le dernier paragraphe.

Malheureusement Poedit n'aime pas les différences de ponctuation finales
entre un paragraphe et sa traduction ; il faut passer outre ses avertissements.
Vous pouvez aussi rajouter un commentaire dans le fichier *.po* pour avertir
les traducteurs suivants et éviter qu'ils ne « corrigent » par erreur ces
avertissements.

Outils utiles pour la traduction
--------------------------------

Potodo
~~~~~~

| Permet de d'identifier les parties de la documention qu'il reste à traduire.
| Installez-le à l'aide de *pip* (``pip install potodo``) dans un environnement
  ``python3.6`` ou plus.
| `Lien vers le dépôt <https://github.com/seluj78/potodo>`__

Pogrep
~~~~~~

| Permet de rechercher dans la documentation des termes. Utile si on a un doute
  sur comment traduire un terme ou chercher la traduction d'un terme dans
  d'autres fichiers.
| Installez-le à l'aide de *pip* (``pip install pogrep``).
| `Lien vers le dépôt <https://github.com/JulienPalard/pogrep>`__

Padpo (beta)
~~~~~~~~~~~~

| Analyseur de code qui vérifie la grammaire et l'orthographe et la syntaxe
  du fichier .po.
| Installez-le à l'aide de *pip* (``pip install padpo``) dans un environnement
  ``python3.7`` ou plus.
| `Lien vers le dépôt <https://github.com/vpoulailleau/padpo>`__

Powrap
~~~~~~

| Formateur de fichier .po.
| Installez-le à l'aide de *pip* (``pip install powrap``).
| `Lien vers le dépôt <https://github.com/JulienPalard/powrap>`__


Simplification des diffs git
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


Pas d'inquiétude, cela ne change la façon dont Git affiche les changements que sur
les fichiers de la traduction, sans incidence sur les autres.


Maintenance
-----------

Toutes ces commandes doivent être exécutées à partir de la racine d'un clone
de ``python-docs-fr`` et certaines s'attendent à trouver un clone de CPython
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


Fusion des fichiers *pot* de CPython
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  make merge


Copier des traductions d'une branche à l'autre
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dans certains cas on a besoin de bouger des traductions d'une branche
à l'autre :

- d'une ancienne branche vers une nouvelle branche : lors du passage
  d'une version à l'autre de cpython, quelqu'un a une PR sur une
  ancienne release (*forward porting*) ;
- d'une nouvelle branche vers des anciennes branches : pour propager
  de temps en temps le travail sur d'anciennes releases (*back porting*).

On utilise ``pomerge``\  : on le fait lire sur une branche, puis écrire
sur une autre, par exemple pour copier de la 3.7 à la 3.8 ::

    git fetch
    git checkout 3.7
    git reset --hard upstream/3.7
    pomerge --from-files *.po */*.po
    git checkout -b forward-porting upstream/3.8
    pomerge  --no-overwrite --to-files *.po */*.po
    powrap -m
    git add --patch
    git commit --message="Forward porting from 3.7"
    git push --set-upstream origin HEAD

Notes :

- j'utilise ``git fetch`` au début pour avoir upstream/3.7 et
  upstream/3.8 à jour localement, ainsi je peux travailler sans
  toucher au réseau jusqu'au ``git push``, mais chacun fait comme il
  veut ;
- j'utilise ``*.po */*.po`` et pas ``**/*.po``, car si vous avez un
  venv dans l'arborescence il va vous trouver des traductions de Sphinx et peut-être
  d'autres paquets dans ``.venv/lib/python*/`` (et mettre beaucoup
  plus longtemps) ;
- j'utilise ``pomerge --no-overwrite``, ça indique à ``pomerge`` de
  n'écrire que si le ``msgstr`` est vide, donc de ne pas modifier
  l'existant, ainsi il est impossible de casser quelque chose, c'est
  important lors du *forward-porting* pour ne pas défaire une
  correction. Mais on pourrait le tenter sans ``--no-overwrite`` sur
  du rétroportage, attention, ça fait des bêtises, ça nécessite une
  relecture attentive : certaines traductions, comme *example:* sont en
  francais parfois traduite avec une majuscule, et parfois non, en
  fonction du contexte, ``pomerge`` uniformiserait ça, ce n'est pas bien ;
- attention, si vous testez sans ``--no-overwrite``, il est peut être
  bon de vider la mémoire de ``pomerge`` avant la lecture, pour éviter
  de lui faire écrire des choses lues lors des sessions précédentes,
  via un ``rm -f ~/.pomerge.json``\  ;
- j'utilise ``git add --patch`` (ou ``-p``) car j'aime bien relire quand même,
  typiquement je n'ajoute pas les différences d'ordre dans les entêtes,
  mais un ``git add --update`` irait très bien ;
- attention au fichier *dict* à qui il peut manquer des lignes.


Synchronisation de la traduction avec Transifex
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
