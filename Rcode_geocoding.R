#Geocoding Workshop
library(pacman)
#load up the ggmap library
p_load(ggmap)
#https://maps.googleapis.com/maps/api/geocode/json?address=baylor+university&key=xxx
p_load(tidyverse)
p_load(tmaptools)

setwd("F:\\GitHub\\geocoding")

#gkey = "AIzaSyCa9_mrD7EwhR5MUJx_uX62O0CiXoVLUaw"
gkey = "AIzaSyAUNVqt1iyBAk_kUuToHqxc5sXx2ZejvOk"
# save api key
register_google(key = gkey)

# get the input data
infile <- "us_address.csv"
data <- read.csv(infile)
#create a parsed column
data<-mutate(data, addr=paste(ADDRESS, CITY,  STATE, ZIPCODE, sep=','))


#geocode using google
gcode<-mutate_geocode(data, location=addr)

#geocode using OSM
#Similar to geocode from the ggmap package. It uses OpenStreetMap Nominatim. 
osmcode<-geocode_OSM(data[,"addr"])


#Merged together
cmbdloc<-  merge(gcode, osmcode[,(1:3)], by.x="addr", by.y = "query", all.x = T, suffixes = c(".google", ".osm"))

#read the RCC geocoder file and merge it
esrigc<-read.csv("address_1643749650_geocoded.csv")
cmbdloc<- merge(cmbdloc, esrigc[, c(1,2:4)], by.x = "addr", by.y ="ADDRESS" )


#create a function to calculate distance between lat and long
get_geo_distance = function(long1, lat1, long2, lat2) {
  loadNamespace("purrr")
  loadNamespace("geosphere")
  longlat1 = purrr::map2(long1, lat1, function(x,y) c(x,y))
  longlat2 = purrr::map2(long2, lat2, function(x,y) c(x,y))
  distance_list = purrr::map2(longlat1, longlat2, function(x,y) geosphere::distHaversine(x, y))
  distance_m = distance_list[[1]]

  return(distance_m)
}

#distance between esri - google and esri - osm
cmbdloc<-cmbdloc %>% rowwise() %>% mutate(google_esri=get_geo_distance(lon.google, lat.google, Longitude, Latitude),
                                 osm_esri=get_geo_distance(lon.osm, lat.osm, Longitude, Latitude))


#check the mean deviation
summary(cmbdloc$google_esri)
summary(cmbdloc$osm_esri)

#################################
#OpenStreetMap-Based Routing Service
#################################

p_load(osrm)
#Reading file from my box drive, these are 10 points (long, lat) in Germany
pts<-read.csv("https://uchicago.box.com/shared/static/sxg1hlb7vv4mmtrq3uzvxy2eujl7ckgh.csv")

#calculate drive time table
osrmTable(loc = pts)

#calculate drive time between source and destination
osrmTable(src = pts[1:5,], dst = pts[6:10,])

#calculate drive time and distance between source and destination
osrmTable(src = pts[1:5,], dst = pts[6:10,], measure = c('duration', 'distance'))

#For drive time and distance between only two points (eg. between 1 and 6)
osrmRoute(src = pts[1,], dst = pts[6,], overview=FALSE)

