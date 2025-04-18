
# Load necessary libraries
library(readxl)
library(dplyr)

# Define the file path
file_path <- "./data/Air Quality Data.xlsx"  # Replace with your actual file path

# Get the names of all sheets (each sheet corresponds to a city)
sheet_names <- excel_sheets(file_path)

# Initialize an empty list to store the DataFrames
data_list <- list()

# Loop through each sheet and process the data
for (sheet in sheet_names) {
  # Read the sheet
  df <- read_excel(file_path, sheet = sheet)
  
  # Add a column with the city name (sheet name)
  df <- df %>% mutate(CityName = sheet)
  
  # Extract only the date part from the Date column
  df <- df %>% mutate(Date = as.Date(Date))
  
  # Append the DataFrame to the list
  data_list[[sheet]] <- df
}

# Combine all city data into one DataFrame
tidy_data <- bind_rows(data_list)

# Save the tidy data to a new CSV file
write.csv(tidy_data, "tidy_air_quality_data.csv", row.names = FALSE)
cat("Tidy data has been saved to 'tidy_air_quality_data.csv")
    
    
