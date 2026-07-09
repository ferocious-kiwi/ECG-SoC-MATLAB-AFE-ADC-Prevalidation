# Dynamic Range and ADC Headroom Reference

MATLAB nominal pre-validation에서 가장 중요한 결과는 대표 ECG 입력에 대해 IA gain ×201 이후에도 ADC ±1.65 V 범위를 넘지 않는지 확인하는 것이다.

- CSV: `results_dataset/afe_dynamic_range_headroom_summary.csv`
- Figure: `figures/fig_dynamic_range_headroom.png`
- ADC distribution: `figures/fig_adc_code_distribution.png`

## Summary

| record_name   |   input_duration_s |   sample_count |   sampling_rate_Hz |   afe_output_min_V |   afe_output_max_V |   adc_input_min_V |   adc_input_max_V |   adc_code_min |   adc_code_max |   adc_code_peak_to_peak |   positive_rail_hit_count |   negative_rail_hit_count |   clipping_ratio_percent |   positive_headroom_to_rail_V |   negative_headroom_to_rail_V |   minimum_headroom_to_rail_V |   minimum_headroom_to_rail_LSB |
|:--------------|-------------------:|---------------:|-------------------:|-------------------:|-------------------:|------------------:|------------------:|---------------:|---------------:|------------------------:|--------------------------:|--------------------------:|-------------------------:|------------------------------:|------------------------------:|-----------------------------:|-------------------------------:|
| NSR           |                 60 |          60000 |               1000 |          -0.111193 |           0.385184 |         -0.111193 |          0.385184 |           1909 |           2525 |                     616 |                         0 |                         0 |                        0 |                       1.26482 |                       1.53881 |                      1.26482 |                        1569.52 |
| CHF           |                 60 |          60000 |               1000 |          -0.278713 |           0.557422 |         -0.278713 |          0.557422 |           1701 |           2739 |                    1038 |                         0 |                         0 |                        0 |                       1.09258 |                       1.37129 |                      1.09258 |                        1355.79 |
| ARR           |                 60 |          60000 |               1000 |          -0.630367 |           0.466399 |         -0.630367 |          0.466399 |           1265 |           2626 |                    1361 |                         0 |                         0 |                        0 |                       1.1836  |                       1.01963 |                      1.01963 |                        1265.27 |
| AFF           |                 60 |          60000 |               1000 |          -0.350374 |           0.326538 |         -0.350374 |          0.326538 |           1612 |           2452 |                     840 |                         0 |                         0 |                        0 |                       1.32346 |                       1.29963 |                      1.29963 |                        1612.72 |

## Main Message

MATLAB nominal pre-validation을 통해 선택한 IA gain과 ADC range가 대표 ECG 입력에 대해 clipping 없이 충분한 headroom을 제공함을 확인하였다.

모든 NSR/CHF/ARR/AFF case에서 positive/negative rail hit count는 0이며 clipping ratio는 0%이다.

## Scope

이 결과는 nominal ADC headroom reference이다. ADC offset/gain/noise/jitter robustness, op-amp non-ideality, CMRR, PCB/silicon-level 검증은 포함하지 않는다.
