#! /usr/bin/env Rscript 

## CLEANING DATA
## Author: Tarini Bhatnagar

# This script takes raw data as input, performs some tidying tasks and writes the data to a new output .csv file. 

# Dependencies 
# tidyverse

# Input: flavors_of_cacao.csv (args[1]: input_file)

# Data cleaning tasks:
# Convert csv to dataframe
# Remove first row conatining attribute names 
# Replace spaces in attribute names with `_`.
# Convert columns to their correct types as many numeric columns are mistakenly characterzied as chr.
# Broad_Bean_Origin column has few rows with multiple countries, I have assumed and selected the first country as the dominant origin.
# Replacing acronyms with correct names of country in Broad_Bean_Origin column.

# Output: tidy_choc_data.csv (args[2]: output_file)


args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

main <- function(){
  
  
  
  library(tidyverse)
  
  #Loading raw data
  chocolate_data <- read_csv(input_file) 
  
  #Removing first row containg column names as rows
  chocolate_data <- chocolate_data[-1,] 
  
  #Replacing spaces in column names with _
  names(chocolate_data)<-names(chocolate_data)%>% 
  stringr::str_replace_all("\\s","_")
  
  #Converting columns to their correct data types
  chocolate_data$Cocoa_Percent <- sapply(chocolate_data$Cocoa_Percent, function(x) gsub("%", "", x))
  chocolate_data <- type_convert(chocolate_data)
  
  #Broad_Bean_Origin has many tupples with more than one region and some have different notations for same country. I have assumed the first country to be the dominant one.
  chocolate_data$Broad_Bean_Origin[grepl("Ven", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Venezuela"
  chocolate_data$Broad_Bean_Origin[grepl("Trinidad", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Trinidad"
  chocolate_data$Broad_Bean_Origin[grepl("Peru", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Peru"
  chocolate_data$Broad_Bean_Origin[grepl("Mad", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Madagascar"
  chocolate_data$Broad_Bean_Origin[grepl("Dom", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Dominican Republic"
  chocolate_data$Broad_Bean_Origin[grepl("Ecua", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Ecuador"
  chocolate_data$Broad_Bean_Origin[grepl("Gre", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Grenada"
  chocolate_data$Broad_Bean_Origin[grepl("PNG", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Papua New Guinea"
  chocolate_data$Broad_Bean_Origin[grepl("Indo", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Indonesia"
  chocolate_data$Broad_Bean_Origin[grepl("Sao", chocolate_data$Broad_Bean_Origin, ignore.case=FALSE)] <- "Sao Tome"
  
  #Write tidy data to a new .csv file
  write.csv(chocolate_data, file=output_file, row.names=FALSE)
  
}

# call main function
main()
