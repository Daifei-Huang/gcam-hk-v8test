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

driver_drake(xmldir = 'xml_test3/', memory_strategy = "autoclean")



## DEBUG 1: module_gcamchina_L101.Energy_Balance ====================================================================================

driver_drake(xmldir = 'xml_test3/', memory_strategy = "autoclean", stop_before = "module_gcamchina_L101.Energy_Balance")

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

driver_drake(xmldir = 'xml_test3/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L154.Transport")
trn.outputs <- load_from_cache(outputs_of("module_gcamchina_L154.Transport"))$L154.in_EJ_province_trn_F

# Debug 3: module_gcamchina_L132.Industry ================

driver_drake(xmldir = 'xml_test3/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L132.Industry")

L101.inNBS_Mtce_province_S_F <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L101.inNBS_Mtce_province_S_F
L101.NBS_use_all_Mtce <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L101.NBS_use_all_Mtce
L122.in_EJ_province_refining_F <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L122.in_EJ_province_refining_F
L123.in_EJ_R_indchp_F_Yh <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L123.in_EJ_R_indchp_F_Yh
L123.out_EJ_R_indchp_F_Yh <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L123.out_EJ_R_indchp_F_Yh
L1322.in_EJ_R_indenergy_F_Yh <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L1322.in_EJ_R_indenergy_F_Yh
L1322.in_EJ_R_indfeed_F_Yh <- load_from_cache(inputs_of("module_gcamchina_L132.Industry"))$L1322.in_EJ_R_indfeed_F_Yh

unique(L1322.in_EJ_R_indenergy_F_Yh$fuel)


L132.in_EJ_province_indnochp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indnochp_F
L132.in_EJ_province_indchp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indchp_F
L132.out_EJ_province_indchp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.out_EJ_province_indchp_F
L132.in_EJ_province_indfeed_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indfeed_F

# Debug 4: module_gcamchina_L1323.detailed_industry =========================

driver_drake(xmldir = 'xml_test3/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L1323.detailed_industry")

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1323.detailed_industry"))
detailed_industry_output <- L1L2inputs$`gcam-china/detailed_industry_output`
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings`
IO_detailed_industry <- L1L2inputs$`gcam-china/IO_detailed_industry`
IO_detailed_industry_HK <- L1L2inputs$`gcam-china/IO_detailed_industry_HK`
L132.in_EJ_province_indnochp_F <- L1L2inputs$L132.in_EJ_province_indnochp_F
L132.in_EJ_province_indfeed_F <- L1L2inputs$L132.in_EJ_province_indfeed_F

L1323.in_EJ_province_detailed_industry_F_Y <- load_from_cache("L1323.in_EJ_province_detailed_industry_F_Y")$L1323.in_EJ_province_detailed_industry_F_Y
L1323.in_EJ_province_indnochp_F <- load_from_cache("L1323.in_EJ_province_indnochp_F")$L1323.in_EJ_province_indnochp_F
L1323.in_EJ_province_indfeed_F <- load_from_cache("L1323.in_EJ_province_indfeed_F")$L1323.in_EJ_province_indfeed_F



# Debug : module_gcamchina_industry_xml ====================================
# 生成的 industry_CHINA_high_demand.xml 被用于模型运行

L232.StubTechCalInput_indenergy_CHINA <- load_from_cache(inputs_of("module_gcamchina_industry_xml"))$L232.StubTechCalInput_indenergy_CHINA
L232.StubTechCalInput_indfeed_CHINA <- load_from_cache(inputs_of("module_gcamchina_industry_xml"))$L232.StubTechCalInput_indfeed_CHINA


# Debug : module_gcamchina_detailed_industry_xml ====================================
# 生成的 detailed_industry_CHINA.xml 被用于模型运行

L2323.Production_detailed_industry_China <- load_from_cache(inputs_of("module_gcamchina_detailed_industry_xml"))$L2323.Production_detailed_industry_China
L2323.StubTechProd_detailed_industry <- load_from_cache(inputs_of("module_gcamchina_detailed_industry_xml"))$L2323.StubTechProd_detailed_industry

#



