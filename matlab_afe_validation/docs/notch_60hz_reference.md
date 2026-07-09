# Dense 60 Hz Notch 기준 문서

이 문서는 active Twin-T notch의 55-65 Hz dense sweep reference를 정리한다.  
현재 notch scope는 **60 Hz mains target**이다. 50 Hz까지 완벽히 제거한다고 주장하지 않는다.

- CSV: `results_dataset/notch_dense_sweep.csv`
- Metric CSV: `results_dataset/notch_dense_sweep_metrics.csv`
- Figure: `figures/fig_notch_dense_sweep.png`
- PDF: `figures/fig_notch_dense_sweep.pdf`

## Dense sweep metrics

|   target_주파수_Hz |   notch_center_주파수_Hz |   정확한_60Hz_감쇠_dB |   55_65Hz_최소_감쇠_dB |   -3dB_저주파_Hz |   -3dB_고주파_Hz |   -3dB_대역폭_Hz |   -3dB_기준_근사_Q |   설정_Q |   50Hz_감쇠_dB | scope_비고                                          |
|-------------------:|-------------------------:|----------------------:|-----------------------:|-----------------:|-----------------:|-----------------:|-------------------:|---------:|---------------:|:----------------------------------------------------|
|                 60 |                       60 |              -83.5557 |               -83.5557 |               55 |               65 |               10 |                  6 |        5 |       -1.13122 | 60 Hz mains target; 50 Hz 완전 제거로 주장하지 않음 |

## 해석

- configured Q는 약 5.000이다.
- exact 60 Hz attenuation은 MATLAB nodal-analysis reference 기준으로 약 -83.56 dB이다.
- 50 Hz는 reference point로만 제공하며, 본 notch의 primary target은 60 Hz이다.

## 한계

이 결과는 MATLAB nominal/reference 결과이다. 실제 XMODEL 결과와의 equivalence는 후속 SystemVerilog XMODEL 검증에서 수행해야 한다.
