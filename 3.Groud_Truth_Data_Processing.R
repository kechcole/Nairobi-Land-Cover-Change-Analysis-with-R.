
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
polygon <- st_read(paste0(dataFolder, 'Nairobidata.gpkg'))


# CRS 
crs(polygon)

# Reproject to Pseudo Mercator, projected coordinate system that uses meters 
poly_rep <- st_transform(polygon, crs=3857) 
poly_rep

# Plot 
plot(st_geometry(poly_rep), axes=TRUE)



#--------------------------------------------------
# Dissolve based on class id 

dissolve_by_class_id_sf <- function(input_layer, class_id_column) {
  # Check if input is an sf object
  if (!inherits(input_layer, "sf")) {
    stop("Input layer must be an sf object")
  }
  
  # Ensure the class_id_column exists in the input layer
  if (!(class_id_column %in% colnames(input_layer))) {
    stop("class_id_column does not exist in the input layer")
  }

  # Dissolve by class_id using st_union
  dissolved_layer <- input_layer %>%
    split(.[[class_id_column]]) %>%       # Split by the class_id column
    lapply(st_union) %>%                  # Apply st_union to dissolve
    do.call(what = st_sfc) %>%            # Combine into a single sfc object
    st_sf(class_id = unique(input_layer[[class_id_column]]))  # Create sf object with class_id
  
  return(dissolved_layer)
}
poly_dis <- dissolve_by_class_id_sf(poly_rep, "Class_ID")


