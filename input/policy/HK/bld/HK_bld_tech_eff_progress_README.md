# HK building technology-efficiency pathways, 2030-2100

## Files

- `HK_bld_tech_eff_2030_2100_conservative.xml`: current-standard continuation.
- `HK_bld_tech_eff_2030_2100_central.xml`: regular code tightening.
- `HK_bld_tech_eff_2030_2100_ambitious.xml`: best-available practical technology.
- `HK_bld_tech_eff_2030_2100_trajectory_summary.csv`: compact trajectory table (all commercial technologies and residential decile d1; d2-d10 are identical).

## How to use

Each 2030-2100 XML contains periods `2030, 2035, ..., 2100` only. Load it together with the matching 2025 file:

| Pathway | 2025 file | 2030-2100 file |
|---|---|---|
| Conservative | `HK_bld_tech_eff_2025_conservative.xml` | `HK_bld_tech_eff_2030_2100_conservative.xml` |
| Central | `HK_bld_tech_eff_2025_policy_calibrated.xml` | `HK_bld_tech_eff_2030_2100_central.xml` |
| Ambitious | `HK_bld_tech_eff_2025_ambitious.xml` | `HK_bld_tech_eff_2030_2100_ambitious.xml` |

Do not load more than one pathway at the same time. If XML input ordering creates override ambiguity in a particular configuration, combine the matching 2025 and future periods into one file before running.

## Pathway equation

For technologies that improve after 2025:

```text
eta(t) = eta(2025) + [eta_max - eta(2025)] * [1 - 2^(-(t-2025)/H)]
```

`eta_max` is a practical long-run platform and `H` is the number of years needed to close half of the remaining efficiency gap. The equation creates rapid early improvement followed by gradual saturation. Explicit values are written for every five-year model period; no value depends on interpolation from 2025 to a distant terminal year.

## Fixed technologies

Resistance heating already at 1.0, high-efficiency resistance water heating at 1.0, district heat, coal water-heater placeholders, and selected commercial water-heater placeholders remain fixed. This avoids exceeding conversion-efficiency limits or assigning unsupported progress to technical placeholders.

## Validation

Each file contains 208 technologies and 15 periods per technology (3,120 efficiency nodes). XML parsing, year coverage, monotonicity, and equality across residential deciles d1-d10 were checked programmatically.
