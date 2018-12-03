


SELECT osm_id, place as type, MAX(admin_level) as admin_level, name, name_eu, source_name_eu, admincode, postcode, wikidata, ST_X(ST_Transform(way,4326)) as x, ST_Y(ST_Transform(way,4326)) as y, ST_Transform(way,4326) as way
FROM
(
    -- communes
    (WITH
        p AS (
            SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way
            FROM planet_osm_point 
            WHERE place IN ('village','town')
            AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) )
        SELECT p.osm_id, p.place, 1 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way
        FROM planet_osm_rels AS r, p
        WHERE
            r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,8' 
            AND p.admin_centre_id = ANY(members)
            -- ceci pour forcer l'utilisation des indexes
            AND ARRAY[p.osm_id] && parts
    )
    -- chefs-lieux de canton
    UNION
    (WITH
        p AS (
            SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way
            FROM planet_osm_point 
            WHERE place IN ('village','town')
            AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) )
        SELECT p.osm_id, p.place, 2 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way
        FROM planet_osm_rels AS r, p
        WHERE
            r.members::text ~ 'admin_centre' AND r.tags::text ~ 'political_division,canton'
            AND p.admin_centre_id = ANY(members)
            AND ARRAY[p.osm_id] && parts
    )
    -- sous-préfectures
    UNION
    (WITH
        p AS (
            SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way
            FROM planet_osm_point 
            WHERE place IN ('village','town')
            AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) )
        SELECT p.osm_id, p.place, 3 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way
        FROM planet_osm_rels AS r, p
        WHERE
            r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,7' 
            AND p.admin_centre_id = ANY(members)
            AND ARRAY[p.osm_id] && parts
    )
    -- préfectures
    UNION
    (WITH
        p AS (
            SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way
            FROM planet_osm_point 
            WHERE place IN ('town','city')
            AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) )
        SELECT p.osm_id, p.place, 4 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way
        FROM planet_osm_rels AS r, p
        WHERE
            r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,6' 
            AND p.admin_centre_id = ANY(members)
            AND ARRAY[p.osm_id] && parts
    )
) AS query
GROUP BY osm_id, place, name, name_eu, source_name_eu, admincode, postcode, wikidata, way
ORDER BY admin_level DESC, name ASC


-- minify
SELECT osm_id, place as type, MAX(admin_level) as admin_level, name, name_eu, source_name_eu, admincode, postcode, wikidata, ST_X(ST_Transform(way,4326)) as x, ST_Y(ST_Transform(way,4326)) as y, ST_Transform(way,4326) as way FROM ((WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('village','town') AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) ) SELECT p.osm_id, p.place, 1 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,8'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) UNION (WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('village','town') AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) ) SELECT p.osm_id, p.place, 2 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'political_division,canton'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) UNION (WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('village','town') AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) ) SELECT p.osm_id, p.place, 3 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,7'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) UNION (WITH p AS (SELECT osm_id, CONCAT('n',osm_id) as admin_centre_id, place, name, COALESCE(tags -> 'name:eu'::text,'') as name_eu, COALESCE(tags -> 'source:name:eu'::text,'') as source_name_eu, COALESCE(tags -> 'ref:INSEE'::text,'') as admincode, COALESCE(tags -> 'addr:postcode'::text,'') as postcode, COALESCE(tags -> 'wikidata'::text,'') as wikidata, way FROM planet_osm_point WHERE place IN ('town','city') AND way && ST_MakeEnvelope (-588292, 5083863, 25284, 5418361, 3857) ) SELECT p.osm_id, p.place, 4 as admin_level, p.name, p.name_eu, p.source_name_eu, p.admincode, p.postcode, p.wikidata, p.way FROM planet_osm_rels AS r, p WHERE r.members::text ~ 'admin_centre' AND r.tags::text ~ 'admin_level,6'AND p.admin_centre_id = ANY(members) AND ARRAY[p.osm_id] && parts ) ) AS query GROUP BY osm_id, place, name, name_eu, source_name_eu, admincode, postcode, wikidata, way ORDER BY admin_level DESC, name ASC
