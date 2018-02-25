#!usr/local/bin/python
# -*- coding: utf-8 -*-
#-------------------------------------------------------------------------------
# Name:        local names stats monitor
#
# Author:      Maël REBOUX
#
# Created:     09/2017
# Licence:     GNU GPL 3
#
#  this script make request to the french TagInfo OSM server  https://taginfo.openstreetmap.fr/api/4/
#  to get this stats on local name tags. see  http://wiki.openstreetmap.org/wiki/FR:Noms_multilingues
#
#		langages :  
#			br = breton
#			eu = basque
#			oc = occitan
#			gsw = alsacien
#			ca = catalan
#			co = corse
#			frp = arpitan / franco-provençal
#			gcf = créole guadeloupéen
#			gyn = créole guyanais
#			gcr = créole réunionnais
#			vls = flamand
#			frk = francique
#			ty = tahitien
#			fr-x-gallo = gallo
#			fr-x-norman = normand
#		tags :
#			name:{code}
#			source:name:{code}
#
#
#-------------------------------------------------------------------------------


import array
import urllib2
import json
import datetime


#  set langages array
langs = ["br", "eu", "oc", "gsw", "ca", "co", "frp", "vls", "frk", "fr-x-gallo", "fr-x-norman", "name:fr-x-fc", "gcf", "gyn", "gcr", "ty"]
#langs = ["br"]

# open the CSV file
f_csv = open('stats_locale_names.csv','a')
#f_csv = open('test.csv','a')

# get the today date
now = datetime.datetime.now()
dday = now.strftime("%Y-%m-%d")


# only one taginfo service for the moment
taginfo_service = "taginfo org"

# loop on each langage

for lang in langs :
	print "+++++++++++++++++++++++++++++++++++++++++++"
	print "   " + lang

	# get name:{code} stats in JSON
	req = urllib2.Request("https://taginfo.openstreetmap.org/api/4/key/stats?key=name%3A" + lang + "&sortname=&sortorder=")
	opener = urllib2.build_opener()
	f = opener.open(req)
	json_name = json.loads(f.read())
	
	name_object_count = str(json_name['data'][0]['count'])
	name_values_count = str(json_name['data'][0]['values'])
	name_users_count = ''

	print "   name:" + lang + " : " + name_object_count + " | " + name_values_count  + " | " + name_users_count


	# get source:name:{code} stats in JSON
	req = urllib2.Request("https://taginfo.openstreetmap.org/api/4/key/stats?key=source%3Aname%3A" + lang + "&sortname=&sortorder=")
	opener = urllib2.build_opener()
	f = opener.open(req)
	json_src_name = json.loads(f.read())
	
	src_name_object_count = str(json_src_name['data'][0]['count'])
	src_name_values_count = str(json_src_name['data'][0]['values'])
	src_name_users_count = ''

	print "   source:name:" + lang + " : " + src_name_object_count + " | " + src_name_values_count  + " | " + src_name_users_count


	# write stats in the CSV file
	f_csv.write(dday +","+ taginfo_service +","+ lang +","+ name_object_count +","+ name_values_count +","+ name_users_count +","+ src_name_object_count +","+ src_name_values_count +","+ src_name_users_count +"\n")


	# get source:name values for survey
	#req = urllib2.Request("https://taginfo.openstreetmap.fr/api/4/key/values?key=source:name:br&filter=all&lang=fr&sortname=count&sortorder=desc&page=1&rp=21&qtype=value")
	#opener = urllib2.build_opener()
	#f = opener.open(req)
	#json_src_name_values = json.loads(f.read())
	#print json_src_name_values


# close the CSV file
f_csv.close

