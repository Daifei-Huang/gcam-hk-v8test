rm(list = ls())
gc()
# library(devtools)
# load_all()
#
# renv::status()

require(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

renv::deactivate()
library(devtools)
load_all()
options(gcamdata.use_java = TRUE)
# ?driver_drake

driver(write_outputs = TRUE, xmldir = 'xml_test1/')

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean")



## DEBUG 1: module_gcamchina_L101.Energy_Balance ====================================================================================

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_before = "module_gcamchina_L101.Energy_Balance")

# 打开 zgcamchina_L101.Energy_Balance_china.R，开始调试
share <- year <- sector <- fuel <- province <- pop <- share <- province.name <-
  EBProcess <- EBMaterial <- value <- org <- xz.sector <- xz.fuel <- NULL# silence package check.

# Load required inputs
province_names_mappings <- load_csv_files("gcam-china/province_names_mappings", FALSE, quiet = TRUE)[[1]]
NBS_CESY_process <- load_csv_files("gcam-china/NBS_CESY_process", FALSE, quiet = TRUE)[[1]]
NBS_CESY_material <- load_csv_files("gcam-china/NBS_CESY_material", FALSE, quiet = TRUE)[[1]]
en_balance_Mtce_Yh_province <- load_csv_files("gcam-china/en_balance_Mtce_Yh_province", FALSE, quiet = TRUE)[[1]]
en_balance_Mtce_Yh_HK <- load_csv_files("gcam-china/en_balance_Mtce_Yh_HK", FALSE, quiet = TRUE)[[1]] # *** for HK version *** // Daifei 05/11/2025
Tibet_share  <- load_csv_files("gcam-china/Tibet_share", FALSE, quiet = TRUE)[[1]]
tibet_shares_mappings <- load_csv_files("gcam-china/tibet_shares_mappings", FALSE, quiet = TRUE)[[1]]

# # Load required inputs
# tdata <- load_from_cache(outputs_of("module_energy_L144.building_det_en"))
# L144.base_service_EJ_serv <- tdata$L144.base_service_EJ_serv


# Debug 2: module_gcamchina_L154.Transport ===============

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L154.Transport")
trn.outputs <- load_from_cache(outputs_of("module_gcamchina_L154.Transport"))$L154.in_EJ_province_trn_F

# Debug 3: module_gcamchina_L132.Industry ================

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L132.Industry")
L132.in_EJ_province_indnochp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indnochp_F
L132.in_EJ_province_indchp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indchp_F
L132.out_EJ_province_indchp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.out_EJ_province_indchp_F
L132.in_EJ_province_indfeed_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indfeed_F

