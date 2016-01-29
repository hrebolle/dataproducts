
# Data obtained from http://earthquake.usgs.gov/earthquakes/search/
# Dates from 1900-01-01 to 2015-12-31
# Geographic Region (Rectangular) North: -17, South: -50, East: -66, West: -77
# i.e., near Nazca plate.

quakes <- read.csv("NazcaQuakes.csv")

# do some useful transformations
quakes$date <- as.Date(quakes$time)
quakes$place <- as.character(quakes$place)
quakes$category <- as.integer(2*quakes$mag-11)  # goes from 1 to 9
quakes$year <- as.integer(substr(quakes$time,1,4))

# Set slider ranges to actual values. 
# Selecting values outside this range produces NULL data frames and kills this App.
minYear <- min(quakes$year); maxYear <- max(quakes$year)
minMagn <- min(quakes$mag); maxMagn <- max(quakes$mag)

# Set the map bounds to actual values.
minLat <- floor(min(quakes$latitude))-1; ceiling(maxLat <- max(quakes$latitude))+1
minLong <- floor(min(quakes$longitude))-1; maxLong <- ceiling(max(quakes$longitude))+1


