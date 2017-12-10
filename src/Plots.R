#! /usr/bin/env Rscript 

## DATA VISUALIZATION
## Author: Tarini Bhatnagar

# This script takes tidy data (created in 1Clean.R), join_company_location and join_company_location (created in 1Analysis.R) as input, and produces and saves plots. 

# Dependencies 
# tidyverse
# maps
# countrycode
# colorRamps
# RColorBrewer

# Input: tidy_choc_data.csv        (args[1]: input_file_1)
#        join_company_location.csv (args[2]: input_file_2)
#        join_company_location.csv (args[3]: input_file_3)

# Data Visualization:
# Chocolate Ratings boxplot
# Cocoa percentage vs Rating scatter plot + fit line
# World map of Company locations producing highest rated (>4)chocolates
# World map of average rating of various origins of beans

# Output: rating_boxplot.png
#       : rating_cocoa_scatter.png
#       : world_comp_loc.png
#       : world_bean_origin.png

args <- commandArgs(trailingOnly = TRUE)
input_file_1 <- args[1]
input_file_2 <- args[2]
input_file_3 <- args[3]

main <- function(){
  
  ## ANALYSIS OF DATA
  
  library(tidyverse)
  library(maps)
  library(countrycode)
  library(colorRamps)
  library(RColorBrewer)
  
  #Loading tidy dataset
  
  chocolate_data <- read_csv(input_file_1) 
  company_loc_df <- read_csv(input_file_2)
  bean_origin_df <- read_csv(input_file_3)
  
  # Boxplot Chocolate Ratings
  
  p1 <- ggplot(chocolate_data, aes("",Rating))+
    geom_boxplot()+
    geom_jitter(alpha=0.4, color="turquoise3")+
    labs(title="Distribution of Chocolate Ratings", y="Rating (/5)")+
    theme_bw()
  
  ggsave("results/figures/rating_boxplot.png", p1, width=4, height=4, dpi=300)
  
  #Cocoa percentage vs Rating scatter plot
  
  p2 <- ggplot(chocolate_data, aes(Cocoa_Percent, Rating))+
    geom_point(color="violetred3", alpha =0.3)+
    geom_smooth(color="blue2", se=FALSE, method =lm)+
    labs(title=" Cocoa Percentage vs Rating", x="Cocoa Percentage (%)", y="Rating (/5)")+
    theme_bw()
  
  ggsave("results/figures/rating_cocoa_scatter.png", p2, width=7, height=4, dpi=300)

  
  #World map of company locations producing highest rated (>=4) chocolates
  
  p3 <- ggplot(map_data("world")) +
    geom_polygon(aes(x = long, y = lat, group = group), fill="white") +
    geom_polygon(data=company_loc_df,aes(x = long, y = lat, group = group, fill = count)) +
    labs(title="Regions (Company Location) producing chocolates rated > 4", x="Longitude (degrees)", y="Latitude (degrees)")+
    scale_fill_gradient(name="Count",low="grey17", high="chartreuse2")
  
  ggsave("results/figures/world_comp_loc.png", p3, width=7, height=4, dpi=300)
  
  #World map of origin of beans
  
  p4 <- ggplot(map_data("world")) +
    geom_polygon(aes(x = long, y = lat, group = group), fill="white") +
    geom_polygon(data=bean_origin_df,aes(x = long, y = lat, group = group, fill = avg_rating)) +
    labs(title="Average rating of various origin of Beans ", x="Longitude (degrees)", y="Latitude (degrees)")+
    scale_fill_gradientn(name="Average rating (/5)",colours=topo.colors(7),na.value = "transparent")
  
  ggsave("results/figures/world_bean_origin.png", p4, width=7, height=4, dpi=300)

}

# call main function
main()

