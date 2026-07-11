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


# driver(write_outputs = TRUE, xmldir = 'xml_test2/', outdir = "outputs_test2/")
#
# driver_drake(xmldir = 'xml_test2/', memory_strategy = "autoclean")

# # test function of driver_drake() --------
# tdata <- load_from_cache(outputs_of("module_gcamchina_L101.Energy_Balance"))
# rm(tdata)
#
# # Get the drake plan
# plan <- driver_drake(return_plan_only = TRUE)
# # Pick targets to show the commands that would be used to build them
# plan %>%
#   filter(target %in% c("L244.Satiation_flsp_gcamchina",
#                        "module_gcamchina_L144.Building",
#                        "module_gcamchina_building_xml",
#                        "xml.building_CHINA.xml",
#                        "xml.ghg_emissions_CHINA.xml"))
# # Display the dependency graph downstream from module L210.RenewRscr
# vis_drake_graph(plan, from = make.names("L244.Supplysector_bld"))

## Before Debug: 生成包含 EBMaterial 和 EBProcess 的 gcam-china/en_balance_Mtce_Yh_HK.csv ===================================================
# 根据 ① IEA_energybalance_2019.csv、② PREBUILT_DATA 中的 L101.en_bal_EJ_ctry_Si_Fi_Yh_full、③ zenergy_L100.IEA_downscale_ctry.R 和 ④ zenergy_L101.en_bal_IEA.R
# 首先在此处导出 ① ② ③ ④ 涉及的数据
# 具体见文件夹 GCAM_china/HK数据/energybalance/Extract and Process IEA PREBUILT_DATA/

driver_drake(xmldir = 'xml_testHKenergybalance/', memory_strategy = "autoclean", stop_before = "module_energy_L100.IEA_downscale_ctry")
L100.Pop_thous_ctry_Yh <- load_from_cache("L100.Pop_thous_ctry_Yh")$L100.Pop_thous_ctry_Yh
# IEA_EnergyBalances_2019 <- load_csv_files("energy/IEA_EnergyBalances_2019", FALSE, quiet = TRUE)[[1]]
IEA_product_downscaling <- load_csv_files("energy/mappings/IEA_product_downscaling", FALSE, quiet = TRUE)[[1]]
IEA_ctry <- load_csv_files("energy/mappings/IEA_ctry", FALSE, quiet = TRUE)[[1]]

driver_drake(xmldir = 'xml_testHKenergybalance/', memory_strategy = "autoclean", stop_before = "module_energy_L101.en_bal_IEA")
iso_GCAM_regID <- load_csv_files("common/iso_GCAM_regID", FALSE, quiet = TRUE)[[1]]
A_regions <- load_csv_files("energy/A_regions", FALSE, quiet = TRUE)[[1]]
IEA_flow_sector <- load_csv_files("energy/mappings/IEA_flow_sector", FALSE, quiet = TRUE)[[1]]
IEA_product_fuel <- load_csv_files("energy/mappings/IEA_product_fuel", FALSE, quiet = TRUE)[[1]]
IEA_sector_fuel_modifications <- load_csv_files("energy/mappings/IEA_sector_fuel_modifications", FALSE, quiet = TRUE)[[1]]
enduse_fuel_aggregation <- load_csv_files("energy/mappings/enduse_fuel_aggregation", FALSE, quiet = TRUE)[[1]]
L100.IEA_en_bal_ctry_hist <- load_from_cache("L100.IEA_en_bal_ctry_hist")$L100.IEA_en_bal_ctry_hist

driver_drake(xmldir = 'xml_testHKenergybalance/', memory_strategy = "autoclean", stop_before = "module_energy_L1011.en_bal_adj")

data.output.path <- 'F:/0_HKU_work/2_GCAM/GCAM_china/HK数据/energybalance/Extract and Process IEA PREBUILT_DATA/cache/'
library(data.table)
fwrite(L100.Pop_thous_ctry_Yh, paste0(data.output.path, 'L100.Pop_thous_ctry_Yh.csv'))
fwrite(IEA_product_downscaling, paste0(data.output.path, 'mappings/IEA_product_downscaling.csv'))
fwrite(IEA_ctry, paste0(data.output.path, 'mappings/IEA_ctry.csv'))
fwrite(iso_GCAM_regID, paste0(data.output.path, 'iso_GCAM_regID.csv'))
fwrite(A_regions, paste0(data.output.path, 'A_regions.csv'))
fwrite(IEA_flow_sector, paste0(data.output.path, 'mappings/IEA_flow_sector.csv'))
fwrite(IEA_product_fuel, paste0(data.output.path, 'mappings/IEA_product_fuel.csv'))
fwrite(IEA_sector_fuel_modifications, paste0(data.output.path, 'mappings/IEA_sector_fuel_modifications.csv'))
fwrite(enduse_fuel_aggregation, paste0(data.output.path, 'mappings/enduse_fuel_aggregation.csv'))
fwrite(L100.IEA_en_bal_ctry_hist, paste0(data.output.path, 'L100.IEA_en_bal_ctry_hist.csv'))
# 输出后还要手动处理一下：把文件头删掉
# L101.en_bal_EJ_ctry_Si_Fi_Yh_full <- load_from_cache("L101.en_bal_EJ_ctry_Si_Fi_Yh_full")$L101.en_bal_EJ_ctry_Si_Fi_Yh_full
# L101.en_bal_EJ_R_Si_Fi_Yh_full <- load_from_cache("L101.en_bal_EJ_R_Si_Fi_Yh_full")$L101.en_bal_EJ_R_Si_Fi_Yh_full

# 保留了 biomass 和 traditional biomass, 但是要在 zgcamchina_L144.building_CHINA.R 中处理（NBS 数据中没有显式的 biomass，# need to add some mapping for traditional biomass since that was not explicit in the energy balance）

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

# Debug 2: module_gcamchina_L1322.Fert ========

tdata <- load_from_cache(c('L1322.Fert_Prod_MtNH3_R_F_Y', 'L1322.IO_R_Fert_F_Yh', 'L101.NBS_use_all_Mtce'))
L1322.Fert_Prod_MtNH3_R_F_Y <- tdata$L1322.Fert_Prod_MtNH3_R_F_Y
L1322.IO_R_Fert_F_Yh <- tdata$L1322.IO_R_Fert_F_Yh
# Proxy for downscaling fertilizer to provinces
# TODO: Find a better proxy
L101.NBS_use_all_Mtce <- tdata$L101.NBS_use_all_Mtce

# Silence package check
year <- GCAM_region_ID <- value <- org <- sum <- province <-
  sector <- fuel <- EBProcess <- EBMaterial <- multiplier <- output <- . <- NULL

# 香港的能源平衡中需要有 agriculture 的结构，值设为0，防止出现 left_join_error_no_match 报错 na


# Debug 3: module_gcamchina_L154.Transport ===============
load_all()
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L154.Transport")

# trnUCD_NBS_mapping <- load_from_cache(inputs_of("module_gcamchina_L154.Transport"))$`gcam-china/trnUCD_NBS_mapping`
# L154.in_EJ_R_trn_m_sz_tech_F_Yh <-  load_from_cache(inputs_of("module_gcamchina_L154.Transport"))$L154.in_EJ_R_trn_m_sz_tech_F_Yh
# L154.out_mpkm_R_trn_nonmotor_Yh <-  load_from_cache(inputs_of("module_gcamchina_L154.Transport"))$L154.out_mpkm_R_trn_nonmotor_Yh
# L101.Pop_thous_province <-  load_from_cache(inputs_of("module_gcamchina_L154.Transport"))$L101.Pop_thous_province
# L101.inNBS_Mtce_province_S_F <-  load_from_cache(inputs_of("module_gcamchina_L154.Transport"))$L101.inNBS_Mtce_province_S_F
# L101.NBS_use_all_Mtce <-  load_from_cache(inputs_of("module_gcamchina_L154.Transport"))$L101.NBS_use_all_Mtce

trn.outputs <- load_from_cache(outputs_of("module_gcamchina_L154.Transport"))$L154.in_EJ_province_trn_F %>% filter(province == "HK")

# Debug 4: module_gcamchina_L132.Industry ================
load_all()
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L132.Industry")

L132.in_EJ_province_indnochp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indnochp_F
L132.in_EJ_province_indchp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indchp_F
L132.out_EJ_province_indchp_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.out_EJ_province_indchp_F
L132.in_EJ_province_indfeed_F <- load_from_cache(outputs_of("module_gcamchina_L132.Industry"))$L132.in_EJ_province_indfeed_F

# Debug 5: module_gcamchina_L144.Building ================
load_all()
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L144.Building")
L144.in_EJ_province_bld_F_U <- load_from_cache(outputs_of("module_gcamchina_L144.Building"))$L144.in_EJ_province_bld_F_U
HK.in_EJ_province_bld_F <- L144.in_EJ_province_bld_F_U %>% filter(province == "HK") %>%
  group_by(sector, fuel, year) %>% summarise(sum = sum(value)) %>% ungroup()
HK.in_EJ_province_bld_U <- L144.in_EJ_province_bld_F_U %>% filter(province == "HK") %>%
  group_by(sector, service, year) %>% summarise(sum = sum(value)) %>% ungroup()

# Debug 6: module_gcamchina_L123.Electricity ================
load_all()
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L123.Electricity")
L123.in_EJ_province_elec_F <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.in_EJ_province_elec_F %>% filter(province == "HK")
L123.out_EJ_province_elec_F <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.out_EJ_province_elec_F %>% filter(province == "HK")
L123.in_EJ_province_ownuse_elec <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.in_EJ_province_ownuse_elec %>% filter(province == "HK")
L123.out_EJ_province_ownuse_elec <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.out_EJ_province_ownuse_elec %>% filter(province == "HK")

# Debug 7: module_gcamchina_L2231.coal_vintage ================

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L2231.coal_vintage")
L1L2Data <- load_from_cache(inputs_of("module_gcamchina_L2231.coal_vintage"))

L2234.StubTechProd_elecS_CHINA <- L1L2Data$L2234.StubTechProd_elecS_CHINA
L2234.StubTechEff_elecS_CHINA <- L1L2Data$L2234.StubTechEff_elecS_CHINA
L2234.StubTechMarket_elecS_CHINA <- L1L2Data$L2234.StubTechMarket_elecS_CHINA
L2234.GlobalTechCapFac_elecS_CHINA <- L1L2Data$L2234.GlobalTechCapFac_elecS_CHINA
L2234.GlobalTechCapital_elecS_CHINA <- L1L2Data$L2234.GlobalTechCapital_elecS_CHINA
L2234.GlobalTechOMfixed_elecS_CHINA <- L1L2Data$L2234.GlobalTechOMfixed_elecS_CHINA
L2234.GlobalTechOMvar_elecS_CHINA <- L1L2Data$L2234.GlobalTechOMvar_elecS_CHINA
L2234.GlobalTechEff_elecS_CHINA <- L1L2Data$L2234.GlobalTechEff_elecS_CHINA
L2234.GlobalTechProfitShutdown_elecS_CHINA <- L1L2Data$L2234.GlobalTechProfitShutdown_elecS_CHINA
L2234.GlobalTechSCurve_elecS_CHINA <- L1L2Data$L2234.GlobalTechSCurve_elecS_CHINA

gen_dist_prov <- L1L2Data$`gcam-china/MEIC2015_province_vint_gen`
provNamesMapping <- L1L2Data$`gcam-china/province_names_mappings`


gcamchina.COAL_VINTAGE_LABELS <- c("before 1990", "1991-1995","1996-2000", "2001-2005", "2006-2010", "2011-2015","2016-2021")
gcamchina.AVG_COAL_PLANT_LIFETIME <- 40
MODEL_BASE_YEARS <- c(1975,1990,2005,2010,2015,2021)
gcamchina.COAL_RETIRE_STEEPNESS<- 0.3


# Debug: module_gcamchina_L1236.elec_load_segments_solver ================
L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1236.elec_load_segments_solver"))
elecS_horizontal_to_vertical_map <- L1L2inputs$`gcam-china/elecS_horizontal_to_vertical_map`
L1234.out_EJ_grid_elec_F <- L1L2inputs$L1234.out_EJ_grid_elec_F_CHINA %>%
  rename(grid_region = grid.region)
L1235.grid_elec_supply_CHINA <- L1L2inputs$L1235.grid_elec_supply_CHINA
L1235.elecS_demand_fraction_CHINA <- L1L2inputs$L1235.elecS_demand_fraction_CHINA
L1235.elecS_horizontal_vertical_CHINA <- L1L2inputs$L1235.elecS_horizontal_vertical_CHINA
L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA <- L1L2inputs$L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA


L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1236.elec_load_segments_solver"))

# Debug: module_gcamchina_L1239.elec_province_fractions ================
L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1239.elec_province_fractions"))

L1239.province_elec_supply <- load_from_cache(outputs_of("module_gcamchina_L1239.elec_province_fractions"))$L1239.province_elec_supply

