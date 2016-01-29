library(dplyr)

defColors <- colorNumeric(c("navy", "blue", "cyan", "green", "gold", "darkorange", "orangered", "red", "darkred"),
                          domain = c(1,9))

shinyServer(function(input, output, session) {
    selectData <- reactive({
    # Filter data to the desired year and range of magnitudes
       quakes %>% filter(mag  >= input$rangeMg[1], mag  <= input$rangeMg[2], 
                         year >= input$rangeYr[1], year <= input$rangeYr[2])
    })
    
    output$map <- renderLeaflet({
        qk <- selectData()
        if (nrow(qk) > 0) {      # This code works only with non-empty data frames
            leaflet(data = qk) %>% addTiles() %>%
            fitBounds(minLong, minLat, maxLong, maxLat) %>%
            addCircleMarkers(lng = ~longitude, lat = ~latitude,
                radius = ~2*category+2, color = ~defColors(category),
                popup = ~paste("Date:", time, "/ Magnitude:", mag, "/",place,
                               "/ Lat:",latitude," / Long:", longitude, " / Depth:", depth, "km"),
                stroke = TRUE, fillOpacity = 0.6)
            } else { 
                # Lazy solution to reported bugs when the data frame is empty.
                # (map dissapears, markers dissapear, application freezes)
                # After trying several workarounds, I just created a new, empty map.
                # Not elegant, but effective.
                leaflet() %>% addTiles() %>%
                    fitBounds(minLong, minLat, maxLong, maxLat)
            }
        
    })
    output$info <- renderText(paste("Number of earthquakes found:",nrow(selectData())))
    
    # "Rebuild Map button observer
    observeEvent(input$doRefresh, {
        # The idea here is to return back to the original map after zooming or moving, 
        # if you landed in middle of nowhere.
        leafletProxy("map") %>%
            fitBounds(minLong, minLat, maxLong, maxLat)
    })
    
    output$downloadData <- downloadHandler(
        filename = 'NazcaQuakes.csv',
        content = function(file) {
            write.csv(quakes, file, row.names=FALSE)
        })

})