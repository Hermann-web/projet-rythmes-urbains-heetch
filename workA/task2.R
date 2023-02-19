############### Project #################

# 1. Load packages ------

library(dplyr) 
library(sf)
library(leaflet)
library(lubridate)
library(mapsf)
library(tidyr)

# 2. Load data -------

heetchPoints <-readRDS("DATA/heetchmarchcrop.Rds")
casaNeib <-st_read("DATA/casaneib.geojson") 

# 3. Projeter les objets spatiaux ------

casaNeibProj <-st_transform(casaNeib, crs=26191)
heetchPointsProj <-st_transform(heetchPoints, crs=26191)

# 4. Créer la section du 1er Mars ------

heetchPointsProj$Day <-day(heetchPointsProj$location_at_local_time)
heetchPointsProj$Hour <-hour(heetchPointsProj$location_at_local_time)
heetchM1Proj <-heetchPointsProj %>% 
  filter(Day==1) %>% 
  filter(Hour<23 & Hour>6 )

# 5. Intersecter les points x et les quartiers y ------

casaNeibUnion <-st_union(casaNeibProj)
ptsInCasa <-st_contains(x=casaNeibUnion, y=heetchM1Proj)

selectPtsInCasa <-unlist(ptsInCasa)

heetchM1CropProj <-heetchM1Proj[selectPtsInCasa,]
ptsInNeib <-st_within(x=heetchM1Proj, y=casaNeibProj) %>% 
  unlist() 
heetchM1CropProj$NEIB <-ptsInNeib

# 6. Grouper par heure/ par identifiant chauffeur et par quartier --------

nestedPts <-heetchM1CropProj %>% 
  st_drop_geometry() %>% 
  group_by(Hour, NEIB, driver_id) %>% 
  summarize(NBPTS=n())

# 7. Selectionner le quartier principal pour chaque chauffeur à chaque heure

mainNeib <-nestedPts %>% 
  group_by(driver_id, Hour) %>% 
  arrange(desc(NBPTS)) %>% 
  slice(1)

# 8. Pour chaque heure, pour chaque quartier, calculer le nombre de chauffeurs

mainNeibJ <-nestedPts %>% 
  group_by(Hour, NEIB) %>% 
  summarize(NBDRiver=n())

