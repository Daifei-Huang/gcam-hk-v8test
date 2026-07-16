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

driver(write_outputs = TRUE, xmldir = 'xml_test3/')

driver_drake(xmldir = 'xml_test3/', memory_strategy = "autoclean")

###########################
xml_test1 中的 MEIC Hong Kong 是以 before 1990 为主的，
xml_test3 中的 MEIC Hong Kong 是以 1991-1995 为主的

###########################

# Debug: module_gcamchina_L123.Electricity ================

L123.in_EJ_province_elec_F <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.in_EJ_province_elec_F %>% filter(province == "HK")
L123.out_EJ_province_elec_F <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.out_EJ_province_elec_F %>% filter(province == "HK")
L123.in_EJ_province_ownuse_elec <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.in_EJ_province_ownuse_elec %>% filter(province == "HK")
L123.out_EJ_province_ownuse_elec <- load_from_cache(outputs_of("module_gcamchina_L123.Electricity"))$L123.out_EJ_province_ownuse_elec %>% filter(province == "HK")

# Debug: module_gcamchina_L1231.Elec_tech ================

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1231.Elec_tech"))
L1231.in_EJ_province_elec_F_tech <- L1L2outputs$L1231.in_EJ_province_elec_F_tech
L1231.out_EJ_province_elec_F_tech <- L1L2outputs$L1231.out_EJ_province_elec_F_tech

# Debug: module_gcamchina_L1232.Elec_subregions ================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1232.Elec_subregions"))
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings` %>%
  select(province, grid.region)
L1231.out_EJ_province_elec_F_tech <- L1L2inputs$L123.out_EJ_province_elec_F

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1232.Elec_subregions"))
L1232.out_EJ_sR_elec_CHINA <- L1L2outputs$L1232.out_EJ_sR_elec_CHINA

# Debug: module_gcamchina_L1234.elec_gridregions ================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1234.elec_gridregions"))
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings`
L123.in_EJ_province_elec_F <- L1L2inputs$L123.in_EJ_province_elec_F
L123.out_EJ_province_elec_F <- L1L2inputs$L123.out_EJ_province_elec_F

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1234.elec_gridregions"))
L1232.out_EJ_sR_elec_CHINA <- L1L2outputs$L1232.out_EJ_sR_elec_CHINA

# Debug: module_gcamchina_L1235.elec_load_segments ================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1235.elec_load_segments"))
elecS_demand_fraction <- L1L2inputs$`gcam-china/elecS_demand_fraction`
elecS_time_fraction <- L1L2inputs$`gcam-china/elecS_time_fraction`
elecS_fuel_fraction <- L1L2inputs$`gcam-china/elecS_fuel_fraction`
elecS_horizontal_to_vertical_map <- L1L2inputs$`gcam-china/elecS_horizontal_to_vertical_map`
L1234.out_EJ_grid_elec_F <- L1L2inputs$L1234.out_EJ_grid_elec_F

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1235.elec_load_segments"))
L1235.grid_elec_supply_CHINA <- L1L2outputs$L1235.grid_elec_supply_CHINA
L1235.elecS_horizontal_vertical_CHINA <- L1L2outputs$L1235.elecS_horizontal_vertical_CHINA
L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA <- L1L2outputs$L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA
L1235.elecS_demand_fraction_CHINA <- L1L2outputs$L1235.elecS_demand_fraction_CHINA

# Debug: module_gcamchina_L1236.elec_load_segments_solver ================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1236.elec_load_segments_solver"))
elecS_horizontal_to_vertical_map <- L1L2inputs$`gcam-china/elecS_horizontal_to_vertical_map`
L1234.out_EJ_grid_elec_F <- L1L2inputs$L1234.out_EJ_grid_elec_F %>%
  rename(grid_region = grid.region)
L1235.grid_elec_supply_CHINA <- L1L2inputs$L1235.grid_elec_supply_CHINA
L1235.elecS_demand_fraction_CHINA <- L1L2inputs$L1235.elecS_demand_fraction_CHINA
L1235.elecS_horizontal_vertical_CHINA <- L1L2inputs$L1235.elecS_horizontal_vertical_CHINA
L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA <- L1L2inputs$L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1236.elec_load_segments_solver"))
L1236.grid_elec_supply_CHINA <- L1L2outputs$L1236.grid_elec_supply_CHINA
L1236.elecS_demand_fraction_adj_CHINA <- L1L2outputs$L1236.elecS_demand_fraction_adj_CHINA

# Debug: module_gcamchina_L1239.elec_province_fractions ================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L1239.elec_province_fractions"))
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings`
L123.out_EJ_province_elec_F <- L1L2inputs$L123.out_EJ_province_elec_F
L1236.grid_elec_supply_CHINA <- L1L2inputs$L1236.grid_elec_supply_CHINA

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L1239.elec_province_fractions"))
L1239.province_elec_supply_CHINA <- L1L2outputs$L1239.province_elec_supply_CHINA



# Debug: module_gcamchina_L223.electricity ================
load_all()
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_after = "module_gcamchina_L223.electricity")

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L223.electricity"))
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings`
calibrated_techs <- L1L2inputs$`energy/calibrated_techs`
future_hydro_gen_EJ <- L1L2inputs$`gcam-china/future_hydro_gen_EJ`
nuc_share_weight_assumptions <- L1L2inputs$`gcam-china/nuc_share_weight_assumptions`
# NREL_us_re_technical_potential <- L1L2inputs$`gcam-china/NREL_us_re_technical_potential`
A23.globaltech_eff <- L1L2inputs$`energy/A23.globaltech_eff`
A10.renewable_resource_delete <- L1L2inputs$`gcam-china/A10.renewable_resource_delete`
L114.CapacityFactor_wind_province <- L1L2inputs$L114.CapacityFactor_wind_province
L119.CapFacScaler_PV_province <- L1L2inputs$L119.CapFacScaler_PV_province
L119.CapFacScaler_CSP_province <- L1L2inputs$L119.CapFacScaler_CSP_province
L223.Supplysector_elec <- L1L2inputs$L223.Supplysector_elec
L223.ElecReserve <- L1L2inputs$L223.ElecReserve
L223.SubsectorLogit_elec <- L1L2inputs$L223.SubsectorLogit_elec
L223.SubsectorShrwtFllt_elec <- L1L2inputs$L223.SubsectorShrwtFllt_elec
L223.SubsectorShrwt_nuc <- L1L2inputs$L223.SubsectorShrwt_nuc
L223.SubsectorShrwt_renew <- L1L2inputs$L223.SubsectorShrwt_renew
L223.SubsectorInterp_elec <- L1L2inputs$L223.SubsectorInterp_elec
L223.SubsectorInterpTo_elec <- L1L2inputs$L223.SubsectorInterpTo_elec
L223.StubTech_elec <- L1L2inputs$L223.StubTech_elec
L223.StubTechEff_elec <- L1L2inputs$L223.StubTechEff_elec
L223.StubTechCapFactor_elec <- L1L2inputs$L223.StubTechCapFactor_elec
L223.GlobalIntTechBackup_elec <- L1L2inputs$L223.GlobalIntTechBackup_elec
L1231.in_EJ_province_elec_F_tech <- L1L2inputs$L1231.in_EJ_province_elec_F_tech
L1231.out_EJ_province_elec_F_tech <- L1L2inputs$L1231.out_EJ_province_elec_F_tech
L1232.out_EJ_sR_elec_CHINA <- L1L2inputs$L1232.out_EJ_sR_elec_CHINA


L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L223.electricity"))
L223.DeleteSubsector_CHINAelec <- L1L2outputs$L223.DeleteSubsector_CHINAelec
L223.Supplysector_CHINAelec <- L1L2outputs$L223.Supplysector_CHINAelec
L223.SubsectorShrwtFllt_CHINAelec <- L1L2outputs$L223.SubsectorShrwtFllt_CHINAelec
L223.SubsectorInterp_CHINAelec <- L1L2outputs$L223.SubsectorInterp_CHINAelec
L223.SubsectorLogit_CHINAelec <- L1L2outputs$L223.SubsectorLogit_CHINAelec
L223.TechShrwt_CHINAelec <- L1L2outputs$L223.TechShrwt_CHINAelec
L223.TechCoef_CHINAelec <- L1L2outputs$L223.TechCoef_CHINAelec
L223.Production_CHINAelec <- L1L2outputs$L223.Production_CHINAelec
L223.Supplysector_elec_GRIDR <- L1L2outputs$L223.Supplysector_elec_GRIDR
L223.SubsectorShrwtFllt_elec_GRIDR <- L1L2outputs$L223.SubsectorShrwtFllt_elec_GRIDR
L223.SubsectorInterp_elec_GRIDR <- L1L2outputs$L223.SubsectorInterp_elec_GRIDR
L223.SubsectorLogit_elec_GRIDR <- L1L2outputs$L223.SubsectorLogit_elec_GRIDR
L223.TechShrwt_elec_GRIDR <- L1L2outputs$L223.TechShrwt_elec_GRIDR
L223.TechCoef_elec_GRIDR <- L1L2outputs$L223.TechCoef_elec_GRIDR
L223.Production_elec_GRIDR <- L1L2outputs$L223.Production_elec_GRIDR
L223.InterestRate_GRIDR <- L1L2outputs$L223.InterestRate_GRIDR
L223.Pop_GRIDR <- L1L2outputs$L223.Pop_GRIDR
L223.GDP_GRIDR <- L1L2outputs$L223.GDP_GRIDR
L223.Supplysector_elec_CHINA <- L1L2outputs$L223.Supplysector_elec_CHINA
L223.ElecReserve_CHINA <- L1L2outputs$L223.ElecReserve_CHINA
L223.SubsectorLogit_elec_CHINA <- L1L2outputs$L223.SubsectorLogit_elec_CHINA
L223.SubsectorShrwtFllt_elec_CHINA <- L1L2outputs$L223.SubsectorShrwtFllt_elec_CHINA
L223.SubsectorShrwt_nuc_CHINA <- L1L2outputs$L223.SubsectorShrwt_nuc_CHINA
L223.SubsectorShrwt_renew_CHINA <- L1L2outputs$L223.SubsectorShrwt_renew_CHINA
L223.SubsectorInterp_elec_CHINA <- L1L2outputs$L223.SubsectorInterp_elec_CHINA
L223.SubsectorInterpTo_elec_CHINA <- L1L2outputs$L223.SubsectorInterpTo_elec_CHINA
L223.StubTech_elec_CHINA <- L1L2outputs$L223.StubTech_elec_CHINA
L223.StubTechEff_elec_CHINA <- L1L2outputs$L223.StubTechEff_elec_CHINA
L223.StubTechCapFactor_elec_CHINA <- L1L2outputs$L223.StubTechCapFactor_elec_CHINA
L223.StubTechFixOut_elec_CHINA <- L1L2outputs$L223.StubTechFixOut_elec_CHINA
L223.StubTechFixOut_hydro_CHINA <- L1L2outputs$L223.StubTechFixOut_hydro_CHINA
L223.StubTechProd_elec_CHINA <- L1L2outputs$L223.StubTechProd_elec_CHINA
L223.StubTechMarket_elec_CHINA <- L1L2outputs$L223.StubTechMarket_elec_CHINA
L223.StubTechMarket_backup_CHINA <- L1L2outputs$L223.StubTechMarket_backup_CHINA
L223.StubTechElecMarket_backup_CHINA <- L1L2outputs$L223.StubTechElecMarket_backup_CHINA
L223.StubTechCapFactor_elec_wind_CHINA <- L1L2outputs$L223.StubTechCapFactor_elec_wind_CHINA
L223.StubTechCapFactor_elec_solar_CHINA <- L1L2outputs$L223.StubTechCapFactor_elec_solar_CHINA


# Debug: module_gcamchina_L2231.coal_vintage ================

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

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L2231.coal_vintage"))
L2231.StubTechProd_coal_vintage_CHINA <- L1L2outputs$L2231.StubTechProd_coal_vintage_CHINA
L2231.StubTechEff_coal_vintage_CHINA <- L1L2outputs$L2231.StubTechEff_coal_vintage_CHINA
L2231.StubTechMarket_coal_vintage_CHINA <- L1L2outputs$L2231.StubTechMarket_coal_vintage_CHINA
L2231.GlobalTechEff_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechEff_coal_vintage_CHINA
L2231.GlobalTechCapFac_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechCapFac_coal_vintage_CHINA
L2231.GlobalTechCapital_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechCapital_coal_vintage_CHINA
L2231.GlobalTechOMfixed_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechOMfixed_coal_vintage_CHINA
L2231.GlobalTechOMvar_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechOMvar_coal_vintage_CHINA
L2231.GlobalTechShrwt_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechShrwt_coal_vintage_CHINA
L2231.GlobalTechProfitShutdown_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechProfitShutdown_coal_vintage_CHINA
L2231.GlobalTechSCurve_coal_vintage_CHINA <- L1L2outputs$L2231.GlobalTechSCurve_coal_vintage_CHINA


# Debug : module_gcamchina_L2232.electricity_GRIDR =====================================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L2232.electricity_GRIDR"))
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings`
A23.sector <- L1L2inputs$`energy/A23.sector`
A232.structure <- L1L2inputs$`gcam-china/A232.structure`
L123.in_EJ_province_ownuse_elec <- L1L2inputs$L123.in_EJ_province_ownuse_elec
L123.out_EJ_province_ownuse_elec <- L1L2inputs$L123.out_EJ_province_ownuse_elec
L132.out_EJ_province_indchp_F <- L1L2inputs$L132.out_EJ_province_indchp_F
L1232.out_EJ_sR_elec_CHINA <- L1L2inputs$L1232.out_EJ_sR_elec_CHINA
L223.StubTechMarket_backup_CHINA <- L1L2inputs$L223.StubTechMarket_backup_CHINA
L126.IO_R_electd_F_Yh <- L1L2inputs$L126.IO_R_electd_F_Yh
L122.in_EJ_province_refining_F <- L1L2inputs$L122.in_EJ_province_refining_F
L123.out_EJ_province_elec_F <- L1L2inputs$L123.out_EJ_province_elec_F
L132.in_EJ_province_indchp_F <- L1L2inputs$L132.in_EJ_province_indchp_F
L132.in_EJ_province_indfeed_F <- L1L2inputs$L132.in_EJ_province_indfeed_F
L132.in_EJ_province_indnochp_F <- L1L2inputs$L132.in_EJ_province_indnochp_F
L1321.in_EJ_province_cement_F_Y <- L1L2inputs$L1321.in_EJ_province_cement_F_Y
L1322.in_EJ_province_Fert_Yh <- L1L2inputs$L1322.in_EJ_province_Fert_Yh
L144.in_EJ_province_bld_F_U <- L1L2inputs$L144.in_EJ_province_bld_F_U
L154.in_EJ_province_trn_F <- L1L2inputs$L154.in_EJ_province_trn_F

L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L2232.electricity_GRIDR"))
L2232.DeleteSupplysector_CHINAelec <- L1L2outputs$L2232.DeleteSupplysector_CHINAelec
L2232.Supplysector_CHINAelec <- L1L2outputs$L2232.Supplysector_CHINAelec
L2232.SubsectorShrwtFllt_CHINAelec <- L1L2outputs$L2232.SubsectorShrwtFllt_CHINAelec
L2232.SubsectorInterp_CHINAelec <- L1L2outputs$L2232.SubsectorInterp_CHINAelec
L2232.SubsectorLogit_CHINAelec <- L1L2outputs$L2232.SubsectorLogit_CHINAelec
L2232.TechShrwt_CHINAelec <- L1L2outputs$L2232.TechShrwt_CHINAelec
L2232.TechCoef_CHINAelec <- L1L2outputs$L2232.TechCoef_CHINAelec
L2232.Production_exports_CHINAelec <- L1L2outputs$L2232.Production_exports_CHINAelec
L2232.Supplysector_elec_GRIDR <- L1L2outputs$L2232.Supplysector_elec_GRIDR
L2232.ElecReserve_GRIDR <- L1L2outputs$L2232.ElecReserve_GRIDR
L2232.SubsectorShrwtFllt_elec_GRIDR <- L1L2outputs$L2232.SubsectorShrwtFllt_elec_GRIDR
L2232.SubsectorInterp_elec_GRIDR <- L1L2outputs$L2232.SubsectorInterp_elec_GRIDR
L2232.SubsectorLogit_elec_GRIDR <- L1L2outputs$L2232.SubsectorLogit_elec_GRIDR
L2232.TechShrwt_elec_GRIDR <- L1L2outputs$L2232.TechShrwt_elec_GRIDR
L2232.TechCoef_elec_GRIDR <- L1L2outputs$L2232.TechCoef_elec_GRIDR
L2232.TechCoef_elecownuse_GRIDR <- L1L2outputs$L2232.TechCoef_elecownuse_GRIDR
L2232.Production_imports_GRIDR <- L1L2outputs$L2232.Production_imports_GRIDR
L2232.Production_elec_gen_GRIDR <- L1L2outputs$L2232.Production_elec_gen_GRIDR
L2232.StubTechElecMarket_backup_CHINA <- L1L2outputs$L2232.StubTechElecMarket_backup_CHINA

# Debug : module_gcamchina_L2234.elec_segments =====================================
L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L2234.elec_segments"))
L2234.Supplysector_elecS_CHINA <- L1L2outputs$L2234.Supplysector_elecS_CHINA
L2234.ElecReserve_elecS_CHINA <- L1L2outputs$L2234.ElecReserve_elecS_CHINA
L2234.SubsectorLogit_elecS_CHINA <- L1L2outputs$L2234.SubsectorLogit_elecS_CHINA
L2234.SubsectorShrwtInterp_elecS_CHINA <- L1L2outputs$L2234.SubsectorShrwtInterp_elecS_CHINA
L2234.SubsectorShrwtInterpTo_elecS_CHINA <- L1L2outputs$L2234.SubsectorShrwtInterpTo_elecS_CHINA
L2234.SubsectorShrwt_elecS_CHINA <- L1L2outputs$L2234.SubsectorShrwt_elecS_CHINA
L2234.StubTechEff_elecS_CHINA <- L1L2outputs$L2234.StubTechEff_elecS_CHINA
L2234.StubTechCapFactor_elecS_solar_CHINA <- L1L2outputs$L2234.StubTechCapFactor_elecS_solar_CHINA
L2234.StubTechCapFactor_elecS_wind_CHINA <- L1L2outputs$L2234.StubTechCapFactor_elecS_wind_CHINA
# L2234.StubTechTrackCapital_elecS_CHINA <- L1L2outputs$L2234.StubTechTrackCapital_elecS_CHINA
L2234.SubsectorShrwtFllt_elecS_grid_CHINA <- L1L2outputs$L2234.SubsectorShrwtFllt_elecS_grid_CHINA
L2234.SubsectorShrwtInterp_elecS_grid_CHINA <- L1L2outputs$L2234.SubsectorShrwtInterp_elecS_grid_CHINA
L2234.PassThroughSector_elecS_CHINA <- L1L2outputs$L2234.PassThroughSector_elecS_CHINA
L2234.PassThroughTech_elecS_grid_CHINA <- L1L2outputs$L2234.PassThroughTech_elecS_grid_CHINA
L2234.GlobalTechShrwt_elecS_CHINA <- L1L2outputs$L2234.GlobalTechShrwt_elecS_CHINA
L2234.GlobalIntTechShrwt_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechShrwt_elecS_CHINA
L2234.PrimaryRenewKeyword_elecS_CHINA <- L1L2outputs$L2234.PrimaryRenewKeyword_elecS_CHINA
L2234.PrimaryRenewKeywordInt_elecS_CHINA <- L1L2outputs$L2234.PrimaryRenewKeywordInt_elecS_CHINA
L2234.AvgFossilEffKeyword_elecS_CHINA <- L1L2outputs$L2234.AvgFossilEffKeyword_elecS_CHINA
L2234.GlobalTechCapital_elecS_CHINA <- L1L2outputs$L2234.GlobalTechCapital_elecS_CHINA
L2234.GlobalIntTechCapital_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechCapital_elecS_CHINA
L2234.GlobalTechOMfixed_elecS_CHINA <- L1L2outputs$L2234.GlobalTechOMfixed_elecS_CHINA
L2234.GlobalIntTechOMfixed_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechOMfixed_elecS_CHINA
L2234.GlobalTechOMvar_elecS_CHINA <- L1L2outputs$L2234.GlobalTechOMvar_elecS_CHINA
L2234.GlobalIntTechOMvar_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechOMvar_elecS_CHINA
L2234.GlobalTechCapFac_elecS_CHINA <- L1L2outputs$L2234.GlobalTechCapFac_elecS_CHINA
L2234.GlobalTechEff_elecS_CHINA <- L1L2outputs$L2234.GlobalTechEff_elecS_CHINA
L2234.GlobalIntTechEff_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechEff_elecS_CHINA
L2234.GlobalTechLifetime_elecS_CHINA <- L1L2outputs$L2234.GlobalTechLifetime_elecS_CHINA
L2234.GlobalIntTechLifetime_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechLifetime_elecS_CHINA
L2234.GlobalTechProfitShutdown_elecS_CHINA <- L1L2outputs$L2234.GlobalTechProfitShutdown_elecS_CHINA
L2234.GlobalTechSCurve_elecS_CHINA <- L1L2outputs$L2234.GlobalTechSCurve_elecS_CHINA
L2234.GlobalTechCapture_elecS_CHINA <- L1L2outputs$L2234.GlobalTechCapture_elecS_CHINA
L2234.GlobalIntTechBackup_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechBackup_elecS_CHINA
L2234.GlobalIntTechValueFactor_elecS_CHINA <- L1L2outputs$L2234.GlobalIntTechValueFactor_elecS_CHINA
L2234.StubTechMarket_elecS_CHINA <- L1L2outputs$L2234.StubTechMarket_elecS_CHINA
L2234.StubTechMarket_backup_elecS_CHINA <- L1L2outputs$L2234.StubTechMarket_backup_elecS_CHINA
L2234.StubTechElecMarket_backup_elecS_CHINA <- L1L2outputs$L2234.StubTechElecMarket_backup_elecS_CHINA
L2234.StubTechProd_elecS_CHINA <- L1L2outputs$L2234.StubTechProd_elecS_CHINA
L2234.StubTechFixOut_elecS_CHINA <- L1L2outputs$L2234.StubTechFixOut_elecS_CHINA
L2234.StubTechFixOut_hydro_elecS_CHINA <- L1L2outputs$L2234.StubTechFixOut_hydro_elecS_CHINA
L2234.TechShrwt_elecS_grid_CHINA <- L1L2outputs$L2234.TechShrwt_elecS_grid_CHINA
L2234.TechCoef_elecS_grid_CHINA <- L1L2outputs$L2234.TechCoef_elecS_grid_CHINA
L2234.TechProd_elecS_grid_CHINA <- L1L2outputs$L2234.TechProd_elecS_grid_CHINA

# Debug : module_gcamchina_L2235.elec_segments_GRID =====================================

L1L2inputs <- load_from_cache(inputs_of("module_gcamchina_L2235.elec_segments_GRID"))
province_names_mappings <- L1L2inputs$`gcam-china/province_names_mappings`
A232.structure <- L1L2inputs$`gcam-china/A232.structure`
A23.elec_delete <- L1L2inputs$`gcam-china/A23.elec_delete`
A23.elecS_sector_vertical <- L1L2inputs$`gcam-china/A23.elecS_sector_vertical`
A23.elecS_metainfo_vertical <- L1L2inputs$`gcam-china/A23.elecS_metainfo_vertical`
ABSPI_intra_province_electricity_trade <- L1L2inputs$`gcam-china/ABSPI_intra_province_electricity_trade`
L1235.elecS_demand_fraction_CHINA <- L1L2inputs$L1235.elecS_demand_fraction_CHINA

L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA <-
  L1L2inputs$L1235.elecS_horizontal_vertical_GCAM_coeff_CHINA %>%
  rename(region = grid_region)

L123.in_EJ_province_ownuse_elec <- L1L2inputs$L123.in_EJ_province_ownuse_elec
L123.out_EJ_province_ownuse_elec <- L1L2inputs$L123.out_EJ_province_ownuse_elec
L126.in_EJ_province_td_elec <- L1L2inputs$L126.in_EJ_province_td_elec
L132.out_EJ_province_indchp_F <- L1L2inputs$L132.out_EJ_province_indchp_F
L1232.out_EJ_sR_elec_CHINA <- L1L2inputs$L1232.out_EJ_sR_elec_CHINA
L126.in_EJ_R_electd_F_Yh <- L1L2inputs$L126.in_EJ_R_electd_F_Yh



L1L2outputs <- load_from_cache(outputs_of("module_gcamchina_L2235.elec_segments_GRID"))
L2235.DeleteSupplysector_elec_CHINA <- L1L2outputs$L2235.DeleteSupplysector_elec_CHINA
L2235.InterestRate_GRID_CHINA <- L1L2outputs$L2235.InterestRate_GRID_CHINA
L2235.Pop_GRID_CHINA <- L1L2outputs$L2235.Pop_GRID_CHINA
L2235.GDP_GRID_CHINA <- L1L2outputs$L2235.GDP_GRID_CHINA
L2235.LaborForceFillout_GRID_CHINA <- L1L2outputs$L2235.LaborForceFillout_GRID_CHINA
L2235.Supplysector_elec_CHINA <- L1L2outputs$L2235.Supplysector_elec_CHINA
L2235.ElecReserve_elecS_grid_vertical_CHINA <- L1L2outputs$L2235.ElecReserve_elecS_grid_vertical_CHINA
L2235.SubsectorLogit_elec_CHINA <- L1L2outputs$L2235.SubsectorLogit_elec_CHINA
L2235.SubsectorShrwtFllt_elec_CHINA <- L1L2outputs$L2235.SubsectorShrwtFllt_elec_CHINA
L2235.SubsectorInterp_elec_CHINA <- L1L2outputs$L2235.SubsectorInterp_elec_CHINA
L2235.SubsectorShrwtFllt_elecS_grid_vertical_CHINA <- L1L2outputs$L2235.SubsectorShrwtFllt_elecS_grid_vertical_CHINA
L2235.SubsectorShrwtInterp_elecS_grid_vertical_CHINA <- L1L2outputs$L2235.SubsectorShrwtInterp_elecS_grid_vertical_CHINA
L2235.TechShrwt_elec_CHINA <- L1L2outputs$L2235.TechShrwt_elec_CHINA
L2235.TechCoef_elec_CHINA <- L1L2outputs$L2235.TechCoef_elec_CHINA
L2235.Production_exports_elec_CHINA <- L1L2outputs$L2235.Production_exports_elec_CHINA
L2235.TechShrwt_elecS_grid_vertical_CHINA <- L1L2outputs$L2235.TechShrwt_elecS_grid_vertical_CHINA
L2235.TechCoef_elecS_grid_vertical_CHINA <- L1L2outputs$L2235.TechCoef_elecS_grid_vertical_CHINA
L2235.Supplysector_elec_GRID_CHINA <- L1L2outputs$L2235.Supplysector_elec_GRID_CHINA
L2235.SubsectorLogit_elec_GRID_CHINA <- L1L2outputs$L2235.SubsectorLogit_elec_GRID_CHINA
L2235.SubsectorShrwtFllt_elec_GRID_CHINA <- L1L2outputs$L2235.SubsectorShrwtFllt_elec_GRID_CHINA
L2235.SubsectorInterp_elec_GRID_CHINA <- L1L2outputs$L2235.SubsectorInterp_elec_GRID_CHINA
L2235.TechShrwt_elec_GRID_CHINA <- L1L2outputs$L2235.TechShrwt_elec_GRID_CHINA
L2235.TechCoef_elec_GRID_CHINA <- L1L2outputs$L2235.TechCoef_elec_GRID_CHINA
L2235.TechCoef_elecownuse_GRID_CHINA <- L1L2outputs$L2235.TechCoef_elecownuse_GRID_CHINA
L2235.Production_imports_GRID_CHINA <- L1L2outputs$L2235.Production_imports_GRID_CHINA
L2235.Production_elec_gen_GRID_CHINA <- L1L2outputs$L2235.Production_elec_gen_GRID_CHINA
