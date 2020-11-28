Maintenance
-----------

Les commandes suivantes doivent être exécutées à partir de la racine d'un clone
de ``python-docs-fr`` et certaines s'attendent à trouver un clone de CPython
à jour à proximité :

.. code-block:: bash
  
  ~/
  ├── python-docs-fr/
  └── cpython/
  
  
Pour cloner CPython, vous pouvez utiliser :
  
.. code-block:: bash
  
  git clone --depth 1 --no-single-branch https://github.com/python/cpython.git
  
  
Ceci évite de télécharger tout l'historique (inutile pour générer la
documentation) mais récupère néanmoins toutes les branches.

.. code-block:: bash
  
  make merge

Dans certains cas on a besoin de propager des traductions d'une branche
à l'autre :
  
- d'une ancienne branche vers une nouvelle branche : lors du passage
  d'une version à l'autre de CPython, lorsque quelqu'un a une PR sur une
  ancienne version (*forward porting*) ;
- d'une nouvelle branche vers des anciennes branches : pour propager
  de temps en temps le travail sur d'anciennes versions (rétroportage
  ou *backporting*).
  
Pour forward-porter un ou plusieurs commits, il vaut mieux utiliser ``git
cherry-pick -x LE_SHA``, ça garde l'auteur, le sha1 d'origine, et
toutes les modifications.

Pour rétroporter « en gros » on utilise ``pomerge``\  : on le fait lire
sur une branche, puis écrire sur une autre, par exemple pour copier de
la 3.8 à la 3.7 :
  
.. code-block:: bash
  
    git fetch
    git checkout 3.8
    git reset --hard upstream/3.8
    pomerge --from-files *.po */*.po
    git checkout --branch back-porting upstream/3.7
    pomerge  --no-overwrite --to-files *.po */*.po
    powrap --modified
    git add --patch
    git commit --message="Backporting from 3.8"
    git push --set-upstream origin HEAD
  
  
Notes :
  
- j'utilise ``git fetch`` au début pour avoir *upstream/3.7* et
 *upstream/3.8* à jour localement, ainsi je peux travailler sans
  toucher au réseau jusqu'au ``git push``, mais chacun fait comme il
  veut ;
- j'utilise ``*.po */*.po`` et pas ``**/*.po``, car si vous avez un
  *venv* dans l'arborescence il va vous trouver des traductions de Sphinx
  et peut-être d'autres paquets dans ``.venv/lib/python*/`` (et mettre
  beaucoup plus de temps) ;
- j'utilise ``pomerge --no-overwrite``, ça indique à ``pomerge`` de
  n'écrire que si le ``msgstr`` est vide, donc de ne pas modifier
  l'existant, ainsi il est impossible de casser quelque chose.
  On peut le tenter sans ``--no-overwrite``, attention, ça fait
  des bêtises, ça nécessite une relecture attentive :
  certaines traductions, comme *example:* sont en parfois traduites en
  français avec une majuscule, et parfois non, en
  fonction du contexte, ``pomerge`` uniformiserait ça, ce n'est pas bien ;
- attention, si vous testez sans ``--no-overwrite``, il est peut-être
  bon de vider la mémoire de ``pomerge`` avant la lecture, pour éviter
  de lui faire écrire des choses lues lors des sessions précédentes,
  via un ``rm -f ~/.pomerge.json``\  ;
- j'utilise ``git add --patch`` (ou ``-p``) car j'aime bien relire quand même,
  en général, je n'ajoute pas les différences d'ordre dans les entêtes,
  mais un ``git add --update`` irait très bien ;
- attention au fichier *dict* auquel il peut manquer des lignes.

