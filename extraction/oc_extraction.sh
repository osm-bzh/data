#!/bin/bash

# this script performs data extraction

# destination files path
dest_path="/data/tiles/data/oc/"

# GeoJSON
echo "GeoJSON..."
ogr2ogr -f "GeoJSON" "/data/tiles/data/oc/osm_oc_municipalities.geojson" PG:'host=db.openstreetmap.world user=osmbr dbname=osm password=m4d31nbr31zh' -sql "SELECT osm_id, place as type, MAX(admin_level) as admin_level, name, name_oc, source_name_oc, admincode, postcode, wikidata, ST_X(ST_Transform(way,4326)) as x, ST_Y(ST_Transform(way,4326)) as y, ST_Transform(way,4326) as way FROM ((WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:oc'::text,'') as name_oc, COALESCE(tags -> 'source:name:oc'::text,'') as source_name_oc, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('village','town') AND way && ST_MakeEnvelope (-232022, 5198661, 868456, 5800362, 3857) ) SELECT p.osm_id, p.place, 1 as admin_level, p.name, p.name_oc, p.source_name_oc, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,8'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) UNION (WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:oc'::text,'') as name_oc, COALESCE(tags -> 'source:name:oc'::text,'') as source_name_oc, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('village','town') AND way && ST_MakeEnvelope (-232022, 5198661, 868456, 5800362, 3857) ) SELECT p.osm_id, p.place, 2 as admin_level, p.name, p.name_oc, p.source_name_oc, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'political_division,canton'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) UNION (WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:oc'::text,'') as name_oc, COALESCE(tags -> 'source:name:oc'::text,'') as source_name_oc, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('village','town') AND way && ST_MakeEnvelope (-232022, 5198661, 868456, 5800362, 3857) ) SELECT p.osm_id, p.place, 3 as admin_level, p.name, p.name_oc, p.source_name_oc, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,7'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) UNION (WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:oc'::text,'') as name_oc, COALESCE(tags -> 'source:name:oc'::text,'') as source_name_oc, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('town','city') AND way && ST_MakeEnvelope (-232022, 5198661, 868456, 5800362, 3857) ) SELECT p.osm_id, p.place, 4 as admin_level, p.name, p.name_oc, p.source_name_oc, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,6'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) ) AS query GROUP BY osm_id, place, name, name_oc, source_name_oc, admincode, postcode, wikidata, way ORDER BY admin_level DESC, name ASC"


# GeoJSON
echo "GeoJSON..."
ogr2ogr -f "GeoJSON" "/data/tiles/data/oc/osm_oc_municipalities.geojson" "/data/tiles/data/oc/osm_oc_municipalities.gml"


# CSV
echo "CSV..."
ogr2ogr -f "CSV" "/data/tiles/data/oc/osm_oc_municipalities.csv" "/data/tiles/data/oc/osm_oc_municipalities.gml"

