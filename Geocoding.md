---

title: Geocoding.md
---



![](img/Geocoding0.jpg)

# **Hands-on workshop on Geo-coding** 
 **Feb 1, 2022**

**Parmanand Sinha, PhD** 

**Computational Scientist, RCC** 

![](img/Geocoding2.png)

------

# Topics

TIGER Basics

Geocoding vs\. Address Matching

Online Geocoders

Geocoding Errors

## __Hands on Training I__

* RCC Geocoder, Google Geocoder API, and OSM Geocoder
* Comparison

## __Hands on Training II__
* Offline Geocoding in Midway2
------


**TIGER = Topologically Integrated Geographic Encoding and Referencing**

![](img/Geocoding3.png)

<span style="color:#C00000">Initial TIGER database created in 1990</span>

------

# TIGER Basics

  * A system for recording the location of geographic features associated with U\.S\. Census\.
  * The system includes the location and attributes of census related point\, line and area features\.

* What information is stored?
    * Census Feature Class Codes \(CFCC\)
      * Road = A\, Transport terminal = D
    * Census geography \(Federal Information Processing Standard\- FIPS\)
      * E\.g\. State\, county\, census tract
    * Feature name
    * Address range
    * Source material

![](img/Geocoding4.png)

------

# Geocoding
* The process of finding the location of an address on a map\.
* The location can be a pair of \(X\, Y\) coordinate or a street address\, postal delivery location\, or building\.
  * X – longitude \(\+ for E hemisphere; \- for W hemisphere\)
  * Y – latitude \(\+ for N hemisphere; \- for S hemisphere\)
* In GIS\, geocoding requires a reference dataset that contains address attributes for the geographic features in the area of interest\.

![](img/Geocoding5.jpg)

------


# Address Matching

The process of relating two or more data files using a common address field\.

A process that compares an address or a table of addresses to the address attributes of a reference dataset to determine whether a particular address falls within an address range associated with a feature in the reference dataset\.

If an address falls within a feature's address range\, it is considered a match and a location can be returned\.

------

![](img/Geocoding7.png)

Address

database

------

* What is address matching?
  * Address matching is the process of assigning an actual address to a geographic location / area based on some reference files\.
* Common reference files
  * A  <span style="color:#FF0000"> __point/polygon__ </span>  reference file where each feature contains <span style="color:#FF0000"> __ __ </span>  <span style="color:#FF0000"> _discrete address location_ </span>
  * E\.g\. Parcel or parcel centroids
  * A  <span style="color:#FF0000"> __point/polygon__ </span>  reference file where each feature contains  <span style="color:#FF0000"> _a series of address locations_ </span>
  * E\.g\. Zip \+ 4
  * A  <span style="color:#FF0000"> __line __ </span> reference file where each feature contains  <span style="color:#FF0000"> _address ranges_ </span>
  * E\.g\. TIGER roads \(streets\)

------

Zip code boundaries / centroids as geographic reference

![](img/Geocoding8.png)

------

Zip code \+ 4 as geographic reference

![](img/Geocoding9.png)

------

Parcel Boundaries – polygons with a discrete address

![](img/Geocoding10.png)

------

Parcel Centroids – points with a discrete address

![](img/Geocoding11.jpg)

------

TIGER roads – line file with address ranges and directional information

![](img/Geocoding12.png)

------

![](img/Geocoding13.jpg)

------

# Parsing Addresses – breaking up street addresses into component pieces, i.e., prefix, number, name, type, and suffix

![](img/Geocoding14.jpg)

------

# Address Matching

![](img/Geocoding15.png)        ![](img/Geocoding16.png)

------

\-\-\- Both X and Y need to be interpolated allocate the address\. Linear Interpolation means addresses are arranged proportionally\.

Where is 2200 Gervais Street?

![](img/Geocoding17.png)

Which is the best?

**<span style="color:#FF0000">Depends on what reference file you used\!</span>**

------

# Geocoders

| Local | Online |
| :-: | :-: |
| Local geocoder (city of Chicago Geostreets )<br />Create geocoder based on street centerlines<br /><br />ESRI street map premium<br /> | U.S. Census Geocoder<br />OSM<br />ESRI World Geocoder<br />OpenCage<br />Texas A&M Geoservices<br />SAS Proc Geocode<br />Google/Bing/Mapquest API<br /> |

------

# ESRI

# ESRI World Geocoder

* Pros:
  * Most accurate option
  * Fast processing
* Cons:
  * Expensive and difficult credit system
  * Higher learning curve than alternatives

![](img/Geocoding18.jpg)

------

# Google/Bing/Mapquest API

* Pros:
  * Can use Stata\. R\, and other tools
  * Many are already be familiar withthese services
* Cons:
  * Limited free queries per IP per day
  * Less transparent on quality of matches
  * Enterprise API key is expensive

<img src="img/Geocoding19.jpg" style="zoom: 25%;" />

<img src="img/Geocoding20.png" style="zoom:25%;" />

<img src="img/Geocoding21.jpg" style="zoom:25%;" />

------

# U.S. Census Geocoder

* Pros:
  * Completely free
  * Easy to use
* Cons:
  * Limited to 1\,000 addresses
  * Lower accuracy than alternatives

<img src="img/Geocoding22.jpg" style="zoom:33%;" />

------

# SAS Proc Geocode

* Pros:
  * Free \(inside UI\)
  * Handles unlimited addresses
* Cons:
  * Basic knowledge of SAS required
  * Lower accuracy than alternatives

<img src="img/Geocoding23.png" style="zoom:33%;" />

------

# OSM

* Pros:
  * Free
  * Across the globe coverage
  * Setup local server
* Cons:
  * Lower accuracy than alternatives

![](img/Geocoding24.jpg)

------

# Local Geocoders

* Pros:
  * Highly accurate
  * Usually free to use
* Cons:
  * Limited to a single city
  * Need to create or learn for each city

![](img/Geocoding25.jpg)

------

![](img/Geocoding26.png)

------

# Local Geocoders: StreetMap Premium

* Pros:
  * Highly accurate
  * One time cost
* Cons:
  * Expensive\, need to purchase separate dataset for each state

<img src="img/Geocoding27.png" style="zoom:50%;" />

------

# Hybrid Geocoding Approach Example 


__100,000 addresses__: Start with the cheapest option

**OSM:** 20,000 unsuccessful and

**ESRI:** 2,000 unsuccessful geocodes

**Googlemap API:** 120 unsuccessful geocodes

__99,880 successful geocodes__


------

![](img/Geocoding30.png)

------

# RCC-GIS Geocoding Service

[https://gis\.rcc\.uchicago\.edu/content/rcc\-gis\-geocoding\-service](https://gis.rcc.uchicago.edu/content/rcc-gis-geocoding-service)

__Based on ESRI world Geocoder__

__Acceptable headers:__

ID

ADDRESS

NEIGHBORHOOD

CITY

SUBREGION

REGION or STATE or ST

POSTAL or ZIP or ZIP CODE

COUNTRYCODE

------

# Generating Google Geocoder API Key

Go to the  __Google__  Cloud Platform Console\.

[https://developers\.google\.com/maps/documentation/geocoding/get\-api\-key](https://developers.google.com/maps/documentation/geocoding/get-api-key)

From the Project drop\-down menu\, select or  __create__  the project for which you want to add an  __API key__ \.

From the Navigation menu\, select  __APIs__  & Services > Credentials\.

On the Credentials page\, click  __Create__  credentials >  __API key__ \. \.\.\.

On the dialog\, click Restrict  __Key__

------

# API Based Geocoding

### https://maps.googleapis.com/maps/api/geocode/json?address=address&key=XXX

https://maps.googleapis.com/maps/api/geocode/json?address=university+of+chicago&key=AIzaSyCa9_mrD7EwhR5MUJx_uX62O0CiXoVLUaw

```json
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "5801",
               "short_name" : "5801",
               "types" : [ "street_number" ]
            },
            {
               "long_name" : "South Ellis Avenue",
               "short_name" : "S Ellis Ave",
               "types" : [ "route" ]
            },
            {
               "long_name" : "Hyde Park",
               "short_name" : "Hyde Park",
               "types" : [ "neighborhood", "political" ]
            },
            {
               "long_name" : "Chicago",
               "short_name" : "Chicago",
               "types" : [ "locality", "political" ]
            },
            {
               "long_name" : "Chicago",
               "short_name" : "Chicago",
               "types" : [ "administrative_area_level_3", "political" ]
            }, 
            {
               "long_name" : "Cook County",
               "short_name" : "Cook County",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "Illinois",
               "short_name" : "IL",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United States",
               "short_name" : "US",
               "types" : [ "country", "political" ]
            },
            {
               "long_name" : "60637",
               "short_name" : "60637",
               "types" : [ "postal_code" ]
            }
         ],
         "formatted_address" : "5801 S Ellis Ave, Chicago, IL 60637, USA",
         "geometry" : {
            "location" : {
               "lat" : 41.7886079,
               "lng" : -87.5987133
            },
            "location_type" : "ROOFTOP",
            "viewport" : {
               "northeast" : {
                  "lat" : 41.7899568802915,
                  "lng" : -87.5973643197085
               },
               "southwest" : {
                  "lat" : 41.7872589197085,
                  "lng" : -87.60006228029151
               }
            }
         },
         "place_id" : "ChIJRUhmExYpDogRyvXSAM9lf18",
         "plus_code" : {
            "compound_code" : "QCQ2+CG Chicago, Illinois, United States",
            "global_code" : "86HJQCQ2+CG"
         },
         "types" : [ "establishment", "point_of_interest", "university" ]
      }
   ],
   "status" : "OK"
}
```

------



# Geocoding Error

------

S Western Ave is one\-way street \(the green triangles for blvd are on the wrong side\)

![](img/Geocoding31.png)

 <span style="color:#FF0000"> __Red rectangles__ </span> \- Street map premium       
 <span style="color:#008000"> __Green triangles__ </span> \- ESRI world geocoder

------

ESRI world locator could not locate W 43rd St\.


![](img/Geocoding32.png)

 <span style="color:#FF0000"> __Red rectangles__ </span> \- Street map premium       
 <span style="color:#008000"> __Green triangles__ </span> \- ESRI world geocoder

------

# Final Note

Address matching based on the Linear Interpolation rule is not 100 percent correct\.

However\, this is the most widely accepted approach \(practical and efficient\) for GIS geocoding\.

Same as in Google Maps, Bing and other cloud based\.

------

# Hands On 1

# R Script

------



# Hands On 2

# Geocoding in Midway cluster

Python on ArcGIS Server for Linux runs a Windows version of Python under Wine\.

Start the ArcGIS Python console with: /home/\<user>/arcgis/server/tools/python

\#Or\, use Anaconda3 2019\.03 module

```bash
module load Anaconda3/2019.03

source activate arcpy
```

------

# Hands On 2 (Cont.)
### Navigate to /scratch/midway2/rcc/project2/incoming/geocoding

Script:geocode\_script\.py

\# Change the parameter values:
\#  1: address\_table to geocode
\#  2: column header matching Address to Street address\, City to city\, county to county\, and so on
\#  3: output file

```python
import arcpy

address_table="\\scratch\\midway2\\rcc\\project2\\incoming\\geocoding\\ChicagoLeadTest.csv"
address_fields = "Address Address ;City City;State State; ZIP_Code Postal"
geocode_result = "\\home\\pnsinha\\geocode_result"
address_locator = "\\scratch\\midway2\\rcc\\project2\\incoming\\geocoding\\Geocoding_Data\\USA_LocalComposite"

# Process: Geocode Addresses
arcpy.GeocodeAddresses_geocoding(address_table, address_locator, address_fields, geocode_result, 'STATIC')
```

------



# Questions?

* <mark>  gis@uchicago.edu</mark>
* <mark>  gis-help@rcc.uchicago.edu</mark>


