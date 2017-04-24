#!/bin/bash

# on efface

rm *.gml
rm *.xsd

# export de données spécifiques contenant les name:br

ogr2ogr -progress -f "GML" ./osm_admin_places.gml PG:"host=localhost user=osm password=osmbr dbname=osm" "osm_admin_places"
ogr2ogr -progress -f "GML" ./osm_places.gml PG:"host=localhost user=osm password=osmbr dbname=osm" "osm_places"
ogr2ogr -progress -f "GML" ./osm_roads.gml PG:"host=localhost user=osm password=osmbr dbname=osm" "osm_roads"
ogr2ogr -progress -f "GML" ./osm_waterareas.gml PG:"host=localhost user=osm password=osmbr dbname=osm" "osm_waterareas"
ogr2ogr -progress -f "GML" ./osm_waterways.gml PG:"host=localhost user=osm password=osmbr dbname=osm" "osm_waterways"

# et on zippe

# la date du jour
dateAjd=$(date +"%Y%m%d")

zip osm_br_data_$dateAjd.zip osm_admin_places.gml osm_admin_places.xsd osm_places.gml osm_places.xsd osm_roads.gml osm_roads.xsd osm_waterareas.gml osm_waterareas.xsd osm_waterways.gml osm_waterways.xsd

