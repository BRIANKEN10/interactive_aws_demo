
library(tidyverse)
library(here)
library(leaflet)
library(sf)

fishcnt.df <- read.csv(paste0(here(),"/data/fish cnt static.csv"))

fishcnt.df$cnt.date <- as.Date(fishcnt.df$Updated)

fishcnt.recent.df <- fishcnt.df %>% 
  group_by(trap_location) %>% 
  filter(cnt.date == max(cnt.date))

dam.loc.df <- read.csv(paste0(here(),"/data/dam locations.csv")) %>% 
  rename(dam = 1)

dam.loc.sf <- dam.loc.df %>% 
  st_as_sf(.,coords=c("lon","lat"),crs=4326)

me.centroid <- data.frame(
  X = -68.7716675,
  Y = 44.8013268) %>% 
  dplyr::select(lon = X, lat = Y)


server <- function(input, output, session){
  
  
  output$dammap <- renderLeaflet({
    
    leaflet() %>% 
      setView(lng = me.centroid$lon, lat = me.centroid$lat,  # making sure map zooms in on the zone
              zoom = 6) %>% 
      addProviderTiles(providers$CartoDB,
                       group = "Base Map") %>% 
      addCircleMarkers(data = dam.loc.sf %>% 
                         filter(
                          !dam == input$trap),  # deselecting the dam
                       color = "black",
                       popup = ~dam) %>% 
      addCircleMarkers(data = dam.loc.sf %>% 
                         filter(
                           dam == input$trap),  # deselecting the dam
                       color = "red",
                       popup = ~dam)
  })
  
  output$barchart <- renderPlot({
    
    trap.filter <- input$trap
    
    if(input$noalewife == FALSE){
      
      # base R, change cnt values for spp that == river heering
      fishcnt.recent.df$cnt[fishcnt.recent.df$spp == "River Herring"] <- 0
      
      fishcnt.plotinput.df <- fishcnt.recent.df
      
    }else{fishcnt.plotinput.df <- fishcnt.recent.df}
    
    ggplot(data = fishcnt.plotinput.df %>% 
             filter(trap_location == trap.filter)) + 
      geom_bar(aes(cnt.date, cnt, fill = spp),
               stat = "identity") + 
      labs(title = paste0("Dam Selected: ", trap.filter),
           x = "Most Recent Count", y = "Fish Count", fill = "Species") + 
      theme_bw()
    
  })
  
}
  

ui <- fluidPage(
  titlePanel("Very crude sample app with many necessary improvements to be made"),
  fluidRow(
    column(
      width = 4,
      selectInput(
                  "trap",
                  "Dam Location",
                  c(
                    as.character(unique(fishcnt.df$trap_location))
                    )
      ), # end selector
      checkboxInput("noalewife", "Include River Herring:", TRUE),
      plotOutput("barchart")
    ),  # column  
    column(
      width = 8,
      leafletOutput("dammap")
    ) # end column
  )  # end row 
)


shinyApp(ui = ui, server = server)