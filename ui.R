library(shiny)
library(leaflet)
library(semantic.dashboard)
library(shiny.semantic)
library(DT)

header = dashboardHeader(color = "orange",inverted=TRUE)

sidebar = dashboardSidebar(
  #size = "wide",
  color = "orange",
  inverted = TRUE,
  sidebarMenu(
    menuItem(tabName = "map", text = "Map", icon = icon("map marker alternate")),
    menuItem(tabName = "visualizations", text = "Visualizations", icon = icon("chart bar outline")),
    menuItem(tabName = "table", text = "Table", icon = icon("table")),
    menuItem(tabName = "about", text = "About", icon = icon("comment outline"))
  )
)

body = dashboardBody(
  tabItems(
    #selected = 1,
    tabItem(
      tabName = "map",
      tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
      leafletOutput("latlong", height=700)
      ),
    tabItem(
      tabName = "visualizations",
      textOutput(outputId = "visualizationoutput")
      ),
    tabItem(
      tabName = "table",
      fluidRow(
        h1("Table"),
        semantic_DTOutput("IndiaTable")
      )
    ),
    tabItem(
      tabName = "about",
      htmlOutput(outputId = "aboutoutput")
      )
    )
  )


ui <- dashboardPage(header,sidebar,body)



#navbarPage("AppName", id="main",
#           tabPanel("Map", leafletOutput("latlong", height=1000)))