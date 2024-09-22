 '''
LAND COVER CHANGE ANALYSIS IN THE GREATER NAROBI METROPOLITAN AREA. 

A landsat 8 image of the greater Nairobi region was acquire from google earth engine 
for the years 2013, 2018, and 2023. 


'''
 
 
 # Install libraries and load
# ---------------------------------------------------- 
# 1.Install required libraries 
# Write a function to check iof package is installed 
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
      install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
 
# Packages to be installed assigned to a vector
packages <- c("raster", "rasterVis", "sp", "rgdal", 
              "RStoolbox", "ggplot2", "raster")

# Install 
ipak((packages))
 
install.packages("rgdal")
 
# Load libraries 
library(raster)       # raster data
library(rasterVis)   # raster visualisation     
library(sp)          # spatial data processing          
# library(rgdal)       # spatial data processing      
library(RStoolbox)   # Image analysis
library(ggplot2)     # plotting
library(gridExtra)   # plot arrangement

 
 
 
# Load raster data and study properties 
# ---------------------------------------------------- 
landsat_24 <- stack("c:/Users/admin/Downloads/Nairobi Landsat data/NAIROBI_L8_2023.tif")

# Attributes of the whole image  
landsat_24
 
# Use a range to subset the bands
selected_bands <- stack(landsat_24[[2:7]])
 
# Attribute of subset bands 
 selected_bands
 


 # Plot data  
# ---------------------------------------------------- 
# Plot data using base R 
plot(selected_bands)
 
# Plot histogram 
 hist(selected_bands)


 # Plot using ggplot 
 # 1.True colour image, RGB image. It replicates what the human eyes see.
 # Healthy vegetation is green, urban areas are white and grey while water is dark or blue 
 naturalColour <-ggRGB(landsat_24, r=4, g=3, b=2, stretch = "lin")+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("Natural Color\n (R= Red, G= Green, B= Blue)")
trueColour

# 2.Colour infrared image is used for analysing vegetation. Vegetation have higher reflectance 
 # for NIR light, vegetative areas appear red while water which absorbs this band appears dark 
 # as urban areas are white. 
 falseColourVeg <- ggRGB(landsat_24, r=5, g=4, b=3, stretch = "lin")+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("False Color Vegetation \n (R= NIR, G= Red,  B=Green)")
falseColourVeg

 
 
 # 3.SWIR is also false colour but used for urban area analysis using swir band combination, it displays vegetative areas as 
 # dark green while urban areas are whit/grey/purple  while soils have shades of brown, water and snow is black or blue shades. 
 # The composite is useful for detecting wildfires and calderas of volcanoes, as they are displayed in shades of red and yellow.
 falseColourUrb <- ggRGB(landsat_24, r=7, g=6, b=4, stretch = "lin")+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("False Color Urban \n (R= SWIR2, G= SWIR1,  B= Red)")
falseColourUrb
 
 
 # Agriculture 


