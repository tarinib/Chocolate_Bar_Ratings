#! /usr/bin/env Rscript 

## DATA ANALYSIS

# This script takes tidy data (created in 1Clean.R) as input, performs some analysis and writes the data to new output .csv files. 

# Dependencies 
# tidyverse
# maps
# countrycode

# Input: tidy_choc_data.csv (args[1]: input_file)

# Data analysis tasks:
# Convert csv to dataframe
# Save statistical summary to a .csv file
# Group data frame by Company Location 
# Create a new column with country codes
# Join dataframe with world map dataframe containing latitude and longitude information (by ISO code column) & save to a .csv file
# Group data frame by Bean Origin
# Create a new column with countrycodes
# Join dataframe with world map dataframe containing latitude and longitude information (by ISO code column) & save to a .csv file

# Output: stat_summary.csv          (args[2]: output_file_1)
#         join_company_location.csv (args[3]: output_file_2)
#         join_join_bean_origin.csv (args[4]: output_file_3)

args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file_1 <- args[2]
output_file_2 <- args[3]
output_file_3 <- args[4]

main <- function(){
  
  library(tidyverse)
  library(maps)
  library(countrycode)
  
  # Load tidy data
  chocolate_data <- read_csv(input_file) 
  
  #Sumamry of dataset
  
  summary <- summary(chocolate_data)
  write.csv(summary, output_file_1, row.names=FALSE)
  
  # Load world map data
  world_data <- map_data("world") 
  
  # Region (Company location) producing highest rated chocolates (rating >4)
  # Creating new column with country codes
  chocolate_data_hr <- chocolate_data %>% 
    filter(Rating>=4) %>%
    group_by(Company_Location) %>% 
    summarize(count=n()) %>% 
    mutate(ISO=countrycode(Company_Location, "country.name", "iso2c")) 
  
  # Creating new column with country codes in world map data
  world_data <- map_data("world") %>% 
    mutate(ISO=countrycode(region, "country.name", "iso2c"))
  
  # Joining company location for highest rated chocolates with world map data
  company_loc_df <- left_join(chocolate_data_hr,world_data)
  
  # Write join data to new .csv file
  write.csv(company_loc_df, file=output_file_2, row.names=FALSE)
  
  # Average rating of bean origin
  # Creating new column with country codes
  chocolate_data_bean <- chocolate_data %>% 
    filter(!is.na(Broad_Bean_Origin) | (Broad_Bean_Origin!=" ")) %>% 
    group_by(Broad_Bean_Origin) %>%
    summarise(avg_rating=mean(Rating)) %>% 
    mutate(ISO=countrycode(Broad_Bean_Origin, "country.name", "iso2c")) 
  
  # Joining average rating of bean origin of chocolates with world map data
  bean_origin_df <- left_join(chocolate_data_bean,world_data)
  
  # Write join data to new .csv file
  write.csv(bean_origin_df, file=output_file_3, row.names=FALSE)
  
}

# call main function
main()

