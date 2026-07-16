# HK cost premium XML validation report

## Generated XML files
- HK_cost_premium_low.xml: XML parse OK
- HK_cost_premium_mid.xml: XML parse OK
- HK_cost_premium_high.xml: XML parse OK

## Coverage
- Cost-complete technologies adjusted: 57
- Future periods included: 2025, 2030, 2035, 2040, 2045, 2050, 2055, 2060, 2065, 2070, 2075, 2080, 2085, 2090, 2095, 2100
- Rows per scenario: {'low': 912, 'mid': 912, 'high': 912}
- Skipped technologies due to missing cost tags: 5
  - base load generation / hydro / hydro_base: No future period has complete input-capital/input-OM-fixed/input-OM-var cost tags.
  - intermediate generation / hydro / hydro_int: No future period has complete input-capital/input-OM-fixed/input-OM-var cost tags.
  - peak generation / grid_storage / battery: No future period has complete input-capital/input-OM-fixed/input-OM-var cost tags.
  - peak generation / hydro / hydro_peak: No future period has complete input-capital/input-OM-fixed/input-OM-var cost tags.
  - subpeak generation / hydro / hydro_subpeak: No future period has complete input-capital/input-OM-fixed/input-OM-var cost tags.

## Factor source counts by technology-scenario rows
- fallback_reference_md: 87
- v3_final_recommended_matrix.csv: 84

## Notes
- PV, rooftop PV, and wind OM-var are kept unchanged by setting variableOM premium to 1.0.
- CSP, nuclear, and geothermal are included as cost-neutral where cost tags exist; this avoids arbitrary HK premiums for not-applicable/local-unsupported technologies.
- Hydro and standalone battery technologies in the uploaded XML do not contain the three target cost inputs and are therefore not overridden.
- Output XML uses region-specific `region name="HK"` and `pass-through-sector/subsector/stub-technology` overrides; it does not modify the global technology database.
