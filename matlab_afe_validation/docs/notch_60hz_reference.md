# Dense 60 Hz Notch Reference

이 문서는 active Twin-T notch의 55-65 Hz dense sweep reference를 정리한다.
현재 notch scope는 **60 Hz mains target**이다. 50 Hz까지 완벽히 제거한다고 주장하지 않는다.

- CSV: `results_dataset/notch_dense_sweep.csv`
- Metric CSV: `results_dataset/notch_dense_sweep_metrics.csv`
- Figure: `figures/fig_notch_dense_sweep.png`
- PDF: `figures/fig_notch_dense_sweep.pdf`

## Dense Sweep Metrics

|   target_frequency_Hz |   notch_center_frequency_Hz |   exact_60Hz_attenuation_dB |   minimum_attenuation_dB_in_55_65Hz |   minus3dB_bandwidth_low_Hz |   minus3dB_bandwidth_high_Hz |   minus3dB_bandwidth_Hz |   approximate_Q_from_minus3dB |   configured_Q |   attenuation_at_50Hz_dB | scope_note                                                  |
|----------------------:|----------------------------:|----------------------------:|------------------------------------:|----------------------------:|-----------------------------:|------------------------:|------------------------------:|---------------:|-------------------------:|:------------------------------------------------------------|
|                    60 |                          60 |                    -83.5557 |                            -83.5557 |                          55 |                           65 |                      10 |                             6 |              5 |                 -1.13122 | 60 Hz mains target; not claimed as complete 50 Hz rejection |

## Interpretation

- configured Q는 약 5.000이다.
- exact 60 Hz attenuation은 MATLAB nodal-analysis reference 기준으로 약 -83.56 dB이다.
- 50 Hz는 reference point로만 제공하며, 본 notch의 primary target은 60 Hz이다.

## Limitation

이 결과는 MATLAB nominal/reference 결과이다. 실제 XMODEL 결과와의 equivalence는 후속 SystemVerilog XMODEL 검증에서 수행해야 한다.
