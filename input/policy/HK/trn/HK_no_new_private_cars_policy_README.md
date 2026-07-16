# Hong Kong private-car policy parameterization

## Model mapping
- Supply sector: `trn_pass_road_LDV_4W`
- Private-car subsectors: `Car`, `Large Car and Truck`, `Mini Car`
- Fuel-propelled technologies closed to new investment: `Liquids`, `Hybrid Liquids`, and `NG`
- Zero-emission technology explicitly kept available: `BEV`
- `FCEV` is left unchanged because current Hong Kong policy does not set a quantified hydrogen private-car target.

## Scenarios
- Scenario 1 (Current Policy): fuel-propelled private-car technologies receive `share-weight=0` from 2035 onward.
- Scenario 2 (Accelerated Transition): the same restriction starts in 2030.

## Important interpretation
A technology `share-weight=0` prevents that technology from receiving new production/investment in the relevant model vintage. It represents a ban on new registrations, not immediate retirement of the existing vehicle stock. Existing vintages may continue to operate according to GCAM turnover assumptions.

The parent aggregation technologies `trn_pass_road/LDV` and `trn_pass_road_LDV/4W` are deliberately not set to zero. Closing either parent would suppress the entire LDV or four-wheel pathway, including BEVs.

The files do not claim a specific BEV sales share before the phase-out year. Such a path would require calibration against observed registrations and translating desired sales shares into technology share-weights under GCAM's logit structure.
