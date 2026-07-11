# China detailed industry electricity intensity scenarios for GCAM-China v8

## Purpose

This package contains three compact GCAM XML files that reduce industrial electricity energy-intensity coefficients in China. The modified parameter is:

```xml
<minicam-energy-input name="elect_td_ind">
  <coefficient>...</coefficient>
</minicam-energy-input>
```

The coefficient is interpreted as the electricity input coefficient for a given industrial technology in a given region and model period. Reductions are applied relative to the **original coefficient in the same year** from `detailed_industry_CHINA v8.xml`, not cumulatively from a previous modified period.

## Files

- `detailed_industry_CHINA_v8_elect_intensity_conservative.xml`
- `detailed_industry_CHINA_v8_elect_intensity_recommended.xml`
- `detailed_industry_CHINA_v8_elect_intensity_aggressive.xml`
- `detailed_industry_CHINA_v8_elect_intensity_summary.csv`
- `detailed_industry_CHINA_v8_elect_intensity_sample_changes.csv`
- `detailed_industry_CHINA_v8_elect_intensity_verification.csv`
- `detailed_industry_CHINA_v8_elect_intensity_README.md`

## Scope of XML edits

- The `HK` region is removed from all scenario XMLs.
- Only periods from 2025 through 2100 are included.
- Only non-zero numeric `elect_td_ind` coefficients are included.
- Zero electricity coefficients are omitted rather than changed.
- Non-numeric coefficients, if any, are omitted.
- The compact XML keeps only the necessary hierarchy:

```xml
<scenario>
  <world>
    <region>
      <supplysector>
        <subsector>
          <stub-technology>
            <period>
              <minicam-energy-input name="elect_td_ind">
                <market-name>...</market-name>
                <coefficient>...</coefficient>
              </minicam-energy-input>
            </period>
          </stub-technology>
        </subsector>
      </supplysector>
    </region>
  </world>
</scenario>
```

`share-weight`, `interpolation-rule`, `minicam-non-energy-input`, `CalDataOutput`, other energy inputs, output/input/price units, logit parameters, and resource blocks are intentionally excluded.

## Scenario assumptions

| Period | Conservative reduction | Recommended reduction | Aggressive reduction |
|---:|---:|---:|---:|
| 2025 | 4% | 6% | 8% |
| 2030 | 8% | 10% | 15% |
| 2035 | 12% | 15% | 20% |
| 2040 | 15% | 18% | 25% |
| 2045 | 18% | 20% | 28% |
| 2050 | 20% | 22% | 30% |
| 2055 | 20% | 25% | 32% |
| 2060 | 20% | 25% | 35% |
| 2065 | 20% | 25% | 35% |
| 2070 | 20% | 25% | 35% |
| 2075 | 20% | 25% | 35% |
| 2080 | 20% | 25% | 35% |
| 2085 | 20% | 25% | 35% |
| 2090 | 20% | 25% | 35% |
| 2095 | 20% | 25% | 35% |
| 2100 | 20% | 25% | 35% |

The coefficient multiplier is `1 - reduction`. For example, a 2025 recommended reduction of 6% applies:

```text
new_coefficient = original_2025_coefficient * 0.94
```

## Interpretation

These XML files should be interpreted as industrial electricity-intensity improvement scenarios. They reduce electricity use per unit of industrial technology output, holding other inputs and technology share settings unchanged. They do not directly represent industrial output reductions, industrial structure changes, or explicit electrification policies.

## Recommended use

- Use the recommended scenario as the central policy scenario.
- Use the conservative scenario as a lower-bound / existing-policy-continuation sensitivity.
- Use the aggressive scenario as an upper-bound sensitivity for deep industrial efficiency improvement.

## Verification summary

- `detailed_industry_CHINA_v8_elect_intensity_conservative.xml`: 5488 coefficients modified; 31 regions kept; HK skipped = 1; XML validation passed; SHA256 = `d1818525060a5247422ab0abb8d4bd63ee7629ff6c1c6c3b8fc9eb3edeb7bdbd`.
- `detailed_industry_CHINA_v8_elect_intensity_recommended.xml`: 5488 coefficients modified; 31 regions kept; HK skipped = 1; XML validation passed; SHA256 = `60e48fd858d95b130b21d2f99e42c54946498bec305966086abe60ee36c88a29`.
- `detailed_industry_CHINA_v8_elect_intensity_aggressive.xml`: 5488 coefficients modified; 31 regions kept; HK skipped = 1; XML validation passed; SHA256 = `fc0e6a32dad162460ea4be25af2848556e865f958c1ebe630849a85d215440bc`.

## Notes

Because this is a compact override XML, it should be loaded after the baseline detailed industry XML in the GCAM configuration so that these coefficient values override the baseline values for the same regions, sectors, subsectors, technologies, and periods.
