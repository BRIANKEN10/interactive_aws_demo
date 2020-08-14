### really quick scrap code fo rapp

library(here)
library(sf)
library(tidyverse)
library(leaflet)
library(ggmap)
library(tidygeocoder)


fishcnt.df <- read.csv(paste0(here(),"/data/fish cnt static.csv"))

fishcnt.df$cnt.date <- as.Date(fishcnt.df$Updated)

fishcnt.recent.df <- fishcnt.df %>% 
  group_by(trap_location) %>% 
  filter(cnt.date == max(cnt.date))

dam.loc.df <- read.csv(paste0(here(),"/data/dam locations.csv"))

dam.loc.sf <- dam.loc.df %>% 
  st_as_sf(.,coords=c("lon","lat"),crs=4326)


gis.data.path <- "C:/Users/brian/OneDrive/Desktop/natural earth data/"

states.temp <- sf::st_read(paste0(gis.data.path, "ESRI_USA_States_Generalized/USA_States_Generalized.shp")) %>% 
  filter(STATE_NAME == "Maine")

me.centroid <- states.temp %>%    
  sf::st_centroid() %>% 
  sf::st_coordinates() %>% 
  as.data.frame() %>% 
  dplyr::select(lon = X, lat = Y)

# BASIC MAP 

leaflet() %>% 
  setView(lng = me.centroid$lon, lat = me.centroid$lat,  # making sure map zooms in on the zone
          zoom = 6) %>% 
  addProviderTiles(providers$CartoDB,
                   group = "Base Map") %>% 
  addCircleMarkers(data = dam.loc.sf,
             color = "red",
            popup = ~dam
                   )

# BASIC CHART


fishcnt.recent.df$cnt[fishcnt.recent.df$spp == "River Herring"] <- 0



if(fishcnt.recent.df$spp[fishcnt.recent.df$spp == "River Herring"]){
  fishcnt.recent.df$cnt



if(input$noalewife == FALSE){filter(!spp == "River Herring")}

if(bool == FALSE){x == 2}else{4}
  
}

{if (y=="") filter(., x>3) else filter(., x<3)}


bool <- FALSE

if(bool == FALSE){
  fishcnt.plotinput.df <- fishcnt.recent.df %>% 
    filter(!spp == "River Herring")
}else{fishcnt.plotinput.df <- fishcnt.recent.df}

ggplot(data = fishcnt.plotinput.df %>% 
         filter(trap_location == trap.filter))  + 
  geom_bar(aes(cnt.date, cnt, fill = spp),
           stat = "identity") + 
  labs(title = paste0("Dam Selected: ", trap.filter)) + 
    theme_bw()







