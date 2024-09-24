'''
                    IMAGE CLASSIFICATION. 
This is the process of assingning new land cover classes to an image resulting to thematic maps that 
show land use maps. This activity on the reflactance value of different features, i.e a built up area
has different value a s compared to vegetative areas. By assigning classes, the image acquires new 
labels / themes. 

          Procedure of classification. 
1. Image Preprocessing. Includes corrections i.e radiometric(missmatch between energy being emmited and one received), 
   atmospheric(radiance scattering/absorption), topographic, image enhancement, or sometimes clustering analysis, 
   geometric(incorrect coordinates). 
2. Design a classification scheme. Based of ground truth from field survey or other ancilliary data, infor 
   about ground features such as agriculture, built areas is determined. 
3. Create training areas. Representative areas of the image is created either through an earlier classification
   algorith(unsupervised) or manually developing training signatures through digitization. 
4. Run a classification algorithm. 
5. Post processing. Techniques aimed at improving the accuracy of an image thus raising value of infor generated from 
   an image. This includes image enhancement, orthorectification(horizontal accuracy using GCPs), spectral analysis to reveal hidden 
   information.  
6. Accuracy assesment. Checks the accuracy of your model by comparing ground truth and values generated.

          Image Classification Techniques. 
Remote sensing has a wide array of classifications groups based on characteristic of underlying algorithm. They include 
    a) Parametric and non-parametric techniques - one uses assumptions on data while the other ignores. 
    b) Hard or soft. Hard technique is where each pixel is assigned a class leading to data loss in cases where there are 
       a pixel can represent more than one class while the later allows pixels to have more than one classes, it assumes the 
       real world pattern where features are heterogenious. In soft a pixel is assigned a portion of the cover type it represents.
    c) Supervised and unsupervised classification. 
    d) Hybrid technique combines multiple other techniques by leveraging on AI and expert systems to improve on their deficiencies. 

I will delve into two major ones : supervided and supervised since they are commonly used and have been explored widely. 

         Supervised Image Classification. 
Using a set of pre-labelled sample data, an analyst trains a classifier that will then use knowledge learnt to classify an image.
Once an algorithm learns, it is exposed to unknown pixels and assign them to different classes. Sample data data can be fetched 
from field visits, expert knowledge, or ancilliary data such as maps. Example of such algorithms include random forest, support vector 
machine, and decision trees. One huge advantage is that this algorithm meets user objectives or needs resulting to less effort and 
time/cost saving due to higher accuracies. The downside is that in real world scenario, data is homegenious this it does not capture 
natures variabilities and complexities. Users can also spend a lot of time when collecting sampling data.  

        Unsupervised classification. 
This algorithm does not have any prio knowledge of the data and uses pixel properties such as simmilaries or differences in radiance value
to design clusters that minimises feature variation and maximises class separation. One huge advantage over supervised classification is 
that the algorith is able to reveal hidden patterns that human capacity easily ignores. Conversly, is fall short of meeting user 
as in may require expert knowledge to interpret. 


'''
# ---------------------------------------------------------------------------------
#                    Section 1 : UNSUPERVISED CLASSIFICATION.
#----------------------------------------------------------------------------------

library(raster)      # raster data
library(rasterVis)  # raster visualisation  
library(sp)         # Spatial data processing           
# library(rgdal)      # Spatial data processing
library(RStoolbox)  # Image analysis
library(ggplot2)    # ploting



































# ---------------------------------------------------------------------------------
#                    Section 2 : SUPERVISED CLASSIFICATION.
#----------------------------------------------------------------------------------