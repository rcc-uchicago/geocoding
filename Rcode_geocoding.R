#Geocoding Workshop
#load up the ggmap library
library(ggmap)
#https://maps.googleapis.com/maps/api/geocode/json?address=baylor+university&key=xxx
library(tidyverse)
library(tmaptools)

setwd("D:\\Dropbox\\4#Research\\Uchicago\\WORKSHOP\\geocoding")

gkey = "AIzaSyCa9_mrD7EwhR5MUJx_uX62O0CiXoVLUaw"
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
osmcode<-geocode_OSM(data[,"addr"])


#Merged together
cmbdloc<-  merge(gcode, osmcode[,(1:3)], by.x="addr", by.y = "query", all.x = T, suffixes = c(".google", ".osm"))

#read the RCC geocoder file and merge it
esrigc<-read.csv("us_address_-_Copy_1558387447_geocoded.csv")
cmbdloc<- merge(cmbdloc, esrigc[, c(1,5:7)], by="ADDRESS")


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

