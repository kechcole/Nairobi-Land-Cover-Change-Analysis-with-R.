'''
              SPECTRAL INDICIES. 
Spectral indicies compares the spectral reflectance from two or more wavelengths showing relative 
abundance of a feature of interest. This analysis is commonly used to study vegetation, burnt areas, 
built-up areas, water and geological features.  
Before processing data, some pre-processing on raw raster data must be performed, this includes : 
      a) Clipping all bands to area of study 
      b) Convert radiance values to reflactance values, this normalised pixel values 

By extracting information about various features on the earth surfaces, we get to enhance our knowledge and make 
better decisions regarding the enviroment. By tracking changes in plant health we can easily predict output of farmers. 
There are several indicies but more traditional ones include 
            * NDVI - Normalised Difference Vegetation Index is derived from NIR and Red bands. 
                   - Healthy vegetation absorbs visible light but reflects near infrared light, but the inverse is true 
                   - for unhealthy vegetation. 
                                NDVI = (NIR - R)/(NIR + R)
                   - A value of 1 means the vegeation is extremely green, 0 means no vegetation at all, while negative 
                     value indicates unhealthy cover.  
            
            * NDWI - This numerical indicator is derived from nir and short wave infrared spectral bands to identify water content in 
                     vegetation. This can be used in monitoring crop health, discerning inland water from sea water etc.
                     Water strongly absorbs visible to infrared range of wavelenths.  
                                NDWI = (NIR - SWIR1) / (NIR + SWIR1) 
            
            * EVI2 - A two band Enhanced Vegetation Index(EVI2) and Enhanced vegetation Index(EVI) are used to counter the shortcommings of NDVI,
                     because they increase visibility for areas with dense vegetation. This makes them well suited for studying palnt phenology. 
                     The former has been recently introduced as a proxy for phenology, quantity and activity, it has the advantage of clearly discerning soil.
                                EVI2 = G * ( (NIR - RED) / (NIR + 2.4*RED + 1) ) 

            * SAVI - Soil Adjusted Vegetation Index is similar to NDVI bare soil values are suppressed through an adjustment factor(L). 
                     L is a function of vegetation density, in places with low vegetation cover, a value of 0.5 is recomended. 
                     This index is well suited for areas with relative sparse vegetation and soil is more pronounced. 
                              SAVI = ((L + 1) * (NIR - RED)) / (NIR + RED + L)

            * IBI - Index Based Built-up Index is a new indicator used to extract built-up enviroment features. Its a bit different from other indocators because it uses existing(thematic) 
                    index-derived bands to construct and index rather than adopting the original satellite bands. For exaple it makes use of 
                    other known MNDWI, SAVI, and NDBI which map major urban components of vegetation, water and built-up land.
                    Its advantageous because it suprises banckground noise while enhancing built-up areas.  
                    Higher values close to 1 show density of built-up areas while lower values close to -1 is for low to no built areas orwater/vegetation. 
                                       (2 * SWIR1/(SWIR1 + NIR) - [ NIR/(NIR + RED) + GREEN/(GREEN + RED)] )
                            IBI =       --------------------------------------------------------------------
                                       (2 * SWIR1/(SWIR1 + NIR) + [ NIR/(NIR + RED) + GREEN/(GREEN + RED)] )



'''

# ---------------------------------------------------------------------
# Load libraries and data 
# ---------------------------------------------------------------------

library(raster)      # raster data
library(rasterVis)  # raster visualisation  
library(sp)         # Spatial data processing           
# library(rgdal)      # Spatial data processing
library(RStoolbox)  # Image analysis
library(ggplot2)    # ploting


# Load data. Landsat data used for an area covering the greater Nairobi region downloaded from Google Earth Engine.
dataFolder <- "c:/Users/admin/Downloads/Nairobi Landsat data/"

landsat_2023 <- stack(paste0(dataFolder, 'NAIROBI_L8_2023.tif'))
blue <- landsat_2023[[2]]
red <- landsat_2023[[4]]
green <- landsat_2023[[3]]
nir <- landsat_2023[[5]]
swir1 <- landsat_2023[[6]]



#-------------------------------------------------------------------------------
# Calculate NDVI.
#-------------------------------------------------------------------------------
ndvi = (nir - red) / (nir + red)

# Plot data using ggplot 
ndvi_img <- ggR(ndvi,  geom_raster = TRUE)+
                # Legend title and colours 
                scale_fill_gradientn("NDVI", 
                        colours = c("red", "yellow", "green", "green4"))+
                # Remove axis labels 
                theme(axis.title.x=element_blank(),
                      axis.text.x=element_blank(),
                      axis.ticks.x=element_blank(),
                      axis.title.y=element_blank(),
                      axis.text.y=element_blank(),
                      axis.ticks.y=element_blank())+
                ggtitle("Normalised Difference Vegetation Index.)") # Plot title 
ndvi_img



#-------------------------------------------------------------------------------
#   Two bands Enhanced Vegetation Index.
#-------------------------------------------------------------------------------
G = 2.5
evi2 = G * (nir - red) / (nir + 2.4 * red + 1)

evi2_img <- ggR(evi2,  geom_raster = TRUE)+
        # Legend title and colours 
        scale_fill_gradientn("EVI2", 
                colours = c("red", "yellow", "green", "blue"))+
        ggtitle("2-Bands Enhanced Vegetation Index(EVI2).") # Plot title

evi2_img



#------------------------------------------------------------------
#  NDWI 
#--------------------------------------------------------------------
ndwi = (nir - swir1) / (nir + swir1)

ndwi_img <- ggR(ndwi,  geom_raster = TRUE)+
          # Legend title and colours 
          scale_fill_gradientn("Ndwi", 
                  colours = c("blue", "green", "yellow", "red"))+
          ggtitle("Normalised Difference Water Index.") # Plot title 
ndwi_img


#--------------------------------------------------------------------------
#        SAVI 
# -------------------------------------------------------------------------------
L = 0.5
savi = (L + 1)*(nir - red) / (nir + red + L)

savi_img <- ggR(savi,  geom_raster = TRUE)+
            # Legend title and colours 
            scale_fill_gradientn("SAVI", 
                    colours = c("red", "yellow", "green", "green4"))+
            ggtitle("Soil Adjusted Vegetation Index.") # Plot title 
savi_img




#--------------------------------------------------------------------------
#         IBI 
# -------------------------------------------------------------------------------
ibi <- ( (2*swir1 / (swir1 + nir)) - (nir/(nir + red) + green/(green + red)) ) /
       ( (2*swir1 / (swir1 + nir)) + (nir/(nir + red) + green/(green + red)) )

ibi_img <- ggR(ibi,  geom_raster = TRUE)+
          # Legend title and colours 
          scale_fill_gradientn("EVI2", 
                  colours = c("red", "yellow", "green", "blue"))+
          ggtitle("2-Band Enhanced Vegetation Index(EVI1).") # Plot title 

ibi_img



#--------------------------------------------------------------------------
#         NBI - normalised difference build-up index  
# -------------------------------------------------------------------------------
ndbi = (swir1 - nir) / (swir1 + nir)

ndbi_img <- ggR(ndbi,  geom_raster = TRUE)+
          # Legend title and colours 
          scale_fill_gradientn("NDBI", 
                  colours = c("red", "yellow", "blue", "blue4"))+
          ggtitle("Normalised Difference Built-up Index.") # Plot title 

ndbi_img

