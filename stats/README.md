# Suivi statistiques des langues minoritaires dans OSM

## Principe

Ce script python interroge le service français de TagInfo (https://taginfo.openstreetmap.fr/api/4/) afin d'obtenir des statistiques sur le nombre d'objets dans OSM concernés par des langues minoritaires.

Voir http://wiki.openstreetmap.org/wiki/FR:Noms_multilingues

## Utilisation

`python locale_names_monitor.py`

Les statistiques sont écrites dans le fichier CSV `stats_locale_names.csv`


## automatisation

Le script `maj_stats_osm_locales.bash` permet d'automatiser l'exécution du script python en l'installant dans cron.

`# stats OSM
0 8 2 * * /data/scripts/maj_stats_osm_locales.bash > /data/scripts/maj_stats_osm.log`

On le fait exécuter le 2 de chaque mois pour avoir des données du 1er.
