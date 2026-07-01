

rm(list=ls()); gc()
require(data.table)
# require(R.utils)
require(dplyr)
require(tidyr)
# require(tidyverse)
require(stringr)
require(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))




# dstrace("", direction = 'both', graph = TRUE)
# dstrace_chunks('module_gcamchina_L2235.elec_segments_GRID', gcam_data_map)

# Specify the path to the folder you want to search
# Use "." to search the current working directory
folder_path <-"./input/gcamdata/R/"

# Get a list of all .R files in the specified folder and its subdirectories
all_files <- list.files(path = folder_path, pattern = "\\.R$", recursive = TRUE, full.names = TRUE)

# Define the text pattern to search for
search_pattern <- 'A_ExoShutdownScalar' 

# Loop through each file and check for the search pattern
fileline.list <- data.table()
for (file in all_files) {
  # Read all lines from the file
  lines <- readLines(file, warn = FALSE)

  # Search for the pattern within the lines
  # The 'grep' function returns the line numbers that contain a match
  matching_lines <- grep(search_pattern, lines, value = FALSE)

  # If any matches are found, print the file name and the line numbers
  if (length(matching_lines) > 0) {
    cat("Found a match in file:", file, "\n")
    cat("On lines:", matching_lines, "\n\n")

    fileline.list <- rbind(fileline.list,
                           data.table(file = gsub(folder_path, "", file)))
  }
}
fileline.list


# 逐省份查找 （全名）-------------------------------------------------------------------------------
province_list <- c( "Beijing", "Tianjin", "Hebei", "Shanxi", "Inner Mongolia", "Liaoning", "Jilin",
                  "Heilongjiang", "Shanghai", "Jiangsu", "Zhejiang", "Anhui", "Fujian", "Jiangxi",
                  "Shandong", "Henan", "Hubei", "Hunan", "Guangdong", "Guangxi", "Hainan",
                  "Chongqing", "Sichuan", "Guizhou", "Yunnan", "Tibet", "Shaanxi",
                  "Gansu", "Qinghai", "Ningxia", "Xinjiang", "Hong Kong", "Macau" )
fileline.list <- data.table()
for(i.prv in province_list){
  for (file in all_files) {

    lines <- readLines(file, warn = FALSE)

    matching_lines <- grep(i.prv, lines, value = FALSE)


    if (length(matching_lines) > 0) {
      # cat("Found a match in file:", file, "\n")
      # cat("On lines:", matching_lines, "\n\n")

      fileline.list <- rbind(fileline.list,
                             data.table(province = i.prv,
                                        file = gsub(folder_path, "", file)))
    }
  }
}
fileline.list

# 逐省份查找 （缩写）-------------------------------------------------------------------------------
province_abbr_list <- c( '\"AH\"', '\"BJ\"', '\"CQ\"', '\"FJ\"', '\"GD\"', '\"GS\"', '\"GX\"', '\"GZ\"',
                         '\"HA\"', '\"HB\"', '\"HE\"', '\"HI\"', '\"HK\"', '\"HL\"', '\"HN\"',
                         '\"JL\"', '\"JS\"', '\"JX\"', '\"LN\"',
                         '\"MC\"', '\"NM\"', '\"NX\"', '\"QH\"', '\"SC\"', '\"SD\"', '\"SH\"',
                         '\"SN\"', '\"SX\"', '\"TJ\"', '\"XJ\"', '\"XZ\"', '\"YN\"', '\"ZJ\"' )
fileline.list <- data.table()
for(i.prv in province_abbr_list){
  for (file in all_files) {

    lines <- readLines(file, warn = FALSE)

    matching_lines <- grep(i.prv, lines, value = FALSE)


    if (length(matching_lines) > 0) {
      # cat("Found a match in file:", file, "\n")
      # cat("On lines:", matching_lines, "\n\n")

      fileline.list <- rbind(fileline.list,
                             data.table(province = i.prv,
                                        file = gsub(folder_path, "", file)))
    }
  }
}
fileline.list


# =========================================================================================
library(tibble)
# 对比两个csv
library(dataCompareR)
filepath1 <- 'F:\\0_HKU_work\\2_GCAM\\gcam-china-v7.1-Windows-Release-Package\\input\\gcamdata\\inst\\extdata\\'
filepath2 <- 'F:\\0_HKU_work\\2_GCAM\\GCAM_82_Global\\gcam-v8.2-Windows-Release-Package\\input\\gcamdata\\inst\\extdata\\' # 'F:\\0_HKU_work\\2_GCAM\\GCAM_82_Global\\gcam-china-v7.1-Windows-Release-Package\\input\\gcamdata\\inst\\extdata\\'
filename <- 'common\\FAO_GDP_Deflators.csv'
f1 <- read.csv(paste0(filepath1, filename), skip = 8, header = TRUE)
f2 <- read.csv(paste0(filepath2, filename), skip = 8, header = TRUE)
comparison_result <- rCompare(f1, f2)
# Generate a summary report of the differences
summary(comparison_result)
