#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  latlong <- read.csv("C:/Users/manassavs/Documents/Shiny/Data/India latlong.csv")
  
  latlong <- mutate(latlong, cntnt=paste0('<strong>States: </strong>',States,
                                          '<br><strong>Population(inThousands): </strong>',Population.inThousands.,
                                          '<br><strong>RuralPopulation:</strong> ',RuralPopulation,
                                          '<br><strong>UrbanPopulation:</strong> ', UrbanPopulation,
                                          '<br><strong>PopulationDensity:</strong> ', PopulationDensity,
                                          '<br><strong>BirthRate:</strong> ', BirthRate,
                                          '<br><strong>DeathRate:</strong> ', DeathRate,
                                          '<br><strong>GenderRatio:</strong> ', GenderRatio,
                                          '<br><strong>LiteracyRate:</strong> ', LiteracyRate,
                                          '<br><strong>PovertyRate:</strong> ', PovertyRate
                                          ))
                                          
  
  
  output$latlong <- renderLeaflet({
    leaflet(latlong) %>% 
      addCircles(lng = ~Longitude, lat = ~Latitude) %>% 
      addTiles() %>%
      addCircleMarkers(data = latlong, lat =  ~Latitude, lng =~Longitude, 
                       radius = 7, popup = ~as.character(cntnt), 
                       color = "blue",
                       stroke = FALSE, fillOpacity = 0.8) %>%
      addEasyButton(easyButton(
        icon="fa-crosshairs", title="ME",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  })
  
  output$visualizationoutput<-renderText("Visualizations")
  output$aboutoutput<-renderUI({
    text1<-"Idea behind the app:"
    text2<-"Indian culture is known for its mixture of various traditions and heritage. The objective of the app is to highlight these rich cultural differences among the various states of India. 
            The app will have the feature of selecting each state in the Indian map, which in turn will display the information about them. 
            It will also have some beautiful visualizations of various data, like population, literacy rate, agriculture yield etc., of each state."
    text3<-"About Us:"
    HTML(paste(text1,text2,text3,sep="<br><br>"))
  })
  
  output$IndiaTable <- DT::renderDataTable(
    semantic_DT(latlong[1:12])
  )
  
  })
