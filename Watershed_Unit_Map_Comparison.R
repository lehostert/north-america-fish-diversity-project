library(tidyverse)

setwd("~/GitHub/north_american_fish_species_project")

NAW_df <- read_csv("NA_Watersheds_p_v2.csv")
  
US_SUB_df <- read_csv("NA_Watersheds_USA_SUB.csv")

US_CAN_df <- read_csv("NA_Watersheds_USA_CAN.csv")

###In original dataset how many distinct SUbregions and Regions were there Answer should be 221 and 21. 

NAW_df_US <- NAW_df %>% 
  filter(USA_SUB != "-999")

count(distinct(NAW_df_US, USA_SUB))
  
count(distinct(NAW_df_US, USA_REG))

# In US layer that was cut and merged to subregion how many were there. 

count(distinct(US_SUB_df, US_SUB_NA))

###In US CAN Final dataset how many distinct SUbregions and Regions were there Answer should be 221 and 21. 
names(US_CAN_df_US_only) <- str_replace_all(names(US_CAN_df_US_only), "FIRST_", "")

US_CAN_df_US_only <-US_CAN_df  %>% 
  filter(USA_SUB != "-999")

count(distinct(US_CAN_df_US_only, USA_SUB))

count(distinct(US_CAN_df_US_only, USA_REG))

### Get  Original NAW and Final US/CAN datasets into similar form

NAW <- NAW_df_US %>% 
  select(NAW1_EN, NAW2_EN, NAW4_EN, USA_REG, USA_SUB)

US_CAN <- US_CAN_df_US_only %>% 
  select(NAW1_EN, NAW2_EN, NAW4_EN, USA_REG, USA_SUB)

compare_df1 <- anti_join(NAW, US_CAN)
compare_df2 <- semi_join(NAW, US_CAN)


NAW_and_final <- distinct(compare_df2, USA_SUB)
NAW_not_final <- distinct(compare_df1, USA_SUB)

compare <- anti_join(NAW_not_final, NAW_and_final, by = "USA_SUB")
