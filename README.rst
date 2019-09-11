Traduction française de la documentation Python
===============================================

|build| |progression|

.. |build| image:: https://travis-ci.org/python/python-docs-fr.svg?branch=3.8
   :target: https://travis-ci.org/python/python-docs-fr
   :width: 45%

.. |progression| image:: https://img.shields.io/badge/dynamic/json.svg?label=fr&query=%24.fr&url=http%3A%2F%2Fgce.zhsj.me%2Fpython/newest
   :width: 45%


Accord de contribution à la documentation
-----------------------------------------

NOTE CONCERNANT LA LICENCE POUR LES TRADUCTIONS : La documentation de Python
est maintenue grâce à un réseau mondial de bénévoles. En publiant ce projet
sur Transifex, Github, et d'autres endroits publics, et vous invitant
à participer, la PSF vous enjoint à accepter cet accord qui stipule que vous
acceptez de fournir vos améliorations à la documentation de Python ou à la
traduction de la documentation de Python pour le bénéfice de la PSF sous licence
CC0 (disponible à l'adresse
https://creativecommons.org/publicdomain/zero/1.0/legalcode). En retour, vous
pouvez demander à ce que votre contribution à la documentation soit
publiquement reconnue, et si votre traduction est acceptée par la
PSF, vous pouvez (mais vous n'êtes pas obligé) soumettre un correctif incluant
une modification appropriée dans le fichier Misc/ACKS ou TRANSLATORS. Bien que
rien dans le présent *accord de contribution* à la documentation n'oblige la PSF
à incorporer votre contribution textuelle, votre participation à la communauté
Python est bienvenue et appréciée.

En soumettant votre travail à la PSF pour inclusion dans la documentation,
vous signifiez votre acceptation de cet accord.


Contribuer à la traduction
--------------------------

Comment contribuer
~~~~~~~~~~~~~~~~~~

Vous pouvez contribuer en utilisant :

- Des *pull requests* Github (solution recommandée).
- En envoyant un patch à la liste `traductions <https://lists.afpy.org/mailman/listinfo/traductions>`_.


Contribuer en utilisant Github
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prérequis :

- Un compte `Github <https://github.com/join>`_.
- ``git`` `installé <https://help.github.com/articles/set-up-git/>`_ (pour Windows, voir
  https://gitforwindows.org/).
- Un éditeur de fichier ``.po`` (utilisez `poedit <https://poedit.net/>`_
  si vous n'en avez pas déjà un).


Commencer :

Vous aurez besoin de *forker* le dépôt des sources `python-docs-fr
<https://github.com/python/python-docs-fr>`_ en cliquant sur son bouton
``Fork``. Ceci crée une copie du projet sur votre compte Github : un endroit
où vous avez le droit de faire des modifications.

Étape par étape :

.. code-block:: bash

    # Clonez votre fork Github avec `git` en utilisant ssh :
    git clone git@github.com/VOTRE_NOM_DE_COMPTE_GITHUB/python-docs-fr.git
    # *OU* HTTPS :
    git clone https://github.com/VOTRE_NOM_DE_COMPTE/python-docs-fr.git

    # Allez dans le répertoire cloné :
    cd python-docs-fr/

    # Ajoutez le dépot upstream (le dépôt public) en utilisant HTTPS (git
    # ne demandera pas de mot de passe ainsi) :
    # Ceci permet à *git* de savoir quoi/où est *upstream*
    git remote add upstream https://github.com/python/python-docs-fr.git

Ensuite, vous devez trouver un fichier sur lequel travailler.
Vous pouvez utiliser `potodo <https://github.com/seluj78/potodo>`_, un outil
fait pour trouver des fichiers ``po`` à traduire.
Installez-le à l'aide de *pip* (``pip install potodo``) dans un environnement
``python3.6`` ou plus.
Lancez ensuite la commande ``potodo`` dans votre clone local.
Vous pouvez choisir n'importe quel fichier non réservé dans la liste
renvoyée par la commande.

**Nous vous recommandons de ne pas commencer avec un fichier de ``c-api``
car c'est une partie très technique.**

Une fois que vous avez choisi un fichier sur lequel travailler, veuillez
ouvrir un `ticket sur Github <https://github.com/python/python-docs-fr>`_ dans
le format ``Je travaille sur RÉPERTOIRE/FICHIER.po``. Ceci permet à ``potodo``
de détecter via l'API Github les fichiers ``.po`` réservés dans les tickets
et les *pull requests*.

Vous êtes maintenant prêt à commencer une session de travail. Chaque
fois que vous commencerez un nouveau fichier, commencez ainsi :

.. code-block:: bash

    # Pour travailler, nous aurons besoin d'une branche, basée sur une version à jour
    # (fraîchement récupérée) de la branche upstream/3.8. Nous appellerons notre branche
    # « library-sys » mais vous pouvez appeller la vôtre comme vous voulez.
    # En général, vous nommez une branche en fonction du fichier sur lequel vous travaillez.
    # Par exemple, si vous travaillez sur « library/venv.po », vous pouvez nommer votre
    # branche « library-venv ».

    # Mettez à jour votre version locale
    git fetch upstream
    # Créez une nouvelle branche nommée « library-sys » basée sur « upstream/3.8 ».
    git checkout -b library-sys upstream/3.8

    # Vous pouvez maintenant travailler sur le fichier, typiquement en utilisant poedit.
    # Bien sûr, remplacez « library/sys.po » par le fichier que vous avez choisi précédemment
    poedit library/sys.po

    # Configurez poedit pour « ne pas préserver le formatage des
    # fichiers existants » (décochez la case), et indiquez une longueur
    # de ligne maximum de 79 caractères.

    # Quand vous avez fini de traduire, vous pouvez lancer *pospell* (pip install pospell).
    # Cet outil a été conçu pour vérifier si vous n'avez pas d'erreurs de français.
    # Vous pouvez exécuter la commande suivante : pospell -p dict -l fr_FR **/*.po pour vérifier
    # tous les fichiers ou remplacer **/*.po par le fichier que vous traduisez (recommandé).
    # Une liste blanche de certains termes techniques ou de noms propres, comme « Guido »,
    # « C99 » ou « sérialisable », est stockée dans le fichier « dict » à la racine du projet.
    # Vous pouvez bien sûr y ajouter une entrée si nécessaire.
    # pospell -p dict library/sys.po

    # Vous pouvez ensuite lancer *powrap* (pip install powrap) qui va reformater le fichier
    # que avez vous avez modifié à la longueur de ligne correcte de `79`.
    # Exécutez cette commande : `powrap **/*.po`, ou remplacez `**/*.po` par le fichier
    # que vous traduisez
    powrap library/sys.po

    # C'est le moment de git add et git commit
    git add -p  # C'est l'occasion de se relire, mais git add -u c'est bien aussi
    # ou même git add library/sys.po

    git commit -m "Traduction de library/sys.po"  # Ou un autre message plus inspiré :)

    # Poussez ensuite vos modifications sur votre fork Github.
    # Le -u n'est utile qu'une fois pour que votre client git se souvienne que cette
    # branche est liée à votre fork Github (et donc qu'un futur `git pull` sache quoi
    # tirer)
    git push -u origin

    # La commande précédente vous affichera un lien pour ouvrir une pull request sur
    # Github. Si vous l'avez manqué, allez simplement sur https://github.com/python/python-docs-fr/
    # et un joli bouton « Compare & pull request » devrait apparaître au bout de quelques secondes
    # vous indiquant que vous pouvez demander une pull request.

    # À partir de là, quelqu'un passera en revue vos modifications, et vous voudrez
    # probablement corriger les erreurs qu'ils auront trouvé. Retournez alors sur votre
    # branche (au cas où vous auriez commencé quelque chose d'autre sur une autre branche) :
    git checkout glossary
    git pull  # pour rapatrier les modifications que vous auriez accepté
              # sur l'interface web.
    # Réglez les problèmes, puis commitez à nouveau :
    git commit -a -m "glossaire : petites corrections".
    git push


Vous avez peut-être remarqué que cela ressemble à un triangle, avec un
segment manquant :

- Vous récupérez depuis *upstream* (le dépôt commun public sur Github)
- Vous poussez sur *origin* (votre clone sur Github)

Donc oui, c'est le travail de quelqu'un d'autre d'ajouter le dernier segment,
de votre *origin* au *upstream* public, pour « boucler la boucle ». C'est le
rôle des personnes qui *fusionnent* les *pull requests* après les avoir relues.

Vous avez peut-être aussi remarqué que vous n'avez jamais commité sur une
branche de version (``3.7``, ``3.8``, etc.), seulement récupéré les
modifications à partir d'elles. Considérez-les comme étant en lecture seule,
vous éviterez les problèmes.

Avant de valider, vous devriez utiliser `grammalecte
<https://grammalecte.net/>`_ pour vérifier vos traductions.


Toutes les traductions doivent être faites sur la dernière version.
Nous ne traduisons jamais sur une version plus ancienne. Par exemple,
si la dernière version de python est Python 3.8, nous ne voulons pas
traduire directement sur la version python 3.5.
Si nécessaire, les traductions seraient rétroportées sur les versions
les plus anciennes par l'`équipe de documentation
<https://www.python.org/dev/peps/pep-8015/#documentation-team>`_.


Que traduire ?
~~~~~~~~~~~~~~

Vous pouvez commencer par des tâches faciles comme réviser les entrées
*fuzzy* pour aider à garder la documentation à jour (trouvez les entrées
*fuzzy* l'aide de `make fuzzy`).

Vous pouvez également relire les entrées déjà traduites, et enfin
traduire celles qui ne sont pas traduites (trouvez-les à l'aide de
`make todo`)...

- Ne traduisez pas le contenu de ``:ref :...`` et ``:term :...``.
- Mettez les mots anglais, si vous devez les utiliser, en *italique*
  (entourés par des astérisques).
- ``::`` à la fin de certains paragraphes doivent être traduits en `` :
  ::`` en français pour placer l'espace avant les deux-points.
- Si vous traduisez un titre de lien, veuillez traduire le lien aussi.
  (surtout si c'est un lien Wikipédia et que l'article a une traduction).
  Si aucune traduction de la cible n'existe, ne traduisez pas le titre.
- Les guillemets français ``«`` et ``»`` ne sont pas identiques aux
  guillemets anglais ``"``. Cependant, Python utilise les guillemets
  anglais comme délimiteurs de chaîne de caractères. Il convient donc de
  traduire les guillemets mais pas les délimiteurs de chaîne.

Le cas de « --- »
~~~~~~~~~~~~~~~~~

La version anglaise utilise une chose nommée `smartquotes
<http://docutils.sourceforge.net/docs/user/smartquotes.html>`_, qui
essaie d'être intelligente, qui fonctionne en anglais, mais cause
rapidement des problèmes dans d'autres langues.
Nous l'avons donc désactivée.

Les *smartquotes* sont également responsables de la transformation de
``--`` en *en-dash* (``-``), de ``-----`` en *em-dash* (``—``), et de
``...`` en ``…``.

Comme nous n'avons pas de *smartquotes*, nous devrons également « traduire »
cela manuellement, donc si vous voyez ``---`` en anglais, vous devez le
transformer en ``—`` en français.


Le cas de « :: »
~~~~~~~~~~~~~~~~

Du point de vue du langage *reStructuredText* (ou *rst*) utilisé dans la documentation :

=> ``::`` collé à la fin d'un mot signifie « affiche ``:`` et introduit un bloc de code »,
mais un ``::`` après une espace signifie « introduit juste un bloc de code ».

Donc, dans du *rst*, en anglais, nous voyons soit « bla bla:: », soit « bla bla. :: ».

En français, nous mettons une espace insécable devant nos deux-points, comme :
« Et voilà : ».

L'utilisation de l'espace insécable en *rst* est naturelle, vous n'aurez qu'à
écrire ``Et voilà ::``. Le ``::`` n'est pas précédé d'un espace normal,
il affichera les deux-points et introduira le bloc de code, et c'est bon.

Si vous ne savez pas comment taper une espace insécable, il y a une astuce :
lisez celle de la touche *compose* dans la section suivante ; sinon :

=> Traduisez ``deux-points deux-points`` par
``espace deux-points espace deux-points deux-points``.

Les caractères ``espace deux-points`` sont restitués tel quel,
c'est du français correct, et la balise ``espace deux-points deux-points`` qui
suit n'affichera rien et introduira le bloc de code.

Dans un ``.po`` ça donne : `` : ::``

Non ! Ça n'insère pas magiquement une espace insécable donc ce n'est toujours pas
vraiment du français valide.

Oui ! il vaut mieux apprendre à taper les espaces insécables.


Utilisation du futur
~~~~~~~~~~~~~~~~~~~~

Dans la description du comportement de Python (au sens large, c'est-à-dire
l'interpréteur lui-même mais aussi toutes les bibliothèques), la version
originale utilise souvent le futur : « if you do this, il will produce that … ».
En français, l'utlisation du présent convient tout à fait et le présent est
souvent plus facile à lire : « si vous faites ceci, il se produit cela … ».
On ne conserve le futur que si la deuxième proposition se situe réellement
dans le futur (par exemple, on peut penser qu'un processus de compilation n'est
pas immédiat) ou pour des raisons de concordance des temps.

Traduction de *should*
~~~~~~~~~~~~~~~~~~~~~~

La version originale est très polie envers le lecteur ; elle lui intime
rarement des obligations, préférant employer « you should ». Cependant, en
français, il est d'usage d'être plus direct pour être correctement compris :
« vous devez ». *Vous devriez* est en effet généralement compris comme quelque
chose dont l'on peut de temps en temps se passer, alors que c'est très
rarement le cas pour les « you should » de cette documentation.

Comment saisir des em-dash, des ellipses, des guillemets français, ou des espaces insécables ?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Malheureusement, cela dépend de votre système d'exploitation et de votre clavier.

=> Sous Linux/Unix/\*BSD (tel OpenBSD), vous pouvez utilisez une
`Touche de composition <https://fr.wikipedia.org/wiki/Touche_de_composition>`_,
c'est facile à configurer à l'aide de l'outil graphique de configuration de votre
clavier ou via ``dpkg-reconfigure keyboard-configuration``
(pour Ubuntu ou Debian et distributions assimilées)

À minima, vous pouvez configurer votre fichier '~/.Xmodmap' pour ajouter l'équivalent de :

.. code-block:: shell

    # key Compose
    keycode 115 = Multi_key


Utilisez ``xev`` pour connaitre la bonne correspondance de la touche que vous
voulez assigner !

Ensuite, dans votre fichier '~/.xsession', ajoutez :

.. code-block:: shell

    # Gestion des touches clavier
    xmodmap $HOME/.Xmodmap


Sous X, avec un bureau graphique, tel que Gnome, ou Xfce, il faut aller modifier
dans les paramètres > clavier > Disposition : puis 'Touche composée'.
Pour finir, redémarrez votre session.

=> Sous Windows, vous
pouvez utiliser `wincompose <https://github.com/SamHocevar/wincompose>`_.

Avec une touche de composition (personnellement j'utilise ``alt-gr``,
vous pouvez aussi utiliser ``verr maj 🔒``), vous pouvez utiliser les
compositions suivantes :

- Composer ``<`` ``<`` donne ``« ``
- Composer ``>`` ``>`` donne `` »``
- Composer espace espace donne une espace insécable
- Composer ``.`` ``.`` ``.`` donne ``…``

Comme vous l'avez noté, presque toutes les compositions sont faciles
à retenir, vous pouvez donc essayer les autres et elles devraient tout
simplement fonctionner :

- Composer ``C`` ``=`` donne ``€``
- Composer ``1`` ``2`` donne ``½``
- Composer ``'`` ``E`` donne ``É``
- … …


Où obtenir de l'aide ?
~~~~~~~~~~~~~~~~~~~~~~

Le coordinateur de cette traduction est `mdk <https://mdk.fr/>`_.

N'hésitez pas à poser vos questions sur le canal ``#python-fr`` sur `freenode
<https://webchat.freenode.net/>`_ (ne nécessite pas d'inscription) ou sur la
`liste de diffusion des traductions de l'AFPy <https://lists.afpy.org/mailman/listinfo/traductions>`_.


Ressources de traduction
------------------------

- le canal IRC `#python-fr <http://irc.lc/freenode/python-fr>`_ sur freenode ;
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
- `deepl.com/translator <https://www.deepl.com>`_ ;
- `Petites leçons de typographie <https://jacques-andre.fr/faqtypo/lessons.pdf>`_,
  résumé succint de typographie, utile pour apprendre le bon usage des majuscules,
  des espaces, etc.


Glossaire
---------

Afin d'assurer la cohérence de nos traductions, voici quelques propositions et
rappels pour les termes fréquents à traduire, n'hésitez pas à ouvrir un ticket
si vous n'êtes pas d'accord.

Pour trouver facilement comment un terme est déjà traduit dans notre documentation,
vous pouvez utiliser
`find_in_po.py <https://gist.github.com/JulienPalard/c430ac23446da2081060ab17bf006ac1>`_.

========================== ===============================================
Terme                      Traduction proposée
========================== ===============================================
-like                      -compatible
abstract data type         type abstrait
argument                   argument (à ne pas confondre avec *paramètre*)
backslash                  antislash, *backslash*
bound                      lier
bug                        bogue, *bug*
built-in                   native
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
et al.                     et autre, `à accorder
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
underscore                 tiret bas, *underscore*
========================== ===============================================


Historique du projet
--------------------

Ce projet a été lancé `vers 2012
<https://github.com/AFPy/python_doc_fr/commit/b77bdff59036b6b6b5a4804d5f519ce3ea341e027c>`_
par des membres de l'`AFPy <https://www.afpy.org/>`_. En 2017 ce projet
est devenu la traduction officielle de la documentation Python en français
grâce à la `PEP 545 <https://www.python.org/dev/peps/pep-0545/>`_.


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
