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

# driver(write_outputs = TRUE, xmldir = 'xml_test/', outdir = 'outputs_test/')

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean")

# Debug: module_gcamchina_L203.water_td_CHINA ================

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_before = "module_gcamchina_L203.water_td_CHINA")

L1L2Data <- load_from_cache(inputs_of("module_gcamchina_L203.water_td_CHINA"))

basin_to_country_mapping <- L1L2Data$`water/basin_to_country_mapping`
water_td_sectors <- L1L2Data$`water/water_td_sectors`
A71.sector <- L1L2Data$`water/A71.sector`
A72.sector <- L1L2Data$`water/A72.sector`
A73.sector <- L1L2Data$`water/A73.sector`
A74.sector <- L1L2Data$`water/A74.sector`
L103.water_mapping_CHINA_R_LS_W_Ws_share <- L1L2Data$L103.water_mapping_CHINA_R_LS_W_Ws_share
L103.water_mapping_CHINA_R_PRI_W_Ws_share <- L1L2Data$L103.water_mapping_CHINA_R_PRI_W_Ws_share
L103.water_mapping_CHINA_R_GLU_W_Ws_share <- L1L2Data$L103.water_mapping_CHINA_R_GLU_W_Ws_share
L103.water_mapping_CHINA_R_B_W_Ws_share <- L1L2Data$L103.water_mapping_CHINA_R_B_W_Ws_share
GCAM_province_names <- L1L2Data$`gcam-china/provinces_subregions`
province_and_basin <- L1L2Data$`gcam-china/province_and_basin`
china_seawater_provinces_basins <- L1L2Data$`gcam-china/china_seawater_provinces_basins`
water_td_sectors <- L1L2Data$`water/water_td_sectors`
A03.sector <- L1L2Data$`water/A03.sector`
L201.RsrcTechCoef <- L1L2Data$L201.RsrcTechCoef
L203.Supplysector_desal_basin <- L1L2Data$L203.Supplysector_desal_basin

GLU <- GLU_code <- GLU_name <- water.sector <-
  water_type <- supplysector <- field.eff <- conveyance.eff <-
  coefficient <- region <- state <- share <- basin_name <- Basin_name <-
  GCAM_basin_ID <- state_abbr <- water_sector <- year <- wt_short <- value <-
  state.to.country.share <- subsector <- technology <- share.weight <-
  price.unit <- input.unit <- output.unit <- logit.exponent <- logit.type <-
  logit.year.fillout <- resource <- minicam.energy.input <- subresource <- NULL

# Debug: module_gcamchina_L103.water_mapping_CHINA ================

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_before = "module_gcamchina_L103.water_mapping_CHINA")

L1L2Data <- load_from_cache(inputs_of("module_gcamchina_L103.water_mapping_CHINA"))

region <- state  <- year <- water_type <- water_sector <- demand <- demand_total <- Value <- state.to.country.share <-
  fresh.share <- saline.share <- value <- GCAM_basin_ID <- basin_name <- state_abbr <- volume <- Basin_name <-
  GLU_name <- share <- NULL        # silence package check.


# Load required inputs
irrigation_shares <- L1L2Data$`gcam-china/irrigation_shares_0p5degree`
nonirrigation_shares <- L1L2Data$`gcam-china/nonirrigation_shares_0p5degree`
basin_to_country_mapping <- L1L2Data$`water/basin_to_country_mapping`
mining_water_shares <- L1L2Data$`gcam-china/mining_water_shares`
livestock_water_withdrawals <- L1L2Data$`gcam-china/livestock_water_withdrawals` %>%
  gather_years()
