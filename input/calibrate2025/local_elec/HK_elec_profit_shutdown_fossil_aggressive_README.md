# HK_elec_profit_shutdown_fossil_aggressive

This standalone GCAM scenario XML adds a stronger `profit-shutdown-decider` to Hong Kong fossil-fuel electricity technologies only.

## Coverage

- Region: `HK`
- Sectors copied from the uploaded cost-premium XML structure:
  - `base load generation`
  - `intermediate generation`
  - `subpeak generation`
  - `peak generation`
- Fossil subsectors:
  - `coal`
  - `gas`
  - `refined liquids`
- Number of technologies covered: 32
- Number of period-level shutdown entries: 512
- Periods covered: 2025-2100 at 5-year intervals

## Scenario values

| subsector | median-shutdown-point | steepness |
|---|---:|---:|
| coal | 0 | 8 |
| gas | 0 | 8 |
| refined liquids | 0 | 8 |

## Interpretation

`median-shutdown-point = 0` means a vintage reaches the midpoint of the profit shutdown function when marginal revenue equals variable cost. This is more aggressive than the GCAM default values used for electricity fossil technologies, where coal/gas are commonly set to `-0.1` and refined-liquids steam/CT to `-0.5`.

`steepness = 8` makes the shutdown response sharper than the common default value of `6`.

## Recommended use

Use this file together with one of the HK cost premium XMLs, for example:

1. `HK_elec_cost_premium_A_low.xml` + this file
2. `HK_elec_cost_premium_A_mid.xml` + this file
3. `HK_elec_cost_premium_A_high.xml` + this file

This file should be loaded after the base electricity technology XMLs. It can be loaded before or after the cost-premium XML because it modifies different tags.
