# Dynamic Range 및 ADC Headroom 기준 문서

MATLAB nominal pre-validation에서 가장 중요한 결과는 대표 ECG 입력에 대해 IA gain ×201 이후에도 ADC ±1.65 V 범위를 넘지 않는지 확인하는 것이다.

- CSV: `results_dataset/afe_dynamic_range_headroom_summary.csv`
- Figure: `figures/fig_dynamic_range_headroom.png`
- ADC distribution: `figures/fig_adc_code_distribution.png`

## 요약

| record/class   |   입력_길이_s |   sample_count |   sampling_rate_Hz |   AFE_output_min_V |   AFE_output_max_V |   ADC_input_min_V |   ADC_input_max_V |   ADC_code_min |   ADC_code_max |   ADC_code_p2p |   positive_rail_hit_count |   negative_rail_hit_count |   clipping_ratio_% |   positive_headroom_V |   negative_headroom_V |   minimum_headroom_V |   minimum_headroom_LSB |
|:---------------|--------------:|---------------:|-------------------:|-------------------:|-------------------:|------------------:|------------------:|---------------:|---------------:|---------------:|--------------------------:|--------------------------:|-------------------:|----------------------:|----------------------:|---------------------:|-----------------------:|
| NSR            |            60 |          60000 |               1000 |          -0.111193 |           0.385184 |         -0.111193 |          0.385184 |           1909 |           2525 |            616 |                         0 |                         0 |                  0 |               1.26482 |               1.53881 |              1.26482 |                1569.52 |
| CHF            |            60 |          60000 |               1000 |          -0.278713 |           0.557422 |         -0.278713 |          0.557422 |           1701 |           2739 |           1038 |                         0 |                         0 |                  0 |               1.09258 |               1.37129 |              1.09258 |                1355.79 |
| ARR            |            60 |          60000 |               1000 |          -0.630367 |           0.466399 |         -0.630367 |          0.466399 |           1265 |           2626 |           1361 |                         0 |                         0 |                  0 |               1.1836  |               1.01963 |              1.01963 |                1265.27 |
| AFF            |            60 |          60000 |               1000 |          -0.350374 |           0.326538 |         -0.350374 |          0.326538 |           1612 |           2452 |            840 |                         0 |                         0 |                  0 |               1.32346 |               1.29963 |              1.29963 |                1612.72 |

## 핵심 메시지

MATLAB nominal pre-validation을 통해 선택한 IA gain과 ADC range가 대표 ECG 입력에 대해 clipping 없이 충분한 headroom을 제공함을 확인하였다.

모든 NSR/CHF/ARR/AFF case에서 positive/negative rail hit count는 0이며 clipping ratio는 0%이다.

## 범위

이 결과는 nominal ADC headroom reference이다. ADC offset/gain/noise/jitter robustness, op-amp non-ideality, CMRR, PCB/silicon-level 검증은 포함하지 않는다.
