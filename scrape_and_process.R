# Load the necessary libraries
library(rvest)
library(dplyr)
library(tidyr)
library(ggplot2)

# URL of the Wikipedia page
url <- "https://en.wikipedia.org/wiki/List_of_natural_disasters_by_death_toll"

# Read the HTML content of the page
page <- read_html(url)

# Extract the tables for the 20th and 21st century all-cause disasters
tables <- page %>%
  html_nodes("table.wikitable") %>%
  .[c(2, 3)]  # Select the 20th and 21st century tables

# Convert the HTML tables to data frames
data_frames <- lapply(tables, function(table) {
  table %>%
    html_table(fill = TRUE)
})

# Combine the data frames into a single data frame
all_disasters_df <- bind_rows(data_frames)

# Function to convert death toll to numbers
convert_death_toll <- function(death_toll) {
  if (grepl("–", death_toll)) {
    death_toll1=as.character(gsub("[,+]", "", death_toll))
    range <- as.numeric(strsplit(death_toll1, "–")[[1]])
    return(mean(range))
  } else if (grepl("\\+", death_toll)) {
    return(as.numeric(gsub("[+,]", "", death_toll)))
  } 
  else if (grepl("\\[", death_toll)) {
    death1=gsub('.{4}$', '', death_toll)
    return(as.numeric(gsub(",", "", death1)))
  }
  else {
    return(as.numeric(gsub(",", "", death_toll)))
  }
}

colnames(all_disasters_df)[2]="DeathToll"


# Apply the conversion function to the death toll column
all_disasters_df1 <- all_disasters_df %>%
  mutate(DeathToll = sapply(DeathToll, convert_death_toll))

# Merge the 20th and 21st century data frames
merged_df <- all_disasters_df1 %>%select(Year, Type, DeathToll)
