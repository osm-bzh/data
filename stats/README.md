# Suivi statistiques des langues minoritaires dans OSM

## Principe

Ce script python interroge le service français de TagInfo (https://taginfo.openstreetmap.fr/api/4/) afin d'obtenir des statistiques sur le nombre d'objets dans OSM concernés par des langues minoritaires.

Voir http://wiki.openstreetmap.org/wiki/FR:Noms_multilingues


## Installation

```python
python3 -m venv venv
source venv/bin/activate
python3 -m pip install -r requirements.txt
```


## Utilisation

`python locale_names_monitor.py`

Les statistiques sont écrites dans le fichier CSV `stats_locale_names.csv`


## automatisation

Le script `maj_stats_osm_locales.bash` permet d'automatiser l'exécution du script python en l'installant dans cron.

```bash
# stats OSM
0 8 2 * * /data/projets/osm-bzh-data/stats/maj_stats_osm_locales.bash > /data/projets/osm-bzh-data/stats/maj_stats_osm.log
```

On le fait exécuter le 2 de chaque mois pour avoir des données du 1er.

## Production

Le script est actuellement installé sur le serveur bed niverel dans le container bed110

