library(shiny)
library(leaflet)

shinyUI(fluidPage(
    titlePanel(paste("Earthquakes near Nazca Plate", minYear, "-", maxYear)),
    sidebarLayout(
        sidebarPanel(
            p(), p(),
            sliderInput("rangeYr", label="Year Range",
                        min = minYear, max = maxYear,
                        value = c(minYear, maxYear), step = 1),
            sliderInput("rangeMg", label="Magnitude Range", 
                        min = minMagn, max = maxMagn,
                        value = c(minMagn, maxMagn), step = 0.1),
            helpText("Use the sliders to filter the earthquakes",
                     "shown in the right panel.", p(),
                     "The color and size of the circular markers on the map",
                     "corresponds to the magnitude of the earthquake. ", p(),
                     "Clicking on a marker will show details of the event.", p(),
                     "See details on the Help tab.")
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                tabPanel("Earthquakes Map", 
                     h4(textOutput("info")),
                     leafletOutput("map"),
                     br(),
                     actionButton("doRefresh",label="Rebuild Map")
                     ), 
                tabPanel("Help & Data", 
                     h4("How to use the application"),p(),
                     helpText("Use the sliders to filter the earthquakes",
                              "shown in the right panel of the Earthquakes Map tab.", p(),
                              "Select a Year range and a Magnitude range. ", 
                              "The map will show only events whithin those ranges.",
                              "The number of events will be shown on top of the map.", p(),
                              "The size of the circular markers on the map",
                              "represents the magnitude of the earthquake, ",
                              "same as the color, going from blue in the low range of ",
                              "magnitude (6 to 7), green in the middle (7 to 8), ",
                              "and orange or red in the high range (8 to 10).", p(),
                              "Clicking on a marker will show details of the event: date,",
                              "magnitude, place, latitude, longitude, and depth. ", p(),
                              "You can do zooming and move around the map, and you can return ",
                              "at any time to the original map pressing the Rebuild Map button."),
                     br(), br(),
                     helpText("Use this button to download data in CSV format:"),
                     downloadButton('downloadData', 'Download Earthquakes Data')
                )
            )

        )
    )
))
        

