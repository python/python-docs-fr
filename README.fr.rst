Traduction française de la documentation Python
===============================================

|build| |progression|

.. |build| image:: https://travis-ci.org/python/python-docs-fr.svg?branch=3.7
   :target: https://travis-ci.org/python/python-docs-fr
   :width: 45%

.. |progression| image:: https://img.shields.io/badge/dynamic/json.svg?label=fr&query=%24.fr&url=http%3A%2F%2Fgce.zhsj.me%2Fpython/newest
   :width: 45%


Accord de Contribution à la Documentation
-----------------------------------------

NOTE CONCERNANT LA LICENCE POUR LES TRADUCTIONS : La documentation de Python
est maintenue grâce à un réseau mondial de bénévoles. En publiant ce projet
sur Transifex, Github, et d'autres endroits publics, et vous invitant
à participer, nous vous proposons un accord qui vous permettra de
fournir vos améliorations à la documentation de Python ou à la traduction
de la documentation de Python pour l'utilisation de PSF sous licence CC0
(disponible à l'adresse
https://creativecommons.org/publicdomain/zero/1.0/legalcode). En retour,
vous pouvez demander publiquement un crédit pour la partie de la documentation
que vous avez contribué à traduire et si votre traduction est acceptée par la
PSF, vous pouvez (mais vous n'êtes pas obligé) soumettre un patch incluant une
annotation appropriée dans le fichier Misc/ACKS ou TRANSLATORS. Bien que
rien dans le présent Accord de Contribution à la Documentation n'oblige la PSF
à incorporer votre contribution textuelle, votre participation à la communauté
Python est bienvenue et appréciée.

Vous signifiez votre acceptation de cet accord en soumettant votre travail à
la PSF pour inclusion dans la documentation.


Contribuer à la traduction
--------------------------

Comment contribuer
~~~~~~~~~~~~~~~~~~

Vous pouvez contribuer en utilisant :

- github (solution préférée)
- `transifex <https://www.transifex.com/python-doc/public/>`_
- Ou simplement en ouvrant `un ticket sur github <https://github.com/python/python-docs-fr/issues>`_


Contribuer en utilisant Github
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prérequis :

- Un compte `github <https://github.com/join>`_.
- ``git`` `installé <https://help.github.com/articles/set-up-git/>`_ (pour Windows, voir
  https://gitforwindows.org/).
- Un éditeur de fichier ``.po`` (Utilisez `poedit <https://poedit.net/>`_
  si vous n'en avez pas déjà un).


Commencer :

Vous aurez besoin de forker le dépôt des sources `python-docs-fr
<https://github.com/python/python-docs-fr>`_ en cliquant sur son boutton
``Fork``. Ceci crée une copie du projet sur votre compte github : un endroit
où vous avez le droit de faire des modifications.

Étape par étape :

.. code bloc:: bash

    # Clonez votre fork github avec `git` en utilisant ssh :
    git clone git@github.com:YOUR_GITHUB_USERNAME/python-docs-fr.git
    *OU* HTTPS :
    git clone https://github.com:YOUR_GITHUB_USERNAME/python-docs-fr.git

    # Allez dans le répertoire cloné :
    cd python-docs-fr/

    # Ajoutez le dépot upstream (le dépôt public) en utilisant HTTPS (git
    # ne demandera pas de mot de passe ainsi) :
    # Ceci permet à git de savoir quoi/où est *upstream*
    git remote add upstream https://github.com/python/python-docs-fr.git

Ensuite, vous devez trouver un fichier sur lequel travailler.
Vous pouvez utiliser `potodo <https://github.com/seluj78/potodo>`_, un outil fait pour trouver des fichiers ``po``
à traduire.
Installez-le à l'aide de pip (``pip install potodo``) dans un environnement
``python3.6`` ou plus.
Lancez ensuite la commande ``potodo`` dans votre clone local.
Vous pouvez choisir n'importe quel fichier non réservé dans la liste renvoyée
par la commande.

**Nous vous recommandons de ne pas commencer avec un fichier de ``c-api`` car c'est très technique.**

Une fois que vous avez choisi un fichier sur lequel travailler, veuillez
ouvrir un `ticket sur github <https://github.com/python/python-docs-fr>`_ dans
le format `Je travaille sur RÉPERTOIRE/FICHIER.po`. Ceci permet à ``potodo``
de détecter via l'API github les fichiers ``.po`` réservés dans les tickets et
les *pull requests*.

Vous êtes maintenant prêt à commencer une session de travail. Chaque
fois que vous commencerez un nouveau fichier, commencez ainsi :

.. code bloc:: bash

    # Pour travailler, nous aurons besoin d'une branche, basée sur une version à jour (fraîchement récupérée)
    # de la branche upstream/3.7. Nous appellerons notre branche "library-sys" mais vous pouvez appeller la vôtre
    # ce que vous voulez. En général, vous nommez une branche en fonction du fichier sur lequel vous travaillez.
    # Par exemple, si vous travaillez sur "library/venv.po", vous pouvez nommer votre branche "library-venv".

    # Mettez à jour votre version locale
    git fetch upstream
    # Créez une nouvelle branche nommée "library-sys" basée sur "upstream/3.7".
    git checkout -b library-sys upstream/3.7

    # Vous pouvez maintenant travailler sur le fichier, typiquement en utilisant poedit,
    # Bien sûr, remplacez "library/sys.po" par le fichier que vous avez choisi précédemment
    poedit library/sys.po

    # Quand vous avez fini de traduire, vous pouvez lancer pospell (pip install pospell).
    # Cet outil a été conçu pour vérifier si vous n'avez pas d'erreurs de français.
    # Vous pouvez exécuter la commande suivante : pospell -p dict -l fr_FR **/*.po pour vérifier tous les fichiers
    # ou remplacez **/*.po par le fichier que vous traduisez (recommandé).

    # Vous pouvez ensuite lancer powrap (pip install powrap) qui va refformater
    # le fichier que avez vous avez modifié à la longueur de ligne correcte de `80`.
    # Exécutez cette commande : `powrap **/*.po`, ou remplacez `**/*.po` par le fichier
    # que vous traduisez

    # Poussez ensuite vos modifications sur votre fork Github,
    # comme ce sont des branches éphémères, ne configurons pas git pour les suivre toutes,
    # "origin HEAD" est une syntaxe "spéciale" pour dire "pousse sur origin,
    # sur une branche du même nom que la branch locale",
    # c'est pratique car c'est exactement ce que nous voulons :
    git push origin HEAD

    # La commande précédente vous affichera un lien pour ouvrir une pull request sur Github.
    # Si vous l'avez manqué, allez simplement
    # https://github.com/python/python-docs-fr/ et une joli boutton "Compare & pull request"
    # devrait apparaître au bout de quelques secondes vous indiquant que vous pouvez demander
    # une pull request

    # À partir de là, Quelqu'un passera en revue vos modifications, et vous voudrez probablement
    # corriger les erreurs qu'ils auront trouvé, alors retournez sur votre branche
    # (au cas où vous auriez commencé quelque chose d'autre sur une autre branche) :
    git checkout glossary
    # Réglez les problèmes, puis commitez à nouveau :
    git commit -a -m "glossaire : petites corrections".
    git push origin HEAD

Vous avez peut-être remarqué que cela ressemble à un triangle, avec un segment
manquant :

- Vous récupérez depuis *upstream* (le dépôt commun public sur Github)
- Vous poussez sur *origin* (votre clone sur Github)

Donc oui, c'est le travail de quelqu'un d'autre d'ajouter le dernier segment,
de votre fichier au public en amont, pour "boucler la boucle ", c'est le rôle
des personnes qui *fusionnent* les pull request après les avoir relues.

Vous avez peut-être aussi remarqué que vous n'avez jamais commité sur une
branche de version(``3.6``, ``3.7``, ...), seulement les récupé les
modifications à partir d'elles. Considérez-les comme étant en lecture seule,
vous éviterez les problèmes.

Avant de valider, vous devez utiliser `grammalecte
<https://grammalecte.net/>`_ pour vérifier vos traductions.


Toutes les traductions doivent être faites sur la dernière version.
Nous ne traduisons jamais sur une version plus ancienne. Par exemple, si la dernière version de python
est Python 3.7, nous ne voulons pas traduire directement sur la version python 3.5.
Si nécessaire, les traductions seraient rétroportées sur les versions les plus anciennes par la fonction
Équipe de documentation <https://www.python.org/dev/peps/pep-8015/#documentation-team>`.
