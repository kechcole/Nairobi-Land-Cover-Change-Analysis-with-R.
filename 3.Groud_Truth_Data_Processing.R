
library(conflicted)
# library(rgdal)       # spatial data processing
library(raster)      # raster processing
library(plyr)        # data manipulation 
library(dplyr)       # data manipulation 
library(RStoolbox)   # ploting spatial data 
library(RColorBrewer)# color
library(ggplot2)     # ploting
library(sp)          # spatial data
library(sf)          # spatial data

library(gridExtra)
library(tidyverse)   # data 


# Load data. Landsat data used for an area covering the greater Nairobi region downloaded from Google Earth Engine.
dataFolder <- "c:/Users/admin/Downloads/Nairobi Landsat data/"

# Load raster data 
landsat_24 <- stack(paste0(dataFolder, 'NAIROBI_L8_2023.tif'))
crs(landsat_24)


# Load geopackage using sf package , layer is train_2023
polygon_layers <- st_layers(paste0(dataFolder, 'Nairobidata.gpkg'))
polygon_layers

# Load a single layer 
polygon1 <- st_read(paste0(dataFolder, 'Nairobidata.gpkg'), layer = 'dissolved')

# CRS 
crs(polygon1)

# Reproject to Pseudo Mercator, projected coordinate system that uses meters 
poly_rep <- st_transform(polygon1, crs=3857) 
poly_rep

# Choose attribute 
attribute <- poly_rep$Class_Name 

# Plot
plot(poly_rep["Class_Name"], col = terrain.colors(length(unique(attribute))), 
     main = "Plot Colored by Land Type.")

# Add a legend
legend("bottomright", legend = unique(attribute), 
        fill = terrain.colors(length(unique(attribute))), title = "Legend", cex = 0.8)




# ------------------------------------------------------
# Convert Polygon to raster

# Get extent from raster 
extent <- extent(landsat_24)
extent

# Get projection of polygon to be used in rasterisation 
crs = st_crs(poly_rep)$proj4string
crs

# Create a blank raster (define resolution and extent)
# Define the raster resolution (in the units of the coordinate system)
rast_template <- raster(extent, resolution=2.5, crs = crs)

# Assign the extent of reprojected polygon to raster template 
extent(rast_template) <- extent(poly_rep)

# Rasterize the polygon based on an attribute
# Choose the attribute for rasterization MUST be a numeric function
rp <- rasterize(poly_rep, rast_template, 'Class_ID', fun = "first")

# Plot 
plot(rp, main="Ground truth data")



