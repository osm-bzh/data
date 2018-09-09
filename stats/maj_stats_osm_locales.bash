#!/bin/bash

# 03/01/2018

# script exécuté par cron pour
# 1. exécuter un script python pour faire des stats sur taginfo de OSM
# 2. commiter et puller le fichier de stats mis à jour


cd /data/osm/osm-bzh-data/stats
python locale_names_monitor.py

git add stats_locale_names.csv
git commit -m 'maj mensuelle automatique'

git push 'https://{user}:{passwd}@github.com/osm-bzh/osm-bzh-data.git' master

