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

# 4. Créer la section du 1er Mars au 7 Mars (une semaine) ------

heetchPointsProj$Day <-day(heetchPointsProj$location_at_local_time)
heetchPointsProj$Hour <-hour(heetchPointsProj$location_at_local_time)
heetchM1Proj <-heetchPointsProj %>% 
  filter(Day>0 & Day<8 )

# 5. Intersecter les points x et les quartiers y ------

casaNeibUnion <-st_union(casaNeibProj)
ptsInCasa <-st_contains(x=casaNeibUnion, y=heetchM1Proj)

selectPtsInCasa <-unlist(ptsInCasa)

heetchM1CropProj <-heetchM1Proj[selectPtsInCasa,]
ptsInNeib <-st_within(x=heetchM1Proj, y=casaNeibProj) %>% 
  unlist() 
heetchM1CropProj$NEIB <-ptsInNeib

# 6. Grouper par jour/heure/ par identifiant chauffeur et par quartier --------

nestedPts <-heetchM1CropProj %>% 
  st_drop_geometry() %>% 
  group_by(Day,Hour,NEIB, driver_id) %>% 
  summarize(NBPTS=n())

# 7. Selectionner le quartier principal pour chaque chauffeur à chaque jour et heure

mainNeib <-nestedPts %>% 
  group_by(Day, driver_id, Hour) %>% 
  arrange(desc(NBPTS)) %>% 
  slice(1)

# 8. Construire la matrice OD (origine-destination) pour le 1er Mars entre 7H et 8H du matin
# mainNeibwide a comme colonne(driver_id, hours:00,01...)
mainNeibwide <-mainNeib %>% 
  select(driver_id,Day,Hour,NEIB) %>% 
  pivot_wider(names_from=Hour, 
              values_from=NEIB,
              names_prefix="H",
              values_fill=NA)

OD78 <-mainNeibwide %>% 
  group_by(H7,H8) %>% 
  summarize(NB=n()) %>% 
  filter(!is.na(H7) & !is.na(H8))%>% 
  rename(ORI=H7, DES=H8)

OD78$ORINAME <-casaNeib$NAME_4[OD78$ORI]
OD78$DESNAME <-casaNeib$NAME_4[OD78$DES]

polCentroids <- st_centroid(casaNeibProj) # pour avoir les centroides
coordCentroids <-st_coordinates((polCentroids)) %>%as_data_frame()
# pour avoir les coordonnées des centroides
class(coordCentroids)

OD78$XORI <-coordCentroids$X[OD78$ORI]
OD78$XDES <-coordCentroids$X[OD78$DES]
OD78$YORI <-coordCentroids$Y[OD78$ORI]
OD78$YDES <-coordCentroids$Y[OD78$DES]

# Afficher la carte
selecFlows <-OD78 %>% filter(NB>2)
plot(casaNeibProj$geometry, col="grey80", border ="grey30")
arrows(selecFlows$XORI,
       selecFlows$YORI,
       selecFlows$XDES,
       selecFlows$YDES,
       col="chocolate",
       lwd=2,
       length=0.1,
       code=2)

# 9. Construire la matrice OD (origine-destination) pour le 1er Mars entre 12H et 13H du matin
OD1213 <-mainNeibwide %>% 
  group_by(H12,H13) %>% 
  summarize(NB=n()) %>% 
  filter(!is.na(H12) & !is.na(H13))%>% 
  rename(ORI=H12, DES=H13)

OD1213$ORINAME <-casaNeib$NAME_4[OD1213$ORI]
OD1213$DESNAME <-casaNeib$NAME_4[OD1213$DES]

polCentroids <- st_centroid(casaNeibProj) # pour avoir les centroides
coordCentroids <-st_coordinates((polCentroids)) %>%as_data_frame()
# pour avoir les coordonnées des centroides
class(coordCentroids)

OD1213$XORI <-coordCentroids$X[OD1213$ORI]
OD1213$XDES <-coordCentroids$X[OD1213$DES]
OD1213$YORI <-coordCentroids$Y[OD1213$ORI]
OD1213$YDES <-coordCentroids$Y[OD1213$DES]

# Afficher la carte
selecFlows <-OD1213 %>% filter(NB>2)
plot(casaNeibProj$geometry, col="grey80", border ="grey30")
arrows(selecFlows$XORI,
       selecFlows$YORI,
       selecFlows$XDES,
       selecFlows$YDES,
       col="chocolate",
       lwd=2,
       length=0.1,
       code=2)

# 10. Construire la matrice OD (origine-destination) pour le 1er Mars entre 18H et 19H du matin
OD1819 <-mainNeibwide %>% 
  group_by(H18,H19) %>% 
  summarize(NB=n()) %>% 
  filter(!is.na(H18) & !is.na(H19))%>% 
  rename(ORI=H18, DES=H19)

OD1819$ORINAME <-casaNeib$NAME_4[OD1819$ORI]
OD1819$DESNAME <-casaNeib$NAME_4[OD1819$DES]

polCentroids <- st_centroid(casaNeibProj) # pour avoir les centroides
coordCentroids <-st_coordinates((polCentroids)) %>%as_data_frame()
# pour avoir les coordonnées des centroides
class(coordCentroids)

OD1819$XORI <-coordCentroids$X[OD1819$ORI]
OD1819$XDES <-coordCentroids$X[OD1819$DES]
OD1819$YORI <-coordCentroids$Y[OD1819$ORI]
OD1819$YDES <-coordCentroids$Y[OD1819$DES]

# Afficher la carte
selecFlows <-OD1819 %>% filter(NB>2)
plot(casaNeibProj$geometry, col="grey80", border ="grey30")
arrows(selecFlows$XORI,
       selecFlows$YORI,
       selecFlows$XDES,
       selecFlows$YDES,
       col="chocolate",
       lwd=2,
       length=0.1,
       code=2)



